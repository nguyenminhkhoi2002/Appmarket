# Generated by Django 4.2.3 on 2023-07-05 14:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('marketapp', '0006_alter_customer_email'),
    ]

    operations = [
        migrations.AddField(
            model_name='customer',
            name='password',
            field=models.CharField(max_length=200, null=True),
        ),
    ]
