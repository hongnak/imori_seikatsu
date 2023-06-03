import 'package:flutter/material.dart';

Widget selectSizeWidget(model, String label, String hintText) {
  Widget widget = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      DropdownButtonFormField(
        style: const TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
                gapPadding: 0.0,
                borderRadius: BorderRadius.circular(1.5)
            )
        ),
        value: model.size,
        items: tankSizeDDMIs,
        onChanged: (text) => model.size = text as String,
      ),
    ],
  );
  return widget;
}

List<DropdownMenuItem<String>> tankSizeDDMIs = [
  const DropdownMenuItem(value: '不明', child: Text('不明')),
  const DropdownMenuItem(value: '15cm × 15cm × 15cm', child: Text('15cmキューブ水槽　15cm × 15cm × 15cm')),
  const DropdownMenuItem(value: '20cm × 20cm × 20cm', child: Text('20cmキューブ水槽　20cm × 20cm × 20cm')),
  const DropdownMenuItem(value: '25cm × 25cm × 25cm', child: Text('25cmキューブ水槽　25cm × 25cm × 25cm')),
  const DropdownMenuItem(value: '27cm × 27cm × 27cm', child: Text('27cmキューブ水槽　27cm × 27cm × 27cm')),
  const DropdownMenuItem(value: '30cm × 30cm × 30cm', child: Text('30cmキューブ水槽　30cm × 30cm × 30cm')),
  const DropdownMenuItem(value: '45cm × 45cm × 45cm', child: Text('45cmキューブ水槽　45cm × 45cm × 45cm')),
  const DropdownMenuItem(value: '60cm × 60cm × 60cm', child: Text('60cmキューブ水槽　60cm × 60cm × 60cm')),
  const DropdownMenuItem(value: '30cm × 18cm × 24cm', child: Text('30cm規格水槽　30cm × 18cm × 24cm')),
  const DropdownMenuItem(value: '45cm × 24cm × 30cm', child: Text('45cm規格水槽　45cm × 24cm × 30cm')),
  const DropdownMenuItem(value: '60cm × 30cm × 36cm', child: Text('60cm規格水槽　60cm × 30cm × 36cm')),
  const DropdownMenuItem(value: '75cm × 45cm × 45cm', child: Text('75cm規格水槽　75cm × 45cm × 45cm')),
  const DropdownMenuItem(value: '90cm × 45cm × 45cm', child: Text('90cm規格水槽　90cm × 45cm × 45cm')),
  const DropdownMenuItem(value: '120cm × 45cm × 45cm', child: Text('120cm規格水槽　120cm × 45cm × 45cm')),
  const DropdownMenuItem(value: '180cm × 60cm × 60cm', child: Text('180cm規格水槽　180cm × 60cm × 60cm')),
  const DropdownMenuItem(value: '30cm × 24cm × 24cm', child: Text('30cmワイド水槽　30cm × 24cm × 24cm')),
  const DropdownMenuItem(value: '45cm × 30cm × 30cm', child: Text('45cmワイド水槽　45cm × 30cm × 30cm')),
  const DropdownMenuItem(value: '60cm × 45cm × 45cm', child: Text('60cmワイド水槽　60cm × 45cm × 45cm')),
  const DropdownMenuItem(value: 'その他', child: Text('その他')),
];