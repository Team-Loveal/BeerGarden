import 'package:cloud_firestore/cloud_firestore.dart';

class  DatabaseService {

  final CollectionReference usersCollection = Firestore.instance.collection("users");


}