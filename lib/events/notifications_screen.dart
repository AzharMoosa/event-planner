import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:going_out_planner/events/event_invite_sreen.dart';
import 'package:going_out_planner/models/events_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:going_out_planner/assets/constants.dart' as Constants;
import 'package:http/http.dart' as http;

class NotificationsScreenWidget extends StatefulWidget {
  const NotificationsScreenWidget({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

Future<EventsList?> _getInvites() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? "";
  final response = await http.get(
    Uri.parse(Constants.API_URL_GET_USER_INVITES),
    headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return eventsListFromJson(responseString);
  } else {
    return null;
  }
}

class _NotificationsScreenState extends State<NotificationsScreenWidget> {
  final spinkit = SpinKitThreeBounce(color: Color(0xff222831));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff222831),
          title: Text('Events Invite',
              style: TextStyle(
                  color: Color(0xffeeeeee),
                  fontSize: 21,
                  fontWeight: FontWeight.w700)),
        ),
        body: FutureBuilder<EventsList?>(
            future: _getInvites(),
            builder:
                (BuildContext context, AsyncSnapshot<EventsList?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    margin: const EdgeInsets.only(top: 200), child: spinkit);
              } else {
                return SingleChildScrollView(
                    child: Container(
                        margin: const EdgeInsets.only(top: 20, left: 50),
                        child: snapshot.data!.events.length == 0
                            ? Column(children: [
                                Row(
                                  children: [
                                    Text(
                                      'No Invites',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                )
                              ])
                            : Column(children: [
                                for (var event in snapshot.data!.events)
                                  Row(
                                    children: [
                                      Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Color(0xff3F72AF),
                                                  onPrimary: Color(0xffEEEEEE),
                                                  minimumSize: Size(316, 40),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  )),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EventInviteScreenWidget(
                                                                event: event)));
                                              },
                                              child: Container(
                                                  child: Row(children: [
                                                Text(event.name),
                                              ])))),
                                    ],
                                  ),
                              ])));
              }
            }));
  }
}