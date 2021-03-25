import 'package:blog_bank/services/blog_database.dart';
import 'package:blog_bank/widgets/home_page_screen.dart';
import 'package:blog_bank/widgets/slider_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
                  child: CircularProgressIndicator(
                    //valueColor: new AlwaysStoppedAnimation<Color>(Colors.green[300]),
                  ),
                )
              : Consumer<BlogDatabase>(
                  builder: (BuildContext context, value, Widget child) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: CarouselSlider.builder(
                              itemCount: value.list.length,
                              itemBuilder: (ctx, i, realIdx) => SliderWidget(
                                userId: value.list[i].userId,
                                title: value.list[i].title,
                                topic: value.list[i].topic,
                                image: value.list[i].imageUrl,
                                content: value.list[i].content,
                                publisher: value.list[i].publisher,
                                date: value.list[i].date,
                              ),
                              options: CarouselOptions(
                                height: MediaQuery.of(context).size.height * .28,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.easeOutCirc,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration: Duration(milliseconds: 1800),
                                viewportFraction: 0.85,
                              ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            elevation: 0,
                            child: ListView.builder(
                              itemCount: value.list.length,
                              itemBuilder: (ctx, i) => HomePageScreen(
                                userId: value.list[i].userId,
                                title: value.list[i].title,
                                topic: value.list[i].topic,
                                image: value.list[i].imageUrl,
                                content: value.list[i].content,
                                publisher: value.list[i].publisher,
                                date: value.list[i].date,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
