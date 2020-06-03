import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                'Sign Up',
                style:
                  TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.fromLTRB(20, 0, 15, 20),
              child: Text(
                'Please sign up to find your match',
                style:
                  TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  )
              )
            ),
            Container(
              height: 55,
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ),
            Container(
                height: 55,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                )
            ),
            Container(
              padding: EdgeInsets.fromLTRB(220, 0, 20, 0),
              child: RaisedButton(
                onPressed: () => {},
                textColor: Colors.white,
                color: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Row(
                  children: <Widget>[
                    Text('Sign up ',
                        style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)
                        ),
                    Icon(MdiIcons.arrowRight, size: 18)
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
              )
            )


          ],

        )

        
      )
    );
  }
}
