import 'package:flutter/material.dart';
import 'package:going_out_planner/main_menu/main_menu.dart';
import './welcome_screen/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  print(token);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MaterialApp(
      title: 'Going Out Planner',
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffEEEEEE), fontFamily: 'Montserrat'),
      home: token == null ? WelcomeScreen() : MainMenuWidget()));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    return token != "";
  }

  bool logged = false;

  void initState() async {
    logged = await isLoggedIn();
    print(logged);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Going Out Planner',
        theme: ThemeData(
            scaffoldBackgroundColor: Color(0xffEEEEEE),
            fontFamily: 'Montserrat'),
        home: !logged ? WelcomeScreen() : MainMenuWidget());
  }
}
