import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:event_planner/models/event_model.dart';
import 'package:event_planner/models/events_list_model.dart';
import 'package:event_planner/models/users_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_planner/assets/constants.dart' as Constants;
import 'package:http/http.dart' as http;

class InviteEventScreenWidget extends StatefulWidget {
  final Event event;

  const InviteEventScreenWidget({Key? key, required this.event})
      : super(key: key);

  @override
  _InviteEventScreenState createState() => _InviteEventScreenState(event);
}

class _InviteEventScreenState extends State<InviteEventScreenWidget> {
  List<UsersList> _userList = [];
  TextEditingController controller = new TextEditingController();
  List<UsersList> _searchResult = [];

  Event eventInfo;
  _InviteEventScreenState(this.eventInfo);

  Future<List<UsersList>?> _getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    final userID = prefs.getString('id') ?? "";
    final response = await http.get(
      Uri.parse(
          Constants.API_URL_GET_NON_INVITED_USERS + "/${eventInfo.id}/invited"),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      final String responseString = response.body;

      setState(() {
        List<dynamic> tmp = jsonDecode(response.body);
        for (dynamic user in tmp) {
          _userList.add(UsersList.fromJson(user));
        }
        _userList = _userList.where((user) => user.id != userID).toList();
      });
      return usersListFromJson(responseString);
    } else {
      return null;
    }
  }

  Future<EventModel?> _inviteUser(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    final Map data = {'userTwo': id};
    final response = await http.post(
        Uri.parse(Constants.API_URL_INVITE_EVENT + '/${eventInfo.id}/invite'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return eventFromJson(responseString);
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    List<String> splitString = text.split(" ");

    _userList.forEach((userDetail) {
      splitString.forEach((str) {
        if (str != "" &&
                userDetail.firstName
                    .toLowerCase()
                    .contains(str.toLowerCase()) ||
            userDetail.lastName.toLowerCase().contains(str.toLowerCase())) {
          _searchResult.add(userDetail);
        }
      });
    });

    setState(() {
      _searchResult = _searchResult.toSet().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.BLACK,
        title: Text('Invite Users',
            style: TextStyle(
                color: Constants.LIGHT,
                fontSize: 21,
                fontWeight: FontWeight.w700)),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            color: Constants.BLACK,
            child: new Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? new ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (context, i) {
                      return new Card(
                        child: new ListTile(
                          onTap: () async {
                            final EventModel? inviteStatus =
                                await _inviteUser(_searchResult[i].id);
                            if (inviteStatus != null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          this.widget));
                            }
                          },
                          title: new Text(_searchResult[i].firstName +
                              ' ' +
                              _searchResult[i].lastName),
                        ),
                        margin: const EdgeInsets.all(0.0),
                      );
                    },
                  )
                : new ListView.builder(
                    itemCount: _userList.length,
                    itemBuilder: (context, index) {
                      return new Card(
                        child: new ListTile(
                          onTap: () async {
                            final EventModel? inviteStatus =
                                await _inviteUser(_userList[index].id);
                            if (inviteStatus != null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          this.widget));
                            }
                          },
                          title: new Text(_userList[index].firstName +
                              ' ' +
                              _userList[index].lastName),
                        ),
                        margin: const EdgeInsets.all(0.0),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
