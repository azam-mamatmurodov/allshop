from django.template.loader import render_to_string
from django.utils.translation import ugettext as _
from django.shortcuts import reverse

from apps.basic.models import Menu, Banner, Static, StaticFooterPage
from apps.product.models import Category, Product
from apps.order.models import Cart

from apps.account.forms import LoginForm, RegisterForm


def cart(request):
    current_user_session_key = request.COOKIES.get('client_id')
    cart_items = Cart.objects.filter(session_key=current_user_session_key, status=True, order__isnull=True)
    cart_total_price = 0
    for cart_item in cart_items:
        cart_total_price += cart_item.total_price
    cart_total_count = cart_items.count()
    return {
        'cart_items': cart_items,
        'cart_total_price': cart_total_price,
        'cart_total_count': cart_total_count
    }


def get_header(request):
    context = dict()
    context['menu_items'] = Menu.objects.all()
    context['category'] = Category.objects.all()
    context['request'] = request
    context['cart'] = cart(request)
    return render_to_string('parts/header.html', context=context)


def get_banner(request):
    context = dict()
    context['banner_items'] = Banner.objects.all()
    context['request'] = request
    return render_to_string('parts/banner.html', context=context)


def get_footer(request):
    context = dict()
    context['csrf_token'] = request.COOKIES.get('csrftoken')
    context['login_form'] = LoginForm(request.POST) if request.method == 'POST' else LoginForm()
    context['register_form'] = RegisterForm(request.POST) if request.method == 'POST' else RegisterForm()
    context['footer_clients'] = StaticFooterPage.objects.filter(menu_type=0)
    context['footer_partners'] = StaticFooterPage.objects.filter(menu_type=1)
    return render_to_string('parts/footer.html', context=context)


