from django.conf.urls import url
from django.contrib.auth.views import LogoutView
from django.contrib.auth.decorators import login_required

from apps.account.views import (
    LoginView,
    RegisterView,
    ProfileView,
    ProfileSettingsView,
    ProfileOrdersView,
    ProfileDeliveryView,
    ProfilePaymentView,
    ProfilePaymentEdit,
)


urlpatterns = [
    url(r'^login/$', LoginView.as_view(), name='login', ),
    url(r'^logout/$', login_required(LogoutView.as_view(next_page='/')), name='logout', ),
    url(r'^register/$', RegisterView.as_view(), name='register', ),
    url(r'^$', login_required(ProfileView.as_view()), name='profile', ),
    url(r'^security/$', login_required(ProfileSettingsView.as_view()), name='profile_security', ),
    url(r'^orders/$', login_required(ProfileOrdersView.as_view()), name='profile_orders', ),
    url(r'^delivery/$', login_required(ProfileDeliveryView.as_view()), name='profile_delivery', ),
    url(r'^payment/$', login_required(ProfilePaymentView.as_view()), name='profile_payment', ),
    url(r'^payment/(?P<pk>\d+)/edit/$', login_required(ProfilePaymentEdit.as_view()), name='profile_payment_edit', ),
]