# Generated by Django 3.2 on 2023-05-26 09:29

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('sections', '0003_remove_section_description'),
    ]

    operations = [
        migrations.DeleteModel(
            name='Section',
        ),
    ]