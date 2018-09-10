import pytz
from decimal import Decimal
import base64
import uuid
from ast import literal_eval
from urllib.parse import unquote

from django.conf import settings
from django.views.generic import ListView, DetailView, TemplateView
from django.shortcuts import reverse, redirect
from django.core.urlresolvers import reverse_lazy
from django.utils.timezone import now, timedelta, localtime, datetime

from apps.order.models import Cart, Order, PaymentMethod
from apps.account.forms import DeliveryAddressForm
from apps.account.models import DeliveryAddress


def get_total_weight(cart_items):
    total = 0
    for cart_item in cart_items:
        if cart_item.variation.name.isnumeric():
            total += int(cart_item.variation.name) * cart_item.count
    return total


def get_delivery_price(cart_items):
    weight = get_total_weight(cart_items)
    same_product = True if cart_items.count() == 1 else False

    price = 25000
    if 50 <= weight < 800:
        price = 50000
    elif 800 <= weight < 3000:
        price = 120000

    elif 3000 <= weight < 5000:
        price = 180000
    if weight > 2000 and same_product:
        price = 0
    return price


def get_cart_items(request):
    current_user_session_key = request.COOKIES.get('client_id')
    cart_items = Cart.objects.filter(session_key=current_user_session_key, status=True, order__isnull=True)
    return cart_items


def cookie_parser(client_data):
    if not client_data:
        return None
    client_data_str = unquote(client_data)
    data = literal_eval(client_data_str)
    return data


def cookie_is_valid(data):
    if not data.get('time'):
        return False, reverse_lazy('orders:time')
    if not data.get('payment_method'):
        return False, reverse_lazy('orders:payment_method')
    if not data.get('address'):
        return False, reverse_lazy('orders:address')
    address = data.get('address')
    if not address.get('client_name') or not address.get('phone') or not address.get('shipping_address'):
        return False, reverse_lazy('orders:address')
    return True, ''


