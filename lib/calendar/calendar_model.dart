import 'package:flutter/cupertino.dart';
import '../domain/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CalendarModel extends ChangeNotifier {
  List<Event>? events;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  String? userID;

  void setDate(DateTime focusedDay, DateTime selectedDay) {
    this.focusedDay = focusedDay;
    this.selectedDay = selectedDay;
    notifyListeners();
  }

  Future fetchEvent() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final user = FirebaseAuth.instance.currentUser;
      userID = user?.uid;
    }

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('calendar').doc(userID).collection('event').get();
    final List<Event> events;
    events = snapshot.docs.map((document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final List<dynamic> tankIDList = data['tankIDList'] ?? [];
      final List<dynamic> tankNameList = data['tankNameList'] ?? [];
      final List<dynamic> eventList = data['eventList'] ?? [];
      final List<dynamic> docIDList = data['docIDList'] ?? [];
      final String userID = data['userID'] ?? '';
      final Timestamp registrationDate = data['registrationDate'] ?? '';
      return Event(tankIDList, tankNameList, eventList, docIDList, userID, registrationDate);
    }).toList();
    this.events = events;
    notifyListeners();
  }
}