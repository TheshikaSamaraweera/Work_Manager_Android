import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum AssignmentType {
  quiz,
  inClass,
  takeHome,
}

String assignmentTypeToString(AssignmentType type) {
  switch (type) {
    case AssignmentType.quiz:
      return 'Quiz';
    case AssignmentType.inClass:
      return 'In-Class';
    case AssignmentType.takeHome:
      return 'Take Home';
  }
}

class AddAssignmentPage extends StatefulWidget {
  @override
  _AddAssignmentPageState createState() => _AddAssignmentPageState();
}

class _AddAssignmentPageState extends State<AddAssignmentPage> {
  TextEditingController _conductingDateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _moduleNameController = TextEditingController();
  TextEditingController _moduleCodeController = TextEditingController();
  AssignmentType _selectedType = AssignmentType.quiz; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Assignment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField(
              value: _selectedType,
              onChanged: (AssignmentType? value) {
                if (value != null) {
                  setState(() {
                    _selectedType = value;
                  });
                }
              },
              items: AssignmentType.values.map((AssignmentType type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(assignmentTypeToString(type)),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Assignment Type'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _conductingDateController,
              decoration:
                  InputDecoration(labelText: 'Conducting Date (YYYY-MM-DD)'),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time (HH:mm)'),
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
            ElevatedButton(
              onPressed: () async {
                String conductingDate = _conductingDateController.text;
                String time = _timeController.text;
                String moduleName = _moduleNameController.text;
                String moduleCode = _moduleCodeController.text;

                await FirebaseFirestore.instance.collection('assignments').add({
                  'assignmentType': _selectedType.index,
                  'conductingDate': conductingDate,
                  'time': time,
                  'moduleName': moduleName,
                  'moduleCode': moduleCode,
                });

                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, 
              ),
              child: Text(
                'Add Assignment',
                style: TextStyle(color: Colors.white), 
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
      _conductingDateController.text =
          picked.toLocal().toString().split(' ')[0];
    }
  }
}
