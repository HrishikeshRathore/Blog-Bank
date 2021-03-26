import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier {

  String error;

  FirebaseAuth auth = FirebaseAuth.instance;

  static String userName;

  Future<void> registerWithEmailAndPassword(String name, String email, String password) async{
    try {
      userName = name;
      var value = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );
      value.user.updateProfile(displayName: name);

    } on FirebaseAuthException catch (e) {
      handleError(e);
    } catch (e) {
      print(e);
    }
  }



  Future<void> signInWithEmailAndPassword(String email, String password) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
      );
    } on FirebaseAuthException catch (e) {
        handleError(e);
    }
  }

  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }

  void handleError(var e) {
    if (e.code == 'weak-password') {
      error = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      error = 'The account already exists for that email.';
    } else if (e.code == 'user-not-found') {
      error = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      error = 'Wrong password provided for that user.';
    } else if (e.code == 'invalid-email') {
      error = 'Invalid email';
    } else if (e.code == 'invalid-password') {
      error = 'Invalid password';
    } else {
      error = 'Something went Wrong';
    }
    notifyListeners();
  }
}