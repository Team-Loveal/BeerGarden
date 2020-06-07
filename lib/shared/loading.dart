import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//choose loading spinner from here: https://pub.dev/packages/flutter_spinkit#-readme-tab-

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitPumpingHeart(
          color: Colors.pinkAccent,
          size: 50.0,
        ),
      ),
    );
  }
}
