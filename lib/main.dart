import 'package:flutter/material.dart';
import 'package:lovealapp/pages/editProfile.dart';
import 'package:lovealapp/pages/uploadphoto.dart';
import 'package:lovealapp/pages/login.dart';
import 'package:lovealapp/pages/message.dart';
import 'package:lovealapp/pages/welcome.dart';
import 'package:lovealapp/pages/signin.dart';
import 'package:lovealapp/pages/signup.dart';
import 'package:lovealapp/pages/profilePreview.dart';
import 'package:lovealapp/pages/match.dart';
import 'package:lovealapp/pages/forgotpassword.dart';

//main function is the first function that fires when dart file starts
void main() {
  runApp(MyApp());
}

//create new widget called MyApp which is the root widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Material App is a widget that has properties like title, theme etc.
    return MaterialApp(
      title: 'Loveal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Welcome(),
      routes: {
        '/signup': (_) => SignUp(),
        '/login': (_) => Login(),
      }
    );
  }
}
