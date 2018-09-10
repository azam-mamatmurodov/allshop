import datetime

from django import template
from django.template.loader import render_to_string
from django.conf import settings

from apps.order.models import PaymentMethod

register = template.Library()


def get_brands(category):
    brands = category.brands_set.all()
    if brands:
        return render_to_string('parts/brands.html', {'brands': brands})
    return ""


register.filter('get_brands', get_brands)


@register.filter(is_safe=True)
def is_numeric(value):
    return "{}".format(value).isdigit()


@register.filter()
def get_total_cost(value, value2):
    return int(value) + int(value2)


@register.simple_tag
def get_payment(method):
    payment_method = PaymentMethod.objects.get(method__exact=method)
    return payment_method


@register.simple_tag
def print_timestamp(timestamp):
    import pytz
    source_time = datetime.datetime.fromtimestamp(timestamp, tz=pytz.timezone(settings.TIME_ZONE))
    extra_time = source_time + datetime.timedelta(hours=6)
    return source_time.strftime("%H:%M"), extra_time.strftime("%H:%M, %d %b")


@register.filter(name='phone_number')
def phone_number(number):
    """Convert a 10 character string into (xx) xxxxxxx."""
    first = number[0:2]
    second = number[2:5]
    third = number[5:7]
    fourth = number[7:9]
    return first + ' ' + second + ' ' + third + ' ' + fourth


@register.simple_tag
def get_total_weight_from_count_and_weight(weight, count):
    return str(int(weight) * int(count))
