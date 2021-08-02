import 'package:flutter/material.dart';
import 'package:going_out_planner/settings/about.dart';
import 'package:going_out_planner/settings/help.dart';
import 'package:going_out_planner/settings/manage_events.dart';
import 'package:going_out_planner/settings/manage_search.dart';
import 'package:going_out_planner/settings/notifications.dart';
import 'package:going_out_planner/settings/privacy.dart';
import 'package:going_out_planner/settings/profile_settings.dart';

class SettingsScreenWidget extends StatefulWidget {
  const SettingsScreenWidget({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      margin: const EdgeInsets.only(top: 30, left: 50, right: 50),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Settings',
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
                margin: const EdgeInsets.only(top: 40),
                child: Text(
                  'Account',
                  style: TextStyle(
                      color: Color(0xff222831),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffD4D4D4),
                          onPrimary: Color(0xff222831),
                          minimumSize: Size(316, 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileSettingsWidget()));
                      },
                      child: Container(
                          child: Row(children: [
                        Text('Profile Settings'),
                        SizedBox(width: 160),
                        Icon(Icons.chevron_right),
                      ])))),
            ],
          ),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffD4D4D4),
                          onPrimary: Color(0xff222831),
                          minimumSize: Size(316, 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      onPressed: () {},
                      child: Container(
                          child: Row(children: [
                        Text('Sign Out'),
                        SizedBox(width: 205),
                        Icon(Icons.chevron_right),
                      ])))),
            ],
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: Text(
                  'Preferences',
                  style: TextStyle(
                      color: Color(0xff222831),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffD4D4D4),
                          onPrimary: Color(0xff222831),
                          minimumSize: Size(316, 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManageEventsWidget()));
                      },
                      child: Container(
                          child: Row(children: [
                        Text('Manage Events'),
                        SizedBox(width: 160),
                        Icon(Icons.chevron_right),
                      ])))),
            ],
          ),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffD4D4D4),
                          onPrimary: Color(0xff222831),
                          minimumSize: Size(316, 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManageSearchWidget()));
                      },
                      child: Container(
                          child: Row(children: [
                        Text('Manage Search Results'),
                        SizedBox(width: 103),
                        Icon(Icons.chevron_right),
                      ])))),
            ],
          ),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffD4D4D4),
                          onPrimary: Color(0xff222831),
                          minimumSize: Size(316, 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationsWidget()));
                      },
                      child: Container(
                          child: Row(children: [
                        Text('Notifications'),
                        SizedBox(width: 175),
                        Icon(Icons.chevron_right),
                      ])))),
            ],
          ),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffD4D4D4),
                          onPrimary: Color(0xff222831),
                          minimumSize: Size(316, 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacyWidget()));
                      },
                      child: Container(
                          child: Row(children: [
                        Text('Privacy'),
                        SizedBox(width: 215),
                        Icon(Icons.chevron_right),
                      ])))),
            ],
          ),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffD4D4D4),
                          onPrimary: Color(0xff222831),
                          minimumSize: Size(316, 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutWidget()));
                      },
                      child: Container(
                          child: Row(children: [
                        Text('About'),
                        SizedBox(width: 222),
                        Icon(Icons.chevron_right),
                      ])))),
            ],
          ),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffD4D4D4),
                          onPrimary: Color(0xff222831),
                          minimumSize: Size(316, 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HelpWidget()));
                      },
                      child: Container(
                          child: Row(children: [
                        Text('Help'),
                        SizedBox(width: 230),
                        Icon(Icons.chevron_right),
                      ])))),
            ],
          ),
        ],
      ),
    )));
  }
}
