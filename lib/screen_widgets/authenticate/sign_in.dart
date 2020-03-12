import 'package:brew_crew_coffee/services/auth.dart';
import 'package:brew_crew_coffee/shared/constants.dart';
import 'package:brew_crew_coffee/shared/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  Function toogleView;
  SignIn({this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var coffee = Color.fromRGBO(122, 100, 85, 1);

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  bool _isHidden = true;

 //TextField state 
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading? LoadingScreen() : Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text('Sign In Brew Crew'),
        backgroundColor: coffee,
        elevation: 0.0,
        actions: <Widget>[
            FlatButton.icon(
              onPressed: (){
                widget.toogleView();
              },
              icon: Icon(Icons.person, color: Colors.white,), 
              label: Text('Sign Up', style: TextStyle(
               color: Colors.white,
             ),
             ),
             )
          ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (value) => value.isEmpty? 'Email required!' : null,
                        onChanged: (value) {
                          setState(() => email = value);
                        },
                        keyboardType: TextInputType.emailAddress ,
                        decoration: textInputDecoration.copyWith(labelText: 'Email'),
                      ),
                      SizedBox(height: 15.0,),
                      TextFormField(
                        validator: (value) => value.isEmpty? 'Password required!' : null,
                        obscureText: _isHidden? true : false,
                        onChanged: (value){
                          setState(() => password = value);
                        },
                        decoration: textInputDecoration.copyWith
                          (labelText: 'Password'),
                      ),
                      SizedBox(height: 15.0,),
                      RaisedButton(
                        onPressed: () async{
                          if(_formKey.currentState.validate()){
                            setState(() => loading = true);
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                          if(result == null){
                            setState(() {
                              error = 'Invalid Credentials!';
                              loading = false;
                            });
                          }
                          }
                        },
                        child: Text('Sign In',
                          style: TextStyle(
                              color: Colors.white
                          ),),
                        color: coffee,
                      ),
                      SizedBox(height: 13.0,),
                      Text(error,
                        style: TextStyle(color: Colors.red,),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],

      ),
    );
  }
}
