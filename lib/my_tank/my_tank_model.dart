import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imori_seikatsu/domain/imorium.dart';

class MyTankModel extends ChangeNotifier {
  List<Imorium>? imoriums;
  String? userID;
  var defaultDate = Timestamp(0, 1);

  void fetchImoriumList() async {

    if (FirebaseAuth.instance.currentUser != null) {
      final user = FirebaseAuth.instance.currentUser;
      userID = user?.uid;
    }

    if (userID != null) {
      QuerySnapshot snapshot;
      snapshot = await FirebaseFirestore.instance.collection('imorium').where('userID', whereIn: [userID]).get(const GetOptions(source: Source.cache));
      if (snapshot.docs.isEmpty) {
        snapshot = await FirebaseFirestore.instance.collection('imorium').where('userID', whereIn: [userID]).get(const GetOptions(source: Source.server));
      }
      final List<Imorium> imoriums;
      imoriums = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String name = data['name'];
        final String size = data['size'];
        final String memo = data['memo'] ?? '';
        final String imgURL = data['imgURL'];
        final String id = document.id;
        final Timestamp registrationDate = data['registrationDate'];
        final Timestamp lastUpdatedDate = data['lastUpdatedDate'];
        final Timestamp lastWaterChangeDate = data['lastWaterChangeDate'] ?? defaultDate;
        final Timestamp lastFeedDate = data['lastFeedDate'] ?? defaultDate;
        final int waterChangeReminder = data['waterChangeReminder'] ?? 0;
        final int feedReminder = data['feedReminder'] ?? 0;
        final int cleanReminder = data['cleanReminder'] ?? 0;
        final int addWaterReminder = data['addWaterReminder'] ?? 0;
        final int sprayReminder = data['sprayReminder'] ?? 0;
        final int filterExchangeReminder = data['filterExchangeReminder'] ?? 0;
        final Timestamp lastCleanDate = data['lastCleanDate'] ?? defaultDate;
        final Timestamp lastAddWaterDate = data['lastAddWaterDate'] ?? defaultDate;
        final Timestamp lastSprayDate = data['lastSprayDate'] ?? defaultDate;
        final Timestamp lastFilterExchangeDate = data['lastFilterExchangeDate'] ?? defaultDate;
        return Imorium(name, size, memo, imgURL, id, registrationDate,
            lastUpdatedDate, lastWaterChangeDate, lastFeedDate,
            waterChangeReminder, feedReminder, cleanReminder,
            addWaterReminder, sprayReminder, filterExchangeReminder, lastCleanDate, lastAddWaterDate, lastSprayDate, lastFilterExchangeDate);
      }).toList();

      // switch (sortKind) {
      //   case SortKind.abcUp:
      //     tanks.sort((a, b) => b.name.compareTo(a.name));
      //     break;
      //   case SortKind.abcDown:
      //     tanks.sort((a, b) => a.name.compareTo(b.name));
      //     break;
      //   case SortKind.regUp:
      //     tanks.sort((a, b) => b.registrationDate.compareTo(a.registrationDate));
      //     break;
      //   case SortKind.regDown:
      //     tanks.sort((a, b) => a.registrationDate.compareTo(b.registrationDate));
      //     break;
      //   case SortKind.lastUp:
      //     tanks.sort((a, b) => b.lastUpdatedDate.compareTo(a.lastUpdatedDate));
      //     break;
      //   case SortKind.lastDown:
      //     tanks.sort((a, b) => a.lastUpdatedDate.compareTo(b.lastUpdatedDate));
      //     break;
      //   default:
      //     tanks.sort((a, b) => b.registrationDate.compareTo(a.registrationDate));
      //     break;
      // }
      this.imoriums = imoriums;
      notifyListeners();
    }
  }
}