from django.views.generic import ListView, DetailView
from django.views.generic.edit import ProcessFormView
from django.utils.translation import ugettext as _
from django.shortcuts import Http404
from django.db.models import Q

from apps.product.models import Product, Category, Brands, Variation, Feature, Color
from apps.product.forms import LeaveReviewForm

ORDER_BY = (
    ('new_first', _('New first')),
    ('old_first', _('Old first')),
    ('a_z', _('Title asc')),
    ('z_a', _('Title desc')),
    ('price_asc',  _('Price asc')),
    ('price_desc', _('Price desc')),
)


class ProductListView(ListView):
    template_name = 'pages/product_list.html'
    model = Product
    paginate_by = 60

    def get_queryset(self):
        queryset = self.model.objects.all()
        if self.kwargs.get('slug') != 'all':
            try:
                category = Category.objects.get(translations__slug=self.kwargs.get('slug'))
            except Category.DoesNotExist:
                raise Http404
            queryset = queryset.filter(category__in=[cat_item.id for cat_item in category.get_family()])

        brands = self.request.GET.getlist('brand')
        if brands:
            queryset = queryset.filter(brand__in=brands)

        features = self.request.GET.getlist('feature')
        if features:
            queryset = queryset.filter(feature__in=features)

        colors = self.request.GET.getlist('color')
        if colors:
            queryset = queryset.filter(variations__color__in=colors)

        order_by = self.request.GET.get('order_by')
        if order_by:
            if order_by == 'z_a':
                ordering = '-name'
            elif order_by == 'a_z':
                ordering = 'name'
            elif order_by == 'price_asc':
                ordering = '-price'
            elif order_by == 'price_desc':
                ordering = 'price'
            elif order_by == 'new_first':
                ordering = '-pk'
            else:
                ordering = 'pk'
            queryset = queryset.order_by(ordering)
        return queryset

    def get_context_data(self, **kwargs):
        queryset = self.get_queryset()
        fields = queryset.values('brand', 'feature', ).distinct()
        print(fields)

        context = super(ProductListView, self).get_context_data(**kwargs)
        context['brands'] = Brands.objects.all()
        context['features'] = Feature.objects.all()
        context['colors'] = Color.objects.all()
        context['recommended_products'] = self.model.objects.filter(is_recommended=True)
        context['selected_brands'] = self.request.GET.getlist('brand')
        context['selected_features'] = self.request.GET.getlist('feature')
        context['selected_colors'] = self.request.GET.getlist('color')

        if self.kwargs.get('slug') != 'all':
            try:
                category = Category.objects.get(translations__slug=self.kwargs.get('slug'))
            except Category.DoesNotExist:
                raise Http404
            context['title'] = category.name
        else:
            context['title'] = _('All')
        context['orders'] = ORDER_BY
        return context


class ProductDetail(DetailView, ProcessFormView):
    template_name = 'pages/product_detail.html'
    model = Product
    context_object_name = 'product'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['review_form'] = LeaveReviewForm()
        context['similar_products'] = self.model.objects.filter(category=self.object.category).exclude(pk=self.object.pk)

        context['sizes'] = Variation.objects.filter(product=self.object).distinct('name')

        return context

    def post(self, request, *args, **kwargs):
        self.object = self.model.objects.get(pk=kwargs.get('pk'))
        context = self.get_context_data(**kwargs)

        review = LeaveReviewForm(data=request.POST)
        if review.is_valid():
            review_instance = review.save(commit=False)
            review_instance.product = self.object
            review_instance.save()
        else:
            context['review_form'] = review
        return self.render_to_response(context=context)


class SearchView(ListView):
    template_name = 'pages/search.html'
    model = Product

    def get_queryset(self):
        qs = super().get_queryset()
        if self.request.GET.get('search', None):
            searched_text = self.request.GET.get('search', None)
            qs = qs.filter(Q(name__contains=searched_text) | Q(category__translations__name__contains=searched_text) |
                           Q(description__contains=searched_text) | Q(characters__contains=searched_text))
        else:
            qs = list()
        return qs
