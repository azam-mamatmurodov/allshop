# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models
from apps.order.models import Order


class PaycomTransaction(models.Model):
    paycom_transaction_id = models.CharField(max_length=255, null=False, unique=True)
    paycom_time = models.CharField(max_length=15)
    paycom_time_datetime = models.DateTimeField(null=False)
    create_time = models.DateTimeField(null=False)
    perform_time = models.DateTimeField(null=True, blank=True)
    cancel_time = models.DateTimeField(null=True, blank=True)
    amount = models.CharField(max_length=50, null=False)
    state = models.IntegerField(null=False)
    reason = models.IntegerField(null=True, blank=True)
    receivers = models.TextField(null=True, blank=True)

    order = models.ForeignKey(Order, default=22)

    def str(self):
        return "Order id {}".format(self.order.pk)

