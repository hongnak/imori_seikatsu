import 'package:flutter/material.dart';
import 'package:imori_seikatsu/widgets/enterButtonWidget.dart';
import 'package:imori_seikatsu/widgets/enter_memo_widget.dart';
import 'package:imori_seikatsu/widgets/enter_name_widget.dart';
import 'package:imori_seikatsu/widgets/upload_image_widget.dart';
import 'package:provider/provider.dart';
import '../common.dart';
import '../widgets/enter_kind_widget.dart';
import '../widgets/select_amount_widget.dart';
import '../widgets/select_category_widget.dart';
import '../widgets/select_date_widget.dart';
import 'edit_data_model.dart';

class EditDataPage extends StatelessWidget {
  const EditDataPage({Key? key, required this.label, required this.data, required this.tankID, required this.lastWaterChangeDate, required this.lastFeedDate}) : super(key: key);
  final String label;
  final dynamic data;
  final String tankID;
  final DateTime lastWaterChangeDate;
  final DateTime lastFeedDate;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditDataModel>(
      create: (_) => EditDataModel(tankID: tankID, data: data, lastWaterChangeDate: lastWaterChangeDate, lastFeedDate: lastFeedDate)..fetchData(),
      child: Scaffold(
        appBar: AppBar(title: Text('$labelを編集')),
        body: Consumer<EditDataModel>(
          builder: (context, model, child) {
            const String entryStr = '入力してください';
            const String selectStr = '選択してください';
            return SingleChildScrollView(
              child: Stack(
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
                                  enterButtonWidget(model, context, '確定', tankID, 'creature')
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
                                  enterButtonWidget(model, context, '確定', tankID, 'plant')
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
                                  enterButtonWidget(model, context, '確定', tankID, 'waterChange')
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
                                  enterButtonWidget(model, context, '確定', tankID, 'feed')
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
                                  enterButtonWidget(model, context, '確定', tankID, 'temperature')
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
                                  enterButtonWidget(model, context, '確定', tankID, 'ph')
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
                                  enterButtonWidget(model, context, '確定', tankID, 'diary')
                                ],
                              ),
                          ],
                        )
                    ),
                    if (model.isLoading) Container(color: Colors.black26, child: const Center(child: CircularProgressIndicator())),
                  ]
              ),
            );
          },
        ),
      ),
    );
  }

}