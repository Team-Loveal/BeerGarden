import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      Firestore.instance.collection("users");

  Future updateUserData(String nickname, String location, String age,
      String gender, String occupation, String about, String interests) async {
    return await usersCollection.document(uid).setData({
      'nickname': nickname,
      'location': location,
      'age': age,
      'gender': gender,
      'occupation': occupation,
      'about': about,
      'interests': interests,
    });
  }

  //get users stream
  Stream<QuerySnapshot> get users {
    return usersCollection.snapshots();
  }
}
