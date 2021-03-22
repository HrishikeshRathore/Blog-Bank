import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {

  static const routeName = '/aboutUs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.green[300],
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('About us',
          style: TextStyle(
            color: Colors.green[300],
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 4,
        backgroundColor: Colors.white,
      ),
      body: Center(child: Text(
        'hello'
      ),),
    );
  }
}
