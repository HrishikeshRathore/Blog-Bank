import 'package:blog_bank/models/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class BlogDatabase with ChangeNotifier{

  List<BlogModel> list = [];

  List<BlogModel> particularUserList = [];

  List<BlogModel> dataOfParticularUser = [];

  static String currentUser;

  CollectionReference blog = FirebaseFirestore.instance.collection('blogs');
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addBlog(String title, String topic, String content, String url, String publisher, String date) {
    // Call the user's CollectionReference to add a new user
    return blog
        .add({
      'userId' : auth.currentUser.uid,
      'title': title,
      'topic': topic,
      'content': content,
      'url': url,
      'publisher': publisher,
      'date': date,
    })
        .then((value) => print("Blog Added"))
        .catchError((error) => print("Failed to add blog: $error"));
  }

  Future<void> getBlogData() async{

    print('data added');
    List<BlogModel> tempDataList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('blogs')
        .get();
      querySnapshot.docs.forEach((doc) {
        tempDataList.add(BlogModel (
          userId: doc['userId'],
          id: doc.id,
          title: doc['title'],
          topic: doc['topic'],
          content: doc['content'],
          imageUrl: doc['url'],
          date: doc['date'],
          publisher: doc['publisher'],
        ));
      });
      list = tempDataList;
    notifyListeners();
  }


  Future<void> getParticularUserData() async{
    await getBlogData();
    print('particularUserList.length');
    List<BlogModel> tempList = [];
    list.forEach((element) {
      if(element.userId == auth.currentUser.uid)
        tempList.add(BlogModel(
          userId: element.userId,
          id: element.id,
          title: element.title,
          topic: element.topic,
          content: element.content,
          imageUrl: element.imageUrl,
        ));
    });
    particularUserList = tempList;
    print(particularUserList.length);
  }

  //users data on new page by id**************************************

  Future<void> getDataOfPaticularUser(String id) async{
    await getBlogData();

    List<BlogModel> tempList = [];
    list.forEach((element) {
      if(element.userId == id)
        tempList.add(BlogModel(
          userId: element.userId,
          id: element.id,
          title: element.title,
          topic: element.topic,
          content: element.content,
          imageUrl: element.imageUrl,
          date: element.date,
          publisher: element.publisher,
        ));
    });
    dataOfParticularUser = tempList;
    print('size: ${dataOfParticularUser.length}');
  }

  //*****************************************************************

  Future<void> deleteUser(String id) {
    return blog
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> updateBlog(String id, String title, String topic, String content, String url) {
    return blog
        .doc(id)
        .update({
      'title': title,
      'topic': topic,
      'content': content,
      'url': url,
    })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

 BlogModel findById(String id) {
    getBlogData();
    return list.firstWhere((element) => element.id == id);
  }

}