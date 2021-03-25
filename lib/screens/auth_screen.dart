import 'package:blog_bank/models/user_model.dart';
import 'package:blog_bank/services/auth_service.dart';
import 'package:blog_bank/services/user_profile.dart';
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
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                height: MediaQuery.of(context).size.height * .75,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.greenAccent[100],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Text(
                      providerCall.error == null ? '' : providerCall.error,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    isLogin ? SizedBox() : TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                      controller: name,
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Email',
                      ),
                      controller: email,
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.green)
                        ),
                        labelText: 'User Password',
                      ),
                      controller: password,
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 50,
                        child: Text(isLogin ? 'Sign In' : 'Register',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green[800],
                            width: 3,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                      ),
                      onTap: () async{
                          if(isLogin == true){
                            await providerCall.signInWithEmailAndPassword(email.text, password.text);
                          }
                          else{
                            await providerCall.registerWithEmailAndPassword(name.text, email.text, password.text);
                            await Provider.of<UserProfileProvider>(context,listen: false).addUser(UserModel(
                              userId: providerCall.auth.currentUser.uid,
                              userName: AuthService.userName,
                              userInfo: '',
                            ));
                          }
                      },
                    ),
                    SizedBox(height: 30,),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(isLogin ? 'Create an Account' : 'Already have an Account',
                        style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

