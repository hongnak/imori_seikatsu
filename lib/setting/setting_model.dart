import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingModel extends ChangeNotifier {

  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    packageInfo = info;
    notifyListeners();
  }

}