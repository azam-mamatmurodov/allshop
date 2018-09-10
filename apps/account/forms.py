from django import forms
from django.contrib.auth import get_user_model
from django.utils.translation import ugettext as _

from apps.account.models import Client, DeliveryAddress, PaymentCards

User = get_user_model()


class LoginForm(forms.Form):
    username = forms.CharField(max_length=60)
    passwd = forms.CharField(widget=forms.PasswordInput(), max_length=60)

    def clean(self):
        clean_data = super().clean()
        return clean_data


class RegisterForm(forms.ModelForm):
    first_name = forms.CharField(label=_('First name'))
    last_name = forms.CharField(label=_('Last name'))
    address = forms.CharField(widget=forms.Textarea(), required=False)
    password = forms.CharField(widget=forms.PasswordInput(), label=_('Password'))
    confirm_password = forms.CharField(widget=forms.PasswordInput(), label=_('Confirm password'))
    object_id = forms.CharField(widget=forms.HiddenInput())
    action_type = forms.CharField(widget=forms.HiddenInput())

    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'phone', 'password', ]

    def clean(self):
        cleaned_data = super().clean()

        if cleaned_data.get('password') != cleaned_data.get('confirm_password'):
            self.add_error('confirm_password', _('Passwords not match'))
        return cleaned_data

    def save(self, commit=True):
        instance = super().save(commit=False)
        instance.set_password(self.cleaned_data.get('password'))
        instance.save()
        client = Client()
        client.user = instance
        if self.cleaned_data.get('address'):
            client.address = self.cleaned_data.get('address')
        client.save()
        return instance


class DeliveryAddressForm(forms.ModelForm):
    is_default = forms.BooleanField(required=False, )

    class Meta:
        model = DeliveryAddress
        exclude = ['user', ]


class DeliveryAddressRestForm(forms.ModelForm):

    class Meta:
        model = DeliveryAddress
        exclude = ['user', ]


class PaymentMethodForm(forms.ModelForm):

    class Meta:
        model = PaymentCards
        exclude = ['holder']