import 'package:brew_crew_coffee/models/brew_model.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {

final Brew brew;
BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0 , horizontal: 8.0),
      child: Card(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugar} sugar(s)'),
        ),
      ),
    );
  }
}