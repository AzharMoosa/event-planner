import 'package:flutter/material.dart';

class ManageSearchWidget extends StatefulWidget {
  const ManageSearchWidget({Key? key}) : super(key: key);

  @override
  _ManageSearchState createState() => _ManageSearchState();
}

class _ManageSearchState extends State<ManageSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff222831),
        title: Text('Manage Search Settings',
            style: TextStyle(
                color: Color(0xffeeeeee),
                fontSize: 21,
                fontWeight: FontWeight.w700)),
      ),
      body: Text('Manage Search Settings'),
    );
  }
}
