import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget selectCategoryWidget(model, String label, String hintText) {
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
        value: model.category,
        items: creatureCategoryDDMIs,
        onChanged: (text) => model.category = text as String,
      ),
    ],
  );
  return widget;
}

List<DropdownMenuItem<String>> creatureCategoryDDMIs = [
  const DropdownMenuItem(value: '不明', child: Text('不明')),
  const DropdownMenuItem(value: '両生類', child: Text('両生類')),
  const DropdownMenuItem(value: '熱帯魚', child: Text('熱帯魚')),
  const DropdownMenuItem(value: '金魚', child: Text('金魚')),
  const DropdownMenuItem(value: 'メダカ', child: Text('メダカ')),
  const DropdownMenuItem(value: '川魚', child: Text('川魚')),
  const DropdownMenuItem(value: '海水魚', child: Text('海水魚')),
  const DropdownMenuItem(value: 'エビ', child: Text('エビ')),
  const DropdownMenuItem(value: '貝類', child: Text('貝類')),
  const DropdownMenuItem(value: 'その他', child: Text('その他')),
];