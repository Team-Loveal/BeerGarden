import 'package:flutter/material.dart';

class SetPreferences extends StatefulWidget {
  @override
  _SetPreferencesState createState() => _SetPreferencesState();
}

class _SetPreferencesState extends State<SetPreferences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Set Preferences',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
