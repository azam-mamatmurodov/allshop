import os
from django.conf import global_settings
from django.utils.translation import gettext_lazy as _
import raven
import django.conf.locale

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

ADMINS = (
    ('A\'zam', 'azam.mamatmurodov@gmail.com'),
)

MANAGERS = ADMINS


SECRET_KEY = 'e(1xn_n$j!d3$kg6t^)w+yy&)ncs1kxq6%wveov&nyv-+cz2k7'

DEBUG = True

ALLOWED_HOSTS = ['*']

PROJECT_APPS = [
    'apps.account',
    'apps.basic',
    'apps.order',
    'apps.payment',
    'apps.product',
    'apps.restful',
]

BUILT_IN_APPS = [
    # 'suit',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.humanize',
]

THIRD_PARTY_APPS = [
    'easy_thumbnails',
    'filer',
    'mptt',
    'parler',
    'ckeditor',
    'ckeditor_uploader',
    'colorfield',
    'solid_i18n',
    'django_filters',
    'rest_framework',
    'rest_framework_swagger',
    'django_extensions',
    # 'raven.contrib.django.raven_compat',
]
INSTALLED_APPS = BUILT_IN_APPS + THIRD_PARTY_APPS + PROJECT_APPS

MIDDLEWARE = [
    'raven.contrib.django.raven_compat.middleware.Sentry404CatchMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.locale.LocaleMiddleware',
    'solid_i18n.middleware.SolidLocaleMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'apps.basic.middleware.CustomMiddleware',
]

ROOT_URLCONF = 'project.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
                'django.template.context_processors.i18n',
                'django.template.context_processors.request',
            ],
        },
    },
]

WSGI_APPLICATION = 'project.wsgi.application'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'allshop',
        'USER': 'allshop',
        'PASSWORD': 'allshop',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}


AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

LANGUAGE_CODE = 'ru'

LANGUAGES = (
    (u'ru', u"Русский"),
    (u'uz', u"O'zbek"),
    (u'en', u"English"),
)

TIME_ZONE = 'Asia/Tashkent'

USE_I18N = True

USE_L10N = True

USE_TZ = True

LOCALE_PATHS = (
    os.path.join(BASE_DIR, 'locale'),
)

STATIC_URL = '/static/'

STATIC_ROOT = os.path.join(BASE_DIR, 'assets')

STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static'),
]

AUTH_USER_MODEL = 'account.User'

GEOPOSITION_GOOGLE_MAPS_API_KEY = 'AIzaSyAuTEIFO4f4ASMDh8tvdFaDGPo0815fIrQ'

PARLER_DEFAULT_LANGUAGE_CODE = LANGUAGE_CODE

PARLER_LANGUAGES = {
    None: (
        {'code': 'ru',},
        {'code': 'en',},
        {'code': 'uz',},
    ),
    'default': {
        'fallbacks': [LANGUAGE_CODE],          # defaults to PARLER_DEFAULT_LANGUAGE_CODE
        'hide_untranslated': False,   # the default; let .active_translations() return fallbacks too.
    }
}


EXTRA_LANG_INFO = {
    'uz': {
        'bidi': False,
        'code': 'uz',
        'name': 'Uzbek',
        'name_local': u"O'zbek",

    },
}

LANG_INFO = django.conf.locale.LANG_INFO
django.conf.locale.LANG_INFO = LANG_INFO
global_settings.LANGUAGES = global_settings.LANGUAGES + [("uz", 'Uzbek')]

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')


VOLUME_TYPES = (
    ('kg', _('KG'),),
    ('l', _('Litr'),),
)


CKEDITOR_JQUERY_URL = 'https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js'

CKEDITOR_UPLOAD_PATH = 'uploads/'
CKEDITOR_IMAGE_BACKEND = "pillow"

CKEDITOR_CONFIGS = {
    'default': {
        'toolbar': None,
    },
}

MPTT_ADMIN_LEVEL_INDENT = 20

REST_FRAMEWORK = {
    'PAGE_SIZE': 10,
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    'DEFAULT_FILTER_BACKENDS': (
        'rest_framework.filters.SearchFilter',
        'django_filters.rest_framework.DjangoFilterBackend',
    ),
    'DEFAULT_PARSER_CLASSES': (
        'rest_framework.parsers.JSONParser',
        'rest_framework.parsers.FormParser',
        'rest_framework.parsers.MultiPartParser'
    ),
    'DEFAULT_RENDERER_CLASSES': (
        'rest_framework.renderers.JSONRenderer',
        'rest_framework.renderers.BrowsableAPIRenderer',
        'rest_framework.renderers.TemplateHTMLRenderer',
    ),
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.SessionAuthentication',
    ),
}

# CACHES = {
#     "default": {
#         "BACKEND": "django_redis.cache.RedisCache",
#         "LOCATION": "redis://127.0.0.1:6379/1",
#         "OPTIONS": {
#             "CLIENT_CLASS": "django_redis.client.DefaultClient",
#         }
#     }
# }


#
# LOGGING = {
#     'version': 1,
#     'disable_existing_loggers': False,
#     'root': {
#         'level': 'WARNING',
#         'handlers': ['sentry'],
#     },
#     'formatters': {
#         'verbose': {
#             'format': '%(levelname)s %(asctime)s %(module)s '
#                       '%(process)d %(thread)d %(message)s'
#         },
#     },
#     'handlers': {
#         'sentry': {
#             'level': 'ERROR', # To capture more than ERROR, change to WARNING, INFO, etc.
#             'class': 'raven.contrib.django.raven_compat.handlers.SentryHandler',
#             'tags': {'custom-tag': 'x'},
#         },
#         'console': {
#             'level': 'DEBUG',
#             'class': 'logging.StreamHandler',
#             'formatter': 'verbose'
#         }
#     },
#     'loggers': {
#         'django.db.backends': {
#             'level': 'ERROR',
#             'handlers': ['sentry', 'console'],
#             'propagate': False,
#         },
#         'raven': {
#             'level': 'ERROR',
#             'handlers': ['sentry', 'console'],
#             'propagate': False,
#         },
#         'sentry.errors': {
#             'level': 'ERROR',
#             'handlers': ['sentry', 'console'],
#             'propagate': False,
#         },
#     },
# }


pardir = os.path.abspath(BASE_DIR)
#
# RAVEN_CONFIG = {
#     'dsn': 'https://7d9bb4cd7a954c2f841ba88fd0eea88b:3c012f644643414e8f9e48d7148b5675@sentry.io/1198570',
#     # If you are using git, you can also automatically configure the
#     # release based on the git info.
#     'release': raven.fetch_git_sha(pardir),
# }

SUIT_CONFIG = {
    'ADMIN_NAME': _('Administration')
}


PAYME_MERCHANT_ID = ''
PAYME_KEY = ''
PAYME_TEST_KEY = ''
