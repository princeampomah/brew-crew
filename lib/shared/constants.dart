import 'package:flutter/material.dart';

const coffee = Color.fromRGBO(122, 100, 85, 1);

const textInputDecoration = InputDecoration(
    labelStyle: TextStyle(color: Colors.white),
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: coffee)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2.0))
);
