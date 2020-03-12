import 'package:brew_crew_coffee/models/user_model.dart';
import 'package:brew_crew_coffee/services/database.dart';
import 'package:brew_crew_coffee/shared/constants.dart';
import 'package:brew_crew_coffee/shared/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {

  final _formKey = GlobalKey<FormState>();
  List<String> sugars = ['0', '1', '2', '3', '4', '5'];

  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Container(
      child: StreamBuilder(
        stream: DatabaseService(uid: user.uid).userData,
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text('Update Your Brew Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          letterSpacing: 0.5,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: userData.name,
                        validator: (val) => val.isEmpty ? 'Please Enter Name' : null,
                        onChanged: (val) {
                          setState(() {
                            _currentName = val;
                          });
                        },
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.black45),
                            labelText: 'Enter Name',
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: coffee)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: coffee, width: 1.0))
                        ),
                      ),
                      SizedBox(height: 15.0),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder()
                        ),
                        value: _currentSugar ?? userData.sugars,
                        items: sugars.map((sugar) {
                          return DropdownMenuItem(
                              value: sugar,
                              child: Text('$sugar sugar(s)')
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _currentSugar = val;
                          });
                        },
                      ),
                      SizedBox(height: 10.0),
                      Slider(
                        activeColor: Colors.brown[_currentStrength ??
                            userData.strength],
                        inactiveColor: Colors.brown[_currentStrength ??
                            userData.strength],
                        onChanged: (val) =>
                            setState(() {
                              _currentStrength = val.round();
                            }),
                        value: (_currentStrength ?? userData.strength).toDouble(),
                        min: 100.0,
                        max: 900.0,
                        divisions: 8,
                      ),
                      RaisedButton(
                        color: coffee,
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                           await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name,
                             _currentSugar ?? userData.sugars,
                             _currentStrength ?? userData.strength
                           );
                           Navigator.pop(context);
                          }

                        },
                        child: Text('Update',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),),
                      )

                    ],
                  ),
            );
          }
          else {
            LoadingScreen();
          }
        },
      ),
    );
  }
}
