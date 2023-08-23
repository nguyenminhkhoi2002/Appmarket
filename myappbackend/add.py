from marketapp.models import Customer, Product, Order,OrderItem
for i in range(1,10):
    product = Product.objects.create(name="product"+str(i),price=i*10,description=" This is product"+str(i))
