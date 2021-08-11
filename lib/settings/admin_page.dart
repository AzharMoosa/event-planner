import 'package:flutter/material.dart';
import 'package:event_planner/admin/admin_places_info.dart';
import 'package:event_planner/admin/admin_user_info.dart';
import 'package:event_planner/assets/constants.dart' as Constants;

class AdminPageWidget extends StatefulWidget {
  const AdminPageWidget({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPageWidget> {
  int selectedIndex = 0;
  bool userInfoPage = true;
  bool placesInfoPage = false;

  static const List<Widget> _widgetOptions = <Widget>[
    AdminUserInfoWidget(),
    AdminPlaceInfoWidget(),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.BLACK,
          title: Text('Admin Page',
              style: TextStyle(
                  color: Constants.LIGHT,
                  fontSize: 21,
                  fontWeight: FontWeight.w700)),
        ),
        body: SafeArea(
            child: Container(child: _widgetOptions.elementAt(selectedIndex))),
        bottomNavigationBar: BottomAppBar(
            color: Constants.BLACK,
            child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.person,
                        color:
                            userInfoPage ? Constants.PRIMARY : Constants.LIGHT,
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
                            ? Constants.PRIMARY
                            : Constants.LIGHT,
                      ),
                      onPressed: () {
                        _resetSelectedItem();
                        placesInfoPage = true;
                        _onItemTapped(1);
                      },
                    )),
                  ],
                ))));
  }
}
