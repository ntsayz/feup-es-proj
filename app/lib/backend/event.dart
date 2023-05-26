import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trabalho/backend/Groups.dart';
import 'package:trabalho/main.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
String groupID = '';


Future<void> createEvent(String ID, String name, int capacity, String Sport, DateTime day, String group) async{
  DocumentReference docref = await _firestore.collection('Event').add({
    'capacity' : capacity,
    'Name': name,
    'users': FieldValue.arrayUnion([ID]),
    'sport' : Sport,
    'day' : day,
    'group' : group,
  });

  await _firestore.collection('groups').doc(group).update({
    'events': FieldValue.arrayUnion([docref.id]),
  });

}


Future<void> addEventToGroup (String event, String groupID) async{
  await _firestore.collection('groups').doc(groupID).update({'events': FieldValue.arrayUnion([event])});
  // await _firestore.collection('user').doc(ID).update({'groups': FieldValue.arrayUnion([groupID])});
}


DateTime joinDateTimeWithTime(DateTime date, TextEditingController timeController) {
  final DateFormat timeFormat = DateFormat.jm();

  try {
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
  } catch (e) {
    print('Error parsing time: $e');
    return DateTime.now(); // Return a default value or handle the error as needed
  }
}


Future<String?> getEventName (String ID) async{
  // Get a reference to the Firestore collection
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('Event');

  // Get the document with the given ID
  DocumentSnapshot documentSnapshot = await collectionReference.doc(ID).get();

  // If the document exists, return the value of the "myValue" field
  if (documentSnapshot.exists) {
    return documentSnapshot.get('Name');
  } else {
    throw Exception('Document not found');
  }
}

Future<Timestamp?> getEventDate (String ID) async{
  // Get a reference to the Firestore collection
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('Event');

  // Get the document with the given ID
  DocumentSnapshot documentSnapshot = await collectionReference.doc(ID).get();

  // If the document exists, return the value of the "myValue" field
  if (documentSnapshot.exists) {
    return documentSnapshot.get('day');
  } else {
    throw Exception('Document not found');
  }
}

Future<int?> getEventCapacity (String ID) async {
  // Get a reference to the Firestore collection
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('Event');

  // Get the document with the given ID
  DocumentSnapshot documentSnapshot = await collectionReference.doc(ID).get();

  // If the document exists, return the value of the "myValue" field
  if (documentSnapshot.exists) {
    return documentSnapshot.get('capacity');
  } else {
    throw Exception('Document not found');
  }
}

Future<String?> getEventSport (String ID)async {
  // Get a reference to the Firestore collection
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('Event');

  // Get the document with the given ID
  DocumentSnapshot documentSnapshot = await collectionReference.doc(ID).get();

  // If the document exists, return the value of the "myValue" field
  if (documentSnapshot.exists) {
    return documentSnapshot.get('sport');
  } else {
    throw Exception('Document not found');
  }
}



Future<void> addElementEvent(String ID, String EventID) async{
  await _firestore.collection('Event').doc(EventID).update({'users': FieldValue.arrayUnion([ID])});
}


Future<void> removeElementEvent(String ID, String EventID) async{
  await _firestore.collection('Event').doc(EventID).update({'users': FieldValue.arrayRemove([ID])});
}


Future <List<String>> EventElements (String EventID) async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance.collection('Event').doc(EventID).get();
    final List<dynamic> arrayField = documentSnapshot.data()!['users'];
    final List<String> stringArray = List<String>.from(arrayField.map((element) => element.toString()));
    return stringArray;
}

