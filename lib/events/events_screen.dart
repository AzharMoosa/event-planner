import 'package:flutter/material.dart';

class EventsScreenWidget extends StatefulWidget {
  const EventsScreenWidget({Key? key}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Events Screen'),
    );
  }
}
