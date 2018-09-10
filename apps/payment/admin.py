# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib import admin

from apps.payment.models import PaycomTransaction


class PaycomTransactionAdmin(admin.ModelAdmin):
    list_display = ['customer', 'create_time', 'amount', 'state', 'order']

    @staticmethod
    def customer(obj):
        return obj.order.customer.first_name


admin.site.register(PaycomTransaction, PaycomTransactionAdmin)
