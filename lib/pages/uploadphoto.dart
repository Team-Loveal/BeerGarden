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

  // select image via either folder of camera
  Future getImageFromGallery() async {
    PickedFile image =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image.path);
    });
  }

  Future getImageFromCamera() async {
    PickedFile image = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _image == null
                      ? Text(
                      'Upload Picture!',
                      style: TextStyle(fontSize: 30),
                    ) : Text(
                      'Tap next button!',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: _image == null
                          ? Image.asset('images/blank.jpg')
                          : Image.file(_image),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: _image == null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                FloatingActionButton(
                                  heroTag: null,
                                  child: Icon(
                                    Icons.photo_camera,
                                    size: 30,
                                  ),
                                  onPressed: getImageFromCamera,
                                ),
                                FloatingActionButton(
                                  heroTag: null,
                                  child: Icon(
                                    Icons.photo_library,
                                    size: 30,
                                  ),
                                  onPressed: getImageFromGallery,
                                )
                              ],
                            )
                          : enableUpload(),
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

  Widget enableUpload() {
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
