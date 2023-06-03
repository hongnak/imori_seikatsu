import 'package:cloud_firestore/cloud_firestore.dart';

class Diary {
  Diary(this.amount, this.imgURL, this.id, this.registrationDate, this.lastUpdatedDate);
  String amount;
  String imgURL;
  String id;
  Timestamp registrationDate;
  Timestamp lastUpdatedDate;
}