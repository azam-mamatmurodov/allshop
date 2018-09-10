from django.db import models
from django.utils.translation import gettext_lazy as _
from parler.models import TranslatableModel, TranslatedFields
from parler.managers import TranslationManager
from ckeditor_uploader.fields import RichTextUploadingField


class Menu(TranslatableModel):
    translations = TranslatedFields(
        name=models.CharField(max_length=60, verbose_name=_('Name')),
        slug=models.SlugField(max_length=60, verbose_name=_('Slug')),
    )

    order = models.IntegerField(default=0, verbose_name=_('Order'))
    objects = TranslationManager()

    def __str__(self):
        return "{}".format(self.name)


class UserMenu(TranslatableModel):
    translations = TranslatedFields(
        name=models.CharField(max_length=60, verbose_name=_('Name')),
        slug=models.SlugField(max_length=60, verbose_name=_('Slug')),
    )

    order = models.IntegerField(default=0, verbose_name=_('Order'))
    objects = TranslationManager()

    def __str__(self):
        return "{}".format(self.name)


class CustomerMenu(TranslatableModel):
    translations = TranslatedFields(
        name=models.CharField(max_length=60, verbose_name=_('Name')),
        slug=models.SlugField(max_length=60, verbose_name=_('Slug')),
    )

    order = models.IntegerField(default=0, verbose_name=_('Order'))
    objects = TranslationManager()

    def __str__(self):
        return "{}".format(self.name)


class Banner(TranslatableModel):
    translations = TranslatedFields(
        name=models.CharField(max_length=60, verbose_name=_('Name')),
        slug=models.SlugField(max_length=60, verbose_name=_('Slug')),
        image=models.ImageField(upload_to='banners/%Y/%m/%d', verbose_name=_('Image')),
    )

    order = models.IntegerField(default=0, verbose_name=_('Order'))
    objects = TranslationManager()

    def __str__(self):
        return "{}".format(self.name)


class Static(TranslatableModel):
    translations = TranslatedFields(
        name=models.CharField(max_length=60, verbose_name=_('Name')),
        slug=models.SlugField(max_length=60, verbose_name=_('Slug')),
        image=models.ImageField(upload_to='banners/%Y/%m/%d', verbose_name=_('Image'), null=True, blank=True,),
        body=RichTextUploadingField()
    )
    objects = TranslationManager()

    def __str__(self):
        return "{}".format(self.name)


class StaticFooterPage(TranslatableModel):
    TARGET_CHOICES = (
        (0, 'For clients'),
        (1, 'For partners'),
    )

    translations = TranslatedFields(
        name=models.CharField(max_length=60, verbose_name=_('Name')),
        slug=models.SlugField(max_length=60, verbose_name=_('Slug')),
        body=RichTextUploadingField()
    )
    menu_type = models.IntegerField(choices=TARGET_CHOICES, blank=True, null=True)
    # target_type = models.CharField(choices=TARGET_CHOICES, max_length=12, default='clients')
    image = models.ImageField(upload_to='banners/%Y/%m/%d', verbose_name=_('Image')),
    objects = TranslationManager()

    def __str__(self):
        return "{}".format(self.name)