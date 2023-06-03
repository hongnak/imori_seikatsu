import 'package:flutter/material.dart';

Widget enterMemoWidget(model, String label, String hintText) {
  Widget widget = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      TextField(
          controller: (model.memo != null || model.memo != '') ? TextEditingController(text: model.memo) : null,
          maxLength: 300,
          maxLines: 5,
          decoration: InputDecoration(
              border: OutlineInputBorder(gapPadding: 0.0, borderRadius: BorderRadius.circular(1.5)),
              hintText: hintText
          ),
          onChanged: (text) => model.memo = text
      ),
    ],
  );
  return widget;
}