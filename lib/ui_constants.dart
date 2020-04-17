import 'package:flutter/material.dart';

final String mainFontFamily = 'Consolas';

final TextStyle bodyText = TextStyle(fontFamily: mainFontFamily, fontSize: 18.0);
final TextStyle headerText = TextStyle(fontFamily: mainFontFamily, fontSize: 32.0);
final TextStyle headlineText = TextStyle(fontFamily: mainFontFamily, fontSize: 72.0);
final TextStyle errorTextStyle = TextStyle(fontFamily: mainFontFamily, fontSize: 18.0, color: Colors.red[900]);

final TextTheme mainTextTheme = TextTheme(
  headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, fontFamily: mainFontFamily),
  headline6: TextStyle(fontSize: 32.0, fontFamily: mainFontFamily, color: Colors.white70),
  bodyText2: TextStyle(fontSize: 14.0, fontFamily: mainFontFamily),
);

final ThemeData mainTheme =  ThemeData(
          // Define the default brightness and colors.
       //   brightness: Brightness.light,
          primaryColor: Colors.black,
          accentColor: Colors.grey,
          backgroundColor: Colors.grey,
          canvasColor: Colors.white,

          // Define the default font family.
          fontFamily: mainFontFamily,

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: mainTextTheme
        );


class NodePaintProperty{
  static const Color circleFill = Colors.white;
  static const double strokeWidth = 5.0;
  static const Color lineColor = Colors.grey;
}
