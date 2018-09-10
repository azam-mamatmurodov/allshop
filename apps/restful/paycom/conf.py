from django.conf import settings

config = {
    'merchantId': settings.PAYME_MERCHANT_ID,
    'login': 'Paycom',
    'key': settings.PAYME_KEY
}
account_params = {'order_id', 'customer_id'}
