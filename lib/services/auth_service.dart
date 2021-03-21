import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier {

  String error;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> registerWithEmailAndPassword(String name, String email, String password) async{
    error = null;
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );
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
    } else {
      error = 'Something went Wrong';
    }
  }
}