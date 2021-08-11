import 'package:flutter/material.dart';
import '../authentication_screen/login_screen.dart';
import '../assets/constants.dart' as Constants;

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
            child: SafeArea(
                child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(top: 60.0),
                child: Text(
                  Constants.WELCOME_TITLE,
                  style: TextStyle(
                      color: Constants.BLACK,
                      fontSize: 35,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ))
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 60, left: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.schedule,
                size: 80,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Schedule Meet Ups & Events',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Constants.BLACK),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 60, left: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.person,
                size: 80,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Send & Receive Invites To Various\nEvents',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Constants.BLACK),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 60, left: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.person,
                size: 80,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Easily Plan Group Meetups',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Constants.BLACK),
                  ),
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(top: 50.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreenWidget()));
                  },
                  child: Text(
                    'Get Started',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Constants.BUTTON_PRIMARY,
                      onPrimary: Constants.LIGHT,
                      minimumSize: Size(238, 43),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      )),
                ))
          ],
        )
      ],
    ))));
  }
}
