import 'package:flutter/material.dart';
import 'package:going_out_planner/admin/admin_places_info.dart';
import 'package:going_out_planner/admin/admin_settings.dart';
import 'package:going_out_planner/admin/admin_user_info.dart';

class AdminPageWidget extends StatefulWidget {
  const AdminPageWidget({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPageWidget> {
  int selectedIndex = 0;
  bool userInfoPage = true;
  bool placesInfoPage = false;
  bool adminSettingsPage = false;

  static const List<Widget> _widgetOptions = <Widget>[
    AdminUserInfoWidget(),
    AdminPlaceInfoWidget(),
    AdminSettingsWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _resetSelectedItem() {
    setState(() {
      userInfoPage = false;
      placesInfoPage = false;
      adminSettingsPage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff222831),
          title: Text('Admin Page',
              style: TextStyle(
                  color: Color(0xffeeeeee),
                  fontSize: 21,
                  fontWeight: FontWeight.w700)),
        ),
        body: SafeArea(
            child: Container(child: _widgetOptions.elementAt(selectedIndex))),
        bottomNavigationBar: BottomAppBar(
            color: Color(0xff222831),
            child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.person,
                        color: userInfoPage
                            ? Color(0xfff67280)
                            : Color(0xffEEEEEE),
                      ),
                      onPressed: () {
                        _resetSelectedItem();
                        userInfoPage = true;
                        _onItemTapped(0);
                      },
                    ),
                    Container(
                        child: IconButton(
                      icon: Icon(
                        Icons.place,
                        color: placesInfoPage
                            ? Color(0xfff67280)
                            : Color(0xffEEEEEE),
                      ),
                      onPressed: () {
                        _resetSelectedItem();
                        placesInfoPage = true;
                        _onItemTapped(1);
                      },
                    )),
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: adminSettingsPage
                            ? Color(0xfff67280)
                            : Color(0xffEEEEEE),
                      ),
                      onPressed: () {
                        _resetSelectedItem();
                        adminSettingsPage = true;
                        _onItemTapped(2);
                      },
                    ),
                  ],
                ))));
  }
}
