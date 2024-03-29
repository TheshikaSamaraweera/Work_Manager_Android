import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddResultPage extends StatefulWidget {
  @override
  _AddResultPageState createState() => _AddResultPageState();
}

class _AddResultPageState extends State<AddResultPage> {
  String _selectedModule = 'EE5302'; 
  String _selectedResult = 'A+'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField(
              value: _selectedModule,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _selectedModule = value;
                  });
                }
              },
              items: ['EE5302', 'EE5303', 'EE5304', 'EE5305', 'EE5306']
                  .map((String module) {
                return DropdownMenuItem(
                  value: module,
                  child: Text(module),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Module'),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField(
              value: _selectedResult,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _selectedResult = value;
                  });
                }
              },
              items: ['A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'E']
                  .map((String result) {
                return DropdownMenuItem(
                  value: result,
                  child: Text(result),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Result'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                
                _saveResultToDatabase();

                Navigator.of(context).pop(); 
              },
              child: Text('Save Result'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveResultToDatabase() async {
    try {
      
      await FirebaseFirestore.instance.collection('results').add({
        'module': _selectedModule,
        'result': _selectedResult,
      });

      // Show a success message or handle success accordingly
      print('Result saved successfully!');
    } catch (error) {
      // Handle errors, show an error message, etc.
      print('Error saving result: $error');
    }
  }
}
