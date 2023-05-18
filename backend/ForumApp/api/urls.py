from django.urls import path
from . import views
from .views import ListSection, DetailSection

urlpatterns = [
    path('users/', views.getData),
    path('create-user/', views.addSection),
    path('sections/', ListSection.as_view()),
    path('<int:pk>', DetailSection.as_view()),
]