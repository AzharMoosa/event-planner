import 'package:flutter/material.dart';
import '../authentication_screen/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final String _welcomeTitle = 'Welcome To\nNAME';

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
                  _welcomeTitle,
                  style: TextStyle(
                      color: Color(0xff222831),
                      fontSize: 35,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ))
          ],
        ),
        Row(
          children: [
            Container(
                margin: const EdgeInsets.only(
                  top: 70,
                  left: 38,
                ),
                child: Row(children: [
                  Icon(
                    Icons.schedule,
                    size: 80,
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                        left: 30,
                      ),
                      child: Text(
                        'Schedule Meet Ups\n& Events',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff222831)),
                      ))
                ])),
          ],
        ),
        Row(
          children: [
            Container(
                margin: const EdgeInsets.only(
                  top: 70,
                  left: 38,
                ),
                child: Row(children: [
                  Icon(
                    Icons.person,
                    size: 80,
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                        left: 30,
                      ),
                      child: Text(
                        'Send & Receive\nInvites To Various\nEvents',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff222831)),
                      ))
                ])),
          ],
        ),
        Row(
          children: [
            Container(
                margin: const EdgeInsets.only(
                  top: 70,
                  left: 38,
                ),
                child: Row(children: [
                  Icon(
                    Icons.groups,
                    size: 80,
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                        left: 30,
                      ),
                      child: Text(
                        'Easily Plan Group\nMeetups',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff222831)),
                      ))
                ])),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(top: 50.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'Get Started',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xfff67280),
                      onPrimary: Color(0xffEEEEEE),
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
