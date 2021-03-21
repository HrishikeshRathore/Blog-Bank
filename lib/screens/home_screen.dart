import 'file:///C:/flutter_projects/Blog-Bank/lib/screens/helper_screens/home_page.dart';
import 'package:blog_bank/helper/HomepageList.dart';
import 'package:blog_bank/screens/helper_screens/create_blog.dart';
import 'package:blog_bank/screens/helper_screens/your_blogs.dart';
import 'package:blog_bank/services/auth_service.dart';
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
    Text(
      'Index 2: School',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {

    String appBarIndex;

    if(_selectedIndex == 0){
      appBarIndex = 'Your Blogs';
    }
    if(_selectedIndex == 1){
      appBarIndex = 'BlogBank';
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
            color: _selectedIndex == 1 ? Colors.green[400] : Colors.black ,
            fontWeight: _selectedIndex == 1 ? FontWeight.w900 : FontWeight.w600,
            fontSize: _selectedIndex == 1 ? 28 : 20,
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
          // FlatButton.icon(
          //   onPressed: () {
          //     Provider.of<AuthService>(context, listen: false).signOut();
          //   },
          //   icon: Icon(Icons.person),
          //   label: Text('Sign Out'),
          // ),
          // IconButton(icon: Icon(Icons.add), onPressed: (){
          //   Navigator.of(context).pushNamed(AddDataScreen.routeName);
          // }
          // ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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

      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

    );
  }
}

