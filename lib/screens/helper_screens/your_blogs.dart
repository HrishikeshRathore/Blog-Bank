import 'package:blog_bank/services/blog_database.dart';
import 'package:blog_bank/widgets/your_blog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourBlogs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder (
        future: Provider.of<BlogDatabase>(context, listen: false).getParticularUserData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting ?
              Center(child: CircularProgressIndicator(),) :
              Consumer<BlogDatabase> (
                builder: (BuildContext context, value, Widget child) {
                  return value.particularUserList.isEmpty ?
                  Center(child: Flexible(child: Text('No blog added by you Yet...')),):
                  ListView.builder(
                    itemCount: value.particularUserList.length,
                    itemBuilder: (ctx, i) => YourBlogWidget(
                      id: value.particularUserList[i].id,
                      title: value.particularUserList[i].title,
                      image: value.particularUserList[i].imageUrl,
                      topic: value.particularUserList[i].topic,
                    )
                  );
                },
              );
        },
      ),
    );
  }
}
