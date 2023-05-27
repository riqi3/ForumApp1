from rest_framework.response import Response
from rest_framework.decorators import api_view
from .models import Topic, Section
from .serializers import SectionSerializers, TopicSerializers
from rest_framework import generics


class ListSection(generics.ListCreateAPIView):
    queryset=Section.objects.all()
    serializer_class=SectionSerializers
    
class DetailSection(generics.RetrieveUpdateDestroyAPIView):
    queryset=Section.objects.all()
    serializer_class=SectionSerializers

class ListTopic(generics.ListCreateAPIView):
    queryset=Topic.objects.all()
    serializer_class=TopicSerializers
    

class DetailTopic(generics.RetrieveUpdateDestroyAPIView):
    queryset=Topic.objects.all()
    serializer_class=TopicSerializers


@api_view(['GET'])
def getData(request):
    sections = Section.objects.all()
    serializer = SectionSerializers(many=True)
    return Response(serializer.data)

@api_view(['POST'])
def addSection(request):
    serializer = SectionSerializers(data=request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)

@api_view(['GET'])
def getData(request):
    topic = Topic.objects.all()
    serializer = TopicSerializers(many=True)
    return Response(serializer.data)

@api_view(['POST'])
def addTopic(request):
    serializer = TopicSerializers(data=request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)

