import 'package:flutter/material.dart';
import 'package:going_out_planner/events/add_events_screen.dart';
import 'package:going_out_planner/events/events_screen.dart';
import 'package:going_out_planner/home/home_screen.dart';
import 'package:going_out_planner/models/user_model.dart';
import 'package:going_out_planner/search/search_screen.dart';
import 'package:going_out_planner/settings/settings_screen.dart';

class MainMenuWidget extends StatefulWidget {
  final UserModel userModel;

  const MainMenuWidget({Key? key, required this.userModel}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenuWidget> {
  int _selectedIndex = 0;
  bool homeSelected = true;
  bool searchSelected = false;
  bool eventsSelected = false;
  bool settingsSelected = false;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreenWidget(),
    SearchScreenWidget(),
    EventsScreenWidget(),
    SettingsScreenWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _resetSelectedItem() {
    setState(() {
      homeSelected = false;
      searchSelected = false;
      eventsSelected = false;
      settingsSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(child: _widgetOptions.elementAt(_selectedIndex))),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xfff67280),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddEventsScreenWidget()));
          },
          child: Icon(Icons.add, size: 30),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
            color: Color(0xff222831),
            shape: CircularNotchedRectangle(),
            notchMargin: 5,
            child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        color: homeSelected
                            ? Color(0xfff67280)
                            : Color(0xffEEEEEE),
                      ),
                      onPressed: () {
                        _resetSelectedItem();
                        homeSelected = true;
                        _onItemTapped(0);
                      },
                    ),
                    Container(
                        margin: const EdgeInsets.only(right: 50),
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: searchSelected
                                ? Color(0xfff67280)
                                : Color(0xffEEEEEE),
                          ),
                          onPressed: () {
                            _resetSelectedItem();
                            searchSelected = true;
                            _onItemTapped(1);
                          },
                        )),
                    IconButton(
                      icon: Icon(
                        Icons.event,
                        color: eventsSelected
                            ? Color(0xfff67280)
                            : Color(0xffEEEEEE),
                      ),
                      onPressed: () {
                        _resetSelectedItem();
                        eventsSelected = true;
                        _onItemTapped(2);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: settingsSelected
                            ? Color(0xfff67280)
                            : Color(0xffEEEEEE),
                      ),
                      onPressed: () {
                        _resetSelectedItem();
                        settingsSelected = true;
                        _onItemTapped(3);
                      },
                    ),
                  ],
                ))));
  }
}
