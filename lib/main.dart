import 'package:flutter/material.dart';
import './welcome_screen/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: Color(0xffEEEEEE),
            fontFamily: 'Montserrat'),
        home: WelcomeScreen());
  }
}
