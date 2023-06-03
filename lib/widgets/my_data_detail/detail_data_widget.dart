import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/imorium.dart';

Widget detailDataWidget(Imorium imorium, BuildContext context) {

  double imgWidth = MediaQuery.of(context).size.width;
  double imgHeight = MediaQuery.of(context).size.height*0.35;
  double labelWidth = MediaQuery.of(context).size.width * 0.3;
  double memoWidth = MediaQuery.of(context).size.width * 0.6;
  double detailFontSize = 14.0;

  Widget widget = Column(
    children: [
      imorium.imgURL != ''
          ?
      Container(
          width: imgWidth,
          height: imgHeight,
          decoration: BoxDecoration(shape: BoxShape.rectangle, image: DecorationImage(image: NetworkImage(imorium.imgURL), fit: BoxFit.cover))
      )
          :
      Container(
          width: imgWidth,
          height: imgHeight,
          color: Colors.grey[200], child: const Center(child: Text('No Image'))
      ),
      const SizedBox(height: 15),
      Divider(color: Colors.grey[200]),
      Row(
          children: [
            SizedBox(width: labelWidth, child: const Text('サイズ', style: TextStyle(fontSize: 14))),
            Text(imorium.size, style: const TextStyle(fontSize: 14.0))]
      ),
      Divider(color: Colors.grey[200]),
      Row(
          children: [
            SizedBox(width: labelWidth, child: const Text('登録日', style: TextStyle(fontSize: 14))),
            Text(DateFormat.yMMMEd('ja').format(imorium.registrationDate.toDate()).toString(), style: TextStyle(fontSize: detailFontSize))
          ]
      ),
      Divider(color: Colors.grey[200]),
      Row(
          children: [
            SizedBox(width: labelWidth, child: const Text('最終更新日', style: TextStyle(fontSize: 14))),
            Text(DateFormat.yMMMEd('ja').format(imorium.lastUpdatedDate.toDate()).toString(), style: TextStyle(fontSize: detailFontSize))
          ]
      ),
      Divider(color: Colors.grey[200]),
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: labelWidth, height: 120, child: const Text('メモ', style: TextStyle(fontSize: 14))),
            SizedBox(width: memoWidth, child: Text(imorium.memo, maxLines: 30, overflow: TextOverflow.ellipsis))
          ]
      ),
    ],
  );
  // double labelWidth = MediaQuery.of(context).size.width * 0.3;
  // double memoWidth = MediaQuery.of(context).size.width * 0.6;
  // Widget widget = Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     if (dataKind == DataKind.creature || dataKind == DataKind.plant)
  //       Column(
  //           children: [
  //             imgURL != ''
  //                 ? Center(child: Container(width: 250, height: 200, decoration: BoxDecoration(shape: BoxShape.rectangle, image: DecorationImage(image: NetworkImage(imgURL), fit: BoxFit.cover))))
  //                 : Center(child: Container(width: 250, height: 200, color: Colors.grey[200], child: const Center(child: Text('No Image')))),
  //             const SizedBox(height: 15),
  //             const Divider(),
  //             Row(children: [SizedBox(width: labelWidth, child: const Text('名前', style: TextStyle(fontSize: 14))), Text(name)]),
  //             const Divider(),
  //             Row(children: [SizedBox(width: labelWidth, child: const Text('カテゴリ', style: TextStyle(fontSize: 14))), Text(category)]),
  //             const Divider(),
  //             Row(children: [SizedBox(width: labelWidth, child: const Text('種類', style: TextStyle(fontSize: 14))), Text(kinds)]),
  //             const Divider(),
  //           ]
  //       ),
  //     if (dataKind == DataKind.waterChange)
  //       Column(
  //         children: [
  //           Row(children: [SizedBox(width: labelWidth, child: const Text('水交換量', style: TextStyle(fontSize: 14))), Text(amount)]),
  //           const Divider(),
  //         ],
  //       ),
  //     if (dataKind == DataKind.feed)
  //       Column(
  //         children: [
  //           Row(children: [SizedBox(width: labelWidth, child: const Text('餌やり量', style: TextStyle(fontSize: 14))), Text(amount)]),
  //           const Divider(),
  //         ],
  //       ),
  //     if (dataKind == DataKind.temperature)
  //       Column(
  //         children: [
  //           Row(children: [SizedBox(width: labelWidth, child: const Text('水温', style: TextStyle(fontSize: 14))), Text('${temperature.toString()}°C')]),
  //           const Divider(),
  //         ],
  //       ),
  //     if (dataKind == DataKind.ph)
  //       Column(
  //         children: [
  //           Row(children: [SizedBox(width: labelWidth, child: const Text('Ph', style: TextStyle(fontSize: 14))), Text(ph.toString())]),
  //           const Divider(),
  //         ],
  //       ),
  //     if (dataKind == DataKind.calendar)
  //       Column(
  //         children: [
  //           imgURL != ''
  //               ? Center(child: Container(width: 250, height: 200, decoration: BoxDecoration(shape: BoxShape.rectangle, image: DecorationImage(image: NetworkImage(imgURL), fit: BoxFit.cover))))
  //               : Center(child: Container(width: 250, height: 200, color: Colors.grey[200], child: const Center(child: Text('No Image')))),
  //           const SizedBox(height: 15),
  //           const Divider(),
  //           Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [SizedBox(width: labelWidth, height: 120, child: const Text('日記', style: TextStyle(fontSize: 14))), SizedBox(width: memoWidth, child: Text(memo, maxLines: 30, overflow: TextOverflow.ellipsis))]
  //           ),
  //           const Divider(),
  //         ],
  //       ),
  //     Row(children: [SizedBox(width: labelWidth, child: const Text('追加日', style: TextStyle(fontSize: 14))), Text(DateFormat.yMMMEd('ja').format(registrationDate).toString())]),
  //     const Divider(),
  //     Row(children: [SizedBox(width: labelWidth, child: const Text('最新更新日', style: TextStyle(fontSize: 14))), Text(DateFormat.yMMMEd('ja').format(lastUpdatedDate).toString())]),
  //     const Divider(),
  //     if (dataKind != DataKind.calendar)
  //       Column(
  //         children: [
  //           Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [SizedBox(width: labelWidth, height: 120, child: const Text('メモ', style: TextStyle(fontSize: 14))), SizedBox(width: memoWidth, child: Text(memo, maxLines: 30, overflow: TextOverflow.ellipsis))]
  //           ),
  //           const Divider(),
  //         ],
  //       ),
  //   ],
  // );

  return widget;
}