import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovealapp/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      Firestore.instance.collection("users");

  //set user data when signing up
  Future setUserData(String email) async {
    return await usersCollection.document(uid).setData({
      'email': email,
      'nickname': "",
      'location': "",
      'age': "",
      'gender': "",
      'occupation': "",
      'about': "",
      "interests": "",
    });
  }

  //update user data when creating profile or editing profile
  Future updateUserData(String nickname, String location, String age,
      String gender, String occupation, String about, String interests) async {
    return await usersCollection.document(uid).updateData({
      'nickname': nickname,
      'location': location,
      'age': age,
      'gender': gender,
      'occupation': occupation,
      'about': about,
      "interests": interests,
    });
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      email: snapshot.data['email'],
      nickname: snapshot.data['nickname'],
      location: snapshot.data['location'],
      age: snapshot.data['age'],
      gender: snapshot.data['gender'],
      occupation: snapshot.data['occupation'],
      about: snapshot.data['about'],
      interests: snapshot.data['interests'],
    );
  }

  //get user doc stream
  //used when populating user data in preview profile and edit profile
  Stream<UserData> get userData {
    return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
