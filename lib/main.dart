import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workapp/addResultPage.dart';
import 'package:workapp/home_page.dart';
import 'package:workapp/login.dart';
import 'package:workapp/notificaton.dart';

import 'package:workapp/student.dart';
import 'package:workapp/teacher.dart';
import 'package:workapp/Admin/todo_list.dart';
import 'package:workapp/widget/bottom_bar.dart';

import 'home.dart';
import 'register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      home: HomePage(),
    );
  }
}

class _LabListPageState {
}
