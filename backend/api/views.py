# from django.shortcuts import render

# Create your views here.
from rest_framework.views import APIView
from rest_framework.response import Response
from .serializers import PingSerializer

class PingView(APIView):
    def get(self, request):
        data = {"message": "pong"}
        serializer = PingSerializer(data)
        return Response(serializer.data)
