# Generated by Django 4.2.3 on 2023-07-06 09:57

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('marketapp', '0009_order_order_date'),
    ]

    operations = [
        migrations.AddField(
            model_name='order',
            name='status',
            field=models.CharField(default='pending', max_length=200),
        ),
    ]