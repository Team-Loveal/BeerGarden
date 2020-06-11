import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/scary.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
                child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              //mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Spacer(flex: 2),
                Text(
                  'Welcome to Loveal',
                  style: TextStyle(fontSize: 45),
                ),
                Text('A dating app for ugly people',
                    style: TextStyle(fontSize: 20)),
                Spacer(flex: 4),
                MaterialButton(
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () =>
                        {Navigator.of(context).pushNamed('/login')},
                    minWidth: 250),
                MaterialButton(
                    child: Text('Signup',
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () =>
                        {Navigator.of(context).pushNamed('/signup')},
                    minWidth: 250),
                Spacer(flex: 1)
              ],
            )),
          ),
        ));
  }
}
