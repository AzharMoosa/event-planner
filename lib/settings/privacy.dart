import 'package:flutter/material.dart';

class PrivacyWidget extends StatefulWidget {
  const PrivacyWidget({Key? key}) : super(key: key);

  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<PrivacyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff222831),
        title: Text('Privacy',
            style: TextStyle(
                color: Color(0xffeeeeee),
                fontSize: 21,
                fontWeight: FontWeight.w700)),
      ),
      body: Text('Privacy'),
    );
  }
}
