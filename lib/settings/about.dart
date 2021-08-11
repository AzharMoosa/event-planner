import 'package:flutter/material.dart';
import 'package:going_out_planner/assets/constants.dart' as Constants;

class AboutWidget extends StatefulWidget {
  const AboutWidget({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<AboutWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.BLACK,
          title: Text('About',
              style: TextStyle(
                  color: Constants.LIGHT,
                  fontSize: 21,
                  fontWeight: FontWeight.w700)),
        ),
        body: SafeArea(
          child: Container(
              margin: const EdgeInsets.only(top: 30, left: 40, right: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                          child: new Text(
                        Constants.ABOUT,
                        style: TextStyle(
                            fontSize: 20,
                            color: Constants.BLACK,
                            height: 1.5,
                            fontWeight: FontWeight.w500),
                      ))
                    ],
                  )
                ],
              )),
        ));
  }
}
