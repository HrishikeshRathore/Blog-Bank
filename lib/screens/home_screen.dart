import 'file:///C:/flutter_projects/Blog-Bank/lib/screens/helper_screens/HomepageList.dart';
import 'package:blog_bank/screens/about_us_screen.dart';
import 'package:blog_bank/screens/helper_screens/create_blog.dart';
import 'package:blog_bank/screens/helper_screens/profile.dart';
import 'package:blog_bank/screens/helper_screens/your_blogs.dart';
import 'package:blog_bank/services/auth_service.dart';
import 'package:blog_bank/services/user_profile.dart';
import 'package:blog_bank/widgets/network_sensitive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  int _selectedIndex = 1;


  static List<Widget> _widgetOptions = <Widget>[

    YourBlogs(),
    HomepageList(),
    UserProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {

    Provider.of<UserProfileProvider>(context, listen: false).getUserData();

    String appBarIndex;

    if(_selectedIndex == 0){
      appBarIndex = 'Your Blogs';
    }
    if(_selectedIndex == 1){
      appBarIndex = 'Pen It!';
    }
    if(_selectedIndex == 2){
      appBarIndex = 'Your Profile';
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.green[400],
          size: 40,
          opacity: 1
        ),
        backgroundColor: Colors.white,
        title: Text(appBarIndex,
          style: TextStyle(
            color: _selectedIndex == 1 ? Colors.green[300] : Colors.black ,
            fontWeight: _selectedIndex == 1 ? FontWeight.w900 : FontWeight.w600,
            fontSize: _selectedIndex == 1 ? 27 : 20,
          ),
        ),
        actions: [
          if(_selectedIndex == 0)
            IconButton(
                color: Colors.black,
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(CreateBlog.routeName);
                }
            ),

          if(_selectedIndex == 1)
            IconButton(
                color: Colors.green[300],
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  Navigator.of(context).pushNamed(AboutUs.routeName);
                }
            ),

          if(_selectedIndex == 2)
            FlatButton(
                onPressed: () {
                  Provider.of<AuthService>(context).signOut();
                },
                child: Text('LOGOUT',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600
                  ),
                )),
        ],
      ),
      body: NetworkSensitive(
        child1: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        child2: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/nointernet.gif'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 5,),
              Text(
                'No internet connection.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green[500],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5, horizontal: 10,
                ),
                child: Text(
                  'Please check your internet connection and try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.style),
            label: 'Your Blogs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[400],
        elevation: 20,
        onTap: _onItemTapped,
      ),


    );
  }
}

