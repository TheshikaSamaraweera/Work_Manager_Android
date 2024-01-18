// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workapp/home_page.dart';
import 'package:workapp/widget/widget_support.dart';
import 'Student.dart';
import 'Teacher.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color.fromARGB(255, 2, 182, 236),
                  Color.fromARGB(255, 26, 115, 231),
                ])),
          ), //uda tabili kotuwa

          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Text(""),
          ), //yatama sudu kotuwa

          Container(
            margin: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Material(
                  //login box 1
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.6,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 245, 245, 245),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          "Login",
                          style: AppWidget.boldTextFieldstyle(),
                        ),
                        Container(
                          color: Color.fromARGB(255, 245, 245, 245),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.all(12),
                              child: Form(
                                key: _formkey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Email',
                                        enabled: true,
                                        contentPadding: const EdgeInsets.only(
                                            left: 14.0, bottom: 8.0, top: 8.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromARGB(
                                                  255, 10, 10, 10)),
                                          borderRadius:
                                              new BorderRadius.circular(10),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromARGB(
                                                  255, 10, 10, 10)),
                                          borderRadius:
                                              new BorderRadius.circular(10),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.length == 0) {
                                          return "Email cannot be empty";
                                        }
                                        if (!RegExp(
                                                "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                            .hasMatch(value)) {
                                          return ("Please enter a valid email");
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        emailController.text = value!;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      controller: passwordController,
                                      obscureText: _isObscure3,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            icon: Icon(_isObscure3
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            onPressed: () {
                                              setState(() {
                                                _isObscure3 = !_isObscure3;
                                              });
                                            }),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Password',
                                        enabled: true,
                                        contentPadding: const EdgeInsets.only(
                                            left: 14.0, bottom: 8.0, top: 15.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              new BorderRadius.circular(10),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              new BorderRadius.circular(10),
                                        ),
                                      ),
                                      validator: (value) {
                                        RegExp regex = new RegExp(r'^.{6,}$');
                                        if (value!.isEmpty) {
                                          return "Password cannot be empty";
                                        }
                                        if (!regex.hasMatch(value)) {
                                          return ("please enter valid password min. 6 character");
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        passwordController.text = value!;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      elevation: 5.0,
                                      height: 40,
                                      onPressed: () {
                                        setState(() {
                                          visible = true;
                                        });
                                        signIn(emailController.text,
                                            passwordController.text);
                                      },
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      color: Colors.white,
                                    ),
                                    Visibility(
                                        maintainSize: true,
                                        maintainAnimation: true,
                                        maintainState: true,
                                        visible: visible,
                                        child: Container(
                                            child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ))),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Register()));
                                        },
                                        child: Text(
                                          "have an account? Register",
                                          style: AppWidget
                                              .SemiboldTextFieldstyle(),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ) //mada okkom

          // body: SingleChildScrollView(
          //   child: Column(
          //     children: <Widget>[
          //       Container(
          //         color: Colors.orangeAccent[700],
          //         width: MediaQuery.of(context).size.width,
          //         height: MediaQuery.of(context).size.height * 0.70,
          //         child: Center(
          //           child: Container(
          //             margin: EdgeInsets.all(12),
          //             child: Form(
          //               key: _formkey,
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 children: [
          //                   SizedBox(
          //                     height: 30,
          //                   ),
          //                   Text(
          //                     "Login",
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.white,
          //                       fontSize: 40,
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 20,
          //                   ),
          //                   TextFormField(
          //                     controller: emailController,
          //                     decoration: InputDecoration(
          //                       filled: true,
          //                       fillColor: Colors.white,
          //                       hintText: 'Email',
          //                       enabled: true,
          //                       contentPadding: const EdgeInsets.only(
          //                           left: 14.0, bottom: 8.0, top: 8.0),
          //                       focusedBorder: OutlineInputBorder(
          //                         borderSide: new BorderSide(color: Colors.white),
          //                         borderRadius: new BorderRadius.circular(10),
          //                       ),
          //                       enabledBorder: UnderlineInputBorder(
          //                         borderSide: new BorderSide(color: Colors.white),
          //                         borderRadius: new BorderRadius.circular(10),
          //                       ),
          //                     ),
          //                     validator: (value) {
          //                       if (value!.length == 0) {
          //                         return "Email cannot be empty";
          //                       }
          //                       if (!RegExp(
          //                               "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
          //                           .hasMatch(value)) {
          //                         return ("Please enter a valid email");
          //                       } else {
          //                         return null;
          //                       }
          //                     },
          //                     onSaved: (value) {
          //                       emailController.text = value!;
          //                     },
          //                     keyboardType: TextInputType.emailAddress,
          //                   ),
          //                   SizedBox(
          //                     height: 20,
          //                   ),
          //                   TextFormField(
          //                     controller: passwordController,
          //                     obscureText: _isObscure3,
          //                     decoration: InputDecoration(
          //                       suffixIcon: IconButton(
          //                           icon: Icon(_isObscure3
          //                               ? Icons.visibility
          //                               : Icons.visibility_off),
          //                           onPressed: () {
          //                             setState(() {
          //                               _isObscure3 = !_isObscure3;
          //                             });
          //                           }),
          //                       filled: true,
          //                       fillColor: Colors.white,
          //                       hintText: 'Password',
          //                       enabled: true,
          //                       contentPadding: const EdgeInsets.only(
          //                           left: 14.0, bottom: 8.0, top: 15.0),
          //                       focusedBorder: OutlineInputBorder(
          //                         borderSide: new BorderSide(color: Colors.white),
          //                         borderRadius: new BorderRadius.circular(10),
          //                       ),
          //                       enabledBorder: UnderlineInputBorder(
          //                         borderSide: new BorderSide(color: Colors.white),
          //                         borderRadius: new BorderRadius.circular(10),
          //                       ),
          //                     ),
          //                     validator: (value) {
          //                       RegExp regex = new RegExp(r'^.{6,}$');
          //                       if (value!.isEmpty) {
          //                         return "Password cannot be empty";
          //                       }
          //                       if (!regex.hasMatch(value)) {
          //                         return ("please enter valid password min. 6 character");
          //                       } else {
          //                         return null;
          //                       }
          //                     },
          //                     onSaved: (value) {
          //                       passwordController.text = value!;
          //                     },
          //                     keyboardType: TextInputType.emailAddress,
          //                   ),
          //                   SizedBox(
          //                     height: 20,
          //                   ),
          //                   MaterialButton(
          //                     shape: RoundedRectangleBorder(
          //                         borderRadius:
          //                             BorderRadius.all(Radius.circular(20.0))),
          //                     elevation: 5.0,
          //                     height: 40,
          //                     onPressed: () {
          //                       setState(() {
          //                         visible = true;
          //                       });
          //                       signIn(
          //                           emailController.text, passwordController.text);
          //                     },
          //                     child: Text(
          //                       "Login",
          //                       style: TextStyle(
          //                         fontSize: 20,
          //                       ),
          //                     ),
          //                     color: Colors.white,
          //                   ),
          //                   SizedBox(
          //                     height: 10,
          //                   ),
          //                   Visibility(
          //                       maintainSize: true,
          //                       maintainAnimation: true,
          //                       maintainState: true,
          //                       visible: visible,
          //                       child: Container(
          //                           child: CircularProgressIndicator(
          //                         color: Colors.white,
          //                       ))),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       SizedBox(
          //         height: 20.0,
          //       ),
          //       GestureDetector(
          //           onTap: () {
          //             Navigator.push(context,
          //                 MaterialPageRoute(builder: (context) => Register()));
          //           },
          //           child: Text(
          //             "Don't have account? Sign up",
          //             style: AppWidget.SemiboldTextFieldstyle(),
          //           ))
          //     ],
          //   ),
          // ),
        ]),
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('rool') == "Teacher") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Teacher(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
