import 'package:brew_crew_coffee/models/brew_model.dart';
import 'package:brew_crew_coffee/screen_widgets/home/brew_list.dart';
import 'package:brew_crew_coffee/screen_widgets/home/settings_form.dart';
import 'package:brew_crew_coffee/services/auth.dart';
import 'package:brew_crew_coffee/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  var coffee = Color.fromRGBO(122, 100, 85, 1);

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0)),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
            child: SingleChildScrollView(
              child: SettingForm(),
            ),
          );
        },
      );
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: coffee,
        appBar: AppBar(
          backgroundColor: coffee,
          title: Text('Brew Crew'),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _showSettingsPanel();
              },
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'LogOut',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login_coffee.jpg'),
              fit: BoxFit.cover
            )
          ),
            child: BrewList()
        ),
      ),
    );
  }
}
