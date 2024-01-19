import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:workapp/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class Task {
  final String title;
  final String time;

  Task({required this.title, required this.time});
}

class ViewTimetablePage extends StatefulWidget {
  @override
  _ViewTimetablePageState createState() => _ViewTimetablePageState();
}

class _ViewTimetablePageState extends State<ViewTimetablePage> {
  late DateTime selectedDay;
  late List<Task> events;

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
    events = [];
    fetchTasks(selectedDay);
  }

  Future<void> fetchTasks(DateTime date) async {
    CollectionReference timetable =
        FirebaseFirestore.instance.collection('timetable');

    QuerySnapshot<Object?> querySnapshot =
        await timetable.where('date', isEqualTo: date).get();

    List<Task> tasks = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Task(title: data['title'], time: data['time']);
    }).toList();

    setState(() {
      events = tasks;
    });
  }

  void _navigateToDayTimeTablePage(DateTime day) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DayTimeTablePage(selectedDay: day),
      ),
    ).then((_) {
      // Fetch tasks again after returning from DayTimeTablePage
      fetchTasks(selectedDay);
    });
  }

  Future<void> saveTask(DateTime date, Task task) async {
    CollectionReference timetable =
        FirebaseFirestore.instance.collection('timetable');
    await timetable.add({
      'date': date,
      'title': task.title,
      'time': task.time,
    });

    // Fetch tasks again to update the list
    fetchTasks(date);
  }

  Future<void> deleteTask(DateTime date, Task task) async {
    CollectionReference timetable =
        FirebaseFirestore.instance.collection('timetable');

    QuerySnapshot<Object?> querySnapshot = await timetable
        .where('date', isEqualTo: date)
        .where('title', isEqualTo: task.title)
        .where('time', isEqualTo: task.time)
        .get();

    querySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });

    fetchTasks(date); // Fetch tasks again to update the list
  }

  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String time = '';

        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Time'),
                onChanged: (value) {
                  time = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (title.isNotEmpty && time.isNotEmpty) {
                  Task newTask = Task(title: title, time: time);
                  await saveTask(selectedDay, newTask);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDayButton(DateTime day) {
    return ElevatedButton(
      onPressed: () {
        _navigateToDayTimeTablePage(day);
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Set button color to blue
      ),
      child: Text(
        DateFormat('EEE, MMM d').format(day),
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Weekly Time Table'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          // Date Buttons
          Container(
            height: 40, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                DateTime day = selectedDay.add(Duration(days: index));
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildDayButton(day),
                );
              },
            ),
          ),
          // Today Works
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Today Works',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // Events
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: events.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(events[index].title),
                  subtitle: Text(events[index].time),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteTask(selectedDay, events[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }
}

class DayTimeTablePage extends StatefulWidget {
  final DateTime selectedDay; // Add the missing semicolon here

  DayTimeTablePage({Key? key, required this.selectedDay}) : super(key: key);

  @override
  _DayTimeTablePageState createState() => _DayTimeTablePageState();
}

class _DayTimeTablePageState extends State<DayTimeTablePage> {
  late List<Task> selectedTasks;

  @override
  void initState() {
    super.initState();
    selectedTasks = [];
    fetchTasks(widget.selectedDay);
  }

  Future<void> fetchTasks(DateTime date) async {
    CollectionReference timetable =
        FirebaseFirestore.instance.collection('timetable');
    QuerySnapshot<Object?> querySnapshot =
        await timetable.where('date', isEqualTo: date).get();

    List<Task> tasks = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Task(title: data['title'], time: data['time']);
    }).toList();

    setState(() {
      selectedTasks = tasks;
    });
  }

  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String time = '';

        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Time'),
                onChanged: (value) {
                  time = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (title.isNotEmpty && time.isNotEmpty) {
                  Task newTask = Task(title: title, time: time);
                  await saveTask(widget.selectedDay, newTask);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveTask(DateTime date, Task task) async {
    CollectionReference timetable =
        FirebaseFirestore.instance.collection('timetable');
    await timetable.add({
      'date': date,
      'title': task.title,
      'time': task.time,
    });
    fetchTasks(date); // Fetch tasks again to update the list
  }

  Future<void> deleteTask(DateTime date, Task task) async {
    CollectionReference timetable =
        FirebaseFirestore.instance.collection('timetable');

    QuerySnapshot<Object?> querySnapshot = await timetable
        .where('date', isEqualTo: date)
        .where('title', isEqualTo: task.title)
        .where('time', isEqualTo: task.time)
        .get();

    querySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });

    fetchTasks(date); // Fetch tasks again to update the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Time Table - ${DateFormat('MMMM d, y').format(widget.selectedDay)}',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedTasks.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(selectedTasks[index].title),
                  onDismissed: (direction) async {
                    await deleteTask(widget.selectedDay, selectedTasks[index]);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: ListTile(
                    title: Text(selectedTasks[index].title),
                    subtitle: Text(selectedTasks[index].time),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ViewTimetablePage(),
    );
  }
}
