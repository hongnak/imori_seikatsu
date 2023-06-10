import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imori_seikatsu/common.dart';

class MyDataDetailModel extends ChangeNotifier {
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future deleteData(String tankID, String docID, String collectionName) async {
    final tankDoc = FirebaseFirestore.instance.collection('imorium').doc(tankID);
    final doc = FirebaseFirestore.instance.collection('imorium').doc(tankID).collection(collectionName).doc(docID);
    try {
      if (dataKind != DataKind.imorium ) {
        await doc.delete();
      } else {
        await tankDoc.delete();
      }
    } catch (e) {
      print(e);
    } finally {
      print('data deleted');
    }
  }

}