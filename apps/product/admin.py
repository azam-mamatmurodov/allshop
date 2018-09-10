from django.contrib import admin
from django.utils.translation import ugettext as _
from django.conf.urls import url
from django.shortcuts import render, redirect
from django.http import FileResponse
from django.db.models import Q

from parler.admin import TranslatableAdmin
from mptt.admin import DraggableMPTTAdmin
from filer.models import File
from io import BytesIO
from pyexcel_xlsx import get_data
import pyexcel

from apps.product.models import *
from apps.account.models import Merchant
from apps.product.forms import ImportForm


class CategoryAdmin(TranslatableAdmin, DraggableMPTTAdmin):

    def get_prepopulated_fields(self, request, obj=None):
        return {'slug': ('name',),}

    mptt_level_indent = 20


class FeatureAdmin(TranslatableAdmin):
    def get_prepopulated_fields(self, request, obj=None):
        return {'slug': ('name',),}


class VariationAdmin(admin.TabularInline):
    model = Variation


class ProductImageAdmin(admin.TabularInline):
    model = ProductImage


class ColorAdmin(TranslatableAdmin):
    list_display = ['id', 'name', 'get_color', ]
    list_per_page = 100

    def get_queryset(self, request):
        return Color.objects.translated().order_by('translations__name')

    def get_color(self, obj):
        return '<div style="background:{}; width: 100px;">{}</div>'.format(obj.color, '&nbsp;')

    get_color.short_description = _('Color')
    get_color.allow_tags = True


class ReviewAdmin(admin.ModelAdmin):

    list_display = ['reviewer', 'subject', 'is_approved', ]
    list_filter = ['is_approved', ]


class ProductVariationAdmin(admin.ModelAdmin):
    list_display = ['name', 'price', 'quantity', 'color',]


class ProductAdmin(admin.ModelAdmin):
    inlines = [VariationAdmin, ]
    list_display = ['id', 'name', 'price', ]
    list_filter = ['brand', 'feature']

    change_list_template = 'admin/products/change_list.html'

    def get_urls(self):
        urls = super().get_urls()
        my_urls = [
            url('import/', self.import_products),
            url('export/', self.export_products),
        ]
        return my_urls + urls

    @staticmethod
    def excel_parser(file, sheet_name):
        excel_read = get_data(file)
        all_items = excel_read[sheet_name]

        head = all_items.pop(0)
        items = all_items
        products = list()
        for item in items:
            new_item = dict()
            for key, value in enumerate(head):
                try:
                    item_value = item[key]
                except IndexError:
                    item_value = None
                new_item.update({
                    value: item_value
                })
            products.append(new_item)
        return products

    def import_products(self, request):
        form = ImportForm()
        if request.method == "POST":
            form = ImportForm(request.POST and request.FILES)

            if form.is_valid():
                file = request.FILES["file"]
                sheet_name = 'products'
                products = self.excel_parser(file, sheet_name)

                for product in products:
                    name = product.get('name').strip()
                    kwargs = {
                        'category_id': product.get('category_id'),
                        'brand_id': product.get('brand'),
                        'name': name,
                        'volume_id': product.get('meas_type'),
                        'description': product.get('description'),
                        'characters': product.get('characters'),
                        'owner_id': Merchant.objects.get(pk=product.get('supplier')).user_id,
                        'is_top': product.get('is_top'),
                        'is_recommended': product.get('is_recommended'),
                        'available_in_stock': product.get('available_in_stock'),
                    }
                    # Images also
                    image_0_filename = product.get('image_0')
                    if image_0_filename:
                        image_0_file = File.objects.filter(Q(original_filename=image_0_filename) |
                                                           Q(original_filename__startswith=image_0_filename)).first()
                        kwargs.update({'image_0': image_0_file})

                    image_1_filename = product.get('image_1')
                    if image_1_filename:
                        image_1_file = File.objects.filter(Q(original_filename=image_1_filename) |
                                                           Q(original_filename__startswith=image_1_filename)).first()
                        kwargs.update({'image_1': image_1_file})

                    image_2_filename = product.get('image_2')
                    if image_2_filename:
                        image_2_file = File.objects.filter(Q(original_filename=image_2_filename) |
                                                           Q(original_filename__startswith=image_2_filename)).first()
                        kwargs.update({'image_2': image_2_file})

                    product_objects = Product.objects
                    product_instance = product_objects.filter(name__exact=name.strip())
                    if product_instance.exists():
                        product_instance.update(**kwargs)
                        product_instance = product_instance.first()
                    else:
                        product_instance = product_objects.create(**kwargs)

                    variation_kwargs = {
                        'name': product.get('size'),
                        'price': product.get('price'),
                        'quantity': product.get('inventory'),
                        'product_id': product_instance.pk,
                    }
                    if product.get('color'):
                        variation_kwargs.update({
                            'color_id': product.get('color')
                        })
                    variations = Variation.objects.filter(product_id=product_instance.pk, name=product.get('size'))
                    if variations.exists():
                        variations.update(**variation_kwargs)
                    else:
                        variations.create(**variation_kwargs)

                self.message_user(request, "Your products have been imported")
                return redirect("/admin/products/product/")
            payload = {"form": form}
            return render(
                request, "admin/products/products_import.html", payload
            )
        payload = {"form": form}
        return render(
            request, "admin/products/products_import.html", payload
        )

    def export_products(self, request):
        if request.method == "POST":
            variations = Variation.objects.all()
            products = list()
            products.append([
                'id',
                'category_id',
                'brand',
                'name',
                'meas_type',
                'description',
                'characters',
                'supplier',
                'image_0',
                'image_1',
                'image_2',
                'is_top',
                'is_recommended',
                'available_in_stock',
                'color',
                'size',
                'price',
                'inventory'
            ])
            for variation in variations:
                products.append([
                    variation.product.id,
                    variation.product.category_id,
                    variation.product.brand_id,
                    variation.product.name,
                    variation.product.volume_id,
                    variation.product.description,
                    variation.product.characters,
                    variation.product.owner.merchant.id,
                    variation.product.image_0.original_filename if variation.product.image_0 else '',
                    variation.product.image_1.original_filename if variation.product.image_1 else '',
                    variation.product.image_2.original_filename if variation.product.image_2 else '',
                    variation.product.is_top * 1,
                    variation.product.is_recommended * 1,
                    variation.product.available_in_stock * 1,
                    variation.color_id,
                    variation.name,
                    float(variation.price),
                    variation.quantity
                ])

            sheet_name = 'products'

            io = BytesIO()
            sheet = pyexcel.Sheet(products)
            sheet.sheet = sheet.name = sheet_name
            io = sheet.save_to_memory("xlsx", io)

            response = FileResponse(streaming_content=io,
                                    content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
            response['Content-Disposition'] = 'attachment; filename="products.xlsx"'
            return response

        return render(
            request, "admin/products/products_export.html"
        )


admin.site.register(Category, CategoryAdmin)
admin.site.register(Feature, FeatureAdmin)
admin.site.register(Brands)
admin.site.register(Product, ProductAdmin)
admin.site.register(Review, ReviewAdmin)
admin.site.register(Color, ColorAdmin)
admin.site.register(VolumeType, TranslatableAdmin)
admin.site.register(Variation, ProductVariationAdmin)
