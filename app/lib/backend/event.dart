import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trabalho/main.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
String groupID = '';


Future<void> createEvent(String ID, String name, int capacity, String Sport, DateTime day) async{
  DocumentReference docref = await _firestore.collection('Event').add({
    'capacity' : capacity,
    'Name': name,
    'users': FieldValue.arrayUnion([ID]),
    'sport' : Sport,
    'day' : day,
  });
}



DateTime joinDateTimeWithTime(DateTime date, TextEditingController timeController) {
  final DateFormat timeFormat = DateFormat.jm();
  final DateTime parsedTime = timeFormat.parse(timeController.text);
  final DateTime combinedDateTime = DateTime(
    date.year,
    date.month,
    date.day,
    parsedTime.hour,
    parsedTime.minute,
    date.second,
    date.millisecond,
    date.microsecond,
  );
  return combinedDateTime.toLocal(); // Convert to local timezone
}

