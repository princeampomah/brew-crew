import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget  {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      child: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 50.0,
          controller: AnimationController(vsync: this, duration: const Duration(seconds: 1)),

        ),
      ),
    );
  }
}
