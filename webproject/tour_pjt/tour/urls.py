
from django.urls import path,include
from . import views

app_name = 'tour'

urlpatterns = [
    path('aitour/', views.aitour,name='aitour'),
    path('aitour_data/', views.aitour_data,name='aitour_data'),
]
