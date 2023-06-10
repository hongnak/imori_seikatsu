import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import '../common.dart';

Widget selectAmountWidget(model, BuildContext context, String label, String hintText, String unitName) {
  Widget widget = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      if (dataKind == DataKind.creature || dataKind == DataKind.plant)
        TextField(
          controller: TextEditingController(text: '${model.amountInt}''$unitName'),
          textAlign: TextAlign.end,
          enabled: false,
          decoration: InputDecoration(border: OutlineInputBorder(gapPadding: 0.0, borderRadius: BorderRadius.circular(1.5))),
        ),
      if (dataKind == DataKind.creature || dataKind == DataKind.plant)
        Center(child: NumberPicker(minValue: 1, maxValue: 200, value: model.amountInt, onChanged: (value) => model.changeAmountVal(value))),
      if (dataKind == DataKind.waterChange || dataKind == DataKind.feed)
        DropdownButtonFormField(
            style: const TextStyle(fontSize: 14, color: Colors.black),
            decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(gapPadding: 0.0, borderRadius: BorderRadius.circular(1.5))
            ),
            value: model.amount,
            items: dataKind == DataKind.waterChange
                ? waterChangeAmountDDMIs
                : feedAmountDDMIs,
            onChanged: (text) {
              if (dataKind == DataKind.waterChange) {
                model.amount = text as String;
              } else {
                model.amount = text as String;
              }
            }
        ),
      if (dataKind == DataKind.temperature)
        TextField(
          controller: TextEditingController(text: '${model.temperature}''°C'),
          textAlign: TextAlign.end,
          enabled: false,
          decoration: InputDecoration(border: OutlineInputBorder(gapPadding: 0.0, borderRadius: BorderRadius.circular(1.5))),
        ),
      if (dataKind == DataKind.temperature)
        Center(child: DecimalNumberPicker(minValue: 0, maxValue: 45, value: model.temperature, onChanged: (value) => model.setTemperature(value))),
      if (dataKind == DataKind.ph)
        TextField(
          controller: TextEditingController(text: '${model.ph}'),
          textAlign: TextAlign.end,
          enabled: false,
          decoration: InputDecoration(border: OutlineInputBorder(gapPadding: 0.0, borderRadius: BorderRadius.circular(1.5))),
        ),
      if (dataKind == DataKind.ph)
        Center(child: DecimalNumberPicker(minValue: 1, maxValue: 14, value: model.ph, decimalPlaces: 2, onChanged: (value) => model.setPh(value)))
    ],
  );
  return widget;
}

List<DropdownMenuItem<String>> feedAmountDDMIs = [
  const DropdownMenuItem(value: '少量', child: Text('少量')),
  const DropdownMenuItem(value: '中量', child: Text('中量')),
  const DropdownMenuItem(value: '大量', child: Text('大量')),
];

List<DropdownMenuItem<String>> waterChangeAmountDDMIs = [
  const DropdownMenuItem(value: '全換え', child: Text('全換え')),
  const DropdownMenuItem(value: '1/2', child: Text('1/2')),
  const DropdownMenuItem(value: '1/3', child: Text('1/3')),
  const DropdownMenuItem(value: '1/4', child: Text('1/4')),
  const DropdownMenuItem(value: '1/5', child: Text('1/5')),
];