import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImoriumModel extends ChangeNotifier {
  String? name;
  String? size;
  String? memo;
  String? userID;
  bool isLoading = false;
  var myDateTime = DateTime.now();
  var defaultDateTime = DateTime(1970);
  final picker = ImagePicker();
  File? imageFile;

  Future pickImage(BuildContext context) async {
    double imgWidth = MediaQuery.of(context).size.width * 0.9;
    double imgHeight = MediaQuery.of(context).size.height * 0.4;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: imgHeight, maxWidth: imgWidth);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future addOrEditData(String id, String collectionName) async {
    if (name == null || name == '') throw '名前が入力されていません';
    if (size == null || size == '') throw 'サイズが入力されていません';
    final doc = FirebaseFirestore.instance.collection('imorium').doc();
    String? imgURL;

    if (FirebaseAuth.instance.currentUser != null) {
      final user = FirebaseAuth.instance.currentUser;
      userID = user?.uid;
    }

    if (imageFile != null) {
      final task = await FirebaseStorage.instance.ref('$userID/imorium/${doc.id}').putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    try {
      await doc.set({
        'userID' : userID,
        'name' : name,
        'size' : size,
        'memo' : memo ?? '',
        'imgURL' : imgURL ?? '',
        'waterChangeReminder' : 0,
        'feedReminder' : 0,
        'cleanReminder' : 0,
        'addWaterReminder' : 0,
        'sprayReminder' : 0,
        'filterExchangeReminder' : 0,
        'registrationDate' : myDateTime,
        'lastUpdatedDate' : myDateTime,
        'lastWaterChangeDate' : defaultDateTime,
        'lastFeedDate' : defaultDateTime,
        'lastCleanDate' : defaultDateTime,
        'lastAddWaterDate' : defaultDateTime,
        'lastSprayDate' : defaultDateTime,
        'lastFilterExchangeDate' : defaultDateTime,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      if (kDebugMode) {
        print('imorium added');
      }
    }
    notifyListeners();
  }
}