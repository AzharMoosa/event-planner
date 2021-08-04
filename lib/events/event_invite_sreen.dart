import 'dart:io';

import 'package:flutter/material.dart';
import 'package:going_out_planner/models/event_model.dart';
import 'package:going_out_planner/models/events_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:going_out_planner/assets/constants.dart' as Constants;
import 'package:http/http.dart' as http;

class EventInviteScreenWidget extends StatefulWidget {
  final Event event;

  const EventInviteScreenWidget({Key? key, required this.event})
      : super(key: key);

  @override
  _EventInviteScreenState createState() => _EventInviteScreenState(event);
}

Future<EventModel?> _acceptInvite(String id) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? "";
  final response = await http.post(
    Uri.parse(Constants.API_URL_ACCEPT_INVITE + "/$id/invite/accept"),
    headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
  );
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return eventFromJson(responseString);
  } else {
    return null;
  }
}

Future<EventModel?> _declineInvite(String id) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? "";
  final response = await http.post(
    Uri.parse(Constants.API_URL_ACCEPT_INVITE + "/$id/invite/decline"),
    headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
  );
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return eventFromJson(responseString);
  } else {
    return null;
  }
}

class _EventInviteScreenState extends State<EventInviteScreenWidget> {
  Event eventInfo;
  _EventInviteScreenState(this.eventInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff222831),
        title: Text('Event Info',
            style: TextStyle(
                color: Color(0xffeeeeee),
                fontSize: 21,
                fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.only(top: 30, left: 50, right: 50, bottom: 30),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Event Name',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    '${widget.event.name}',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Event Description',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    )),
              ],
            ),
            Row(
              children: [
                Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      '${widget.event.description}',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Event Date',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    )),
              ],
            ),
            Row(
              children: [
                Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      widget.event.date,
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Event Location',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    )),
              ],
            ),
            Row(
              children: [
                Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      '${widget.event.location.address}',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
            Row(
              children: [
                Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      '${widget.event.location.postalCode}',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
            Row(
              children: [
                Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      '${widget.event.location.city}',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
            Row(
              children: [
                Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      '${widget.event.location.country}',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Limit',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    )),
              ],
            ),
            Row(
              children: [
                Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      '${widget.event.limit == null ? 'No Limit' : widget.event.limit}',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Accept/Decline Invite',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    )),
              ],
            ),
            Row(
              children: [
                Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        _acceptInvite(eventInfo.id);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Accept'.toUpperCase(),
                        style:
                            TextStyle(fontFamily: 'Montserrat', fontSize: 16),
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
            Row(
              children: [
                Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        _declineInvite(eventInfo.id);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Decline'.toUpperCase(),
                        style:
                            TextStyle(fontFamily: 'Montserrat', fontSize: 16),
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
            ),
          ],
        ),
      )),
    );
  }
}
