import 'package:brew_crew_coffee/services/auth.dart';
import 'package:brew_crew_coffee/shared/constants.dart';
import 'package:brew_crew_coffee/shared/loading_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  Function toggleView;

  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var coffee = Color.fromRGBO(122, 100, 85, 1);
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

//TextField state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen()
        : Scaffold(
            backgroundColor: Colors.white70,
            appBar: AppBar(
              title: Text('Sign Up Brew Crew'),
              backgroundColor: coffee,
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (value) =>
                                  value.isEmpty ? 'Email reqiured!' : null,
                              onChanged: (value) {
                                setState(() => email = value);
                              },
                              decoration: textInputDecoration.copyWith(
                                  labelText: 'Email'),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (value) =>
                                  value.isEmpty ? 'Password required!' : null,
                              onChanged: (value) {
                                setState(() => password = value);
                              },
                              decoration: textInputDecoration.copyWith(
                                  labelText: 'Password'),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            RaisedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth.signUpWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      error = 'Failed to register';
                                      loading = false;
                                    });
                                  }
                                }
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: coffee,
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            Text(
                              error,
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
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
