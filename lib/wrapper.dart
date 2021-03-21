import 'package:blog_bank/screens/auth_screen.dart';
import 'package:blog_bank/screens/home_screen.dart';
import 'package:blog_bank/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<AuthService>(context, listen: false).auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData ? HomeScreen() : AuthScreen();
      },
    );
  }
}
