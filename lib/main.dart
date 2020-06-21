import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lovealapp/services/database.dart';

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
import 'pages/questions.dart';
import 'pages/about.dart';

// for the page transtion
import 'package:page_transition/page_transition.dart';

//main function is the first function that fires when dart file starts
void main() {
  runApp(MyApp());
}

//create new widget called MyApp which is the root widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

        // just keep the original code in case I break the code
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
        },
        // this is for animation. Feel free to change the animation.
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/signup':
              return PageTransition(
                child: SignUp(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/forgotpassword':
              return PageTransition(
                child: ForgotPassword(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/login':
              return PageTransition(
                child: Login(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/createProfile':
              return PageTransition(
                child: CreateProfile(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/questions':
              return PageTransition(
                child: Questions(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/uploadphoto':
              return PageTransition(
                child: UploadPhoto(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/loginFirstTime':
              return PageTransition(
                child: LoginFirstTime(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/moreQuestions':
              return PageTransition(
                child: MoreQuestions(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/editphoto':
              return PageTransition(
                child: EditPhoto(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/editProfile':
              return PageTransition(
                child: EditProfile(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            default:
              return null;
          }
        },
      ),
    );
  }
}
