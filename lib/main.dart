import 'package:flutter/material.dart';
import 'home.dart';
import 'ui_constants.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      theme: mainTheme ,
      title: 'Binary Tree Visualizer',
      home: HomePage()
    );
  }
}
