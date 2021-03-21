import 'package:blog_bank/models/blog_model.dart';
import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {

  static const routeName = '/description-screen';


  @override
  Widget build(BuildContext context) {

    final BlogModel args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  child: Image.network(args.imageUrl == null ? '' : args.imageUrl, fit: BoxFit.cover),
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  left: 5,
                  top: 30,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Positioned(
                  left: 5,
                  bottom: 10,
                  child: Text(
                    args.title == null ? '' : args.title,
                    style: TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.black38,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 30,
                  child: Text(
                    args.topic == null ? '' :args.topic,
                    style: TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.black38,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              top: 15
            ),
            child: Text(
              'Published by Hrishikesh',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  args.content == null ? 'Not Available' : args.content ,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
