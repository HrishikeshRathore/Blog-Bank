import 'file:///C:/flutter_projects/Blog-Bank/lib/screens/helper_screens/HomepageList.dart';
import 'package:blog_bank/screens/about_us_screen.dart';
import 'package:blog_bank/screens/blog_by_user.dart';
import 'package:blog_bank/screens/description_page.dart';
import 'package:blog_bank/screens/helper_screens/create_blog.dart';
import 'package:blog_bank/services/auth_service.dart';
import 'package:blog_bank/services/blog_database.dart';
import 'package:blog_bank/services/user_profile.dart';
import 'package:blog_bank/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
          builder: (ctx) => AuthService(),),
          ChangeNotifierProvider(builder: (ctx) => BlogDatabase()),
          ChangeNotifierProvider(builder: (ctx) => UserProfileProvider()),
        ],
          child: MaterialApp(
              home: Wrapper(),
            theme: ThemeData(accentColor: Colors.green[300]),
            routes: {
                CreateBlog.routeName: (ctx) => CreateBlog(),
                DescriptionPage.routeName: (ctx) => DescriptionPage(),
                HomepageList.routeName: (ctx) => HomepageList(),
                AboutUs.routeName: (ctx) => AboutUs(),
                BlogByUser.routeName: (ctx) => BlogByUser(),
            },
          ),
      );
  }
}
