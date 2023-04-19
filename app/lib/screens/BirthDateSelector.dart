import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthDateSelector extends StatefulWidget {

  final String uid;

  const BirthDateSelector({Key? key, required this.uid}) : super(key: key);


  @override
  _BirthDateSelectorState createState() => _BirthDateSelectorState();
}

class _BirthDateSelectorState extends State<BirthDateSelector> {
  DateTime? _selectedDate;
  DateTime _dateTime  = DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');


  Future<DateTime> _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        _dateTime = selectedDate;
      });
    }

    updateInfo(_dateTime, widget.uid.toString());
    return selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(

    decoration: InputDecoration(hintText: formatter.format(DateTime.now()) ,
    icon: Icon(Icons.calendar_today)),
    readOnly: true,
    onTap: () => _selectDate(),
    ))
      ],
    );
  }
}

updateInfo(DateTime date, String uid){
  FirebaseFirestore.instance.collection('user').doc(uid).update({
    'Birth Date': date,
  });
  return 0;
}

