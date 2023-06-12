import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../domain/imorium.dart';

class EditImoriumModel extends ChangeNotifier {
  EditImoriumModel({Key? key, required this.imorium});
  final Imorium imorium;
  String? name;
  String? size;
  String? memo;
  String? imgURL;
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

  Future fetchData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final user = FirebaseAuth.instance.currentUser;
      userID = user?.uid;
    }

    if (userID != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot;
      snapshot = await FirebaseFirestore.instance.collection('imorium').doc(imorium.id).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      name = data['name'];
      memo = data['memo'];
      size = data['size'];
      imgURL = data['imgURL'];
      notifyListeners();
    }
  }

  Future addOrEditData(String id, String collectionName) async {
    if (name == null || name == '') throw '名前が入力されていません';
    if (size == null || size == '') throw 'サイズが入力されていません';
    final doc = FirebaseFirestore.instance.collection('imorium').doc(imorium.id);
    String? imgURL;

    if (FirebaseAuth.instance.currentUser != null) {
      final user = FirebaseAuth.instance.currentUser;
      userID = user?.uid;
    }

    if (imageFile != null) {
      final task = await FirebaseStorage.instance.ref('$userID/imorium/${doc.id}').putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    await doc.update({
      'name' : name,
      'size' : size,
      'memo' : memo,
      'imgURL' : imgURL ?? '',
      'lastUpdatedDate' : myDateTime,
    });

    notifyListeners();
  }
}