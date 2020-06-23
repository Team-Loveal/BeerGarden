import 'dart:convert';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:lovealapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'database.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(
            uid: user.uid,
            isEmailVerified: user.isEmailVerified,
          )
        : null;
  }

  //auth change user stream
  //stream listens for every time user signs in or signs out we get response down the stream
  Stream<User> get user {
    //map FirebaseUser to custom user obj that we declared above (either obj or null)
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    try {
      FirebaseUser user = result.user;
      await user.sendEmailVerification();
      // if (user.isEmailVerified) {
      //create a new document for the user with the uid and add email field
      await DatabaseService(
              uid: user.uid, isEmailVerified: user.isEmailVerified)
          .setUserData(email);
      return _userFromFirebaseUser(user);
      //}
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      if (user.isEmailVerified == true) {
        return _userFromFirebaseUser(user);
      }
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

  //Register with The Google
  Future registerWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
      //GoogleSignInAccount account = await googleSignIn.signIn();
      /* print("crapppppppp");
      print('acccccounnnntttttttt: ${account}');
      if (account == null) return false;
      print('BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB');
      AuthResult result =
          await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));*/
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      print('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCc');
      //FirebaseUser user = result.user;
      print('google login userID: ${user.uid}');
      print('google login user: $user');
      print('google account: $googleSignInAccount');
      await DatabaseService(uid: user.uid)
          .setUserData(googleSignInAccount.email);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("Error logging with Google");
      return false;
    }
  }

  //Login with The Google
  Future loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) return false;
      AuthResult result =
          await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("Error logging with Google");
      return false;
    }
  }

  Future registerWithFacebook() async {
    try {
      FacebookLogin facebookLogin = FacebookLogin();

      final signupResult = await facebookLogin.logIn(['email']);
      final token = signupResult.accessToken.token;
      final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
      var profile = jsonDecode(graphResponse.body);
      var stringProfile = profile.toString();
      print("This is the object: $stringProfile");
      if (signupResult.status == FacebookLoginStatus.loggedIn) {
        final credential =
            FacebookAuthProvider.getCredential(accessToken: token);
        AuthResult result = await _auth.signInWithCredential(credential);
        FirebaseUser user = result.user;
        print('facebook login userID: ${user.uid}');
        print('facebook login user: $user');
        await DatabaseService(uid: user.uid).setUserData(profile['email']);
        return _userFromFirebaseUser(user);
      }
    } catch (e) {
      print("Error signing up  with Facebook");
      return false;
    }
  }

  Future loginWithFacebook() async {
    try {
      FacebookLogin facebookLogin = FacebookLogin();

      final signupResult = await facebookLogin.logIn(['email']);
      final token = signupResult.accessToken.token;
      if (signupResult.status == FacebookLoginStatus.loggedIn) {
        final credential =
            FacebookAuthProvider.getCredential(accessToken: token);
        AuthResult result = await _auth.signInWithCredential(credential);
        FirebaseUser user = result.user;
        //  await DatabaseService(uid: user.uid).setUserData(profile['email']);
        return _userFromFirebaseUser(user);
      }
    } catch (e) {
      print("Error logging in with Facebook");
      return false;
    }
  }

  // reset password (NOT NEEDED?!?)
  Future sendPasswordResetEmail(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }
}
