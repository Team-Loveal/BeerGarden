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
import 'package:lovealapp/pages/loginFIrstTime.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovealapp/pages/questions.dart';

//provide user data to Wrapper file
import 'package:provider/provider.dart';
import "package:lovealapp/models/user.dart";

//main function is the first function that fires when dart file starts
void main() async {
  var difference = secondsToAlarm();

  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await AndroidAlarmManager.periodic(
      Duration(seconds: difference), 0, resetUserMatches);

  runApp(MyApp());
}

int secondsToAlarm() {
  var today = new DateTime.now();
  // schedule time for function invokation at 7AM
  var tomorrow = new DateTime(today.year, today.month, today.day + 1, 7, 0);
  // calculate hour difference
  return tomorrow.difference(today).inHours;
}

void resetUserMatches() async {
  Firestore.instance
      .collection("users")
      .getDocuments()
      .then((querySnapshot) => {
            querySnapshot.documents.forEach((doc) {
              doc.reference.updateData({'matches': 0});
            })
          })
      .catchError((error) => {print('Error resetting matches: $error')});
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
          initialRoute: '/questions',
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
            '/myprofile': (_) => MyProfile(),
            '/setPreferences': (_) => SetPreferences(),
            '/loginFirstTime': (_) => LoginFirstTime(),
            '/questions': (_) => Questions(),
          }),
    );
  }
}
