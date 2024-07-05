import 'package:flutter/material.dart';

AppBar customAppBar() {
  return AppBar(
    title: const Text(
      "TaskMate", 
      style: TextStyle(
        color: Colors.black,
        fontFamily: "Raleway",
        fontWeight: FontWeight.bold,
        ), ),
    
    centerTitle: true,
    backgroundColor: Color.fromARGB(255, 6, 206, 241),
  );
}