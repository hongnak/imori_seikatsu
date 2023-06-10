import 'package:cloud_firestore/cloud_firestore.dart';

class Feed {
  Feed(this.amount, this.memo, this.id, this.registrationDate, this.lastUpdatedDate);
  String amount;
  String memo;
  String id;
  Timestamp registrationDate;
  Timestamp lastUpdatedDate;
  String collectionName = 'feed';
}