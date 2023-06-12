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
    if (userID != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('event').where('userID', whereIn: [userID]).get();
      final List<Event> events;
      events = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String tankID = data['tankID'];
        final String tankName = data['tankName'] ?? 'unknown';
        final String docID = data['docID'];
        final String userID = data['userID'];
        final List<dynamic> event = data['event'];
        final Timestamp registrationDate = data['registrationDate'];
        return Event(tankID, tankName, docID, userID, event, registrationDate);
      }).toList();

      this.events = events;
      notifyListeners();
    }
  }
}