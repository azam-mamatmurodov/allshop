from django.conf.urls import url

from apps.product.views import (
    ProductListView,
    ProductDetail,
    SearchView,
)

urlpatterns = [
    url(r'^category/(?P<slug>[-\w]+)/$', ProductListView.as_view(), name='product_list'),
    url(r'^category/(?P<slug>[-\w]+)/product/(?P<pk>\d+)/$', ProductDetail.as_view(), name='product_detail'),
    url(r'^search/$', SearchView.as_view(), name='search', ),
]