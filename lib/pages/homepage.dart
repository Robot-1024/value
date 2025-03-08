import 'package:flutter/material.dart';
import 'package:value/utils/dialog_box.dart';
import 'package:value/utils/products.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  void createNewProduct(){
    showDialog(
      context: context, builder: (context) {
        return DialogBox();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
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
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: ListView(
        children: [
          Products(
            productName: "一加 Ace 2V",
            productIcon: Icons.smartphone,
            productBuyDate: DateTime(2023, 11, 1),
            productPrice: 299,
          ),

          
        ],
      ),
    );
  }
}
