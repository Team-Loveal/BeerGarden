import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovealapp/services/auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:hexcolor/hexcolor.dart';


//If you're going to add validator functionality, you must change the TextFields to TextFormField and Container to Form

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
            body: Center(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Hexcolor("#f28e1c"), Hexcolor("#fde895")]
                    )
                  ),
                  child: ListView(
                    children: <Widget>[
                      //May need to add button to switch to Login
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.fromLTRB(20, 60, 20, 5),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 36, fontWeight: FontWeight.bold, fontFamily: 'Alata'),
                        ),
                      ),
                      Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.fromLTRB(20, 0, 15, 20),
                          child: Text('Please sign up to find your match',
                              style: TextStyle(
                                  color: Hexcolor("#000000"),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold))),
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
                          padding: EdgeInsets.fromLTRB(170, 10, 20, 0),
                          child: RaisedButton(
                              onPressed: () async {
                                setState(() => loading = true);
                                String trimmedEmail = email.trim();
                                String trimmedPassword = password.trim();
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        trimmedEmail, trimmedPassword);
                                if (result == null) {
                                  setState(() {
                                    error =
                                        'Could not sign in with those credentials';
                                    loading = false;
                                  });
                                } else {
                                  Navigator.of(context)
                                      .pushNamed('/createProfile');
                                }
                              },
                              textColor: Hexcolor("#000000"),
                              color: Hexcolor("#F6F6E3"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Row(
                                children: <Widget>[
                                  Text('SIGN UP  ',
                                      style: TextStyle(
                                        color: Hexcolor("#000000"),
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
                          margin: EdgeInsets.fromLTRB(0, 80, 0, 10),
                          child: Text('Sign up with',
                              style: TextStyle(
                                color: Hexcolor("#000000"),
                                fontSize: 12,
                              ))),
                      Container(
                          child: Row(
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () async {},
                            fillColor: Colors.white,
                            child: Icon(
                              MdiIcons.facebook,
                              size: 40,
                              color: Color.fromARGB(255, 66, 103, 178),
                            ),
                            shape: CircleBorder(),
                          ),
                          RawMaterialButton(
                            onPressed: () async {
                              dynamic result =
                                  await AuthService().registerWithGoogle();
                              if (result == null) {
                                setState(() {
                                  error =
                                      'Could not sign in with those credentials';
                                  loading = false;
                                });
                              } else {
                                //result.uid is the uid we will need for the db
                                print(result);
                                Navigator.of(context).pushNamed('/createProfile');
                              }
                            },
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
                              Text("Already have an account?",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Hexcolor("#000000"),
                                      fontWeight: FontWeight.bold)),
                              FlatButton(
                                  onPressed: () =>
                                      {Navigator.of(context).pushNamed('/login')},
                                  textColor: Hexcolor("#000000"),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )),
                    ],
                  ),
                )));
  }
}
