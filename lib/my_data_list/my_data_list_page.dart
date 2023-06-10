import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imori_seikatsu/common.dart';
import 'package:intl/intl.dart';
import '../domain/imorium.dart';
import '../my_data_detail/my_data_detail_page.dart';

class MyDataListPage extends StatelessWidget {
  const MyDataListPage({super.key, required this.dataList, required this.label, required this.imorium});
  final Imorium imorium;
  final dynamic dataList;
  final String label;
  @override
  Widget build(BuildContext context) {
    List<Icon> icons = const [Icon(Icons.water_drop), Icon(Icons.dining), Icon(Icons.thermostat_sharp), Icon(Icons.mail)];
    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dataList.length,
          itemBuilder: (_, i) {
            return Column(
              children: [
                ListTile(
                  onTap: () {
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
                    Navigator.push(context, MaterialPageRoute(builder: (_) => MyDataDetailPage(data: dataList[i], label: label, tankID: imorium.id), fullscreenDialog: true));
                    //setDataKind(title);
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailDataPage(data: dataList[i], tankName: tankName, kind: title, tankID: tankID)));
                  },
                  leading: icons[iconIndex],
                  title: Text(dataList[i].amount.toString(), style: const TextStyle(fontSize: 20)),
                  trailing: Text(DateFormat.yMMMEd('ja').add_Hm().format(dataList[i].registrationDate.toDate()).toString(), style: const TextStyle(fontSize: 12)),
                ),
                Divider(color: Colors.grey[200]),
              ],
            );
          }
      ),
    );
  }

}