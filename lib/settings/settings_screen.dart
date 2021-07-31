import 'package:flutter/material.dart';

class SettingsScreenWidget extends StatefulWidget {
  const SettingsScreenWidget({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Settings Screen'),
    );
  }
}
