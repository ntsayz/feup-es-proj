import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trabalho/screens/main.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
String groupID = '';




Future<void> createGroup(String name, String ID) async{
  DocumentReference docref = await _firestore.collection('groups').add({
    'Group Name': name,
    'users': FieldValue.arrayUnion([ID]),
  });


  await _firestore.collection('user').doc(ID).update({
    'groups': FieldValue.arrayUnion([docref.id]),
  });

}

Future<void> addUIDToGroup (String ID, String groupID) async{
  await _firestore.collection('groups').doc(groupID).update({'users': FieldValue.arrayUnion([ID])});
  await _firestore.collection('user').doc(ID).update({'groups': FieldValue.arrayUnion([groupID])});
}

Future<void> addUserToGroup (User? user, String groupID) async{
  await _firestore.collection('groups').doc(groupID).update({'users': FieldValue.arrayUnion([user?.uid])});
}

Future<List<String?>> getAllGroups() async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot =
  await FirebaseFirestore.instance.collection('groups').get();
  final List<String?> fieldValues = querySnapshot.docs
      .map((DocumentSnapshot<Map<String, dynamic>> document) => document.data()!['Group Name'] as String?)
      .where((String? fieldValue) => fieldValue != null)
      .toList();
  return fieldValues;
}

Future<List<String>> getAllGroupsID() async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot =
  await FirebaseFirestore.instance.collection('groups').get();
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
  final List<String> documentIds = documents.map((doc) => doc.id).toList();
  return documentIds;
}

Future<String?> getGroupID(String fieldValue) async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
      .collection('groups')
      .where('Group Name', isEqualTo: fieldValue)
      .limit(1)
      .get();
  final List<DocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
  if (documents.isNotEmpty) {
  final String documentId = documents.first.id;
  return documentId;
  } else {
  return null;
  }
}

Future<String?> getGroupName (String ID) async{
  // Get a reference to the Firestore collection
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('groups');

  // Get the document with the given ID
  DocumentSnapshot documentSnapshot = await collectionReference.doc(ID).get();

  // If the document exists, return the value of the "myValue" field
  if (documentSnapshot.exists) {
    return documentSnapshot.get('Group Name');
  } else {
    throw Exception('Document not found');
  }
}

Future<List<String>> getUIDGroups(String UID) async {
  final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance.collection('user').doc(UID).get();
  final List<dynamic> arrayField = documentSnapshot.data()!['groups'];
  final List<String> stringArray = List<String>.from(arrayField.map((element) => element.toString()));
  return stringArray;
}

Future<List<String>> getUsersofGroup (String ID) async{
  final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance.collection('groups').doc(ID).get();
  final List<dynamic> arrayField = documentSnapshot.data()!['users'];
  final List<String> stringArray = List<String>.from(arrayField.map((element) => element.toString()));
  return stringArray;
}

Future<String?> getUserName (String ID) async{
  // Get a reference to the Firestore collection
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('user');

  // Get the document with the given ID
  DocumentSnapshot documentSnapshot = await collectionReference.doc(ID).get();

  // If the document exists, return the value of the "myValue" field
  if (documentSnapshot.exists) {
    return documentSnapshot.get('Username');
  } else {
    throw Exception('Document not found');
  }
}