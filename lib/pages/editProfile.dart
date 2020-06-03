import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
//                    Image.asset('images/blank.jpg'),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/blank.jpg'),
                      backgroundColor: Colors.white,
                    ),
                    Text(
                      'Edit Profile Picture',
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      'Nickname',
                      style: TextStyle(
                        color: Colors.orange[200],
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Location',
                      style: TextStyle(
                        color: Colors.orange[200],
                        fontSize: 20,
                      ),
                    ),
                    Center(
                      child: Row(

                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Age',
                              style: TextStyle(
                                color: Colors.orange[200],
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Age',
                              style: TextStyle(
                                color: Colors.orange[200],
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
