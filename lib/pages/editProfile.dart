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
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CircleAvatar(
                radius: 60,
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
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      textDirection: TextDirection.ltr,
                      children: <Widget>[
                        TextField(
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w300),
                          decoration: InputDecoration(
                            labelText: 'Nickname',
                          ),
                          autofocus: true,
                          keyboardType: TextInputType.text,
                        ),
                        TextField(
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w300),
                          decoration: InputDecoration(
                            labelText: 'Location',
                          ),
                          autofocus: true,
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 70),
                            child: Text(
                              'Age',
                              style: TextStyle(
                                color: Colors.orange[200],
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Text(
                            'Gender',
                            style: TextStyle(
                              color: Colors.orange[200],
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RaisedButton(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () => {},
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
