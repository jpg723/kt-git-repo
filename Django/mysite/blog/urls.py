from django.urls import path
from . import views

urlpatterns = [
    path("test1/", views.test1),
    path("test2/<int:id>/", views.test2), # 동적 데이터를 id라는 이름으로 받는 방법
    path("test3/<year>/<mon>/<day>/", views.test3),
    path('', views.list),
    path('<int:id>/', views.detail),
    path('test4/', views.test4),
]
