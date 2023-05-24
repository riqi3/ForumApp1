from django.db import models

class Section(models.Model):
    title = models.CharField(max_length=200)

    def __str__(self):
        return self.title
    

class Topic(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField()

    def __str__(self):
        return self.title