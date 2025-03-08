import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// 图标列表（可自定义）
final List<IconData> _iconList = [
  Icons.smartphone,
  Icons.laptop,
  Icons.headphones,
  Icons.watch,
  Icons.tv,
  Icons.camera_alt,
  Icons.sports_esports,
];

class DialogBox extends StatefulWidget {
  final String productNameFromUser;
  final String productPriceFromUser;
  final DateTime productBuyDateFromUser;
  final Function(String, double, DateTime, IconData) onSave; // 新增 IconData 参数

  const DialogBox({
    super.key,
    required this.productNameFromUser,
    required this.productPriceFromUser,
    required this.productBuyDateFromUser,
    required this.onSave,
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  DateTime? _selectedDate;
  IconData _selectedIcon = Icons.smartphone; // 默认图标

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.productNameFromUser);
    _priceController = TextEditingController(text: widget.productPriceFromUser);
    _selectedDate = widget.productBuyDateFromUser;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  // 选择日期
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // 构建图标选择器
  Widget _buildIconSelector() {
    return SizedBox(
      height: 30,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: _iconList.length,
        itemBuilder: (context, index) {
          final icon = _iconList[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIcon = icon; // 更新选中图标
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 2),
              decoration: BoxDecoration(
                color: _selectedIcon == icon ? Colors.indigo[100] : null,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        width: double.maxFinite,
        height: 370, // 增加高度以容纳图标选择
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                const Text(
                  "添加产品",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                InputRow(label: "产品名", controller: _nameController),
                const SizedBox(height: 4),
                InputRow(label: "价格 (元)", controller: _priceController),
                const SizedBox(height: 16),
                // 添加图标选择器
                const Text("选择图标:", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                _buildIconSelector(),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[50],
                  ),
                  onPressed: () => _selectDate(context),
                  child: Text(
                    _selectedDate == null
                        ? '选择购买日期'
                        : '购买日期: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                  ),
                  onPressed: () {
                    if (_nameController.text.isNotEmpty &&
                        _priceController.text.isNotEmpty &&
                        _selectedDate != null) {
                      double price;
                      try {
                        price = double.parse(_priceController.text);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('请输入有效的价格数字'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      if (price <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('价格必须大于0'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      widget.onSave(
                        _nameController.text,
                        price,
                        _selectedDate!,
                        _selectedIcon,
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    "保存",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "关闭",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InputRow extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const InputRow({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: label,
              border: const UnderlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
