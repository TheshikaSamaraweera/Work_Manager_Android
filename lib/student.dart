// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:workapp/Admin/todo_list.dart';
import 'package:workapp/login.dart';
import 'package:workapp/register.dart';
import 'package:workapp/style/app_style.dart';

import 'package:workapp/widget/bottom_bar.dart';
import '../data/data.dart';
import '../size_config.dart';

import 'login.dart';

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 5,
            ),
            child: Column(
              children: const [
                UserInfo(),

                GetBestMedicalService(),
                // User Info Area .

                Services(),

                // GetBestMedicalService
              ],
            ),
          ),
          // Upcoming Appointments
          const UpcomingAppointments(),
        ],
      ),
      //bottomNavigationBar: Navbar(),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: servicesList
              .map(
                (e) => CupertinoButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal! * 17,
                    height: SizeConfig.blockSizeHorizontal! * 17,
                    decoration: BoxDecoration(
                      color: e.color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: SvgPicture.asset(e.image),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.0, // Set the desired width
      child: ListTile(
        //tileColor: Colors.green, // Set the background color to green
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
        trailing: ElevatedButton(
          onPressed: () {
            logout(context);
          },
          child: Text('Logout'),
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
            decoration: BoxDecoration(
              color: Color.fromRGBO(34, 33, 91, 1),
              borderRadius: BorderRadius.all(Radius.circular(28.0)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal! * 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Get the Best\nMedical Service",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                color:
                                    Colors.white, // Text color changed to white
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical! * 1),
                        Text(
                          "Lorem Ipsum is simply dummy\ntext of the printing",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                color:
                                    Colors.white, // Text color changed to white
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                                fontSize: 11.0,
                                height: 1.5,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 2),
                    child: Image.asset(AppStyle.image1),
                  ),
                )
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TodoListPage(),
                      ),
                    );
                    // Add functionality for the Assignment button
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.zero),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    elevation: MaterialStateProperty.all<double>(0),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.blue, Colors.green],
                      ),
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * 0.4,
                        minHeight: MediaQuery.of(context).size.height * 0.2,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ASSIGNMENTS',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '12/4',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
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
                    primary: Color.fromARGB(255, 131, 146, 248),
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
                            'LABORATORY',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '4/2',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: -10,
                        right: -80,
                        left: 0,
                        child: Image.asset(
                          'assets/images/image1.png',
                          height: 50,
                          width: 50,
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
