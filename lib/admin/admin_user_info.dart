import 'package:flutter/material.dart';

class AdminUserInfoWidget extends StatefulWidget {
  const AdminUserInfoWidget({Key? key}) : super(key: key);

  @override
  _AdminUserInfoState createState() => _AdminUserInfoState();
}

class _AdminUserInfoState extends State<AdminUserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Admin User Info'),
    );
  }
}
