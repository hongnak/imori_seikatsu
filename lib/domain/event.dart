import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  Event(this.tankID, this.tankName, this.docID, this.userID, this.event, this.registrationDate);
  List<String> tankID;
  List<String> tankName;
  List<String> docID;
  String userID;
  List<dynamic> event;
  Timestamp registrationDate;
}