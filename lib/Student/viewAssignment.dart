import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workapp/home_page.dart';


class AssignmentListPage extends StatefulWidget {
  @override
  _AssignmentListPageState createState() => _AssignmentListPageState();
}

class _AssignmentListPageState extends State<AssignmentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment List'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.add),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => AddAssignmentPage()),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('assignments')
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var assignments = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: assignments.length,
                  itemBuilder: (context, index) {
                    var assignment = assignments[index].data();
                    return _buildAssignmentTile(
                      AssignmentType.values[assignment['assignmentType'] ??
                          AssignmentType.quiz.index],
                      assignment['conductingDate'] ?? 'No Date',
                      assignment['time'] ?? 'No Time',
                      assignment['moduleName'] ?? 'No Module Name',
                      assignment['moduleCode'] ?? 'No Module Code',
                      assignmentId: assignments[index].id,
                      isCompleted: assignment['completed'] ?? false,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => AddAssignmentPage()),
      //     );
      //   },
      //   backgroundColor: Colors.blue, // Set the button color to blue
      //   child: Icon(Icons.add, color: Colors.white), // Set the icon color to white
      // ),
    );
  }

  Widget _buildAssignmentTile(
    AssignmentType assignmentType,
    String conductingDate,
    String time,
    String moduleName,
    String moduleCode, {
    required String assignmentId,
    required bool isCompleted,
  }) {
    return Card(
      color: isCompleted ? Colors.greenAccent : Colors.white,
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          '$moduleName - $moduleCode',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Assignment Type: ${assignmentTypeToString(assignmentType)}'),
            Text('Date: $conductingDate'),
            Text('Time: $time'),
          ],
        ),
        trailing: isCompleted
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.undo),
                    onPressed: () {
                      _markAssignmentNotCompleted(assignmentId);
                      _showUndoMessage();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteAssignment(assignmentId);
                    },
                  ),
                ],
              )
            : IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  _markAssignmentCompleted(assignmentId);
                  _showCongratulatoryMessage();
                },
              ),
      ),
    );
  }

  void _markAssignmentCompleted(String assignmentId) async {
    await FirebaseFirestore.instance
        .collection('assignments')
        .doc(assignmentId)
        .update({'completed': true});
  }

  void _markAssignmentNotCompleted(String assignmentId) async {
    await FirebaseFirestore.instance
        .collection('assignments')
        .doc(assignmentId)
        .update({'completed': false});
  }

  void _deleteAssignment(String assignmentId) async {
    await FirebaseFirestore.instance
        .collection('assignments')
        .doc(assignmentId)
        .delete();
  }

  void _showUndoMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Assignment Marked as Not Completed'),
          content: Text('You have marked the assignment as not completed.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showCongratulatoryMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have completed your assignment.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

enum AssignmentType { quiz, homework, project }

String assignmentTypeToString(AssignmentType assignmentType) {
  switch (assignmentType) {
    case AssignmentType.quiz:
      return 'Quiz';
    case AssignmentType.homework:
      return 'Homework';
    case AssignmentType.project:
      return 'Project';
    default:
      return '';
  }
}
