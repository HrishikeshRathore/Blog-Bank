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
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    child: Image(image: AssetImage('assets/images/Logo.png'),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * .3,
                    ),
                  ),
                  SizedBox(height: 6,),
                  Text('Pen It!',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Made with ', style: TextStyle(
                  color: Colors.green[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),),
                Icon(Icons.favorite,
                  color: Colors.redAccent,
                  size: 25,
                ),
                Text(' by Hrishikesh',
                  style: TextStyle(
                    color: Colors.green[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
