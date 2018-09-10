from decimal import Decimal

from django.db import models
from django.utils.translation import ugettext as _
from django.conf import settings

from parler.models import TranslatableModel, TranslatedFields
from filer.fields.image import FilerFileField

from apps.product.models import Variation

DELIVERY_TIMES = (
    ('9_15', '9:00 - 15:00'),
    ('15_21', '15:00 - 21:00')
)


def get_price_for_weight(weight, same_kind_of_product=False):
    if 0 < weight <= 50:
        price = 25000
    elif 50 < weight <= 800:
        price = 50000
    elif 800 < weight <= 3000:
        if same_kind_of_product:
            price = 0
        else:
            price = 120000
    elif 3000 < weight <= 5000:
        if same_kind_of_product:
            price = 0
        else:
            price = 180000
    else:
        if same_kind_of_product:
            price = 0
        else:
            price = 240000
    return price


class PaymentMethod(TranslatableModel):
    UZCARD = 'uzcard'
    PAYME = 'payme'
    CASH_ON_DELIVERY = 'cash_on_delivery'

    PAYMENT_METHODS = (
        (UZCARD, 'Uzcard'),
        (PAYME, 'Payme'),
        (CASH_ON_DELIVERY, _('Cash on delivery')),
    )

    title = models.CharField(max_length=60)
    logo = FilerFileField(null=True)
    translations = TranslatedFields(
        description = models.TextField(null=True, blank=True)
    )
    method = models.CharField(choices=PAYMENT_METHODS, max_length=40, default=PAYMENT_METHODS[0][0], unique=True)

    def __str__(self):
        return "{}".format(self.title)


class Order(models.Model):
    AVAILABLE = 0
    AWAITING_PAYMENT = 1
    PAYMENT_COMPLETED = 2
    CANCELLED = 3
    DELIVERED = 4
    IN_PROCESS = -1
    ORDER_STATUS = (
        (AVAILABLE, _('Available')),
        (AWAITING_PAYMENT, _('Awaiting Payment')),
        (PAYMENT_COMPLETED, _('Payment completed')),
        (CANCELLED, _('Cancelled')),
        (DELIVERED, _('Delivered')),
        (IN_PROCESS, _('In process'))
    )
    customer = models.ForeignKey(settings.AUTH_USER_MODEL, blank=True, null=True)
    client_name = models.CharField(verbose_name=_('Client name'), max_length=60, default='')
    phone = models.CharField(max_length=12, verbose_name=_('Phone number'))
    shipping_address = models.TextField(_('Delivery address'))
    created = models.DateTimeField(auto_now_add=True, )
    order_unique_id = models.CharField(unique=True, blank=True, null=True, max_length=120, verbose_name=_('Order Id'), editable=False)
    products = models.TextField(null=True, blank=True)
    total_weight = models.IntegerField(default=50)
    delivery_price = models.FloatField(default=Decimal(25000))
    porter_work_price = models.FloatField(default=Decimal(0))
    products_price = models.FloatField(null=True)
    total_price = models.DecimalField(null=True, blank=True, max_digits=10, decimal_places=2)
    shipping_time = models.DateTimeField(null=True)
    need_porter = models.BooleanField(default=False)
    payment = models.ForeignKey(PaymentMethod, null=True)
    state = models.IntegerField(choices=ORDER_STATUS, default=ORDER_STATUS[0][0], blank=True)

    def str(self):
        return "Order - {}".format(self.pk)

    def get_order_status(self, status_key):
        status_value = status_key
        for status in self.ORDER_STATUS:
            if status[0] == status_key:
                status_value = status[1]
                break
        return status_value

    @property
    def get_status(self):
        return self.ORDER_STATUS[self.state][1]

    def get_items(self):
        return self.cart_set.all()

    @staticmethod
    def get_total_price(obj):
        return obj.total_price * 100


class Cart(models.Model):
    session_key = models.CharField(max_length=255)
    variation = models.ForeignKey(to=Variation, )
    count = models.IntegerField()
    status = models.BooleanField(default=True)
    order = models.ForeignKey(Order, blank=True, null=True, )
    total_price = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        verbose_name = _('Cart item')
        verbose_name_plural = _('Cart items')

    def __str__(self):
        return "{}".format(self.session_key)

    def set_total_price(self, count):
        self.total_price = Decimal(count) * self.variation.price

    def get_total_weight(self):
        if self.variation.name.isdigit():
            return "{}  {}".format(str(int(self.variation.name) * int(self.count)), self.variation.product.volume.name)
        return str()
