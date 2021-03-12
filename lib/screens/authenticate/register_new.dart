import 'package:blog_bank/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  String error = '';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();

    final _formKey = GlobalKey<FormState>();

    //text field state
    String email = '';
    String password = '';

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        title: Text('Sign up to Blog Bank'),
        actions: [
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Sign in'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (val) =>
                    val.isEmpty ? 'Email can not be Empty' : null,
                onChanged: (val) {
                  // setState(() {
                  //   email = val;
                  // });
                  email = val;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (val) => val.length < 6
                    ? 'Password must be of at least 6 digits'
                    : null,
                obscureText: true,
                onChanged: (val) {
                  // setState(() {
                  //   password = val;
                  // });
                  password = val;
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                  color: Colors.redAccent,
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          widget.error = 'Invalid Email Entered!';
                        });
                        print(widget.error);
                      }
                    }
                  }),
              SizedBox(height: 12,),
              Text(
                widget.error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
