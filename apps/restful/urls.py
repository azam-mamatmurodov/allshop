from django.conf.urls import url

from apps.restful.views import (
    CartViews,
    CartDeleteViews,
    CartDetailViews,
    CartUpdateViews,
    UserAuthView,
    UserRegisterView,
    UserUpdateView,
    ProductDetailView,
    VariationDetailView,
    PaycomView,
    CartHtmlViews,
    OrderCreateView,
    DeliveryAddressCreateView,
    PaycomUzcardView
)

urlpatterns = [
    url(r'users/auth/$', UserAuthView.as_view(), name='user_auth'),
    url(r'users/register/$', UserRegisterView.as_view(), name='user_register'),
    url(r'users/(?P<user_id>[\d]+)/update/$', UserUpdateView.as_view(), name='user_update'),
    url(r'^cart/$', CartViews.as_view(), name='cart_list'),

    url(r'^cart/(?P<cart_item_id>[\d]+)/$', CartDetailViews.as_view(), name='cart_detail'),
    url(r'^cart/(?P<cart_item_id>[\d]+)/update/$', CartUpdateViews.as_view(), name='cart_update'),
    url(r'^cart/(?P<cart_item_id>[\d]+)/delete/$', CartDeleteViews.as_view(), name='cart_delete'),
    url(r'^carts/html/$', CartHtmlViews.as_view(), name='cart_html_list'),

    url(r'^products/(?P<pk>[\d]+)/$', ProductDetailView.as_view(), name='product_detail'),
    url(r'^products/(?P<pk>[\d]+)/variations/$', VariationDetailView.as_view(), name='product_variation_detail'),

    # url(r'^orders/$', OrderCreateView.as_view(), name='order_create'),
    url(r'^users/delivery-address/create/$', DeliveryAddressCreateView.as_view(), name='delivery_address_create'),
    url(r'^payment/paycom/$', PaycomView.as_view(), name='paycom'),
    url(r'^payment/paycom/uzcard/$', PaycomUzcardView.as_view(), name='paycom_uzcard'),
]

