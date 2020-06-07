import 'package:flutter/material.dart';
import 'package:lovealapp/pages/editProfile.dart';
import 'package:lovealapp/pages/navigationHome.dart';
import 'package:lovealapp/pages/uploadphoto.dart';
import 'package:lovealapp/pages/login.dart';
import 'package:lovealapp/pages/message.dart';
import 'package:lovealapp/pages/welcome.dart';
import 'package:lovealapp/pages/signin.dart';
import 'package:lovealapp/pages/signup.dart';
import 'package:lovealapp/pages/profilePreview.dart';
import 'package:lovealapp/pages/wrapper.dart';
import 'package:lovealapp/pages/match.dart';
import 'package:lovealapp/pages/forgotpassword.dart';
import 'package:lovealapp/services/auth.dart';
import 'package:lovealapp/pages/createProfile.dart';


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
    return  StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Loveal',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
//        home: Wrapper(),
      home: UploadPhoto(),
        routes: {
          '/signup': (_) => SignUp(),
          '/login': (_) => Login(),
          '/forgotpassword': (_) => ForgotPassword(),
          '/createProfile': (_) => CreateProfile(),
        }
      ),
    );
  }
}

