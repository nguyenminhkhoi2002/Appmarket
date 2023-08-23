from django.db import models

# Create your models here.
class Customer(models.Model):
    
    name = models.CharField(max_length=200, null=True)
    phone = models.CharField(max_length=200, null=True)
    password = models.CharField(max_length=200, null=True)
    email = models.CharField(max_length=200, null=True,unique=True)
    address = models.CharField(max_length=200, null=True)

    def __str__(self):
        return self.name
class Product(models.Model):
    name = models.CharField(max_length=200, null=True)
    price = models.FloatField(null=True)
    description = models.CharField(max_length=200, null=True)
    def __str__(self):
        return self.name
class Order(models.Model):
    customer_id = models.ForeignKey(Customer, null=True, on_delete=models.CASCADE)
    order_date = models.DateTimeField(auto_now_add=True)
    total_amount = models.FloatField(null=True)
    status = models.CharField(max_length=200, null=False,default='pending')
class OrderItem(models.Model):
    order_id = models.ForeignKey(Order, null=True, on_delete=models.CASCADE)
    product_id = models.ForeignKey(Product, null=True, on_delete=models.CASCADE)
    quantity = models.IntegerField(null=True)
    price = models.FloatField(null=True)
    def __str__(self):
        return self.product_id.name
    