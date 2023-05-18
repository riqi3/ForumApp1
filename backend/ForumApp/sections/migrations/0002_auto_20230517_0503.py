# Generated by Django 3.2 on 2023-05-16 21:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sections', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='section',
            name='created',
        ),
        migrations.AddField(
            model_name='section',
            name='description',
            field=models.CharField(default=1, max_length=999),
            preserve_default=False,
        ),
    ]