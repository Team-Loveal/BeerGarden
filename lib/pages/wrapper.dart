import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/pages/welcome.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/pages/navigationHome.dart';

//listen for auth changes provided by stream declared in auth.dart
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //receive user from provider stream
    final user = Provider.of<User>(context);

    if (user == null) {
      return Welcome();
    } else {
      return NavigationHome();
    }
  }
}
