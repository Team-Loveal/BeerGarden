import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/pages/questions.dart';
import 'package:lovealapp/pages/uploadphoto.dart';
import 'package:lovealapp/pages/welcome.dart';
import 'package:lovealapp/services/database.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/pages/navigationHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'createProfile.dart';
class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}
class _WrapperState extends State<Wrapper> {
  Widget build(BuildContext context) {
    //receive user from provider stream
    final user = Provider.of<User>(context);
    if (user == null) {
      return Welcome();
    }
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          if (snapshot.hasData) {
            print('HAS DATA');
            if(userData.isProfileCreated == false) {
              print('HAS DATA');
              return CreateProfile();
            } else if (!userData.questionsCompleted) {
              return Questions();
            } else if (!userData.photoUploaded) {
              return UploadPhoto();
            } else {
              return NavigationHome();
            }
          } else {
            return Loading();
          }
        }
    );
  }
}