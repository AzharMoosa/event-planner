import 'package:flutter/material.dart';
import 'package:event_planner/main_menu/main_menu.dart';
import './welcome_screen/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:event_planner/assets/constants.dart' as Constants;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MaterialApp(
      title: 'Event Planner',
      theme: ThemeData(
          scaffoldBackgroundColor: Constants.LIGHT, fontFamily: 'Montserrat'),
      home: token == null ? WelcomeScreen() : MainMenuWidget()));
}
