import 'package:blog_bank/services/blog_database.dart';
import 'package:blog_bank/widgets/slider_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<BlogDatabase>(context, listen: false).getBlogData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Consumer<BlogDatabase>(
              builder: (BuildContext context, value, Widget child) {
            return SingleChildScrollView(
              child: Container(
                     child: CarouselSlider(
                        items: [
                          ListView.builder(
                            itemCount: value.list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SliderWidget(
                                title: value.list[index].title,
                                topic: value.list[index].topic,
                                content: value.list[index].content,
                                image: value.list[index].imageUrl,
                              );
                            },
                          ),
                        ],

                        //Slider Container properties
                        options: CarouselOptions(
                          height: 200.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(milliseconds: 2500),
                          viewportFraction: 0.8,
                        ),
                      ),
              ),
            );
          });
        });
  }
}

//
// FutureBuilder(
// future: Provider.of<DatabaseProvider>(context, listen: false).getData(),
// builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
// return snapshot.connectionState == ConnectionState.waiting ? Center(child: CircularProgressIndicator(),) :
// Consumer<DatabaseProvider> (
// builder: (BuildContext context, value, Widget child) {
// return ListView.builder(
// itemBuilder: (ctx,i) => ListTile(
// title: Text('${value.list[i].name} is aged ${value.list[i].age}'),
// leading: IconButton(
// icon: Icon(Icons.edit),
// onPressed: () {
// Navigator.of(context).pushNamed(AddDataScreen.routeName, arguments: value.list[i]);
// },
// ),
// subtitle: Text(value.list[i].id == null ? 'abcd' : value.list[i].id),
// trailing: IconButton(
// icon: Icon(Icons.delete),
// onPressed: () {
// Provider.of<DatabaseProvider>(context, listen: false).deleteUser(value.list[i].id);
// Provider.of<DatabaseProvider>(context, listen: false).getData();
// },
// ),
// ),
// itemCount: value.list.length,
// );
// },
// );
// },
// );