from django.contrib.auth import views as auth_views
from django.urls import path
from . import views
from django.views.generic import TemplateView

urlpatterns = [
    path("login/", auth_views.LoginView.as_view(), name="login"),
    path("logout/", auth_views.LogoutView.as_view(), name="logout"),
    path("signup/", views.signup, name="signup"),
    
    # 비밀번호 변경
    path(
        "password_change/", views.MyPasswordChangeView.as_view(), name="password_change"
    ),
    # 비밀번호 완료 후
    path(
        "password_change/done/",
        auth_views.PasswordChangeDoneView.as_view(),
        name="password_change_done",
    ),
    
    path('profile/', TemplateView.as_view(template_name='registration/profile.html'), name='profile' ),
    path('cookie/<code>/', views.cookie_test), # 쿠키 TEST
    path('session/<int:code>', views.session_test), # 세션 TEST
]