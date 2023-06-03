import 'package:flutter/material.dart';

Widget enterNameWidget(model, String label, String hintText) {
  Widget widget = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      TextFormField(
        controller: (model.name != null || model.name != '') ? TextEditingController(text: model.name) : null,
        maxLength: 18,
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(gapPadding: 0, borderRadius: BorderRadius.circular(1.5))
        ),
        onChanged: (text) => model.name = text,
      )
    ],
  );
  return widget;
}