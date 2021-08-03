import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:going_out_planner/models/events_list_model.dart';
import 'package:going_out_planner/models/users_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:going_out_planner/assets/constants.dart' as Constants;
import 'package:http/http.dart' as http;

class InviteEventScreenWidget extends StatefulWidget {
  final Event event;

  const InviteEventScreenWidget({Key? key, required this.event})
      : super(key: key);

  @override
  _InviteEventScreenState createState() => _InviteEventScreenState();
}

class _InviteEventScreenState extends State<InviteEventScreenWidget> {
  List<UsersList> _userList = [];
  TextEditingController controller = new TextEditingController();
  List<UsersList> _searchResult = [];

  Future<List<UsersList>?> _getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    final userID = prefs.getString('id') ?? "";
    final response = await http.get(
      Uri.parse(Constants.API_URL_GET_USERS),
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

    _userList.forEach((userDetail) {
      if (userDetail.firstName.contains(text) ||
          userDetail.lastName.contains(text)) {
        _searchResult.add(userDetail);
      }
      ;
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff222831),
        title: Text('Invite Users',
            style: TextStyle(
                color: Color(0xffeeeeee),
                fontSize: 21,
                fontWeight: FontWeight.w700)),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            color: Color(0xff222831),
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
