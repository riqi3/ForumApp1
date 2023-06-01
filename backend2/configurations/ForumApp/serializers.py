from dj_rest_auth.serializers import LoginSerializer
from dj_rest_auth.registration.serializers import RegisterSerializer

from rest_framework import serializers


class NewRegisterSerializer(RegisterSerializer):
    username=serializers.CharField()
    nickname=serializers.CharField()
    def custom_signup(self, request, user):
        user.nickname=request.data['nickname']
        user.save()

class NewLoginSerializer(LoginSerializer):
    pass
