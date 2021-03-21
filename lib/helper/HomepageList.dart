import 'package:blog_bank/services/blog_database.dart';
import 'package:blog_bank/widgets/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomepageList extends StatelessWidget {

  static const routeName = '/list-of-data';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      color: Colors.white70,
      child: FutureBuilder(
        future: Provider.of<BlogDatabase>(context, listen: false).getBlogData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<BlogDatabase>(
                  builder: (BuildContext context, value, Widget child) {
                    return ListView.builder(
                      itemCount: value.list.length,
                      itemBuilder: (ctx, i) => HomePageScreen(
                        title: value.list[i].title,
                        topic: value.list[i].topic,
                        image: value.list[i].imageUrl,
                        content: value.list[i].content,
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
