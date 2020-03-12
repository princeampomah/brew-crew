import 'package:brew_crew_coffee/screen_widgets/authenticate/authenticate_screen.dart';
import 'package:brew_crew_coffee/screen_widgets/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew_coffee/models/user_model.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context); //provider the stream provider here
    print(user);

    //Either show authenticate or home
    if(user == null){
      return Authenticate();
    }
    else{
      return Home();
    }

  }
}
