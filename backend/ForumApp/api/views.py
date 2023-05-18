from rest_framework.response import Response
from rest_framework.decorators import api_view
from sections.models import Section
from sections import models
from .serializers import SectionSerializers
from rest_framework import generics


class ListSection(generics.ListCreateAPIView):
    queryset=models.Section.objects.all()
    serializer_class=SectionSerializers

class DetailSection(generics.RetrieveUpdateDestroyAPIView):
    queryset=models.Section.objects.all()
    serializer_class=SectionSerializers

@api_view(['GET'])
def getData(request):
    sections = Section.objects.all()
    serializer = SectionSerializers(sections, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def addSection(request):
    serializer = SectionSerializers(data=request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)

