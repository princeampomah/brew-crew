import 'package:brew_crew_coffee/services/auth.dart';
import 'package:brew_crew_coffee/wrapper/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
         primaryColor: Color.fromRGBO(64, 26, 3, 1),
         accentColor: Color.fromRGBO(122, 100, 85, 1)
        ),
        home: Wrapper(),
      ),
    );
  }
}

