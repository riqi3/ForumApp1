from rest_framework import serializers
# from sections.models import Section
from .models import Section, Topic

class SectionSerializers(serializers.ModelSerializer):
    class Meta:
        model=Section 
        fields = '__all__'

class TopicSerializers(serializers.ModelSerializer):
    class Meta:
        model=Topic 
        fields = '__all__'
