import 'package:lovealapp/services/auth.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
// import 'package:beergarden/models/user.dart';

class LoginFirstTime extends StatefulWidget {
  @override
  _LoginFirstTimeState createState() => _LoginFirstTimeState();
}

class _LoginFirstTimeState extends State<LoginFirstTime> {
  final AuthService _auth = AuthService();

  //text field state
  String email = "";
  String password = "";
  String error = '';

  //for loading spinner
  bool loading = false;

  void handleLogin() async {
    setState(() => loading = true);
    String trimmedEmail = email.trim();
    String trimmedPassword = password.trim();

    dynamic result =
        await _auth.signInWithEmailAndPassword(trimmedEmail, trimmedPassword);

    if (result == null) {
      setState(() {
        error = 'Could not sign in with those credentials';
        loading = false;
      });
    } else {
      //result.uid is the uid we will need for the db
      // Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushNamed('/createProfile');
    }
  }

/*
  void googleLogin() async {
    dynamic result = await AuthService().loginWithGoogle();
    if (result == null) {
      setState(() {
        error = 'Could not sign in with those credentials';
        loading = false;
      });
    } else {
      //result.uid is the uid we will need for the db
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  void facebookLogin() async {
  }
*/

  Widget _buildEmail() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 60.0,
      child: TextField(
        onChanged: (val) {
          setState(() => email = val);
        },
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(MdiIcons.email, color: Hexcolor('#F4AA33')),
            labelText: 'Email',
            labelStyle: TextStyle(
                fontSize: 18.0,
                color: Hexcolor('#F4AA33'),
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildPassword() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 50.0,
      child: TextField(
        onChanged: (val) {
          setState(() => password = val);
        },
        obscureText: true,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(MdiIcons.key, color: Hexcolor('#F4AA33')),
            labelText: 'Password',
            labelStyle: TextStyle(
                fontSize: 18.0,
                color: Hexcolor('#F4AA33'),
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => {Navigator.of(context).pushNamed('/forgotpassword')},
        padding: EdgeInsets.only(right: 0.0),
        child: Text('Forgot Password?',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => {handleLogin()},
        padding: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Hexcolor('#FFF1BA'),
                          Hexcolor('#F4AA33'),
                        ],
                        stops: [0.2, 0.7],
                      ),
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 120.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 52.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 50.0),
                          _buildEmail(),
                          SizedBox(
                            height: 12.0,
                          ),
                          _buildPassword(),
                          _buildForgotPasswordBtn(),
                          _buildLoginBtn(),
                          // _buildSignInWithText(),
                          // _buildSocialBtnRow(),
                          // _buildSignupBtn(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
