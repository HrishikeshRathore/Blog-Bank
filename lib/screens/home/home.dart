import 'package:blog_bank/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();

    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text('Blog Bank'),
        elevation: 0.0,
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async{
              await _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}