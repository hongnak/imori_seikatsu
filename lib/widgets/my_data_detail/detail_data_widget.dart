import 'package:flutter/material.dart';
import 'package:imori_seikatsu/common.dart';
import 'package:intl/intl.dart';

Widget detailDataWidget(dynamic data, BuildContext context, String label) {

  double imgWidth = MediaQuery.of(context).size.width;
  double imgHeight = MediaQuery.of(context).size.height*0.35;
  double labelWidth = MediaQuery.of(context).size.width * 0.3;
  double memoWidth = MediaQuery.of(context).size.width * 0.6;
  double detailFontSize = 14.0;

  Widget widget = Column(
    children: [
      if (dataKind == DataKind.imorium || dataKind == DataKind.creature || dataKind == DataKind.plant || dataKind == DataKind.diary)
        data.imgURL != ''
            ?
        Container(
            width: imgWidth,
            height: imgHeight,
            decoration: BoxDecoration(shape: BoxShape.rectangle, image: DecorationImage(image: NetworkImage(data.imgURL), fit: BoxFit.cover))
        )
            :
        Container(
            width: imgWidth,
            height: imgHeight,
            color: Colors.grey[200], child: const Center(child: Text('No Image'))
        ),
      const SizedBox(height: 15),
      if (dataKind == DataKind.imorium || dataKind == DataKind.creature)
        Column(
          children: [
            Row(
                children: [
                  SizedBox(width: labelWidth, child: const Text('名前', style: TextStyle(fontSize: 14))),
                  Text(data.name, style: TextStyle(fontSize: detailFontSize))
                ]
            ),
            Divider(color: Colors.grey[200]),
          ],
        ),
      if (dataKind == DataKind.imorium )
        Column(
          children: [
            Row(
              children: [
                SizedBox(width: labelWidth, child: const Text('サイズ', style: TextStyle(fontSize: 14))),
                Text(data.size, style: const TextStyle(fontSize: 14.0))]
            ),
            Divider(color: Colors.grey[200]),
          ],
        ),
      if (dataKind == DataKind.creature )
        Column(
          children: [
            Row(
                children: [
                  SizedBox(width: labelWidth, child: const Text('カテゴリー', style: TextStyle(fontSize: 14))),
                  Text(data.category, style: const TextStyle(fontSize: 14.0))]
            ),
            Divider(color: Colors.grey[200]),
          ],
        ),
      if (dataKind == DataKind.creature || dataKind == DataKind.plant)
        Column(
          children: [
            Row(
                children: [
                  SizedBox(width: labelWidth, child: const Text('種類', style: TextStyle(fontSize: 14))),
                  Text(data.kind, style: const TextStyle(fontSize: 14.0))]
            ),
            Divider(color: Colors.grey[200]),
            Row(
                children: [
                  SizedBox(width: labelWidth, child: Text(unit, style: const TextStyle(fontSize: 14))),
                  Text(data.amount.toString(), style: const TextStyle(fontSize: 14.0))]
            ),
            Divider(color: Colors.grey[200]),
          ],
        ),
      if (dataKind == DataKind.waterChange || dataKind == DataKind.feed)
        Column(
          children: [
            Row(
                children: [
                  SizedBox(width: labelWidth, child: Text('$label量', style: const TextStyle(fontSize: 14))),
                  Text(data.amount, style: const TextStyle(fontSize: 14.0))]
            ),
            Divider(color: Colors.grey[200]),
          ],
        ),
      if (dataKind == DataKind.temperature || dataKind == DataKind.ph)
        Column(
          children: [
            Row(
                children: [
                  SizedBox(width: labelWidth, child: Text(label, style: const TextStyle(fontSize: 14))),
                  Text(data.amount.toString(), style: const TextStyle(fontSize: 14.0))]
            ),
            Divider(color: Colors.grey[200]),
          ],
        ),
      if (dataKind == DataKind.diary)
        Column(
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: labelWidth, height: 120, child: const Text('日記', style: TextStyle(fontSize: 14))),
                  SizedBox(width: memoWidth, child: Text(data.amount, maxLines: 30, overflow: TextOverflow.ellipsis))
                ]
            ),
            Divider(color: Colors.grey[200]),
          ],
        ),
      Row(
          children: [
            SizedBox(width: labelWidth, child: const Text('登録日', style: TextStyle(fontSize: 14))),
            Text(DateFormat.yMMMEd('ja').format(data.registrationDate.toDate()).toString(), style: TextStyle(fontSize: detailFontSize))
          ]
      ),
      Divider(color: Colors.grey[200]),
      Row(
          children: [
            SizedBox(width: labelWidth, child: const Text('最終更新日', style: TextStyle(fontSize: 14))),
            Text(DateFormat.yMMMEd('ja').format(data.lastUpdatedDate.toDate()).toString(), style: TextStyle(fontSize: detailFontSize))
          ]
      ),
      Divider(color: Colors.grey[200]),
      if (dataKind != DataKind.diary)
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: labelWidth, height: 120, child: const Text('メモ', style: TextStyle(fontSize: 14))),
              SizedBox(width: memoWidth, child: Text(data.memo, maxLines: 30, overflow: TextOverflow.ellipsis))
            ]
        ),
    ],
  );
  return widget;
}