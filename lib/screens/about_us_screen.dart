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
      body: Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Made with ', style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),),
          Icon(Icons.favorite,
            color: Colors.redAccent,
            size: 25,
          ),
          Text(' by Hrishikesh',
            style: TextStyle(
              color: Colors.green[900],
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      )),
    );
  }
}
