import 'package:cloud_firestore/cloud_firestore.dart';

class Creature {
  Creature(this.name, this.category, this.kind, this.imgURL, this.memo, this.id, this.registrationDate, this.lastUpdatedDate, this.amount);
  String name;
  String category;
  String kind;
  String imgURL;
  String memo;
  String id;
  Timestamp registrationDate;
  Timestamp lastUpdatedDate;
  dynamic amount;
  String collectionName = 'creature';
}