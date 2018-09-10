from decimal import Decimal
import uuid
import json

from django.http.response import JsonResponse
from django.utils.translation import ugettext as _
from django.contrib.auth import authenticate, login
from django.db.models import Sum
from django.core.urlresolvers import reverse_lazy
from django.conf import settings

from rest_framework import renderers
from rest_framework import views, generics, status, response, viewsets, parsers

from apps.restful.serializers import (
    CartSerializer,
    ProductSerializer,
    VariationSerializer,
    OrderSerializer,
    DeliveryAddressSerializer
)
from apps.order.models import Cart, Order
from apps.order.views import cookie_parser
from apps.product.models import Variation, Product
from apps.account.models import User, Client
from apps.account.forms import DeliveryAddressRestForm

from .paycom.Application import Application


class CartViews(generics.ListAPIView, generics.CreateAPIView):
    serializer_class = CartSerializer
    queryset = None
    session_key = None
    model = Cart

    def get_cart_items(self):
        cart_instances = self.get_queryset()
        cart_items = []
        total_price = Decimal()
        for cart_instance in cart_instances:
            cart_items.append({
                'product': cart_instance.variation.product.name,
                'variation': cart_instance.variation.name,
                'count': cart_instance.count,
                'price': cart_instance.variation.price,
                'total_price': cart_instance.total_price,
                'total_weight': cart_instance.get_total_weight(),
            })
            total_price += Decimal(cart_instance.total_price)
        return {'total_price': "{:,}".format(int(total_price)).replace(',', ' '), 'items': cart_items}

    def get(self, request, *args, **kwargs):

        return JsonResponse(data=self.get_cart_items(), safe=False)

    def get_queryset(self):
        session_key = self.request.COOKIES.get('client_id')
        cart_instances = self.model.objects.filter(session_key=session_key, status=True, order__isnull=True)
        return cart_instances

    def create(self, request, *args, **kwargs):
        session_key = self.request.COOKIES.get('client_id')

        self.session_key = session_key
        variation_id = request.data.get('variation')
        quantity = int(request.data.get('count'))
        variation = Variation.objects.get(id=variation_id)

        if int(variation.quantity) < quantity:
            msg = _('Not enough quantity')
            message = {
                'status': 'fail',
                'message': _(msg)
            }
            return JsonResponse(data=message)

        total_price = Decimal(variation.price) * Decimal(quantity)

        new_cart_item, created = Cart.objects.get_or_create(session_key=self.session_key, variation=variation, order=None, defaults={
            "count": quantity,
            "total_price": total_price
        })
        if not created:
            total_quantity = new_cart_item.count + quantity
            if variation.quantity < total_quantity:
                msg = _('Not enough quantity')
                message = {
                    'status': 'fail',
                    'message': _(msg)
                }
                return JsonResponse(data=message)
            else:
                new_cart_item.count = total_quantity
                new_cart_item.total_price = new_cart_item.count * new_cart_item.variation.price
                new_cart_item.save()
                msg = _('Cart successfully updated')
        else:
            msg = _('Successful added')
        message = {
            'status': 'success',
            'message': _(msg)
        }
        return JsonResponse(data=message)


class CartDetailViews(generics.RetrieveAPIView):
    serializer_class = CartSerializer
    queryset = None
    model = Cart
    lookup_field = "cart_item_id"

    def get_object(self):
        session_key = self.request.COOKIES.get('client_id')
        cart_item = Cart.objects.filter(session_key=session_key, id=self.kwargs.get('cart_item_id')).first()
        return cart_item


