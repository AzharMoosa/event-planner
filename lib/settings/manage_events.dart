import 'package:flutter/material.dart';

class ManageEventsWidget extends StatefulWidget {
  const ManageEventsWidget({Key? key}) : super(key: key);

  @override
  _ManageEventsState createState() => _ManageEventsState();
}

class _ManageEventsState extends State<ManageEventsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff222831),
        title: Text('Manage Events',
            style: TextStyle(
                color: Color(0xffeeeeee),
                fontSize: 21,
                fontWeight: FontWeight.w700)),
      ),
      body: Text('Manage Events'),
    );
  }
}
