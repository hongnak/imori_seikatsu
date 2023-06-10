import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget selectDateWidget(model, BuildContext context, String label) {
  Widget widget = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      InkWell(
        onTap: () async {
          var selectedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.utc(2021), lastDate: DateTime.now());
          if (selectedDate != null) model.setDate(selectedDate);
        },
        child: TextField(
          controller: TextEditingController(text: DateFormat.yMMMEd('ja').format(model.myDateTime).toString()),
          textAlign: TextAlign.end,
          enabled: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(gapPadding: 0.0, borderRadius: BorderRadius.circular(1.5)),
          ),
        ),
      ),
    ],
  );
  return widget;
}