class CartDeleteViews(generics.DestroyAPIView):
    serializer_class = CartSerializer
    queryset = None
    model = Cart
    lookup_field = "cart_item_id"

    def get_object(self):
        session_key = self.request.COOKIES.get('client_id')
        cart_item_id = self.kwargs.get('cart_item_id')
        cart_item = Cart.objects.get(id=cart_item_id)
        return cart_item

    def destroy(self, request, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        msg = {
            'message': _('Successful removed'),
            'status': 'success'
        }
        return views.Response(data=msg, status=status.HTTP_204_NO_CONTENT)


class CartUpdateViews(generics.UpdateAPIView):
    serializer_class = CartSerializer
    queryset = None
    model = Cart
    lookup_field = "cart_item_id"

    def get_object(self):
        session_key = self.request.COOKIES.get('client_id')
        cart_item = Cart.objects.get(session_key=session_key, id=self.kwargs.get('cart_item_id'))
        return cart_item

    def update(self, request, *args, **kwargs):
        count = request.data.get('count')
        instance = self.get_object()
        instance.count = count
        instance.set_total_price(count)

        self.perform_update(instance)
        msg = {
            'message': _('Successful saved'),
            'status': 'success',
            'data': CartSerializer(instance=instance).data
        }
        return views.Response(data=msg, status=status.HTTP_202_ACCEPTED)


class CartHtmlViews(generics.ListAPIView):
    session_key = None
    model = Cart
    renderer_classes = [renderers.TemplateHTMLRenderer]
    template_name = 'rest/cart.html'

    def list(self, request, *args, **kwargs):
        session_key = self.request.COOKIES.get('client_id')
        cart_items = self.model.objects.filter(session_key=session_key, status=True, order__isnull=True)
        order_total = cart_items.aggregate(Sum('total_price')).get('total_price__sum', 0)
        return response.Response({'cart_items': cart_items, 'order_total': order_total}, template_name=self.template_name)


class UserAuthView(views.APIView):
    def post(self, request):
        if request.POST.get('username') and request.POST.get('passwd'):
            username = request.POST.get('username')
            passwd = request.POST.get('passwd')
            user = authenticate(request, username=username, password=passwd)
            if user:
                login(request, user)
                data = {
                    'status': 'success',
                    'message': _('Successful authenticated')
                }
            else:
                data = {
                    'status': 'failed',
                    'message': _('Invalid credentials')
                }
            return JsonResponse(data)
        return response.Response('Response')


class UserRegisterView(views.APIView):
    def post(self, request):
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        phone = request.POST.get('phone')
        address = request.POST.get('address')
        password = request.POST.get('password')
        confirm_password = request.POST.get('confirm_password')

        if first_name and last_name and phone and password and confirm_password:
            if User.objects.filter(phone=phone).exists():
                data = {
                    'status': 'failed',
                    'fields': [
                        {
                            'message': 'User already exists',
                            'field': 'phone'
                        },
                    ]
                }
            else:
                user = User.objects.create_user(phone=phone, password=password)
                user.first_name = first_name
                user.last_name = last_name
                user.save()
                client = Client()
                client.user = user
                if address:
                    client.address = address
                client.save()
                user = authenticate(request, username=phone, password=password)
                if user:
                    login(request, user)
                    data = {
                        'status': 'success',
                        'message': 'Successful registered'
                    }
                else:
                    data = {
                        'status': 'failed',
                        'message': 'Invalid credentials'
                    }
            return JsonResponse(data)
        return response.Response('Response')


class UserUpdateView(views.APIView):

    def post(self, request, *args, **kwargs):
        user_id = kwargs.get('user_id')
        try:
            user = User.objects.get(pk=user_id)
        except User.DoesNotExist:
            message = {'message': _('Sorry, something went wrong'), 'status': 'fail'}
            return JsonResponse(data=message)
        available_fields = ['phone', 'first_name', 'last_name', 'password', 'password_old', 'address', 'email', ]
        data_list = request.POST.get('data')
        data = json.loads(data_list)
        if isinstance(data, list):
            field_name = data[0].get('field_name')
            field_data = data[0].get('field_data')
        else:
            field_name = data.get('field_name')
            field_data = data.get('field_data')

        if field_name in available_fields:
            if field_name == 'password_old':
                new_password = data[1].get('field_data')
                confirm_password = data[2].get('field_data')

                if user.check_password(field_data):
                    if new_password == confirm_password:
                        user.set_password(new_password)
                    else:
                        message = {'message': _('Sorry, wrong confirm password'), 'status': 'fail'}
                        return JsonResponse(data=message)
                else:
                    message = {'message': _('Sorry, incorrect old password'), 'status': 'fail'}
                    return JsonResponse(data=message)
            elif field_name == 'address':
                user.client.address = field_data
                user.client.save()
            else:
                setattr(user, field_name, field_data)
            message = {'message': _('Successfully updated'), 'status': 'success'}
            user.save()
        else:
            message = {'message': _('Sorry, something went wrong'), 'status': 'fail'}

        return JsonResponse(data=message)


class ProductDetailView(generics.RetrieveAPIView):
    serializer_class = ProductSerializer
    queryset = Product.objects.all()


class VariationDetailView(generics.ListAPIView):
    serializer_class = VariationSerializer

    def get_queryset(self):
        variations = Variation.objects.filter(product_id=self.kwargs.get('pk'))
        name = self.request.GET.get('name')
        if name:
            variations = variations.filter(name=name)
        return variations


class PaycomView(views.APIView):
    def post(self, request):
        app = Application(request=request)
        response = app.run()
        import json
        new_data = json.loads(response)
        return JsonResponse(data=new_data, safe=False)


class PaycomUzcardView(views.APIView):
    def post(self, request, *args, **kwargs):
        import requests
        import json
        payload = request.POST.get('data')
        url = "https://checkout.test.paycom.uz/api"

        headers = {
            'X-Auth': settings.PAYME_MERCHANT_ID,
            'Content-Type': "application/json",
            'Cache-Control': "no-cache"
        }

        response = requests.request("POST", url, data=payload, headers=headers)
        response_obj = json.loads(response.text)
        print(payload)
        print(response_obj)
        return JsonResponse(data=response_obj, safe=False)


class OrderCreateView(views.APIView):
    def get_cart_items(self, request):
        current_user_session_key = request.COOKIES.get('client_id')
        cart_items = Cart.objects.filter(session_key=current_user_session_key, status=True, order__isnull=True)
        return cart_items

    def post(self, request, *args, **kwargs):
        client_data = cookie_parser(request.COOKIES.get('client_data'))
        order = Order()
        order.shipping_address = client_data.get('shipping_address')
        order.phone = client_data.get('phone')
        order.client_name = client_data.get('client_name')
        if request.user.is_authenticated:
            order.customer = request.user
        order.save()
        cart_items = self.get_cart_items(self.request)
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
        order.total_price = Decimal(total_price)
        order.order_unique_id = uuid.uuid4()
        order.save()

        order_detail_url = reverse_lazy('orders:order_detail', args=[order.phone, order.order_unique_id])
        data = {'message': _('Order successful placed'), 'status': 'success', 'redirect_url': order_detail_url}
        return JsonResponse(data=data, safe=False)


class DeliveryAddressCreateView(views.APIView):
    renderer_classes = [renderers.TemplateHTMLRenderer]

    def post(self, request, *args, **kwargs):
        form = DeliveryAddressRestForm(request.POST)
        if form.is_valid():
            address_instance = form.save(commit=False)
            address_instance.user = request.user
            address_instance.is_default = False
            address_instance.save()
            return JsonResponse(data={'message': 'test message'}, status=status.HTTP_201_CREATED)
        else:
            return response.Response(template_name='rest/delivery_address_form.html', data={'form': form}, status=status.HTTP_200_OK)

    def get(self, request, *args, **kwargs):
        form = DeliveryAddressRestForm()
        return response.Response(template_name='rest/delivery_address_form.html', data={'form': form})