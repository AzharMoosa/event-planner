import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:event_planner/events/event_info_screen.dart';
import 'package:event_planner/events/notifications_screen.dart';
import 'package:event_planner/models/events_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_planner/assets/constants.dart' as Constants;
import 'package:http/http.dart' as http;

class EventsScreenWidget extends StatefulWidget {
  const EventsScreenWidget({Key? key}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

Future<EventsList?> _getEvents() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? "";
  final response = await http.get(
    Uri.parse(Constants.API_URL_GET_EVENTS),
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

final spinkit = SpinKitThreeBounce(color: Constants.BLACK);

class _EventsScreenState extends State<EventsScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      margin: const EdgeInsets.only(
        top: 30,
        left: 40,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'My Events',
                style: TextStyle(
                    color: Constants.BLACK,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 100),
                  child: IconButton(
                    icon: new Icon(Icons.notifications),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NotificationsScreenWidget()));
                    },
                  ))
            ],
          ),
          FutureBuilder<EventsList?>(
              future: _getEvents(),
              builder:
                  (BuildContext context, AsyncSnapshot<EventsList?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      margin: const EdgeInsets.only(top: 200), child: spinkit);
                } else {
                  if (snapshot.hasError)
                    return Center(child: Text('Error: ${snapshot.error}'));
                  else {
                    return SingleChildScrollView(
                        child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: snapshot.data!.events.length == 0
                                ? Column(children: [
                                    Row(
                                      children: [
                                        Text(
                                          'No Events Found',
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
                                              margin: const EdgeInsets.only(
                                                  top: 20),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Constants
                                                              .SECONDARY,
                                                          onPrimary:
                                                              Constants.LIGHT,
                                                          minimumSize:
                                                              Size(316, 40),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                          )),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EventInfoScreenWidget(
                                                                    event:
                                                                        event)));
                                                  },
                                                  child: Container(
                                                      child: Row(children: [
                                                    Text(event.name),
                                                  ])))),
                                        ],
                                      ),
                                  ])));
                  }
                }
              })
        ],
      ),
    )));
  }
}
