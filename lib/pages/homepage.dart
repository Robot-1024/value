import 'package:flutter/material.dart';
import 'package:value/utils/dialog_box.dart';
import 'package:value/utils/products.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Map<String, dynamic>> _products = [];

  void createNewProduct() {
    showDialog(
      context: context,
      builder:
          (context) => DialogBox(
            productNameFromUser: '',
            productPriceFromUser: '',
            productBuyDateFromUser: DateTime.now(),
            onSave: (String name, double price, DateTime date, IconData icon) {
              setState(() {
                _products.add({
                  'name': name,
                  'price': price,
                  'date': date,
                  'icon': icon, // 存储图标
                });
              });
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Value",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewProduct,
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView(
        children: [
          for (var product in _products)
            Products(
              productName: product['name'],
              productIcon: product['icon'], // 动态传递图标
              productBuyDate: product['date'],
              productPrice: product['price'],
            ),
        ],
      ),
    );
  }
}
