import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MainScreen.dart';

class ShoppingPage extends StatefulWidget{
  String id;

  ShoppingPage({required this.id});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  int _currentIndex = 0;
  
  
  

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
    MainScreen(id: widget.id),
    Text('no Product'),
    Text('this feature is not available in'),
  ];
    return Scaffold(
      body: Center(
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Giỏ hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Color.fromARGB(255, 70, 13, 230),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
