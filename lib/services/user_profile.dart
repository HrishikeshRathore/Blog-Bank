import 'package:blog_bank/models/user_model.dart';
import 'package:blog_bank/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProfileProvider with ChangeNotifier {

  UserModel userData;

  UserModel particularUserData;

  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference user = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserModel userModel) async {
    // Call the user's CollectionReference to add a new user
    await user.doc(userModel.userId).set(
        userModel.toMap()
    );
  }

  Future<void> updateUser(UserModel userModel) async {
    // Call the user's CollectionReference to add a new user
    await user.doc(userModel.userId).update(
        userModel.toMap()
    );
  }

  Future<void> getUserData() async {
    DocumentSnapshot documentSnapshot =
        await user
        .doc(auth.currentUser.uid)
        .get();
    print(documentSnapshot.data());
    userData = Utils.toUserModel(
      documentSnapshot.data()
    );
    notifyListeners();
  }

  Future<void> getUserDataById(String id) async {
    DocumentSnapshot documentSnapshot =
    await user
        .doc(id)
        .get();
    print(documentSnapshot.data());
    particularUserData = Utils.toUserModel(
        documentSnapshot.data()
    );
    notifyListeners();
  }

}