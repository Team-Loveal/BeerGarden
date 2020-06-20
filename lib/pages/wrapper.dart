import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
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
            if(userData.isProfileCreated) {
              return NavigationHome();
            }
            return CreateProfile();
          } else {
            return Loading();
          }
        }
    );
  }
}