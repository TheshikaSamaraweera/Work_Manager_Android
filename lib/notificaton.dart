// notification_list_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workapp/addNotification.dart';

import 'package:workapp/home_page.dart';

class NotificationListPage extends StatefulWidget {
  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification List'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
        actions: [
          // Your action buttons here
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: FutureBuilder<List<int>>(
              
              future: _getNotificationCounts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  int totalNotifications = snapshot.data![0];
                  int completedNotifications = snapshot.data![1];
                  return Text(
                    'You have notifications: $completedNotifications/$totalNotifications',
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
          ),
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
