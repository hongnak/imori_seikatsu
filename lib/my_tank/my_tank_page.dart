import 'package:flutter/material.dart';
import 'package:imori_seikatsu/add_imorium/add_imorium_page.dart';
import 'package:imori_seikatsu/domain/imorium.dart';
import 'package:imori_seikatsu/my_tank/my_tank_model.dart';
import 'package:imori_seikatsu/my_tank_detail/my_tank_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MyTankPage extends StatelessWidget {
  const MyTankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyTankModel>(
      create: (_) => MyTankModel()..fetchImoriumList(),
      child: Consumer<MyTankModel>(
          builder: (context, model, child) {
            final List<Imorium>? imoriums = model.imoriums;
            double labelWidth = MediaQuery.of(context).size.width * 0.14;
            double tankNameFontSize = 24.0;
            double detailFontSize = 9.0;

            if (imoriums == null) {
              return Scaffold(
                  body: const Center(child: Text('水槽がまだ一つも登録されていません')),
                  floatingActionButton: FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () async {
                      final bool? added = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddImoriumPage(title: '水槽を追加'), fullscreenDialog: true));
                      if (added != null && added) {
                        const snackBar = SnackBar(backgroundColor: Colors.green, content: Text('水槽を追加しました'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      model.fetchImoriumList();
                    },
                  )
              );
            }

            final List<Widget> widgets = imoriums.map((imorium) => Card(
              child: InkWell(
                onTap: () async {
                  final bool? deleted = await Navigator.push(context, MaterialPageRoute(builder: (context) => MyTankDetailPage(imorium: imorium)));
                  if (deleted != null && deleted) {
                    final snackBar = SnackBar(backgroundColor: Colors.green, content: Text('水槽を削除しました'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  model.fetchImoriumList();
                },
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(color: Colors.white, child: const SizedBox(height: 120.0, width: 120.0, child: Center(child: Text('No Image')))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(imorium.name, style: TextStyle(fontSize: tankNameFontSize)),
                                  const SizedBox(height: 20.0),
                                  Row(
                                    children: [
                                      SizedBox(width: labelWidth, child: Text('サイズ', style: TextStyle(fontSize: detailFontSize))),
                                      Text(imorium.size, style: TextStyle(fontSize: detailFontSize)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: labelWidth, child: Text('登録日', style: TextStyle(fontSize: detailFontSize))),
                                      Text(DateFormat.yMMMEd('ja').format(imorium.registrationDate.toDate()).toString(), style: TextStyle(fontSize: detailFontSize)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: labelWidth, child: Text('最終更新日', style: TextStyle(fontSize: detailFontSize))),
                                      Text(DateFormat.yMMMEd('ja').format(imorium.lastUpdatedDate.toDate()).toString(), style: TextStyle(fontSize: detailFontSize)),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )).toList();

            return Scaffold(
                body: imoriums.isNotEmpty
                    ? ListView(children: widgets)
                    : const Center(child: Text('水槽がまだ一つも登録されていません')),
                floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () async {
                    final bool? added = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddImoriumPage(title: 'イモリウムを追加',), fullscreenDialog: true));
                    if (added != null && added) {
                      const snackBar = SnackBar(backgroundColor: Colors.green, content: Text('イモリウムを追加しました'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    model.fetchImoriumList();
                  },
                )
            );
          }
      ),
    );
  }
}