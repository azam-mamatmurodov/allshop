from django.contrib import admin
from parler.admin import TranslatableAdmin
from apps.basic.models import (
    Menu,
    Banner,
    Static,
    UserMenu,
    CustomerMenu,
    StaticFooterPage,
)

from apps.order.models import PaymentMethod


class MenuAdmin(TranslatableAdmin):
    def get_prepopulated_fields(self, request, obj=None):
        return {'slug': ('name',), }


class BannerAdmin(TranslatableAdmin):
    def get_prepopulated_fields(self, request, obj=None):
        return {'slug': ('name',), }


class StaticAdmin(TranslatableAdmin):
    def get_prepopulated_fields(self, request, obj=None):
        return {'slug': ('name',), }
    list_display = ['name', 'slug', ]


class StaticFooterPageAdmin(TranslatableAdmin):
    def get_prepopulated_fields(self, request, obj=None):
        return {'slug': ('name',), }
    list_display = ['name', 'slug', ]


admin.site.register(Menu, MenuAdmin)
admin.site.register(UserMenu, TranslatableAdmin)
admin.site.register(CustomerMenu, TranslatableAdmin)
admin.site.register(Banner, BannerAdmin)
admin.site.register(Static, StaticAdmin)
admin.site.register(StaticFooterPage, StaticFooterPageAdmin)
admin.site.register(PaymentMethod, TranslatableAdmin)
