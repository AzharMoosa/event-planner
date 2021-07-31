import 'package:flutter/material.dart';
import 'package:going_out_planner/authentication_screen/login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: const EdgeInsets.only(top: 50.0),
            child: ElevatedButton(
              onPressed: () {
                // Check If Valid
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text(
                'Back',
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff3F72AF),
                  onPrimary: Color(0xffEEEEEE),
                  minimumSize: Size(238, 43),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  )),
            ))
      ],
    )));
  }
}
