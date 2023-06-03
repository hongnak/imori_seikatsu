import 'package:flutter/cupertino.dart';
import 'package:imori_seikatsu/domain/creature.dart';
import 'package:imori_seikatsu/domain/diary.dart';
import 'package:imori_seikatsu/domain/feed.dart';
import 'package:imori_seikatsu/domain/ph.dart';
import 'package:imori_seikatsu/domain/plant.dart';
import 'package:imori_seikatsu/domain/temperature.dart';
import 'package:imori_seikatsu/domain/waterChange.dart';
import '../domain/imorium.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyTankDetailModel extends ChangeNotifier {
  MyTankDetailModel({Key? key, required this.imorium});
  Imorium imorium;
  List<Creature>? creatures;
  List<Plant>? plants;
  List<WaterChange>? waterChanges;
  List<Feed>? feeds;
  List<Temperature>? temperatures;
  List<Ph>? ph;
  List<Diary>? diaries;
  String? userID;
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void fetchData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final user = FirebaseAuth.instance.currentUser;
      userID = user?.uid;
    }
    List<String> collectionNames = ['creature', 'plant', 'waterChange', 'feed', 'temperature', 'ph', 'calendar'];
    List<QuerySnapshot> snapshots = [];
    final DocumentReference documentReference = FirebaseFirestore.instance.collection('imorium').doc(imorium.id);

    for(int i = 0; i < collectionNames.length; i++) {
      final QuerySnapshot snapshot = await documentReference.collection(collectionNames[i]).get(const GetOptions(source: Source.cache));
      snapshots.add(snapshot);
    }

    final List<Creature> creatures = snapshots[0].docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String name = data['name'];
      final String category = data['category'];
      final String kind = data['kind'];
      final String imgURL = data['imgURL'];
      final String id = document.id;
      final String memo = data['memo'] ?? '';
      final Timestamp registrationDate = data['registrationDate'];
      final Timestamp lastUpdatedDate = data['lastUpdatedDate'];
      return Creature(name, category, kind, imgURL, memo, id, registrationDate, lastUpdatedDate);
    }).toList();

    final List<Plant> plants = snapshots[1].docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String name = data['name'];
      final String category = data['category'];
      final String kind = data['kind'];
      final String imgURL = data['imgURL'];
      final String id = document.id;
      final String memo = data['memo'] ?? '';
      final Timestamp registrationDate = data['registrationDate'];
      final Timestamp lastUpdatedDate = data['lastUpdatedDate'];
      return Plant(name, category, kind, imgURL, memo, id, registrationDate, lastUpdatedDate);
    }).toList();

    final List<WaterChange> waterChanges = snapshots[2].docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String amount = data['amount'];
      final String memo = data['memo'] ?? '';
      final String id = document.id;
      final Timestamp registrationDate = data['registrationDate'];
      final Timestamp lastUpdatedDate = data['lastUpdatedDate'];
      return WaterChange(amount, memo, id, registrationDate, lastUpdatedDate);
    }).toList();

    final List<Feed> feeds = snapshots[3].docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String amount = data['amount'];
      final String memo = data['memo'] ?? '';
      final String id = document.id;
      final Timestamp registrationDate = data['registrationDate'];
      final Timestamp lastUpdatedDate = data['lastUpdatedDate'];
      return Feed(amount, memo, id, registrationDate, lastUpdatedDate);
    }).toList();

    final List<Temperature> temperatures = snapshots[4].docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final double temperature = data['temperature'];
      final String memo = data['memo'] ?? '';
      final String id = document.id;
      final Timestamp registrationDate = data['registrationDate'];
      final Timestamp lastUpdatedDate = data['lastUpdatedDate'];
      return Temperature(temperature, memo, id, registrationDate, lastUpdatedDate);
    }).toList();

    final List<Ph> ph = snapshots[5].docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final double ph = data['ph'];
      final String memo = data['memo'] ?? '';
      final String id = document.id;
      final Timestamp registrationDate = data['registrationDate'];
      final Timestamp lastUpdatedDate = data['lastUpdatedDate'];
      return Ph(ph, memo, id, registrationDate, lastUpdatedDate);
    }).toList();

    final List<Diary> diaries = snapshots[6].docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String memo = data['memo'] ?? '';
      final String imgURL = data['imgURL'];
      final String id = document.id;
      final Timestamp registrationDate = data['registrationDate'];
      final Timestamp lastUpdatedDate = data['lastUpdatedDate'];
      return Diary(memo, imgURL, id, registrationDate, lastUpdatedDate);
    }).toList();

    creatures.sort((a, b) => b.registrationDate.compareTo(a.registrationDate));
    plants.sort((a, b) => b.registrationDate.compareTo(a.registrationDate));
    waterChanges.sort((a, b) => b.registrationDate.compareTo(a.registrationDate));
    feeds.sort((a, b) => b.registrationDate.compareTo(a.registrationDate));
    temperatures.sort((a, b) => b.registrationDate.compareTo(a.registrationDate));
    ph.sort((a, b) => b.registrationDate.compareTo(a.registrationDate));
    diaries.sort((a, b) => b.registrationDate.compareTo(a.registrationDate));
    this.creatures = creatures;
    this.plants = plants;
    this.waterChanges = waterChanges;
    this.feeds = feeds;
    this.temperatures = temperatures;
    this.ph = ph;
    this.diaries = diaries;

    notifyListeners();
  }

}