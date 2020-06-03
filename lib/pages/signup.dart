import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Sign Up', style: TextStyle(
                color: Colors.pinkAccent,
                fontSize: 70
              )),
              Text('Please sign up to find your match' , style: TextStyle(
                color: Colors.pinkAccent,
                fontSize: 35
              ))
            ],
          )
        )
        
      )
    );
  }
}
