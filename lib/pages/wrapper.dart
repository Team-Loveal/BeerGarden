import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/pages/welcome.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/pages/navigationHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      return NavigationHome();
    }
}
