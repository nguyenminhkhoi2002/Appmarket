from django.urls import path
from . import views
urlpatterns = [
    path('api/customers/', views.getCust, name="customers"),
    path('api/customers/sigin/', views.UserSignIn, name="signin"),
    path('api/products/', views.ProducView, name="products"),
    path('api/orders/', views.OrderView, name="orders")
    
]
