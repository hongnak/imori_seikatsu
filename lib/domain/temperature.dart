import 'package:cloud_firestore/cloud_firestore.dart';

class Temperature {
  Temperature(this.amount, this.memo, this.id, this.registrationDate, this.lastUpdatedDate);
  double amount;
  String memo;
  String id;
  Timestamp registrationDate;
  Timestamp lastUpdatedDate;
  String collectionName = 'temperature';
}