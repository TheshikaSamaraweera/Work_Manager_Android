// admin_notification_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workapp/addNotification.dart';

import 'package:workapp/home_page.dart';
import 'package:workapp/teacher.dart';

class AdminNotificationPage extends StatefulWidget {
  @override
  _AdminNotificationPageState createState() => _AdminNotificationPageState();
}

class _AdminNotificationPageState extends State<AdminNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Listaaaaa'),
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
              Map<String, String> newNotification = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNotificationPage()),
              );

              if (newNotification != null) {
                await FirebaseFirestore.instance.collection('notifications').add(newNotification);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance.collection('notifications').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  var notifications = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      var notification = notifications[index].data();
                      return _buildNotificationTile(
                        notification['notificationName'] ?? 'No Notification Name',
                        notification['notificationDate'] ?? 'No Date',
                        notification['notificationTime'] ?? 'No Time',
                        notificationId: notifications[index].id,
                        isCompleted: notification['notificationCompleted'] ?? false,
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20.0),
          
        ],
      ),
    );
  }

  Widget _buildNotificationTile(String notificationName, String date, String time,
      {required String notificationId, required bool isCompleted}) {
    return Card(
      color: isCompleted ? Colors.greenAccent : Colors.white,
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          notificationName,
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
                  _markNotificationCompleted(notificationId);
                  _showCongratulatoryMessage();
                },
              ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteNotification(notificationId);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _markNotificationCompleted(String notificationId) async {
    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(notificationId)
        .update({'notificationCompleted': true});
  }

  void _deleteNotification(String notificationId) async {
    await FirebaseFirestore.instance.collection('notifications').doc(notificationId).delete();
  }

  void _showCongratulatoryMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have completed your notification.'),
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

 

  Future<List<int>> _getNotificationCounts() async {
    QuerySnapshot<Map<String, dynamic>> totalQuerySnapshot =
        await FirebaseFirestore.instance.collection('notifications').get();

    QuerySnapshot<Map<String, dynamic>> completedQuerySnapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .where('notificationCompleted', isEqualTo: true)
        .get();

    return [totalQuerySnapshot.size, completedQuerySnapshot.size];
  }
}
