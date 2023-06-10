import 'package:flutter/material.dart';
import 'package:imori_seikatsu/setting/setting_model.dart';
import 'package:provider/provider.dart';
import '../widgets/setting_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('設定')),
        body: ChangeNotifierProvider<SettingModel>(
          create: (_) => SettingModel()..initPackageInfo(),
          child: Consumer<SettingModel>(builder: (context, model, child) {
            return Padding(padding: const EdgeInsets.all(8.0), child: settingWidget(model, context));
          }),
        )
    );
  }

}