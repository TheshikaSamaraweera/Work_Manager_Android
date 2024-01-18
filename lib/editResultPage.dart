import 'package:flutter/material.dart';
import 'package:workapp/addResultPage.dart';


class EditResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Results'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddResultPage()),
            );
          },
          child: Text('Add Result'),
        ),
      ),
    );
  }
}
