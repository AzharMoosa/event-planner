import 'dart:io';

import 'package:flutter/material.dart';
import 'package:going_out_planner/main_menu/main_menu.dart';
import 'package:going_out_planner/assets/constants.dart' as Constants;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ManageEventsWidget extends StatefulWidget {
  const ManageEventsWidget({Key? key}) : super(key: key);

  @override
  _ManageEventsState createState() => _ManageEventsState();
}

Future<Null>? _deleteEvents() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? "";

  await http.delete(
    Uri.parse(Constants.API_URL_DELETE_EVENT),
    headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
  );

  return null;
}

class _ManageEventsState extends State<ManageEventsWidget> {
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () async {
        await _deleteEvents();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainMenuWidget()));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Delete My Events"),
      content: Text("Would you like to delete all your events?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.only(top: 30, left: 50, right: 50),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(
                          'Manage Events',
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
                            margin: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xfff67280),
                                    onPrimary: Color(0xffEEEEEE),
                                    minimumSize: Size(316, 35),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    )),
                                onPressed: () {
                                  showAlertDialog(context);
                                },
                                child: Container(
                                    child: Row(children: [
                                  Text('Delete My Events'),
                                ])))),
                      ],
                    ),
                  ])))),
    );
  }
}
