import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  const AdaptativeDatePicker({this.selectedDate, this.onDateChanged});

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTheme(
            data: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle:
                    TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            child: Container(
              width: 300,
              height: 170,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                minimumDate: DateTime(2019),
                maximumDate: DateTime.now(),
                onDateTimeChanged: onDateChanged,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FloatingActionButton(
              backgroundColor: Colors.pink[600],
              mini: true,
              child: const Icon(
                Icons.date_range,
                size: 25,
                color: Colors.white,
              ),
              onPressed: () => _showDatePicker(context),
            ),
          );
  }
}
