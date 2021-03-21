import 'package:blog_bank/models/blog_model.dart';
import 'package:blog_bank/screens/description_page.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {

  final String image;
  final String title;
  final String topic;
  final String content;

  SliderWidget({
   this.image,
   this.content,
   this.topic,
   this.title,
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DescriptionPage.routeName, arguments:
          BlogModel(
            title: this.title,
            imageUrl: this.image,
            content: this.content,
            topic: this.topic,
          )
        );
      },
      child: Container(
        height: 200,
        width: double.infinity,
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
                left: 5,
                top: 5,
                child: Text(
                  topic,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )),

            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.only(bottom: 15),
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(8)
                    )
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.white,),
                    onPressed: () {

                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    )
                ),
                height: 40,
                child: Text(title, style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    height: 1
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
