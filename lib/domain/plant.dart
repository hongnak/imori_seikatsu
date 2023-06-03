import 'package:cloud_firestore/cloud_firestore.dart';

class Plant {
  Plant(this.name, this.category, this.kind, this.imgURL, this.memo, this.id, this.registrationDate, this.lastUpdatedDate);
  String name;
  String category;
  String kind;
  String imgURL;
  String memo;
  String id;
  Timestamp registrationDate;
  Timestamp lastUpdatedDate;
}