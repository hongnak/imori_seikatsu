import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget enterButtonWidget(model, BuildContext context, String buttonText, String id, String collectionName) {
  final navigator = Navigator.of(context);
  Widget widget = Center(
    child: ElevatedButton(
      onPressed: () async {
        try {
          model.startLoading();
          await model.addData(id, collectionName);
          navigator.pop(true);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          final snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } finally {
          model.endLoading();
        }
      },
      child: Text(buttonText),
    ),
  );
  return widget;
}