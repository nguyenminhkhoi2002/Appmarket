import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appmarket/network/APIservice.dart';

class MainScreen extends StatefulWidget {
  String id;
  MainScreen({super.key, required this.id});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ListTile _tile(String title, String subtitle, double price) {
    return ListTile(
      selected: true,
      leading: const Icon(Icons.shopping_cart),
      title: Text(title),
      subtitle: Row(
        children: [
          Text(subtitle),
          const SizedBox(
            width: 20,
          ),
          Text(price.toString()),
        ],
      ),
    );
  }

  Future<Widget> buildList() async {
    APIservice ap = APIservice();
    dynamic list = await ap.GetProduct();
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return _tile(list[index]['name'], list[index]['description'],
              list[index]['price']);
        });
  }

  @override
  Widget build(BuildContext context) {
    APIservice ap = APIservice();
    ap.GetProduct();
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: buildList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data;
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
