// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNotificationPage extends StatefulWidget {
  @override
  _AddNotificationPageState createState() => _AddNotificationPageState();
}

class _AddNotificationPageState extends State<AddNotificationPage> {
  TextEditingController _notificationController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _notificationController,
                      decoration: InputDecoration(labelText: 'Notification'),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _dateController,
                      decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                      readOnly: true,
                      onTap: () => _selectDate(context),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _timeController,
                      decoration: InputDecoration(labelText: 'Time (HH:mm)'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.infinity * 0.2, // Take the full width
              child: ElevatedButton(
                onPressed: () async {
                  String notification = _notificationController.text;
                  String date = _dateController.text;
                  String time = _timeController.text;

                  await FirebaseFirestore.instance.collection('notifications').add({
                    'notificationName': notification,
                    'notificationDate': date,
                    'notificationTime': time,
                  });

                  // Navigate back to the previous screen
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16.0), // Adjust the vertical padding
                ),
                child: Text(
                  'Add Notification',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      _dateController.text = picked.toLocal().toString().split(' ')[0];
    }
  }
}