class CartView(ListView):
    model = Cart
    template_name = 'pages/orders/cart.html'
    context_object_name = 'cart_items'

    def get_queryset(self):
        current_user_session_key = self.request.COOKIES.get('client_id')
        return self.model.objects.filter(session_key=current_user_session_key, status=True, order__isnull=True)

    def dispatch(self, request, *args, **kwargs):
        if get_cart_items(request=request).count() == 0:
            return redirect(reverse('main:home'))
        return super().dispatch(request=request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        cart_items = get_cart_items(self.request)
        total_amount = 0
        for cart_item in cart_items:
            total_amount += cart_item.total_price
        context = super().get_context_data(**kwargs)
        context['total_amount'] = total_amount
        return context


class OrderAddressView(TemplateView):
    template_name = 'pages/orders/address.html'
    success_url = reverse_lazy('orders:address')

    def dispatch(self, request, *args, **kwargs):
        if get_cart_items(request=request).count() == 0:
            return redirect(reverse('main:home'))
        return super().dispatch(request=request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        if self.request.user.is_authenticated:
            context['delivery_addresses'] = DeliveryAddress.objects.filter(user=self.request.user).order_by('-is_default')
        client_data = self.request.COOKIES.get('client_data')
        if client_data:
            address = cookie_parser(client_data)['address']
        else:
            address = None
        context['address'] = address
        return context


class OrderTimeView(TemplateView):
    template_name = 'pages/orders/order_time.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        cart_items = get_cart_items(self.request)
        times = []
        for time in range(0, 3):
            _date = localtime(now()) + timedelta(time)
            _datetime = datetime(year=_date.year, month=_date.month, day=_date.day)
            time_1 = datetime(year=_date.year, month=_date.month, day=_date.day, hour=9)
            time_2 = datetime(year=_date.year, month=_date.month, day=_date.day, hour=15)
            times.append({
                'datetime': _datetime,
                'time_1': time_1,
                'time_2': time_2,
                'time_1_is_left': time_1.timestamp() < now().timestamp(),
                'time_2_is_left': time_2.timestamp() < now().timestamp()
            })
            print('Time is left: ', time_2.timestamp() < now().timestamp())
        client_data = self.request.COOKIES.get('client_data')
        if client_data:
            time = cookie_parser(client_data)['time']
        else:
            time = None
        if client_data:
            need_porter = cookie_parser(client_data)['need_porter']
        else:
            need_porter = None
        context['days'] = times
        context['time'] = time
        context['need_porter'] = need_porter
        context['porter_work_price'] = get_delivery_price(cart_items)
        return context


class PaymentMethodView(ListView):
    model = PaymentMethod
    template_name = 'pages/orders/payment_method.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        if self.request.user.is_authenticated:
            context['delivery_addresses'] = DeliveryAddress.objects.filter(user=self.request.user).order_by('-is_default')
        client_data = self.request.COOKIES.get('client_data')
        if client_data:
            payment_method = cookie_parser(client_data)['payment_method']
        else:
            payment_method = None
        context['payment_method'] = payment_method
        return context


class CheckoutView(TemplateView):
    template_name = 'pages/orders/checkout.html'

    def dispatch(self, request, *args, **kwargs):
        if get_cart_items(request=request).count() == 0:
            return redirect(reverse('main:home'))
        if not request.COOKIES.get('client_data'):
            return redirect(reverse('orders:address'))
        client_data = cookie_parser(request.COOKIES.get('client_data'))
        valid, reversed_url = cookie_is_valid(client_data)
        if not valid:
            return redirect(reversed_url)
        return super().dispatch(request=request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        client_data = cookie_parser(self.request.COOKIES.get('client_data'))
        cart_items = get_cart_items(self.request)
        delivery_price = get_delivery_price(cart_items)
        products_price = total_quantity = 0

        for cart_item in cart_items:
            products_price += cart_item.total_price
            total_quantity += cart_item.count
        total_price = products_price + delivery_price
        try:
            if int(client_data.get('need_porter')):
                total_price += delivery_price
        except ValueError:
            pass

        context['products_price'] = products_price
        context['total_amount'] = total_price
        context['total_quantity'] = total_quantity
        context['form'] = DeliveryAddressForm(self.request.POST or None)
        context['cart_items'] = cart_items
        context['client_data'] = client_data
        context['delivery_price'] = delivery_price
        return context

    def post(self, request, *args, **kwargs):
        if request.POST.get('is_submitted'):
            cart_items = get_cart_items(self.request)
            total_weight = get_total_weight(cart_items=cart_items)
            client_data_cookie = self.request.COOKIES.get('client_data')
            client_data = cookie_parser(client_data_cookie)
            address = client_data.get('address')

            order = Order()
            order.client_name = address.get('client_name')
            order.payment = PaymentMethod.objects.get(method__exact=client_data.get('payment_method'))
            order.phone = address.get('phone')
            order.shipping_address = address.get('shipping_address')
            order.total_weight = total_weight
            order.delivery_price = get_delivery_price(cart_items)
            try:
                order.need_porter = int(client_data.get('need_porter'))
            except ValueError:
                pass

            if request.user.is_authenticated():
                order.customer = request.user

            if order.need_porter:
                order.porter_work_price = get_delivery_price(cart_items)
            order.shipping_time = datetime.fromtimestamp(client_data.get('time'), tz=pytz.timezone(settings.TIME_ZONE))
            order.save()

            total_price = 0

            json_data = []
            for cart_item in cart_items:
                cart_item.order = order
                total_price += cart_item.total_price
                cart_item.save()

                title = "{} {}".format(cart_item.variation.product.name, cart_item.variation.name)
                if cart_item.variation.color:
                    title = "{} {}".format(title, cart_item.variation.color.name)
                json_data.append({
                    'title': title,
                    'price': float(cart_item.variation.price),
                    'count': cart_item.count,
                    'total_price': float(cart_item.total_price)
                })
            order.products = json_data
            order.products_price = Decimal(total_price)
            order.order_unique_id = uuid.uuid4()

            order.total_price = order.products_price + get_delivery_price(cart_items)
            order.save()
            if order.payment.method == PaymentMethod.CASH_ON_DELIVERY:
                return redirect(reverse_lazy('orders:order_detail', args=[order.phone, order.order_unique_id]))
            elif order.payment.method == PaymentMethod.PAYME:
                # https://checkout.paycom.uz/base64(m=587f72c72cac0d162c722ae2;ac.order_id=197;a=500)
                merchant_id = settings.PAYME_MERCHANT_ID
                ac_order_id = order.id
                ac_customer_id = order.phone
                amount = int(order.total_price.real) * 100
                redirect_url_after_operation = reverse_lazy('main:home')
                ct = 15
                cr = 860
                data = "m={};ac.order_id={};ac.customer_id={};a={};c={}".format(merchant_id, ac_order_id,
                                                                                ac_customer_id, amount,
                                                                                redirect_url_after_operation)
                base64_data = base64.b64encode(data.encode('utf-8')).decode('utf-8')
                base64_data_url = "https://checkout.paycom.uz/{}".format(base64_data)
                return redirect(to=base64_data_url)
            elif order.payment.method == PaymentMethod.UZCARD:
                return redirect(reverse('orders:payment_uzcard', args=[order.phone, order.order_unique_id]))
            else:
                return redirect(reverse('main:home'))
        return redirect(reverse('main:home'))


class OrderDetail(DetailView):
    template_name = 'pages/order_detail.html'
    model = Order

    def get_object(self, queryset=None):
        phone = self.kwargs.get('phone')
        order_unique_id = self.kwargs.get('order_unique_id')
        return self.model.objects.get(order_unique_id=order_unique_id, phone=phone)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        order = self.get_object()
        client_data = cookie_parser(self.request.COOKIES.get('client_data'))
        cart_items = Cart.objects.filter(order=self.get_object())
        delivery_price = get_delivery_price(cart_items)
        products_price = total_quantity = 0

        for cart_item in cart_items:
            products_price += cart_item.total_price
            total_quantity += cart_item.count

        context['products_price'] = products_price
        context['total_amount'] = order.total_price
        context['total_quantity'] = total_quantity
        context['form'] = DeliveryAddressForm(self.request.POST or None)
        context['cart_items'] = cart_items
        context['client_data'] = client_data
        context['delivery_price'] = delivery_price
        return context


class OrderInvoiceDetail(DetailView):
    template_name = 'pages/invoice.html'
    model = Order

    def get_object(self, queryset=None):
        phone = self.kwargs.get('phone')
        order_unique_id = self.kwargs.get('order_unique_id')
        return self.model.objects.get(order_unique_id=order_unique_id, phone=phone)


class PayUzcard(TemplateView):
    template_name = 'pages/orders/payment_uzcard.html'
