import 'package:flutter/material.dart';
import 'package:imori_seikatsu/widgets/enterButtonWidget.dart';
import 'package:imori_seikatsu/widgets/enter_memo_widget.dart';
import 'package:imori_seikatsu/widgets/enter_name_widget.dart';
import 'package:imori_seikatsu/widgets/select_size_widget.dart';
import 'package:imori_seikatsu/widgets/upload_image_widget.dart';
import 'package:provider/provider.dart';
import 'add_imorium_model.dart';

class AddImoriumPage extends StatelessWidget {
  const AddImoriumPage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddImoriumModel>(
      create: (_) => AddImoriumModel(),
      child: Scaffold(
        appBar: AppBar(title: const Text('イモリウムを追加')),
        body: Consumer<AddImoriumModel>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              child: Stack(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            uploadImageWidget(model, context),
                            enterNameWidget(model, '水槽の名前', '入力してください'),
                            selectSizeWidget(model, '水槽のサイズ', '選択してください'),
                            const SizedBox(height: 16.0),
                            enterMemoWidget(model, 'メモ', '入力してください'),
                            const SizedBox(height: 16.0),
                            enterButtonWidget(model, context, '確定', 'none', 'none')
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