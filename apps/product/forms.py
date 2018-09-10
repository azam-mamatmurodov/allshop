from django import forms

from apps.product.models import Review


class LeaveReviewForm(forms.ModelForm):
    class Meta:
        model = Review
        exclude = ['user', 'is_approved', 'created_at', 'product', ]


class ImportForm(forms.Form):
    file = forms.FileField(required=False)