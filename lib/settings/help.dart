import 'package:flutter/material.dart';
import 'package:going_out_planner/assets/constants.dart' as Constants;

class HelpWidget extends StatefulWidget {
  const HelpWidget({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<HelpWidget> {
  TextEditingController bodyController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.BLACK,
        title: Text('Help',
            style: TextStyle(
                color: Constants.LIGHT,
                fontSize: 21,
                fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.only(top: 30, left: 50, right: 50),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(
                          'Help',
                          style: TextStyle(
                              color: Constants.BLACK,
                              fontSize: 30,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: Text(
                            'Feel Free To Contact Us At event.planner.app.contact@gmail.com',
                            style: TextStyle(
                                color: Constants.BLACK,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ])))),
    );
  }
}
