import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Products extends StatefulWidget {
  final String productName;
  final IconData productIcon;
  final DateTime productBuyDate;
  final double productPrice;

  const Products({
    super.key,
    required this.productName,
    required this.productIcon,
    required this.productBuyDate,
    required this.productPrice,
  });

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  NumberFormat formatter = NumberFormat('0.00');
  late double unitPrice; // 使用 late 延迟初始化

  @override
  void initState() {
    super.initState();
    // 在 initState 中初始化 unitPrice
    unitPrice =
        DateTime.now().difference(widget.productBuyDate).inDays.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.indigo[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(widget.productIcon, color: Colors.black),
                SizedBox(width: 10),
                Text(
                  widget.productName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "购买日期:  ${DateFormat("yyyy-MM-dd").format(widget.productBuyDate)}",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  "距　　今:  ${DateTime.now().difference(widget.productBuyDate).inDays} 天",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 4),

            Row(
              children: [
                Text(
                  "单　　价:  ${formatter.format(widget.productPrice / unitPrice)} 元/天",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
