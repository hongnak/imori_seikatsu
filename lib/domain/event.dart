import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  Event(this.tankIDList, this.tankNameList, this.eventList, this.docIDList, this.userID, this.registrationDate);
  List<dynamic> tankIDList;
  List<dynamic> tankNameList;
  List<dynamic> eventList;
  List<dynamic> docIDList;
  String userID;
  Timestamp registrationDate;
}