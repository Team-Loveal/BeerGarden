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
                Padding(
                  padding: const EdgeInsets.fromLTRB(260, 15, 15, 0),
                  child: MaterialButton(
                      child: Text('About',
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () =>
                          {Navigator.of(context).pushNamed('/about')}),
                ),
                Spacer(flex: 2),
                Image(
                  image: AssetImage('images/logo.png'),
                ),
//                Spacer(flex: 2),
                Text('Grow your relationships over a beer',
                    style: TextStyle(fontSize: 18)),
                Spacer(flex: 2),
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
                _aboutButton(),
                Spacer(flex: 2),
              ],

            )),
          ),
        ));
  }
//}

Widget _aboutButton() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
    child: GestureDetector(
      onTap: () => {Navigator.of(context).pushNamed('/about')},
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Learn about the BeerGarden in ',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Alata',
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Info',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Alata',
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
