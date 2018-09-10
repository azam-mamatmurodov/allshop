from django.db import models
from django.contrib.auth.models import AbstractUser, BaseUserManager
from django.utils.translation import gettext_lazy as _
from django.conf import settings
from django.core.urlresolvers import reverse


class UserManager(BaseUserManager):

    use_in_migrations = True

    def _create_user(self, phone, password, **extra_fields):
        if not phone:
            raise ValueError('The given phone must be set')
        user = self.model(phone=phone, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, phone, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', False)
        extra_fields.setdefault('is_superuser', False)
        return self._create_user(phone, password, **extra_fields)

    def create_superuser(self, phone, password, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must have is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')

        return self._create_user(phone, password, **extra_fields)


class Files(models.Model):
    file = models.FileField(upload_to='files/', default='default.png')

    class Meta:
        verbose_name = _('File')
        verbose_name_plural = _('Files')


class User(AbstractUser):
    username = None
    phone = models.CharField(max_length=12, unique=True, verbose_name=_('Phone number or Username'))
    first_name = models.CharField(max_length=30, blank=True, verbose_name=_('First name'))
    last_name = models.CharField(max_length=30, blank=True, verbose_name=_('Last name'))
    date_joined = models.DateTimeField(auto_now_add=True, verbose_name=_('Date joined'),)
    is_active = models.BooleanField(default=True, verbose_name=_('Active'),)
    avatar = models.OneToOneField(to=Files, null=True, blank=True, verbose_name=_('Avatar'), )
    email = models.EmailField(blank=True, null=True)

    USERNAME_FIELD = 'phone'
    REQUIRED_FIELDS = ['first_name', ]
    objects = UserManager()

    class Meta:
        verbose_name = _('User')
        verbose_name_plural = _('Users')

    def __str__(self):
        return self.first_name if self.first_name else self.phone


class Client(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, related_name='client', verbose_name=_('Client user'))
    address = models.TextField(blank=True, null=True, verbose_name=_('Client address'))
    delivery_address = models.ForeignKey('DeliveryAddress', blank=True, null=True)

    def __str__(self):
        return "{}".format(self.user.get_full_name())


class Merchant(models.Model):
    PRODUCER = 1
    SUPPLIER = 2
    MERCHANT_TYPE = (
        (PRODUCER, _('Producer'),),
        (SUPPLIER, _('Supplier'),),
    )
    user = models.OneToOneField(settings.AUTH_USER_MODEL, related_name='merchant', verbose_name=_('Merchant user'))
    merchant_type = models.IntegerField(choices=MERCHANT_TYPE, verbose_name=_('Merchant type'))

    def __str__(self):
        return "{}".format(self.user.first_name)


class DeliveryAddress(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL,)
    address = models.TextField()
    email = models.EmailField(max_length=60)
    phone = models.CharField(max_length=60)
    is_default = models.BooleanField(default=False)


class PaymentCards(models.Model):
    import datetime
    holder = models.ForeignKey(settings.AUTH_USER_MODEL,)
    card_holder = models.CharField(verbose_name=_('Name on card'), max_length=60)
    cart_number = models.CharField(verbose_name=_('Card number'), max_length=60)
    expiration_date = models.DateField(default=datetime.date(2030, 2, 3))
    billing_address = models.TextField(blank=True, null=True, )
    is_default = models.BooleanField(default=False)

    @staticmethod
    def get_absolute_url():
        return reverse('users:profile_payment')

    class Meta:
        verbose_name = _('Payment method')
        verbose_name_plural = _('Payment methods')
