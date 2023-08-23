from django.shortcuts import render
from django.http import JsonResponse,HttpResponse
from rest_framework.decorators import api_view
from django.views.decorators.csrf import csrf_exempt
from rest_framework.parsers import JSONParser
from rest_framework import status
from .serializers import CustomerSerializer, ProductSerializer, OrderSerializer, OrderItemSerializer
from marketapp.models import Customer, Product, Order,OrderItem

# Create your views here.
@csrf_exempt
def getCust(request):
    if request.method == 'POST':
        data=JSONParser().parse(request)
        serializer = CustomerSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse({"message":"create account successfuly"},status=201)
        return JsonResponse(serializer.errors,status=400)
@csrf_exempt
def UserSignIn(request):
    try:
        print(request)
        data=JSONParser().parse(request)
        email=data['email']
        password=data['password']
        customer = Customer.objects.filter(email=email)
        print(email)
        if not customer.exists():
            return JsonResponse({"message":"account does not exist"},status=500)
        else:
            cus1=Customer.objects.get(email=email)
            if cus1.password==password:
                
                return JsonResponse({"message":"login successfuly","id":cus1.id},status=200)
            else:
                return JsonResponse({"message":"wrong password"},status=400)
    except Customer.DoesNotExist:
        return JsonResponse({"message":"badrequest"},status=status.HTTP_400_BAD_REQUEST)
    except Exception as e:
        return JsonResponse({"message":str(e)},status=status.HTTP_500_INTERNAL_SERVER_ER)
    
    
@csrf_exempt
def ProducView(request):
    try:
        product = Product.objects.all()
        return JsonResponse({"products":list(product.values())},status=200)
    except Product.DoesNotExist:
        return JsonResponse({"message":"no product"},status=400)
@csrf_exempt
@api_view(['GET','POST'])
def OrderView(request):
    try:
        if request.method == 'GET':
            data=JSONParser().parse(request)
            idcus=data["customer_id"]
            custmer= Customer.objects.get(id=idcus)
            order = Order.objects.get(customer_id=custmer)
            list_order = OrderItem.objects.filter(order_id=order)
            return JsonResponse({"order":list(list_order.values())},status=200)
        elif request.method == 'POST':
            data=JSONParser().parse(request)
            id_customer = data['customer_id']
            id_product = data['product_id']
            type_request = data['type_request']
            print(data)
            cus=Customer.objects.get(id=id_customer)
            pro=Product.objects.get(id=id_product)
            if type_request == 'increase':
                
                order,created = Order.objects.get_or_create(customer_id=cus,status='pending')
                if not created:
                    print(Product.objects.get(id=id_product).price)
                    order.total_amount = Product.objects.get(id=id_product).price+order.total_amount
                    
                    orderitem, created1 = OrderItem.objects.get_or_create(order_id=order,product_id=pro)
                    if created1:
                        orderitem.quantity = 1
                    else:
                        orderitem.quantity += 1
                    orderitem.price = Product.objects.get(id=id_product).price*orderitem.quantity
                    orderitem.save()
                else:
                
                    order.total_amount = Product.objects.get(id=id_product).price
                    orderitem, created1 = OrderItem.objects.get_or_create(order_id=order,product_id=pro)
                    if created1:
                        orderitem.quantity = 1
                    else:
                        orderitem.quantity += 1
                    orderitem.price = Product.objects.get(id=id_product).price*orderitem.quantity
                    orderitem.save()
                order.save()
                return JsonResponse({"message":"add order successfuly"},status=201)
            elif type_request == 'decrease':
                order = Order.objects.get(customer_id=cus,status='pending')
                order.total_amount -= Product.objects.get(id=id_product).price
                orderitem = OrderItem.objects.get(order_id=order,product_id=pro)
                orderitem.quantity -= 1
                orderitem.price = Product.objects.get(id=id_product).price*orderitem.quantity
                orderitem.save()
                order.save()
                return JsonResponse({"message":"decrease order successfuly"},status=201)
                
                
        
    except Order.DoesNotExist:
        return JsonResponse({"message":"no order"},status=400)


        



        
        
