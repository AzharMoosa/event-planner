import 'package:flutter/material.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<NotificationsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff222831),
        title: Text('Notifications',
            style: TextStyle(
                color: Color(0xffeeeeee),
                fontSize: 21,
                fontWeight: FontWeight.w700)),
      ),
      body: Text('Notifications'),
    );
  }
}
