import 'package:flutter/material.dart';

Widget enterKindWidget(model, String label, String hintText) {
  Widget widget = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      TextFormField(
        controller: (model.kind != null || model.kind != '') ? TextEditingController(text: model.kind) : null,
        maxLength: 18,
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(gapPadding: 0, borderRadius: BorderRadius.circular(1.5))
        ),
        onChanged: (text) => model.kind = text,
      )
    ],
  );
  return widget;
}