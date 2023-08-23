import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class ProductDetail extends StatelessWidget {
final String id;
String title;
double? price;
Row rating;
String image;
String? description;
ProductDetail({Key? key, required this.id, required this.title, this.price, required this.rating, required this.image,required this.description}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CachedNetworkImage image = CachedNetworkImage(
      imageUrl: this.image,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error, size: 70),
      height: 150,
      width: 150,
    );
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: Column(children: [
        image,
        Text(title),
        Text("Price: $price\$"),
        rating,
        Text(description ?? "No description",softWrap: true,)
      ],
      crossAxisAlignment: CrossAxisAlignment.start,),
    );
  }


  
}