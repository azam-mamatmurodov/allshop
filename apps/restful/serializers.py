from django.contrib.humanize.templatetags import humanize
from rest_framework import serializers

from apps.order.models import Cart, Order
from apps.product.models import Product, Variation
from apps.account.models import DeliveryAddress


class CartSerializer(serializers.ModelSerializer):
    total_weight = serializers.SerializerMethodField()
    total_price = serializers.SerializerMethodField()

    class Meta:
        model = Cart
        fields = '__all__'
        extra_fields = ['weight', ]

    @staticmethod
    def get_total_price(obj):
        return format(int(obj.total_price), ",").replace(',', ' ')

    @staticmethod
    def get_total_weight(obj):
        return obj.get_total_weight()


class ProductSerializer(serializers.ModelSerializer):
    variations = serializers.StringRelatedField(many=True,)

    class Meta:
        model = Product
        fields = '__all__'


class VariationSerializer(serializers.ModelSerializer):
    color_name = serializers.SerializerMethodField()
    color_code = serializers.SerializerMethodField()
    price = serializers.SerializerMethodField()

    class Meta:
        model = Variation
        fields = '__all__'

    @staticmethod
    def get_color_name(obj):
        return obj.color.name if obj.color else None

    @staticmethod
    def get_color_code(obj):
        return obj.color.color if obj.color else None

    @staticmethod
    def get_price(obj):
        return humanize.intcomma(int(obj.price))


class OrderSerializer(serializers.ModelSerializer):

    class Meta:
        model = Order
        exclude = ['state', 'products', ]


class DeliveryAddressSerializer(serializers.ModelSerializer):

    class Meta:
        model = DeliveryAddress
        fields = '__all__'
