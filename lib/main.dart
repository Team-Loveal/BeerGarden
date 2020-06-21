import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

//provide user data to Wrapper file
import 'package:provider/provider.dart';
import "package:lovealapp/models/user.dart";
import 'package:lovealapp/services/auth.dart';

//routes
import 'pages/editPhoto.dart';
import 'pages/moreQuestions.dart';
import 'pages/myProfile.dart';
import 'pages/navigationHome.dart';
import 'pages/preferences.dart';
import 'pages/uploadphoto.dart';
import 'pages/login.dart';
import 'pages/signup.dart';
import 'pages/wrapper.dart';
import 'pages/forgotpassword.dart';
import 'pages/createProfile.dart';
import 'pages/editProfile.dart';
import 'pages/loginFirstTime.dart';
import 'pages/about.dart';
import 'pages/questions.dart';

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
            '/about': (_) => About(),
            '/signup': (_) => SignUp(),
            '/login': (_) => Login(),
            '/forgotpassword': (_) => ForgotPassword(),
            '/createProfile': (_) => CreateProfile(),
            '/uploadphoto': (_) => UploadPhoto(),
            '/editphoto': (_) => EditPhoto(),
            '/editProfile': (_) => EditProfile(),
            '/navigationHome': (_) => NavigationHome(),
            '/myProfile': (_) => MyProfile(),
            '/setPreferences': (_) => SetPreferences(),
            '/loginFirstTime': (_) => LoginFirstTime(),
            '/questions': (_) => Questions(),
            '/moreQuestions': (_) => MoreQuestions(),
          }),
    );
  }
}
