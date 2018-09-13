from django.views import generic
from django.views.generic.edit import FormMixin
from django.shortcuts import redirect, reverse
from django.contrib.auth import login, authenticate
from django.contrib import messages
from django.utils.translation import ugettext as _

from apps.account.forms import LoginForm, RegisterForm, DeliveryAddressForm, PaymentMethodForm
from apps.account.models import DeliveryAddress, PaymentCards
from apps.order.models import Order


class LoginView(generic.FormView):
    template_name = 'pages/accounts/login.html'
    form_class = LoginForm

    def get_success_url(self):
        if 'next' in self.request.GET:
            return self.request.GET['next']
        return reverse(' basic:home')

    def form_valid(self, form):
        username = form.cleaned_data.get('username')
        password = form.cleaned_data.get('passwd')
        user = authenticate(self.request, phone=username, password=password)

        if user:
            login(self.request, user=user)
            return redirect(to=self.get_success_url())
        else:
            form.add_error('username', 'invalid account credentials')
            return super().form_invalid(form=form)

    def form_invalid(self, form):
        return super().form_invalid(form=form)


class RegisterView(generic.FormView):
    template_name = 'pages/accounts/register.html'
    form_class = RegisterForm
    success_url = None

    def get_success_url(self):
        return reverse(' basic:home')

    def form_valid(self, form):
        user = form.save(commit=True)
        if authenticate(self.request, phone=user.phone, password=form.cleaned_data.get('password')):
            login(self.request, user=user)
        return super().form_valid(form=form)

    def dispatch(self, request, *args, **kwargs):
        if request.user.is_authenticated:
            return redirect(to=self.get_success_url())
        else:
            return super().dispatch(request=request, *args, **kwargs)


class ProfileView(generic.TemplateView):
    template_name = 'pages/accounts/profile.html'


class ProfileSettingsView(generic.TemplateView):
    template_name = 'pages/accounts/settings.html'


class ProfileOrdersView(generic.ListView):
    template_name = 'pages/accounts/orders.html'
    paginate_by = 5

    def get_queryset(self):
        return Order.objects.filter(customer=self.request.user)


class ProfileDeliveryView(generic.ListView, FormMixin):
    template_name = 'pages/accounts/delivery.html'
    model = DeliveryAddress
    form_class = DeliveryAddressForm

    def get_queryset(self):
        return self.model.objects.filter(user=self.request.user).order_by('-is_default')

    def post(self, request, *args, **kwargs):
        self.object_list = self.get_queryset()
        form = self.form_class(request.POST)
        if form.is_valid():
            _kwargs = {
                'user': request.user,
                'address': form.data.get('address'),
                'phone': form.data.get('phone'),
            }
            email = form.data.get('email', 'info@example.com')
            if email:
                _kwargs.update({
                    'email': email
                })
            is_default = form.data.get('is_default', 0)
            if is_default == 'on':
                _kwargs.update({
                    'is_default': 1
                })
                self.model.objects.filter(user=self.request.user, is_default=True).update(is_default=False)
            pk = form.data.get('object_id')
            if not pk:
                pk = None
            obj, created = self.model.objects.update_or_create(pk=pk, defaults=_kwargs)
            if created:
                message = _('Address successfully added')
            else:
                message = _('Address successfully updated')
            messages.add_message(request=request, level=messages.SUCCESS, message=message)
        return super().render_to_response(context=self.get_context_data(**kwargs))

    def get(self, request, *args, **kwargs):

        if request.GET.get('remove_id'):
            obj = self.model.objects.filter(id=request.GET.get('remove_id'))
            if obj.exists():
                obj.delete()
                message = _('Address successfully deleted')
                messages.add_message(request=request, level=messages.ERROR, message=message)
        return super().get(request, *args, **kwargs)


class ProfilePaymentView(generic.CreateView):
    template_name = 'pages/accounts/payments.html'
    model = PaymentCards
    form_class = PaymentMethodForm
    http_method_names = ['head', 'get', 'post', 'options', ]

    def get_context_data(self, **kwargs):
        remove_id = self.request.GET.get('remove_id')
        if remove_id:
            objs = self.model.objects.filter(pk=remove_id)
            if objs.exists():
                objs.delete()
        object_list = self.model.objects.filter(holder=self.request.user).exclude(is_default=True)
        context = super().get_context_data(**kwargs)
        context['object_list'] = object_list
        context['default_cards'] = self.model.objects.filter(holder=self.request.user, is_default=True)
        return context

    def form_valid(self, form):
        instance = form.save(commit=False)
        instance.holder = self.request.user
        is_default = form.data.get('is_default', 0)
        if is_default == 'on':

            self.model.objects.filter(holder=self.request.user, is_default=True).update(is_default=False)
            instance.is_default = 1

        instance.save()
        messages.add_message(request=self.request, level=messages.INFO,
                             message=_('Card data successfully added'))
        return super().form_valid(form)


class ProfilePaymentEdit(generic.UpdateView):
    template_name = 'pages/accounts/payments_edit.html'
    model = PaymentCards
    fields = ['card_holder', 'cart_number', 'expiration_date', 'billing_address', 'is_default', ]

    def get_success_url(self):
        return reverse('users:profile_payment')

    def form_valid(self, form):
        if form.data.get('is_default') == 'on':
            self.model.objects.filter(holder=self.request.user, is_default=True).exclude(pk=self.kwargs.get('pk')).update(is_default=False)
        return super().form_valid(form)