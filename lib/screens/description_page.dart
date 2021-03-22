import 'package:blog_bank/models/blog_model.dart';
import 'package:flutter/cupertino.dart';
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
                  right: 0,
                  bottom: 15,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      args.topic == null ? '' :args.topic,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
           Container(
             width: double.infinity,
             alignment: Alignment.center,
             padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20,),
             child: Text(
                  args.title,
                  style: TextStyle(
                    color: Colors.green[400],
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
              ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 15,
                    top: 5
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

              Padding(
                padding: const EdgeInsets.only(
                    right: 15,
                    top: 5
                ),
                child: Text(
                  '12/10/2020',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(height: 20,),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: RichText(
                  text: TextSpan(style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: args.content[0],
                      style:  TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                      ).copyWith(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                    TextSpan(text: args.content.substring(1)),
                ]),
              ),
            ),
          ),
          ),

        ],
      ),
    );
  }
}


// Text(
//   args.content == null ? 'Not Available' : args.content ,
//   textAlign: TextAlign.justify,
//   style: TextStyle(
//     color: Colors.black,
//     fontSize: 15,
//     fontWeight: FontWeight.w500,
//     letterSpacing: .8,
//   ),
// ),