from django.conf.urls import url

from apps.order.views import (
    CartView,
    CheckoutView,
    OrderDetail,
    OrderInvoiceDetail,
    OrderAddressView,
    OrderTimeView,
    PaymentMethodView,
    PayUzcard,
)

urlpatterns = [
    url(r'^cart/$', CartView.as_view(), name='cart', ),
    url(r'^delivery-address/$', OrderAddressView.as_view(), name='address', ),
    url(r'^delivery-time/$', OrderTimeView.as_view(), name='time', ),
    url(r'^payment-method/$', PaymentMethodView.as_view(), name='payment_method', ),
    url(r'^checkout/$', CheckoutView.as_view(), name='checkout', ),
    url(r'^(?P<phone>[\w]+)/(?P<order_unique_id>[-\w]+)/$', OrderDetail.as_view(), name='order_detail', ),
    url(r'^(?P<phone>[\w]+)/(?P<order_unique_id>[-\w]+)/invoice/$',OrderInvoiceDetail.as_view(),
        name='order_invoice_detail', ),
    url(r'^(?P<phone>[\w]+)/(?P<order_unique_id>[-\w]+)/pay/$', PayUzcard.as_view(),
        name='payment_uzcard', ),
]