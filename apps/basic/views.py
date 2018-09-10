from django.views.generic import TemplateView, DetailView

from apps.basic.models import Static, StaticFooterPage
from apps.product.models import Product, Review, Brands


class HomeView(TemplateView):
    template_name = 'pages/main.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['top_products'] = Product.objects.filter(is_top=True)
        context['reviews'] = Review.objects.filter(is_approved=True)
        context['brands'] = Brands.objects.all()
        return context


class Filter(TemplateView):
    template_name = 'pages/filter.html'


class StaticView(DetailView):
    model = Static
    template_name = 'pages/static.html'

    def get_object(self, queryset=None):
        return self.model.objects.all().translated(slug=self.kwargs.get('slug')).first()


class StaticFooterPageView(DetailView):
    model = StaticFooterPage
    template_name = 'pages/static.html'

    def get_object(self, queryset=None):
        a = 5
        return self.model.objects.all().translated(slug=self.kwargs.get('slug')).first()