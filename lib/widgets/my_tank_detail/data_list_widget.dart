import 'package:flutter/material.dart';
import 'package:imori_seikatsu/my_data_list/my_data_list_page.dart';
import 'package:intl/intl.dart';
import '../../add_data/add_data_page.dart';
import '../../common.dart';
import '../../domain/imorium.dart';
import '../../my_data_detail/my_data_detail_page.dart';

Widget dataListWidget(model, BuildContext context, List<dynamic> dataList, String label, int index, Imorium imorium) {
  List<Icon> icons = const [Icon(Icons.water_drop), Icon(Icons.dining), Icon(Icons.thermostat_sharp), Icon(Icons.sticky_note_2_outlined)];
  SnackBar snackBar(String text) {
    final snackBar = SnackBar(backgroundColor: Colors.green, content: Text(text));
    return snackBar;
  }
  final scaffoldMessenger = ScaffoldMessenger.of(context);
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
            onPressed: () async {
              switch (label) {
                case '水交換':
                  dataKind = DataKind.waterChange;
                  break;
                case '餌やり':
                  dataKind = DataKind.feed;
                  break;
                case '水温':
                  dataKind = DataKind.temperature;
                  break;
                case 'ph':
                  dataKind = DataKind.ph;
                  break;
                case '日記':
                  dataKind = DataKind.diary;
                  break;
                default:
                  dataKind = DataKind.imorium;
                  break;
              }
              final bool? added = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddDataPage(dataList: dataList, label: label, imorium: imorium), fullscreenDialog: true));
              if (added != null && added) {
                scaffoldMessenger.showSnackBar(snackBar('記録しました'));
              }
              model.fetchData();
            },
            icon: const Icon(Icons.add, color: Colors.grey, size: 18.0),
          )
        ],
      ),
      dataList.isNotEmpty
          ?
      Column(
        children: [
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
                  onTap: () async {
                    switch (label) {
                      case '水交換':
                        dataKind = DataKind.waterChange;
                        break;
                      case '餌やり':
                        dataKind = DataKind.feed;
                        break;
                      case '水温':
                        dataKind = DataKind.temperature;
                        break;
                      case 'ph':
                        dataKind = DataKind.ph;
                        break;
                      case '日記':
                        dataKind = DataKind.diary;
                        break;
                      default:
                        break;
                    }
                    final bool? deleted = await Navigator.push(context, MaterialPageRoute(builder: (_) => MyDataDetailPage(data: dataList[i], label: label, tankID: imorium.id), fullscreenDialog: true));
                    if (deleted != null && deleted) {
                      scaffoldMessenger.showSnackBar(snackBar('削除しました'));
                    }
                    model.fetchData();
                    },
                  leading: icons[index],
                  title: Text(dataList[i].amount.toString(), maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 20)),
                  trailing: Text(DateFormat.yMMMEd('ja').add_Hm().format(dataList[i].registrationDate.toDate()).toString(), style: const TextStyle(fontSize: 12)),
                ),
              ),
            ),
          ),
          dataList.length > 3
              ?
          TextButton(
              child: const Text('もっと見る'),
              onPressed: () {
                switch (dataKind) {
                  case DataKind.waterChange:
                    iconIndex = 0;
                    break;
                  case DataKind.feed:
                    iconIndex = 1;
                    break;
                  case DataKind.temperature:
                    iconIndex = 2;
                    break;
                  case DataKind.ph:
                    iconIndex = 2;
                    break;
                  case DataKind.diary:
                    iconIndex = 3;
                    break;
                  default:
                    break;
                }
                Navigator.push(context, MaterialPageRoute(builder: (_) => MyDataListPage(dataList: dataList, label: label, imorium: imorium)));
              }
          )
              :
          Container()
        ],
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