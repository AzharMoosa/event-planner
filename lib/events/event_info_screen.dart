import 'package:flutter/material.dart';
import 'package:going_out_planner/events/invite_event_screen.dart';
import 'package:going_out_planner/models/events_list_model.dart';

class EventInfoScreenWidget extends StatefulWidget {
  final Event event;

  const EventInfoScreenWidget({Key? key, required this.event})
      : super(key: key);

  @override
  _EventInfoScreenState createState() => _EventInfoScreenState();
}

class _EventInfoScreenState extends State<EventInfoScreenWidget> {
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
                      'Invite Users',
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InviteEventScreenWidget(
                                    event: widget.event)));
                      },
                      child: Text(
                        'Invite'.toUpperCase(),
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
          ],
        ),
      )),
    );
  }
}