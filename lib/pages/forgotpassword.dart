import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:lovealapp/pages/login.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(MdiIcons.email),
                          labelText: 'Email',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                    )),

                Container(
                    padding: EdgeInsets.fromLTRB(180, 0, 20, 0),
                    child: RaisedButton(
                        onPressed: () => {},
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
                            onPressed: () => {
                              Navigator.of(context).pushNamed('/login')
                            },
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
            ))




    );
  }
}

