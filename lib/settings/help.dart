import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:event_planner/assets/constants.dart' as Constants;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:event_planner/main_menu/main_menu.dart';

class HelpWidget extends StatefulWidget {
  const HelpWidget({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

Future<Null> sendEmail(String body) async {
  final Email email = Email(
    body: body,
    subject: 'Bug',
    recipients: ['event.planner.app.contact@gmail.com'],
    isHTML: false,
  );

  await FlutterEmailSender.send(email);
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
                              color: Color(0xff222831),
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
                            'Contact Us',
                            style: TextStyle(
                                color: Color(0xff222831),
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.only(
                            top: 30,
                          ),
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1000),
                            ],
                            style: TextStyle(fontSize: 18),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: bodyController,
                            decoration: InputDecoration(
                                labelText: "Body",
                                fillColor: Color(0xFFD4D4D4),
                                filled: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: TextStyle(fontSize: 18),
                                prefixStyle: TextStyle(fontSize: 50),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Body Text';
                              }
                              return null;
                            },
                          ),
                        ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 30.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                String body = bodyController.text;
                                await sendEmail(body);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MainMenuWidget()));
                              },
                              child: Text(
                                'Send Message'.toUpperCase(),
                                style: TextStyle(
                                    fontFamily: 'Montserrat', fontSize: 16),
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
                    ),
                  ])))),
    );
  }
}
