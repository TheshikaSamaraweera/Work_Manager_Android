import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:workapp/Student/add_task.dart';
import 'package:workapp/home_page.dart';
import 'package:workapp/teacher.dart';
import 'package:workapp/widget/bottom_bar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Teacher(),
                      ),
                    );
                    
                  },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              Map<String, String> newTask = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTaskPage()),
              );

              if (newTask != null) {
                await FirebaseFirestore.instance.collection('tasks').add(newTask);
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var tasks = snapshot.data!.docs;

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              var task = tasks[index].data();
              return _buildTaskTile(
                task['taskName'] ?? 'No Task Name',
                task['date'] ?? 'No Date',
                task['time'] ?? 'No Time',
                taskId: tasks[index].id,
                isCompleted: task['completed'] ?? false,
              );
            },
          );
        },
      ),
   
    );
  }

  Widget _buildTaskTile(String taskName, String date, String time, {required String taskId, required bool isCompleted}) {
    return Card(
      color: isCompleted ? Colors.greenAccent : Colors.white,
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          taskName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('$date at $time'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isCompleted)
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  _markTaskCompleted(taskId);
                  _showCongratulatoryMessage(); 
                },
              ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteTask(taskId);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _markTaskCompleted(String taskId) async {
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).update({'completed': true});
  }

  void _deleteTask(String taskId) async {
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();
  }

  void _showCongratulatoryMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have completed your task.'),
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
