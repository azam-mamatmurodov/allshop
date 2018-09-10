from django.db import models
from django.utils.translation import gettext_lazy as _
from django.conf import settings
from django.shortcuts import reverse

from mptt.models import MPTTModel, TreeForeignKey
from parler.models import TranslatableModel, TranslatedFields
from parler.managers import TranslationManager
from ckeditor_uploader.fields import RichTextUploadingField
from colorfield.fields import ColorField
from filer.fields import image

import os


class Category(MPTTModel, TranslatableModel):
    parent = TreeForeignKey('self', null=True, blank=True,)
    translations = TranslatedFields(
        name=models.CharField(max_length=60, verbose_name=_('Name')),
        slug=models.SlugField(verbose_name=_('Slug'), unique=True,),
    )

    order = models.IntegerField(default=0)

    objects = TranslationManager()

    def __str__(self):
        return "{}".format(self.name)

    class MPTTMeta:
        level_attr = 'mptt_level'

    class Meta:
        verbose_name = _('Category')
        verbose_name_plural = _('Categories')

    def get_slug_list(self):
        try:
            ancestors = self.get_ancestors(include_self=self)
        except:
            ancestors = []
        else:
            ancestors = [i.slug for i in ancestors]
        slugs = []
        for i in range(len(ancestors)):
            slugs.append('/'.join(ancestors[i + 1]))
        return slugs


class Feature(TranslatableModel):
    translations = TranslatedFields(
        name=models.CharField(max_length=60, verbose_name=_('Name'), unique=True),
        slug=models.SlugField(verbose_name=_('Slug'), unique=True, ),
    )

    objects = TranslationManager()

    class Meta:
        verbose_name = _('Feature')
        verbose_name_plural = _('Features')

    def __str__(self):
        return "{}".format(self.safe_translation_getter('name'))


class Brands(models.Model):
    name = models.CharField(max_length=60, verbose_name=_('Name'))
    logo = models.ImageField(upload_to='brands/', verbose_name=_('Logo'))
    category = TreeForeignKey(Category, null=True,)

    class Meta:
        verbose_name = _('Brand')
        verbose_name_plural = _('Brands')

    def __str__(self):
        return "{}".format(self.name)


class ProductImage(models.Model):
    image = models.ImageField(upload_to='products/', verbose_name=_('Image'), default='default.png')
    product = models.ForeignKey('Product', verbose_name=_('Product'), related_name='images')

    def rename(self, new_name):
        old_path = self.image.path
        self.image.name = new_name

        os.rename(old_path, self.image.path)
        self.save()


class Color(TranslatableModel):
    translations = TranslatedFields(
        name=models.CharField(max_length=60),
    )
    color = ColorField(default='#FF0000')

    objects = TranslationManager()

    def __str__(self):
        return "{}".format(self.name)

    class Meta:
        verbose_name = _('Color')
        verbose_name_plural = _('Colors')


class VolumeType(TranslatableModel):
    translations = TranslatedFields(
        name=models.CharField(max_length=60,),
    )

    def __str__(self):
        return "{}".format(self.name)


class Variation(models.Model):
    name = models.CharField(max_length=60)
    price = models.DecimalField(decimal_places=2, max_digits=10, verbose_name=_('Price'),)
    quantity = models.IntegerField(verbose_name=_('Quantity'))
    product = models.ForeignKey('Product', verbose_name=_('Product'), related_name='variations')
    color = models.ForeignKey(Color, null=True, blank=True,)

    def __str__(self):
        if self.color:
            return "{} {}".format(self.name, self.color)
        else:
            return "{}".format(self.name)

    class Meta:
        verbose_name = _('Variation')
        verbose_name_plural = _('Variations')


class Product(models.Model):
    name = models.CharField(max_length=120, verbose_name=_('Product name'), )
    category = TreeForeignKey(Category, verbose_name=_('Category'), )
    feature = models.ForeignKey(Feature, null=True, blank=True)
    brand = models.ForeignKey(Brands, verbose_name=_('Brand'), )
    description = RichTextUploadingField(blank=True, null=True, verbose_name=_('Description'), )
    characters = RichTextUploadingField(blank=True, null=True, verbose_name=_('Characters'), )
    owner = models.ForeignKey(settings.AUTH_USER_MODEL, verbose_name=_('Product Owner'), related_name='products', )
    volume = models.ForeignKey(VolumeType, verbose_name=_('Volume type'))
    updated = models.DateField(auto_now=True, auto_created=True, )
    available_in_stock = models.BooleanField(default=True, verbose_name=_('Available in stock'))
    is_recommended = models.BooleanField(default=False, verbose_name=_('Is recommended'))
    price = models.DecimalField(decimal_places=2, max_digits=10, verbose_name=_('Price'), null=True, blank=True, )
    is_top = models.BooleanField(default=False)
    image_0 = image.FilerImageField(verbose_name=_('First image'), null=True, related_name='product_image0')
    image_1 = image.FilerImageField(verbose_name=_('Second image'),  null=True, blank=True, related_name='product_image1')
    image_2 = image.FilerImageField(verbose_name=_('Third image'),  null=True, blank=True, related_name='product_image2')

    default_image = models.CharField(choices=(
        ('image_0', 'First image', ),
        ('image_1', 'Second image', ),
        ('image_2', 'Third image', ),
    ), max_length=60, default='image_0')

    def __str__(self):
        return "{}".format(self.name)

    def is_color_exist(self, obj):
        return self.variations.all().first().color

    def get_default_image(self):
        return getattr(self, self.default_image)

    def get_all_images(self):
        images = list()
        images.append(self.image_0)
        if self.image_1:
            images.append(self.image_1)
        if self.image_2:
            images.append(self.image_2)
        return images

    def get_price(self):
        if not self.price:
            self.price = self.get_default_variation().price
            self.save()
        return self.price

    def get_default_variation(self):
        return self.variations.first()

    def get_variations(self):
        return self.variations.filter(product=self).distinct('name')

    def get_reviews(self):
        return self.product_reviews.filter(is_approved=True)

    def get_absolute_url(self):
        return reverse('products:product_detail', args=[self.category.slug, self.pk])

    class Meta:
        verbose_name = _('Product')
        verbose_name_plural = _('Products')


# def my_pre_save_handler(sender, instance, *args, **kwargs):
#     if not instance.variations.price:
#         instance.variations.price = instance.price
#         instance.variations.save()
#         print(instance.price)


# pre_save.connect(my_pre_save_handler, sender=Variation)


class Review(models.Model):
    product = models.ForeignKey(Product, related_name='product_reviews',)
    reviewer = models.CharField(max_length=120, )
    reviewer_location = models.CharField(max_length=120, blank=True, null=True, )
    subject = models.CharField(max_length=60)
    text = models.TextField()
    is_approved = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_created=True, auto_now_add=True,)

    def __str__(self):
        return "{}".format(self.subject)
