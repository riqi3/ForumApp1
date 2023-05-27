"""ForumApp URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path 
from api import views
from api.views import ListSection, DetailSection
from api.views import ListTopic, DetailTopic

urlpatterns = [
    path('admin/', admin.site.urls),
    path('users/', views.getData),
    path('create-section/', views.addSection),
    path('create-topic/', views.addTopic),
    path('sections/', ListSection.as_view()),
    path('topics/', ListTopic.as_view()),
    path('sections/<int:pk>/', DetailSection.as_view()),
    path('topics/<int:pk>/', DetailTopic.as_view()),
]
