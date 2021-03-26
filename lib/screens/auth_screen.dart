import 'package:animated_text/animated_text.dart';
import 'package:blog_bank/models/user_model.dart';
import 'package:blog_bank/services/auth_service.dart';
import 'package:blog_bank/services/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var providerCall = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Colors.green[200],
                height: MediaQuery.of(context).size.height * .35,
                padding: EdgeInsets.only(
                  top: 60
                ),
                child: AnimatedText(
                  alignment: Alignment.topCenter,
                  speed: Duration(milliseconds: 1000),
                  controller: AnimatedTextController.loop,
                  displayTime: Duration(milliseconds: 1000),
                  wordList: ['Welcome.', 'to the.', 'Pen It!'],
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: 10,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: FlatButton(
                    onPressed: () {
                      providerCall.error = '';
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(
                      isLogin ? 'Create an Account' : 'Already have an Account',
                      style: TextStyle(
                        color: Colors.green[300],
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              elevation: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height * .5,
                width: MediaQuery.of(context).size.width * .8,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(22),
                            topLeft: Radius.circular(22),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              isLogin ? 'Sign In' : "Sign Up",
                              style: TextStyle(
                                color: Colors.green[300],
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cursive',
                              ),
                            ),

                            isLogin
                                ? SizedBox()
                                : TextField(
                                    textCapitalization: TextCapitalization.words,
                                    decoration: InputDecoration(
                                      hintText: 'User Name',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: Colors.green[200],
                                          ),
                                      ),
                                    ),
                                    controller: name,
                                  ),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Email Address',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.green[200],
                                  ),
                                ),
                              ),
                              controller: email,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: isLogin ? 'Password' : 'Create Password',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.green[200],
                                  ),
                                ),
                              ),
                              controller: password,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Consumer<AuthService>(
                              builder: (BuildContext context, value, Widget child) {
                                return Text(
                                  value.error == null
                                      ? ''
                                      : value.error,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        providerCall.error = '';
                        if (isLogin == true) {
                          await providerCall.signInWithEmailAndPassword(
                              email.text, password.text);
                        } else {
                          await providerCall.registerWithEmailAndPassword(
                              name.text, email.text, password.text);
                          await Provider.of<UserProfileProvider>(context,
                                  listen: false)
                              .addUser(UserModel(
                            userId: providerCall.auth.currentUser.uid,
                            userName: AuthService.userName,
                            userInfo: '',
                          ));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(22),
                            bottomLeft: Radius.circular(22),
                          ),
                          color: Colors.green[200],
                        ),
                        width: double.infinity,
                        height: 50,
                        child: Text(
                          isLogin ? 'Sign In' : 'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
