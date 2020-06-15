//import 'package:flutter/material.dart';
//import 'package:lovealapp/pages/getMatch.dart';
//import 'package:lovealapp/pages/myProfile.dart';
//import 'package:lovealapp/pages/navigationHome.dart';
//import 'package:lovealapp/pages/preferences.dart';
//import 'package:lovealapp/pages/uploadphoto.dart';
//import 'package:lovealapp/pages/login.dart';
//import 'package:lovealapp/pages/signup.dart';
//import 'package:lovealapp/pages/wrapper.dart';
//import 'package:lovealapp/pages/forgotpassword.dart';
//import 'package:lovealapp/services/auth.dart';
//import 'package:lovealapp/pages/createProfile.dart';
//import 'package:lovealapp/pages/editProfile.dart';
//import 'package:hexcolor/hexcolor.dart';
//import 'package:workmanager/workmanager.dart';
//// import 'package:cloud_firestore/cloud_firestore.dart';
//
////provide user data to Wrapper file
//import 'package:provider/provider.dart';
//import "package:lovealapp/models/user.dart";
//
//void resetUserMatches() {
//  Workmanager.executeTask((task, inputData) {
//    final user = AuthService().user;
//    print(user);
//    // Firestore.instance
//    //     .collection('users')
//    //     .document(user.uid['uid'])
//    //     .updateData({
//    //   'matches': 0,
//    // });
//
//    //TODO FOR BLUR FUNCTIONALITY:
//     create blur field in message document and set it as 50
//every day decrease blur field by 1 or 3 or whatever
// when loading profile page read the blur field from the db and set it as sigmaX and sigmaY
//
//    return Future.value(true);
//  });
//}
//
////main function is the first function that fires when dart file starts
//void main() {
//  Workmanager.initialize(
//      resetUserMatches, // The top level function, aka callbackDispatcher
//      isInDebugMode:
//          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
//      );
//  Workmanager.registerPeriodicTask(
//    "2",
//    "simplePeriodicTask",
//    frequency: Duration(days: 1),
//    constraints: Constraints(networkType: NetworkType.connected),
//  );
//  runApp(MyApp());
//}
//
////create new widget called MyApp which is the root widget
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    //Material App is a widget that has properties like title, theme etc.
//    return StreamProvider<User>.value(
//      value: AuthService().user,
//      child: MaterialApp(
//          title: 'Loveal',
//          debugShowCheckedModeBanner: false,
//          theme: ThemeData(
//            fontFamily: 'Alata',
//            primaryColor: Hexcolor("#000000"),
//            accentColor: Hexcolor("#8CC63E"),
//          ),
//          initialRoute: '/',
//          routes: {
//            '/': (_) => Wrapper(),
//            '/signup': (_) => SignUp(),
//            '/login': (_) => Login(),
//            '/forgotpassword': (_) => ForgotPassword(),
//            '/createProfile': (_) => CreateProfile(),
//            '/uploadphoto': (_) => UploadPhoto(),
//            '/editProfile': (_) => EditProfile(),
//            '/getMatch': (_) => GetMatch(),
//            '/navigationHome': (_) => NavigationHome(),
//            '/myprofile': (_) => MyProfile(),
//            '/setPreferences': (_) => SetPreferences(),
//          }
//          ),
//          );
//  }
//}

import 'package:flutter/material.dart';
import 'package:lovealapp/pages/getMatch.dart';
import 'package:lovealapp/pages/myProfile.dart';
import 'package:lovealapp/pages/navigationHome.dart';
import 'package:lovealapp/pages/preferences.dart';
import 'package:lovealapp/pages/uploadphoto.dart';
import 'package:lovealapp/pages/login.dart';
import 'package:lovealapp/pages/signup.dart';
import 'package:lovealapp/pages/wrapper.dart';
import 'package:lovealapp/pages/forgotpassword.dart';
import 'package:lovealapp/services/auth.dart';
import 'package:lovealapp/pages/createProfile.dart';
import 'package:lovealapp/pages/editProfile.dart';
import 'package:lovealapp/pages/loginFirstTime.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lovealapp/pages/questions.dart';

//provide user data to Wrapper file
import 'package:provider/provider.dart';
import "package:lovealapp/models/user.dart";

//main function is the first function that fires when dart file starts
void main() {
  runApp(MyApp());
}

//create new widget called MyApp which is the root widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Material App is a widget that has properties like title, theme etc.
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Loveal',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Alata',
          primaryColor: Hexcolor("#000000"),
          accentColor: Hexcolor("#8CC63E"),
        ),
          initialRoute: '/',
          routes: {
            '/': (_) => Wrapper(),
            '/signup': (_) => SignUp(),
            '/login': (_) => Login(),
            '/forgotpassword': (_) => ForgotPassword(),
            '/createProfile': (_) => CreateProfile(),
            '/uploadphoto': (_) => UploadPhoto(),
            '/editProfile': (_) => EditProfile(),
            '/getMatch': (_) => GetMatch(),
            '/navigationHome': (_) => NavigationHome(),
            '/myProfile': (_) => MyProfile(),
            '/setPreferences': (_) => SetPreferences(),
            '/loginFirstTime': (_) => LoginFirstTime(),
            '/questions': (_) => Questions(),
          }
      ),
    );
  }
}
