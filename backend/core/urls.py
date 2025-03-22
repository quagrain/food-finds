from django.urls import path
# from rest_framework_simplejwt.views import TokenRefreshView
from .views import *

urlpatterns = [
    path("register/register_user", UsersRegistrationView.as_view(), name="register"),
    path("login/login_user", UsersLoginView.as_view(), name="login"),
    path("profile/<int:id>/", RetrieveUserProfileDetailsView.as_view(), name="retrieve_profile_details"),
]