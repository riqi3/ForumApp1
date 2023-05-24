from rest_framework import serializers
# from sections.models import Section
from sections import models

class SectionSerializers(serializers.ModelSerializer):
    class Meta:
        fields=(
            'id',
            'title',
        )
        model=models.Section

class TopicSerializers(serializers.ModelSerializer):
    class Meta:
        fields=(
            'id',
            'title',
            'description'
        )
        model=models.Topic