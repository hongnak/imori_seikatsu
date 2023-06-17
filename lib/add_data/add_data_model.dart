import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../common.dart';

class AddDataModel extends ChangeNotifier {
  AddDataModel({Key? key, required this.lastWaterChangeDate, required this.lastFeedDate, required this.label, required this.tankName});
  final DateTime lastWaterChangeDate;
  final DateTime lastFeedDate;
  final String label;
  final String tankName;
  String? name;
  String? size;
  String? memo;
  String? kind;
  String? category;
  String? userID;
  double temperature = 26.0;
  double ph = 7.00;
  int amountInt = 1;
  dynamic amount;
  var myDateTime = DateTime.now();
  final picker = ImagePicker();
  File? imageFile;
  bool isLoading = false;

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

  void setDate(DateTime dateTime) {
    myDateTime = dateTime;
    notifyListeners();
  }

  changeAmountVal(val) {
    amountInt = val;
    notifyListeners();
  }

  void setAmountInt(int value) {
    amountInt = value;
    notifyListeners();
  }

  void setAmount(dynamic value) {
    amount = value;
    notifyListeners();
  }

  void setTemperature(double value) {
    temperature = value;
    notifyListeners();
  }

  void setPh(double value) {
    ph = value;
    notifyListeners();
  }

  Future addOrEditData(String id, String collectionName) async {

    final String date = myDateTime.year.toString() + myDateTime.month.toString() + myDateTime.day.toString();

    if (FirebaseAuth.instance.currentUser != null) {
      final user = FirebaseAuth.instance.currentUser;
      userID = user?.uid;
    }

    final tankDoc = FirebaseFirestore.instance.collection('imorium').doc(id);
    final doc = FirebaseFirestore.instance.collection('imorium').doc(id).collection(collectionName).doc();
    final eventDoc = FirebaseFirestore.instance.collection('calendar').doc(userID).collection('event').doc(date);
    final DocumentSnapshot eventDocSnapshot = await eventDoc.get();
    Map<String, dynamic> data = eventDocSnapshot.data() as Map<String, dynamic>;
    List<String> tankNameList = data['tankName'];
    List<String> tankIDList = data['tankID'];
    List<String> eventList = data['event'];

    String? imgURL;

    switch (dataKind) {
      case DataKind.creature:
        if (name == null || name == '') throw '$label名前が入力されていません';
        if (category == null || category == '') throw '$labelのカテゴリーが選択されていません';
        if (kind == null || kind == '') throw '$labelの種類が入力されていません';
        if (imageFile != null) {
          final task = await FirebaseStorage.instance.ref('$userID/creature/${doc.id}').putFile(imageFile!);
          imgURL = await task.ref.getDownloadURL();
        }
        break;
      case DataKind.plant:
        if (kind == null || kind == '') throw '$labelの種類が入力されていません';
        if (imageFile != null) {
          final task = await FirebaseStorage.instance.ref('$userID/plant/${doc.id}').putFile(imageFile!);
          imgURL = await task.ref.getDownloadURL();
        }
        break;
      case DataKind.waterChange:
        if (amount == null || amount == '') throw '$label量が選択されていません';
        break;
      case DataKind.feed:
        if (amount == null || amount == '') throw '$label量が選択されていません';
        break;
      case DataKind.temperature:
        break;
      case DataKind.diary:
        if (memo == null || memo == '') throw '$labelが入力されていません';
        if (imageFile != null) {
          final task = await FirebaseStorage.instance.ref('$userID/diary/${doc.id}').putFile(imageFile!);
          imgURL = await task.ref.getDownloadURL();
        }
      default:
        break;
    }

    try {
      await doc.set({
        if (name != null) 'name': name,
        if (category != null) 'category': category,
        if (kind != null) 'kind': kind,
        if (amount != null) 'amount': amount,
        if (dataKind == DataKind.creature ||
            dataKind == DataKind.plant) 'amount': amountInt,
        if (dataKind == DataKind.temperature) 'temperature': temperature,
        if (dataKind == DataKind.ph) 'ph': ph,
        'imgURL': imgURL ?? '',
        'memo': memo ?? '',
        'registrationDate': myDateTime,
        'lastUpdatedDate': myDateTime,
      });

      await doc.update({
        if (dataKind == DataKind.waterChange && myDateTime.isAfter(lastWaterChangeDate)) 'lastWaterChangeDate' : myDateTime,
        if (dataKind == DataKind.feed && myDateTime.isAfter(lastFeedDate)) 'lastFeedDate' : myDateTime,
        'lastUpdatedDate' : DateTime.now(),
      });

      await tankDoc.update({
        if (dataKind == DataKind.waterChange && myDateTime.isAfter(lastWaterChangeDate)) 'lastWaterChangeDate' : myDateTime,
        if (dataKind == DataKind.feed && myDateTime.isAfter(lastFeedDate)) 'lastFeedDate' : myDateTime,
        'lastUpdatedDate' : DateTime.now(),
        //ToDo: 水足しとかお掃除とかのlastDateを追加
      });

      if (!eventDocSnapshot.exists) {
        await eventDoc.set({
          'tankID' : FieldValue.arrayUnion([id]),
          'tankName' : FieldValue.arrayUnion([tankName]),
          'docID' : FieldValue.arrayUnion([doc.id]),
          'userID' : userID,
          'event' : FieldValue.arrayUnion(['$tankNameに$labelを記録しました']),
          'registrationDate' : FieldValue.arrayUnion([myDateTime]),
        });
      } else {
        await eventDoc.update({
          'tankID' : FieldValue.arrayUnion([id]),
          'tankName' : FieldValue.arrayUnion([tankName]),
          'docID' : FieldValue.arrayUnion([doc.id]),
          'event' : FieldValue.arrayUnion(['$tankNameに$labelを記録しました']),
        });
      }

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      if (kDebugMode) {
        print('data added');
      }
    }
    notifyListeners();
  }

}