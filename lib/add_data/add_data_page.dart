import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imori_seikatsu/add_data/add_data_model.dart';
import 'package:imori_seikatsu/common.dart';
//import 'package:imori_seikatsu/widgets/enter_button_widget.dart';
import 'package:imori_seikatsu/widgets/enter_kind_widget.dart';
import 'package:imori_seikatsu/widgets/enter_memo_widget.dart';
import 'package:imori_seikatsu/widgets/enter_name_widget.dart';
import 'package:imori_seikatsu/widgets/select_category_widget.dart';
import 'package:imori_seikatsu/widgets/select_date_widget.dart';
import 'package:imori_seikatsu/widgets/upload_image_widget.dart';
import 'package:provider/provider.dart';
import '../domain/imorium.dart';
import '../widgets/enterButtonWidget.dart';
import '../widgets/select_amount_widget.dart';

class AddDataPage extends StatelessWidget {
  const AddDataPage({super.key, required this.dataList, required this.imorium, required this.label});
  final List<dynamic> dataList;
  final Imorium imorium;
  final String label;

  @override
  Widget build(BuildContext context) {
    DateTime lastWaterChangeDate = imorium.lastWaterChangeDate.toDate();
    DateTime lastFeedDate = imorium.lastFeedDate.toDate();
    return Scaffold(
      appBar: AppBar(
        title: Text('$labelを追加'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<AddDataModel>(
        create: (_) => AddDataModel(lastWaterChangeDate: lastWaterChangeDate, lastFeedDate: lastFeedDate, label: label, tankName: imorium.name),
        child: SingleChildScrollView(
          child: Consumer<AddDataModel>(builder: (context, model, child) {
            const String entryStr = '入力してください';
            const String selectStr = '選択してください';
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      if (dataKind == DataKind.creature)
                        Column(
                          children: [
                            uploadImageWidget(model, context),
                            const SizedBox(height: 16.0),
                            enterNameWidget(model, '名前', entryStr),
                            selectCategoryWidget(model, 'カテゴリー', selectStr),
                            const SizedBox(height: 16.0),
                            enterKindWidget(model, '種類', entryStr),
                            selectAmountWidget(model, context, '匹数', selectStr, '匹'),
                            selectDateWidget(model, context, '追加日'),
                            const SizedBox(height: 16.0),
                            enterMemoWidget(model, 'メモ', entryStr),
                            const SizedBox(height: 16.0),
                            enterButtonWidget(model, context, '確定', imorium.id, 'creature')
                          ],
                        ),
                      if (dataKind == DataKind.plant)
                        Column(
                          children: [
                            uploadImageWidget(model, context),
                            const SizedBox(height: 16.0),
                            enterKindWidget(model, '種類', entryStr),
                            selectAmountWidget(model, context, '株数', selectStr, '株'),
                            selectDateWidget(model, context, '追加日'),
                            const SizedBox(height: 16.0),
                            enterMemoWidget(model, 'メモ', entryStr),
                            const SizedBox(height: 16.0),
                            enterButtonWidget(model, context, '確定', imorium.id, 'plant')
                          ],
                        ),
                      if (dataKind == DataKind.waterChange)
                        Column(
                          children: [
                            selectAmountWidget(model, context, '水交換量', selectStr, ''),
                            const SizedBox(height: 16.0),
                            selectDateWidget(model, context, '水交換日'),
                            const SizedBox(height: 16.0),
                            enterMemoWidget(model, 'メモ', entryStr),
                            const SizedBox(height: 16.0),
                            enterButtonWidget(model, context, '確定', imorium.id, 'waterChange')
                          ],
                        ),
                      if (dataKind == DataKind.feed)
                        Column(
                          children: [
                            selectAmountWidget(model, context, '餌やり量', selectStr, ''),
                            const SizedBox(height: 16.0),
                            selectDateWidget(model, context, '餌やり日'),
                            const SizedBox(height: 16.0),
                            enterMemoWidget(model, 'メモ', entryStr),
                            const SizedBox(height: 16.0),
                            enterButtonWidget(model, context, '確定', imorium.id, 'feed')
                          ],
                        ),
                      if (dataKind == DataKind.temperature)
                        Column(
                          children: [
                            selectAmountWidget(model, context, '水温', selectStr, '°'),
                            const SizedBox(height: 16.0),
                            selectDateWidget(model, context, '測定日'),
                            const SizedBox(height: 16.0),
                            enterMemoWidget(model, 'メモ', entryStr),
                            const SizedBox(height: 16.0),
                            enterButtonWidget(model, context, '確定', imorium.id, 'temperature')
                          ],
                        ),
                      if (dataKind == DataKind.ph)
                        Column(
                          children: [
                            selectAmountWidget(model, context, 'ph', selectStr, ''),
                            const SizedBox(height: 16.0),
                            selectDateWidget(model, context, '測定日'),
                            const SizedBox(height: 16.0),
                            enterMemoWidget(model, 'メモ', entryStr),
                            const SizedBox(height: 16.0),
                            enterButtonWidget(model, context, '確定', imorium.id, 'ph')
                          ],
                        ),
                      if (dataKind == DataKind.diary)
                        Column(
                          children: [
                            uploadImageWidget(model, context),
                            selectDateWidget(model, context, '記録日'),
                            const SizedBox(height: 16.0),
                            enterMemoWidget(model, '日記', entryStr),
                            const SizedBox(height: 16.0),
                            enterButtonWidget(model, context, '確定', imorium.id, 'diary')
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}