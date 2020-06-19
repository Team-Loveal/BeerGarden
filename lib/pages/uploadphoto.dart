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
import 'package:hexcolor/hexcolor.dart';
import 'package:path/path.dart' as Path;
import 'dart:ui';

//adding for transition animation
import 'package:page_transition/page_transition.dart';

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

  //use for switch button
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
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
                              )
                            : Text(
                                'See what your picture looks like to others!',
                                style: TextStyle(fontSize: 30),
                                textAlign: TextAlign.center,
                              ),
                      ),
                      Container(
                        child: _image != null
                            ? Center(
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: Switch(
                                    value: isSwitched,
                                    onChanged: (value) {
                                      setState(() {
                                        isSwitched = value;
                                      });
                                    },
                                    activeTrackColor: Hexcolor("#8CC63E"),
                                    activeColor: Colors.green,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _image != null
                            ? !isSwitched
                                ? Container(
                                    width: 350,
                                    height: 350,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child:
                                          Image.file(_image, fit: BoxFit.cover),
                                    ),
                                  )
                                : Stack(
                                    children: <Widget>[
                                      Container(
                                        width: 350,
                                        height: 350,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.file(_image,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Container(
                                          width: 350,
                                          height: 350,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 50, sigmaY: 50),
                                                child: Container(
                                                    color: Colors.black
                                                        .withOpacity(0))),
                                          ))
                                    ],
                                  )
                            : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: _image == null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
          )
        ],
      ),
    ));
  }

  Widget enableUpload() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
              color: Colors.pinkAccent,
              child: Text(
                'Select again',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                    PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1), child: UploadPhoto()),
//                  just keeping the original version
//                  MaterialPageRoute(builder: (context) => UploadPhoto()),
                );

              }),
          RaisedButton(
            color: Hexcolor("#8CC63E"),
            child: Text(
              'Next',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () async {
              uploadFile();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfilePreview(profileImg: _image)));
            },
          ),
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
