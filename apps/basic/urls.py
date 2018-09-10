from django.conf.urls import url

from apps.basic.views import HomeView, StaticView, Filter, StaticFooterPageView

urlpatterns = [
    url(r'^$', HomeView.as_view(), name='home'),
    url(r'^filter/$', Filter.as_view(), name='filter'),
    url(r'^page/(?P<slug>[-\w]+)/$', StaticView.as_view(), name='static'),
    url(r'^static-page/(?P<slug>[-\w]+)/$', StaticFooterPageView.as_view(), name='static_footer'),
]