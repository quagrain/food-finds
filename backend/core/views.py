from django.shortcuts import render
from rest_framework import status, generics
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated, AllowAny
# from rest_framework_simplejwt.tokens import RefreshToken
# from rest_framework_simplejwt.views import TokenObtainPairView
from django.utils import timezone
from .models import *
from .serializers import *
# from .permissions import AccessBlacklisted


# Create your views here.


class UsersRegistrationView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = UsersSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            return Response(UsersSerializer(user).data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class UsersLoginView(APIView):
    permission_classes = [AllowAny]

    def post(self, request, *args, **kwargs):
        serializer = UsersSerializer(data=request.data)
        response = super().post(request, *args, **kwargs)

        if serializer.is_valid():
            user = Users.objects.get(email=request.data["email"])

            # set cookies
            # response.set_cookie("refresh_token", response.data["refresh"], httponly=True, samesite="None", secure=True)
            # response.set_cookie("access_token", response.data["access"], httponly=True, samesite="None", secure=True)

            # # update last login
            # user.last_login = timezone.now()

            user.save()

            return response

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# just random
class RetrieveUserProfileDetailsView(generics.RetrieveAPIView):
    # permission_classes = [IsAuthenticated]
    permission_classes = [AllowAny]
    queryset = Users.objects.all()
    serializer_class = UsersSerializer
    lookup_field = "id"