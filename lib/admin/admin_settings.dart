import 'package:flutter/material.dart';

class AdminSettingsWidget extends StatefulWidget {
  const AdminSettingsWidget({Key? key}) : super(key: key);

  @override
  _AdminSettingsState createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Admin Settings'),
    );
  }
}
