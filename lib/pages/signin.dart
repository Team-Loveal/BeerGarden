import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            //buttons
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 180.0),
                    child: Text(
                      'Loveal',
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 70.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
                  Container(
                    child: ButtonTheme(
                      minWidth: 250.0,
                      height: 40.0,
                      child: RaisedButton(
                          child: Text('Login',
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                              )),
                          color: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () => {}),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 00),
                    child: ButtonTheme(
                      minWidth: 250.0,
                      height: 40.0,
                      child: RaisedButton(
                          child: Text('Signup',
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                              )),
                          color: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () => {}),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
