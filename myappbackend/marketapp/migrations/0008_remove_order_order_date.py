# Generated by Django 4.2.3 on 2023-07-06 05:52

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('marketapp', '0007_customer_password'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='order',
            name='order_date',
        ),
    ]
