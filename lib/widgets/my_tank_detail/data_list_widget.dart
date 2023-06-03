import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget dataListWidget(model, BuildContext context, List<dynamic> dataList, String label, int index) {
  List<Icon> icons = const [Icon(Icons.water_drop), Icon(Icons.dining), Icon(Icons.thermostat_sharp), Icon(Icons.mail)];

  double setWidgetHeight(dynamic dataList) {
    double num = 50;
    switch (dataList.length) {
      case 0:
        break;
      case 1:
        num = 100;
        break;
      case 2:
        num = 150;
        break;
      case 3:
        num = 200;
        break;
    }
    return num;
  }

  Widget widget = Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.grey, size: 18.0),
          )
        ],
      ),
      // ListTile(
      //     leading: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      //     trailing: dataList.length > 3
      //         ?
      //     TextButton(
      //       child: const Text('さらに表示', style: TextStyle(fontSize: 12.0)),
      //       onPressed: () {
      //         //setDataKind(title);
      //         //Navigator.push(context, MaterialPageRoute(builder: (context) => SeeMorePage(dataList: dataList, tankName: tankName, title: title, index: index, tankID: id)));
      //       },
      //     )
      //         :
      //     null
      // ),
      dataList.isNotEmpty
          ?
      Container(
        margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
        height: dataList.length < 3
            ? setWidgetHeight(dataList)
            : 200,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dataList.length > 3 ? 3 : dataList.length,
          itemBuilder: (_, i) => Card(
            child: ListTile(
              onTap: () {
                //setDataKind(title);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailDataPage(data: dataList[i], tankName: tankName, kind: title, tankID: id)));
              },
              leading: icons[index],
              title: Text(dataList[i].amount.toString(), maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 20)),
              trailing: Text(DateFormat.yMMMEd('ja').add_Hm().format(dataList[i].registrationDate.toDate()).toString(), style: const TextStyle(fontSize: 12)),
            ),
          ),
        ),
      )
          :
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
        child: Column(
          children: [
            CircleAvatar(child: icons[index]),
            const SizedBox(height: 5.0),
            const Text('登録がありません', style: TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
      //addDataButtonWidget(model, context, title, id, lastWaterChangeDate, lastFeedDate)
    ],
  );
  return widget;
}