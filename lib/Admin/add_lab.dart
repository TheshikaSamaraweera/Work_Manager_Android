import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AddLabPage extends StatefulWidget {
  @override
  _AddLabPageState createState() => _AddLabPageState();
}

class _AddLabPageState extends State<AddLabPage> {
  TextEditingController _labNumberController = TextEditingController();
  TextEditingController _moduleNameController = TextEditingController();
  TextEditingController _moduleCodeController = TextEditingController();
  TextEditingController _conductingDateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Lab'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 3.0,
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _labNumberController,
                    decoration: InputDecoration(labelText: 'Lab Number'),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _moduleNameController,
                    decoration: InputDecoration(labelText: 'Module Name'),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _moduleCodeController,
                    decoration: InputDecoration(labelText: 'Module Code'),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _conductingDateController,
                    decoration: InputDecoration(labelText: 'Conducting Date (YYYY-MM-DD)'),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _timeController,
                    decoration: InputDecoration(labelText: 'Time (HH:mm)'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
  onPressed: () async {
    String labNumber = _labNumberController.text;
    String moduleName = _moduleNameController.text;
    String moduleCode = _moduleCodeController.text;
    String conductingDate = _conductingDateController.text;
    String time = _timeController.text;

    await FirebaseFirestore.instance.collection('labs').add({
      'labNumber': labNumber,
      'moduleName': moduleName,
      'moduleCode': moduleCode,
      'conductingDate': conductingDate,
      'time': time,
      'completed': false, 
    });

    Navigator.of(context).pop();
  },
  style: ElevatedButton.styleFrom(
    primary: Colors.blue,
    onPrimary: Colors.white, 
  ),
  child: Text('Add Lab'),
),

        ],
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
      _conductingDateController.text = picked.toLocal().toString().split(' ')[0];
    }
  }
}
