import 'package:blog_bank/services/blog_database.dart';
import 'package:blog_bank/services/user_profile.dart';
import 'package:blog_bank/widgets/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogByUser extends StatelessWidget {
  
  static const routeName = '/blogbyuser';
  
  @override
  Widget build(BuildContext context) {

    final String argum = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(50),
            height: MediaQuery.of(context).size.height * .3,
            child: FutureBuilder(
              future: Provider.of<UserProfileProvider>(context, listen: false).getUserDataById(argum),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return snapshot.connectionState == ConnectionState.waiting ?
                    Center(child: Text('Loading...',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                        fontSize: 20,
                      ),
                    ),) :
                    Consumer<UserProfileProvider>(
                      builder: (BuildContext context, value, Widget child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(value.particularUserData.userName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(value.particularUserData.userInfo,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        );
                    },);
            },),
          ),
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: Provider.of<BlogDatabase>(context,listen: false).getDataOfPaticularUser(argum),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting ?
                      Center(child: CircularProgressIndicator(),) :
                       Consumer<BlogDatabase>(builder: (BuildContext context, value, Widget child) {
                    return ListView.builder(
                      itemCount: value.dataOfParticularUser.length,
                      itemBuilder: (ctx,i) => HomePageScreen(
                        userId: value.dataOfParticularUser[i].userId,
                        title: value.dataOfParticularUser[i].title,
                        date: value.dataOfParticularUser[i].date,
                        publisher: value.dataOfParticularUser[i].publisher,
                        image: value.dataOfParticularUser[i].imageUrl,
                        topic: value.dataOfParticularUser[i].topic,
                        content: value.dataOfParticularUser[i].content,
                      )
                    );
                  },);
              },),
            ),
          ),
        ],
      ),
    );
  }
}
