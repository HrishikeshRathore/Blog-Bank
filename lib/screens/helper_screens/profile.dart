import 'package:blog_bank/models/user_model.dart';
import 'package:blog_bank/services/auth_service.dart';
import 'package:blog_bank/services/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  TextEditingController userName = TextEditingController();
  TextEditingController userInfo = TextEditingController();


  @override
  Widget build(BuildContext context) {


    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Consumer<UserProfileProvider>(
          builder: (BuildContext context, value, Widget child) {
            userName.text = value.userData?.userName;
            userInfo.text = value.userData?.userInfo;
            print(userInfo.text);
            print(value.userData?.userName);
            return Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: userName,
                    textCapitalization: TextCapitalization.words,
                    style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: 'User Name',
                      border: InputBorder.none,
                    ),
                  ),
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: userInfo,
                    maxLines: null,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: 'add some more details',
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        GestureDetector(
          onTap: () async{
            await Provider.of<UserProfileProvider>(context, listen: false).updateUser(UserModel(
              userId: Provider.of<AuthService>(context, listen: false).auth.currentUser.uid,
              userName: userName.text,
              userInfo: userInfo.text,
            ));
            Provider.of<UserProfileProvider>(context, listen: false).getUserData();

            final snackBar = SnackBar(
              padding: EdgeInsets.all(7),
              duration: Duration(seconds: 1),
              content: Text('Profile updated successfully!', textAlign: TextAlign.center, style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),),
              elevation: 10,
            );

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            Scaffold.of(context).showSnackBar(snackBar);
          },
          child: Container(
            width: double.infinity,
            height: 50,
            child: Center(child: Text('Update Profile')),
            color: Colors.green[300],
          ),
        ),
      ],
    );
  }
}
