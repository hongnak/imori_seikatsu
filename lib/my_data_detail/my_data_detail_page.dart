import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:imori_seikatsu/common.dart';
import 'package:imori_seikatsu/edit_imorium/edit_imorium_page.dart';
import 'package:imori_seikatsu/my_data_detail/my_data_detail_model.dart';
import '../domain/imorium.dart';
import '../edit_data/edit_data_page.dart';
import '../widgets/my_data_detail/detail_data_widget.dart';
import 'package:provider/provider.dart';

class MyDataDetailPage extends StatelessWidget {
  const MyDataDetailPage({super.key, required this.data, required this.label, required this.imorium});
  final dynamic data;
  final String label;
  final Imorium imorium;
  // final String tankID;
  // final DateTime lastWaterChangeDate;
  // final DateTime lastFeedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: dataKind == DataKind.imorium || dataKind == DataKind.creature || dataKind == DataKind.plant
            ? Text(data.name)
            : Text(label),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ChangeNotifierProvider<MyDataDetailModel>(
                        create: (_) => MyDataDetailModel(),
                        child: Consumer<MyDataDetailModel>(
                          builder: (context, model, child) {
                            return SimpleDialog(
                              alignment: Alignment.center,
                              children: [
                                SimpleDialogOption(
                                  child: const Center(child: Text('編集する', style: TextStyle(fontSize: 18.0, color: Colors.blueAccent))),
                                  onPressed: () async {
                                    mode = Mode.edit;
                                    if (dataKind == DataKind.imorium) {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditImoriumPage(imorium: imorium), fullscreenDialog: true));
                                    } else {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditDataPage(label: label, tankID: imorium.id, data: data, lastWaterChangeDate: imorium.lastWaterChangeDate.toDate(), lastFeedDate: imorium.lastFeedDate.toDate()), fullscreenDialog: true));
                                    }
                                  },
                                ),
                                const SimpleDialogOption(
                                  child: Center(child: Text('共有する', style: TextStyle(fontSize: 18.0, color: Colors.blueAccent))),
                                ),
                                SimpleDialogOption(
                                  child: const Center(child: Text('削除する', style: TextStyle(fontSize: 18.0, color: Colors.red))),
                                  onPressed: () {
                                    mode = Mode.delete;
                                    Navigator.of(context).pop();
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: const Text('データを削除します', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                                            content: const Text('この操作は取り消せません。'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('キャンセル', style: TextStyle(fontSize: 18.0))
                                              ),
                                              TextButton(
                                                  onPressed: () async {
                                                    final navigator = Navigator.of(context);
                                                    try {
                                                      await model.deleteData(imorium.id, data.id, data.collectionName);
                                                      if (dataKind == DataKind.imorium) {
                                                        navigator.pop(true);
                                                        navigator.pop(true);
                                                        navigator.pop(true);
                                                      } else {
                                                        navigator.pop(true);
                                                        navigator.pop(true);
                                                      }
                                                    } catch (e) {
                                                      if (kDebugMode) {
                                                        print(e);
                                                      }
                                                      final snackBar = SnackBar(content: Text(e.toString()));
                                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                    }

                                                  },
                                                  child: const Text('OK', style: TextStyle(fontSize: 18.0))
                                              ),
                                            ],
                                          );
                                        }
                                    );
                                  },
                                ),
                                SimpleDialogOption(
                                  child: const Center(child: Text('キャンセル', style: TextStyle(fontSize: 18.0, color: Colors.blueAccent))),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          },
                        ),
                      );
                    }
                );
              },
              icon: const Icon(Icons.more_horiz)
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
              child: detailDataWidget(data, context, label)
          )
      ),
    );
  }

}