import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:async';
import 'package:hexcolor/hexcolor.dart';


class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String emailAddy = '';
  final nameHolder = TextEditingController();

  void onPressed() async {
    setState(() {
      _warning = 'A password has been sent to $emailAddy';
    });
    ShowAlert();
    clearTextInput();
    Timer(Duration(seconds: 5), () {
      {
        Navigator.of(context).pushNamed('/login');
      }
    });
    String trimmedEmailAddy = emailAddy.trim();
    FirebaseAuth mAuth = FirebaseAuth.instance;
    await mAuth.sendPasswordResetEmail(email: trimmedEmailAddy);
  }

  void onChanged(String value) {
    setState(() {
      emailAddy = value;
    });
  }

  void clearTextInput() {
    nameHolder.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Hexcolor("#FFF1BA"), Hexcolor("#F4AA33")],
                stops: [0.2, 0.7],
              )),
          child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: <Widget>[
                  ShowAlert(),
                  Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.fromLTRB(20, 60, 20, 5),
                      child: Text(
                        'Forgot Password',
                        style:
                            TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      )),
                  Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.fromLTRB(20, 0, 15, 20),
                      child: Text(
                        "Please enter your email and we'll reset your password",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                  Container(
                      height: 55,
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: TextField(
                        controller: nameHolder,
                        onChanged: (String value) {
                          onChanged(value);
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(MdiIcons.email),
                            labelText: 'Email',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                  Container(
                      padding: EdgeInsets.fromLTRB(180, 0, 20, 0),
                      child: RaisedButton(
                          onPressed: () => {
                                onPressed(),
                              },
                          textColor: Colors.white,
                          color: Colors.pink,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Row(
                            children: <Widget>[
                              Text('Send request  ',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                              Icon(MdiIcons.arrowRight, size: 18)
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ))),
                  Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Text("Already have an account?",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          FlatButton(
                              onPressed: () =>
                                  {Navigator.of(context).pushNamed('/login')},
                              textColor: Colors.pink,
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )),
                ],
              )),
        ));
  }
}

String _warning;

class ShowAlert extends StatefulWidget {
  @override
  _ShowAlertState createState() => _ShowAlertState();
}

class _ShowAlertState extends State<ShowAlert> {
  @override
  Widget build(BuildContext context) {
    if (_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.error_outline),
          ),
          Expanded(
            child: Text(
              _warning,
              style: TextStyle(
                color: Colors.cyan,
              ),
              maxLines: 3,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                },
              ))
        ]),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}
