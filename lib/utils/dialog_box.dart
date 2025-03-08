import 'package:flutter/material.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({super.key});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  DateTime? _selectedDate;

  //const SelectBuyDate({super.key});

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(), // 初始日期
      firstDate: DateTime(1900), // 可选的最早日期
      lastDate: DateTime.now(), // 可选的最晚日期
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked; // 更新选择的日期
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        width: double.maxFinite, // 设置宽度为最大
        height: 320,
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min, // 让 Column 只占用最小空间
              children: [
                SizedBox(height: 16),
                Text(
                  "添加产品",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16), // 添加间距
                InputRow(label: "产品名"), // 使用 InputRow
                SizedBox(height: 16),
                InputRow(label: "价格 (元)"),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[50],
                  ),
                  onPressed: () => _selectDate(context), // 点击按钮显示日期选择框
                  child: Text(
                    '选择购买日期',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                  ),
                  onPressed: () {},
                  child: Text("保存", style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // 关闭对话框
                  },
                  child: Text("关闭", style: TextStyle(color: Colors.white)),
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

  const InputRow({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 右侧输入框
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: '$label', // 提示文本
              border: UnderlineInputBorder(), // 下划线样式
            ),
          ),
        ),
      ],
    );
  }
}
