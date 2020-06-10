import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:lovealapp/pages/profilePreview.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lovealapp/models/user.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;

class UploadPhoto extends StatefulWidget {
  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  File _image;
  String _uploadedFileURL;

  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Upload Picture!',
                  style: TextStyle(fontSize: 28),
                ),
                Container(
                  child: _image == null
                      ? Image.asset('images/blank.jpg')
                      : Image.file(_image),
                ),
                RaisedButton(
                  child: _image == null
                      ? Text(
                          'Upload',
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : enableUpload(),
                  color: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: _image == null ? () => {getImage()} : () => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget enableUpload() {
    final user = Provider.of<User>(context);
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            color: Colors.pink,
            child: Text('Next', style: TextStyle(fontWeight: FontWeight.bold)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () async {
              uploadFile();
//              Navigator.of(context).pushNamed('/profilePreview');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfilePreview(profileImg: _image)));
            },
          )
        ],
      ),
    );
  }

  Future uploadFile() async {
    final user = Provider.of<User>(context, listen: false);
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      Firestore.instance
          .collection("users")
          .document(user.uid)
          .updateData({"imgUrl": fileURL});
    });
  }
}
