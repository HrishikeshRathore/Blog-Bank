import 'package:blog_bank/models/blog_model.dart';
import 'package:blog_bank/screens/description_page.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatelessWidget {

  final String image;
  final String title;
  final String topic;
  final String content;

  HomePageScreen({this.topic, this.title, this.image, this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DescriptionPage.routeName, arguments: BlogModel(
          title: title,
          topic: topic,
          imageUrl: image,
          content: content,
        ));
      },
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .2,
        margin: EdgeInsets.all(5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: Image.network(
                  image,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * .35,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 17,),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        topic,
                        style: TextStyle(
                          color: Colors.green[300],
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(
                      height: 0,
                    ),
                    Text(
                      'Publisher: Hrishikesh',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
