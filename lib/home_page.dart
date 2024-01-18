// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:workapp/ResultGraphPage.dart';
import 'package:workapp/assignment.dart';
import 'package:workapp/lab_list.dart';
import 'package:workapp/login.dart';
import 'package:workapp/register.dart';
import 'package:workapp/style/app_style.dart';
import 'package:workapp/teacher.dart';
import 'package:workapp/todo_list.dart';
import 'package:workapp/widget/bottom_bar.dart';
import '../data/data.dart';
import '../size_config.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(
          255, 255, 255, 1), // Set the background color to yellow
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 7,
            ),
            child: Column(
              children: const [
                UserInfo(),
                GetBestMedicalService(),
                Services(),
              ],
            ),
          ),
          const UpcomingAppointments(),
        ],
      ),
      // bottomNavigationBar: Navbar(),
    );
  }
}

class Services extends StatelessWidget {
  const Services({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Services",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w700, letterSpacing: 1),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Button 1
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodoListPage(),
                  ),
                );
                // Add functionality for the Laboratory button
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                minimumSize: Size(30, 60), // Adjust size as needed
                padding: EdgeInsets.all(12), // Adjust padding to decrease space
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                //side: BorderSide(color: Colors.blue),
                elevation: 5,
                shadowColor: Colors.blue,
              ),
              child: Image.asset(
                'assets/images/todo.png',
                height: 40, // Adjust the height of your image
                width: 40, // Adjust the width of your image
              ),
            ),

            // Button 2
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultGraphPage(),
                  ),
                );
                // Add your action for button 4
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                minimumSize: Size(30, 60), // Adjust size as needed
                padding: EdgeInsets.all(12), // Adjust padding to decrease space
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                //side: BorderSide(color: Colors.blue),
                elevation: 5,
                shadowColor: Colors.blue,
              ),
              child: Image.asset(
                'assets/images/result.png',
                height: 40, // Adjust the height of your image
                width: 40, // Adjust the width of your image
              ),
            ),

            // Button 3
            ElevatedButton(
              onPressed: () {
                // Add your action for button 4
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                minimumSize: Size(30, 60), // Adjust size as needed
                padding: EdgeInsets.all(12), // Adjust padding to decrease space
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                //side: BorderSide(color: Colors.blue),
                elevation: 5,
                shadowColor: Colors.blue,
              ),
              child: Image.asset(
                'assets/images/timetable.png',
                height: 40, // Adjust the height of your image
                width: 40, // Adjust the width of your image
              ),
            ),

            // Button 4
            ElevatedButton(
              onPressed: () {
                // Add your action for button 4
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                minimumSize: Size(30, 60), // Adjust size as needed
                padding: EdgeInsets.all(12), // Adjust padding to decrease space
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                //side: BorderSide(color: Colors.blue),
                elevation: 5,
                shadowColor: Colors.blue,
              ),
              child: Image.asset(
                'assets/images/timetable.png',
                height: 40, // Adjust the height of your image
                width: 40, // Adjust the width of your image
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Color.fromARGB(
          255, 255, 255, 255), // Set the background color to green
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppStyle.profile),
                fit: BoxFit.cover,
                repeat: ImageRepeat.repeat,
              ),
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
            ),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: 18.0,
                  height: 18.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppStyle.primarySwatch,
                    border: Border.all(
                      color: Colors.white,
                      width: 3.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10), // Adjust the space between image and text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("👋 Hello!"),
              Text(
                "Kamal Perera",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
      trailing: Container(
        width: 40.0, // Adjust the width as needed
        height: 40.0, // Adjust the height as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), // Small border radius
        ),
        child: ElevatedButton.icon(
          onPressed: () {
            logout(context);
          },
          icon: Icon(
            Icons.logout,
            size: 20.0,
          ),
          label: Text(''),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Small border radius
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}

class GetBestMedicalService extends StatelessWidget {
  const GetBestMedicalService({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical! * 3.5),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: Color.fromRGBO(34, 33, 91, 1),
              borderRadius: BorderRadius.all(Radius.circular(28.0)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal! * 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Notifications",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Lorem Ipsum is simply dummy\ntext of the printing",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 7,
              vertical: SizeConfig.blockSizeVertical! * 2),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal! * 7,
          ),
          child: Text(
            "Upcoming Appointments",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w700, letterSpacing: 1),
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical! * 2),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LabListPage(),
                      ),
                    );
                    // Add functionality for the Laboratory button
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 5,
                    shadowColor: Colors.blue,
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.4,
                      MediaQuery.of(context).size.height * 0.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'LABORETORIES',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                              height: 70), // Adjust the height of the SizedBox
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: -10, // Adjust the bottom position
                        right: -50, // Adjust the right position
                        left: 0,
                        child: Image.asset(
                          'assets/images/lab.png',
                          height: 110, // Adjust the height of the image
                          width: 110, // Adjust the width of the image
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AssignmentListPage(),
                      ),
                    );
                    // Add functionality for the Laboratory button
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 5,
                    shadowColor: Colors.blue,
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.4,
                      MediaQuery.of(context).size.height * 0.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ASSIGNMENTS',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                              height: 70), // Adjust the height of the SizedBox
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: -10, // Adjust the bottom position
                        right: -50, // Adjust the right position
                        left: 0,
                        child: Image.asset(
                          'assets/images/assignment.png',
                          height: 110, // Adjust the height of the image
                          width: 110, // Adjust the width of the image
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
