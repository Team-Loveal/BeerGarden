import 'package:flutter/material.dart';
import 'package:lovealapp/services/auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:lovealapp/shared/loading.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();

  //text field state
  String email = "";
  String password = "";
  String error = '';

  //for loading spinner
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Padding(
                padding: EdgeInsets.all(20),
                child: ListView(
                  children: <Widget>[
                    //May need to add button to switch to Sign Up
                    Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.fromLTRB(20, 60, 20, 5),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 36, fontWeight: FontWeight.bold),
                        )),
                    Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.fromLTRB(20, 0, 15, 20),
                        child: Text(
                          'Please login to find your match',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                        height: 55,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: TextField(
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(MdiIcons.email),
                              labelText: 'Email',
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold)),
                        )),
                    Container(
                        height: 55,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: TextField(
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(MdiIcons.key),
                              labelText: 'Password',
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold)),
                        )),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child: FlatButton(
                        onPressed: () => {
                          Navigator.of(context).pushNamed('/forgotpassword')
                        },
                        textColor: Colors.pink,
                        child: Text(
                          'Forgot password',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(180, 0, 20, 0),
                        child: RaisedButton(
                            onPressed: () async {
                              setState(() => loading = true);
                              String trimmedEmail = email.trim();
                              String trimmedPassword = password.trim();
                              dynamic result =
                                  await _auth.signIWithEmailAndPassword(
                                      trimmedEmail, trimmedPassword);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'Could not sign in with those credentials';
                                  loading = false;
                                });
                              } else {
                                //result.uid is the uid we will need for the db
                                print(result);
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              }
                            },
                            textColor: Colors.white,
                            color: Colors.pink,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Row(
                              children: <Widget>[
                                Text('LOGIN  ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Icon(MdiIcons.arrowRight, size: 18)
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ))),
                    Container(
                      child: Text(error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0)),
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
                        child: Text('Login with',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ))),
                    Container(
                        child: Row(
                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () {},
                          fillColor: Colors.white,
                          child: Icon(
                            MdiIcons.facebook,
                            size: 40,
                            color: Color.fromARGB(255, 66, 103, 178),
                          ),
                          shape: CircleBorder(),
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          fillColor: Colors.white,
                          child: Icon(
                            MdiIcons.google,
                            size: 40,
                            color: Color.fromARGB(255, 234, 67, 53),
                          ),
                          shape: CircleBorder(),
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          fillColor: Colors.white,
                          child: Icon(
                            MdiIcons.twitter,
                            size: 40,
                            color: Color.fromARGB(255, 29, 161, 242),
                          ),
                          shape: CircleBorder(),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Text("Don't have an account?",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                            FlatButton(
                                onPressed: () => {
                                      Navigator.of(context).pushNamed('/signup')
                                    },
                                textColor: Colors.pink,
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )),
                  ],
                )));
  }
}
