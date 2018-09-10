from django.contrib import admin

from apps.order.models import Order, Cart


class CartAdmin(admin.ModelAdmin):
    list_display = ['session_key', 'get_variation', 'per_item_price', 'count', 'total_price', 'status', 'get_order', ]

    def per_item_price(self, obj):
        return "{}".format(obj.variation.price)

    per_item_price.short_description = "Price for per item"

    def get_variation(self, obj):
        return "{} - {}".format(obj.variation.product.name, obj.variation.name)

    def get_order(self, obj):
        if obj.order:
            return "<a href='/admin/orders/order/%s/change/'>%s</a>" % (obj.order.pk, 'Order - ' + str(obj.order.pk))
        else:
            return None
    get_order.allow_tags = True
    get_order.short_description = 'Order'

    get_variation.short_description = 'Product and variation'
    list_display_links = ['get_variation', 'get_order', ]


class OrderAdmin(admin.ModelAdmin):
    list_display = ['id', 'order_unique_id', 'client_name', 'phone', 'total_price', 'created', 'state', ]
    search_fields = ['client_name', 'phone', 'shipping_address', ]
    list_filter = ['state', ]


admin.site.register(Order, OrderAdmin)
admin.site.register(Cart, CartAdmin)