def get_breadcrumbs(request, *args, **kwargs):
    view_name = request.resolver_match.view_name
    kwargs = request.resolver_match.kwargs
    paths = list()
    paths.append({
        'title': _('Shop'),
        'path': reverse('main:home')
    })
    print(view_name)
    if view_name == 'users:profile':
        paths.append({
            'title': _('Account Settings'),
            'path': reverse(view_name)
        })
    elif view_name == 'users:profile_payment':
        paths.append({
            'title': _('Account Settings'),
            'path': reverse('users:profile')
        })
        paths.append({
            'title': _('Payment methods'),
            'path': reverse(view_name)
        })
    elif view_name == 'users:profile_payment_edit':
        paths.append({
            'title': _('Account Settings'),
            'path': reverse('users:profile')
        })
        paths.append({
            'title': _('Payment methods'),
            'path': reverse('users:profile_payment')
        })
        paths.append({
            'title': _('Payment'),
            'path': reverse(view_name, args=[kwargs.get('pk')])
        })
    elif view_name == 'users:profile_orders':
        paths.append({
            'title': _('Account Settings'),
            'path': reverse('users:profile')
        })
        paths.append({
            'title': _('Orders history'),
            'path': reverse(view_name)
        })
    elif view_name == 'users:profile_security':
        paths.append({
            'title': _('Account Settings'),
            'path': reverse('users:profile')
        })
        paths.append({
            'title': _('Security'),
            'path': reverse(view_name)
        })
    elif view_name == 'users:profile_delivery':
        paths.append({
            'title': _('Account Settings'),
            'path': reverse('users:profile')
        })
        paths.append({
            'title': _('Delivery address'),
            'path': reverse(view_name)
        })
    elif view_name == 'products:product_list':
        arg = kwargs.get('slug')
        paths.append({
            'title': _('Category'),
            'path': reverse(view_name, args=['all']),
        })
        if arg != 'all':
            category = Category.objects.get(translations__slug=arg)
            family_items = category.get_ancestors()
            for index, family_item in enumerate(family_items):
                paths.append({
                    'title': family_item.name,
                    'path': reverse(view_name, args=[family_item.slug])
                })
            paths.append({
                'title': category.name,
                'path': reverse(view_name, args=[category.slug])
            })
    elif view_name == 'main:static':
        arg = kwargs.get('slug')
        static_content = Static.objects.get(translations__slug=arg)
        paths.append({
            'title': static_content.name,
            'path': reverse(view_name, args=[arg]),
        })
    elif view_name == 'main:static_footer':
        arg = kwargs.get('slug')
        static_content = StaticFooterPage.objects.get(translations__slug=arg)
        paths.append({
            'title': static_content.name,
            'path': reverse(view_name, args=[arg]),
        })
    elif view_name == 'orders:cart':
        paths.append({
            'title': _('Cart'),
            'path': reverse(view_name),
        })
    elif view_name == 'orders:order_detail':
        paths.append({
            'title': _('Cart'),
            'path': reverse('orders:cart'),
        })
        paths.append({
            'title': _('Order info'),
            'path': reverse(view_name, args=[kwargs.get('phone'), kwargs.get('order_unique_id')]),
        })
    elif view_name == 'products:product_detail':
        slug = kwargs.get('slug')
        category = Category.objects.get(translations__slug=slug)
        category_view_name = 'products:product_list'

        product_id = kwargs.get('pk')
        product = Product.objects.get(pk=product_id)

        paths.append({
            'title': _('Category'),
            'path': reverse(category_view_name, args=['all']),
        })

        family_items = category.get_ancestors()
        for index, family_item in enumerate(family_items):
            paths.append({
                'title': family_item.name,
                'path': reverse(category_view_name, args=[family_item.slug])
            })
        paths.append({
            'title': category.name,
            'path': reverse(category_view_name, args=[category.slug])
        })

        paths.append({
            'title': product.name,
            'path': reverse(view_name, args=[slug, product_id, ]),
        })
    elif view_name == 'orders:address':
        paths.append({
            'title': _('Cart'),
            'path': reverse('orders:cart'),
        })
        paths.append({
            'title': _('Address'),
            'path': reverse(view_name,),
        })
    elif view_name == 'orders:time':
        paths.append({
            'title': _('Cart'),
            'path': reverse('orders:cart'),
        })
        paths.append({
            'title': _('Address'),
            'path': reverse('orders:address',),
        })
        paths.append({
            'title': _('Delivery time'),
            'path': reverse(view_name),
        })
    elif view_name == 'orders:payment_method':
        paths.append({
            'title': _('Cart'),
            'path': reverse('orders:cart'),
        })
        paths.append({
            'title': _('Address'),
            'path': reverse('orders:address',),
        })
        paths.append({
            'title': _('Delivery time'),
            'path': reverse('orders:time'),
        })
        paths.append({
            'title': _('Payment method'),
            'path': reverse(view_name),
        })
    elif view_name == 'orders:checkout':
        paths.append({
            'title': _('Cart'),
            'path': reverse('orders:cart'),
        })
        paths.append({
            'title': _('Address'),
            'path': reverse('orders:address',),
        })
        paths.append({
            'title': _('Delivery time'),
            'path': reverse('orders:time'),
        })
        paths.append({
            'title': _('Payment method'),
            'path': reverse('orders:payment_method'),
        })
        paths.append({
            'title': _('Checkout'),
            'path': reverse(view_name,),
        })
    elif view_name == 'products:search':
        paths.append({
            'title': _('Search'),
            'path': reverse(view_name,),
        })
    elif view_name == 'orders:payment_uzcard':
        phone = kwargs.get('phone')
        unique_id = kwargs.get('order_unique_id')
        paths.append({
            'title': _('Order detail'),
            'path': reverse('orders:order_detail', args=[phone, unique_id]),
        })
        paths.append({
            'title': _('Uzcard pay'),
            'path': reverse(view_name, args=[phone, unique_id]),
        })
    return render_to_string('parts/breadcrumbs.html', {'paths': paths})


def defaults(request, *args, **kwargs):
    header = get_header(request)
    banner = get_banner(request)
    footer = get_footer(request)
    breadcrumbs = get_breadcrumbs(request, *args, **kwargs)
    address_example = _('Tashkent, Yashnabad district, st. Tinchlik / 1-quarter, 1-house, 1-kvart')
    return locals()
