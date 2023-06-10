import 'package:flutter/material.dart';
import 'package:imori_seikatsu/add_data/add_data_page.dart';
import 'package:imori_seikatsu/common.dart';
import 'package:imori_seikatsu/my_data_detail/my_data_detail_page.dart';
import '../../domain/imorium.dart';

Widget creatureAndPlantContainer(List<dynamic> dataList, String label, BuildContext context, Imorium imorium, dynamic model) {
  SnackBar snackBar(String text) {
    final snackBar = SnackBar(backgroundColor: Colors.green, content: Text(text));
    return snackBar;
  }
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  Widget widget = Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          IconButton(
            onPressed: () async {
              switch (label) {
                case '生き物':
                  dataKind = DataKind.creature;
                  break;
                case '水草':
                  dataKind = DataKind.plant;
                  break;
                default:
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
            margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 18.0),
            height: 120.0,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) => Column(
                  children: [
                    GestureDetector(
                      child: dataList[i].imgURL != ''
                          ?
                      Container(
                          width: 90.0,
                          height: 90.0,
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(dataList[i].imgURL)))
                      )
                          :
                      Container(
                          width: 90.0,
                          height: 90.0,
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200]), child: const Center(child: Text('No Image'))
                      ),
                      onTap: () async {
                        switch (label)  {
                          case '生き物':
                            dataKind = DataKind.creature;
                            final bool? deleted = await Navigator.push(context, MaterialPageRoute(builder: (_) => MyDataDetailPage(data: dataList[i], label: label, tankID: imorium.id), fullscreenDialog: true));
                            if (deleted != null && deleted) {
                              scaffoldMessenger.showSnackBar(snackBar('削除しました'));
                            }
                            model.fetchData();
                            break;
                          case '水草':
                            dataKind = DataKind.plant;
                            final bool? deleted = await Navigator.push(context, MaterialPageRoute(builder: (_) => MyDataDetailPage(data: dataList[i], label: label, tankID: imorium.id), fullscreenDialog: true));
                            if (deleted != null && deleted) {
                              scaffoldMessenger.showSnackBar(snackBar('削除しました'));
                            }
                            model.fetchData();
                            break;
                          default:
                            break;
                        }
                      },
                    ),
                    Text(dataList[i].name, overflow: TextOverflow.ellipsis)
                  ],
                ),
                separatorBuilder: (BuildContext context, int i) => const SizedBox(width: 10.0),
                itemCount: dataList.length
            ),
          ),
        ],
      )
          :
      const Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
            child: Column(
              children: [
                CircleAvatar(child: Icon(Icons.emoji_food_beverage)),
                SizedBox(height: 5.0),
                Text('登録がありません', style: TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    ],
  );
  return widget;
}