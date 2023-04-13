import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthDateSelector extends StatefulWidget {
  @override
  _BirthDateSelectorState createState() => _BirthDateSelectorState();
}

class _BirthDateSelectorState extends State<BirthDateSelector> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            _selectedDate == null
                ? 'Select your birth date'
                : 'Birth date: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
          ),
        ),
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
      ],
    );
  }
}
