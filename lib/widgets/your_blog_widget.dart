import 'package:blog_bank/screens/description_page.dart';
import 'package:blog_bank/screens/helper_screens/create_blog.dart';
import 'package:blog_bank/services/blog_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourBlogWidget extends StatelessWidget {

  final String id;
  final String title;
  final String topic;
  final String image;

  YourBlogWidget({
   this.title,
   this.topic,
   this.image,
   this.id,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .22,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * .35,
                height: double.infinity,
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Flexible(
                    child: Text(topic,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.green[300],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(width: 0,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(Icons.edit_outlined,
                      color: Colors.green[400],
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CreateBlog.routeName, arguments: id);
                    }
                ),
                IconButton(
                    icon: Icon(Icons.delete_forever_sharp,
                      color: Colors.redAccent[400],
                      size: 30,
                    ),
                    onPressed: () {
                      Provider.of<BlogDatabase>(context, listen: false).deleteUser(id);
                      Provider.of<BlogDatabase>(context, listen: false).getParticularUserData();
                    }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
