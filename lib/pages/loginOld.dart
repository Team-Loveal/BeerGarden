import 'package:flutter/material.dart';
import 'package:lovealapp/services/auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:google_fonts/google_fonts.dart';

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
            body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                  0.1,
                  0.8,
                ],
                    colors: [
                  Colors.white,
                  Colors.orange
                ])),
            child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    //May need to add button to switch to Sign Up
                    Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.fromLTRB(20, 60, 20, 5),
                        child: Text(
                          'Login',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold)),
                        )),
                    Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.fromLTRB(20, 5, 15, 20),
                        child: Text(
                          'Please login to find your match',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 50.0),
                        height: 55.0,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              prefixIcon:
                                  Icon(MdiIcons.email, color: Colors.white),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        )),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        height: 55.0,
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: TextField(
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            prefixIcon: Icon(MdiIcons.key, color: Colors.white),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: 50.0,
                        height: 50.0,
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
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('LOGIN  ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Icon(MdiIcons.arrowRight, size: 18)
                              ],
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
                              fontSize: 16,
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
                          onPressed: () async {
                            dynamic result =
                                await AuthService().loginWithGoogle();
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

                            /* bool res = await AuthService().loginWithGoogle();
                              if(!res)
                                print("error logging in with Google");*/
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
                            Text("Don't have an account?",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                            FlatButton(
                                onPressed: () => {
                                      Navigator.of(context).pushNamed('/signup')
                                    },
                                textColor: Colors.green,
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
                )),
          ));
  }
}
