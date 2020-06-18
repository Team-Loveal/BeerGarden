import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/pages/welcome.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/pages/navigationHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//listen for auth changes provided by stream declared in auth.dart

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String isProfileCreated;

  @override
/*  void initState() {
    super.initState();
   final user = Provider.of<User>(context);

    Firestore.instance.collection('users').document(user.uid).get().then((doc) {
      setState(() {
        isProfileCreated = doc['isProfileCreated'];
      });
    });
  }*/

  Widget build(BuildContext context) {
    //receive user from provider stream
    final user = Provider.of<User>(context);

    //final user = Provider.of<User>(context);
   // print('5555555555555555555555555${isProfileCreated}');
    if (user == null) {
      return Welcome();
    } else {

      return NavigationHome();
    }
  }
}
