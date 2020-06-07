//for auth service
import 'package:firebase_auth/firebase_auth.dart';
import "package:lovealapp/models/user.dart";
import 'package:lovealapp/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  //stream listens for every time user signs in or signs out we get response down the stream
  Stream<User> get user {
    //map FirebaseUser to custom user obj that we declared above (either obj or null)
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //sign in anon but prob won't use it
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signIWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('Yurika', 'Tokyo',
          '50-59', 'Female', 'Yodler', 'I am a hoot', 'yodeling');

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // reset password
  Future sendPasswordResetEmail(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }
}
