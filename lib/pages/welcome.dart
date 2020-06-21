import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Hexcolor("#FFF1BA"), Hexcolor("#F4AA33")],
          stops: [0.2, 0.7],
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
                child: Column(
              children: <Widget>[
                Spacer(flex: 2),
                Image(
                  image: AssetImage('images/logo.png'),
                ),
//                Spacer(flex: 2),
                Text('Grow your relationships over a beer',
                    style: TextStyle(fontSize: 18)),
                Spacer(flex: 1),
                MaterialButton(
                    height: 50.0,
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () =>
                        {Navigator.of(context).pushNamed('/login')},
                    minWidth: 250),
                SizedBox(height: 20.0),
                MaterialButton(
                    height: 50.0,
                    child: Text('Sign up',
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () =>
                        {Navigator.of(context).pushNamed('/signup')},
                    minWidth: 250),
                Spacer(flex: 2)
              ],
            )),
          ),
        ));
  }
}
