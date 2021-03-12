import 'package:blog_bank/models/user.dart';
import 'package:blog_bank/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    //return either authenticate or home widget
    final user = Provider.of<UserModel>(context);
    print(user);

    if(user == null){
      return Authentication();
    }
    else
      return Home();

  }
}