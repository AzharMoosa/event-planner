import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:going_out_planner/admin/user_info.dart';
import 'package:going_out_planner/models/users_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:going_out_planner/assets/constants.dart' as Constants;
import 'package:http/http.dart' as http;

class AdminUserInfoWidget extends StatefulWidget {
  const AdminUserInfoWidget({Key? key}) : super(key: key);

  @override
  _AdminUserInfoState createState() => _AdminUserInfoState();
}

class _AdminUserInfoState extends State<AdminUserInfoWidget> {
  List<UsersList> _userList = [];
  bool loading = true;

  Future<List<UsersList>?> _getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
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
        loading = false;
      });
      return usersListFromJson(responseString);
    } else {
      return null;
    }
  }

  void initState() {
    super.initState();
    _getUsers();
  }

  final spinkit = SpinKitThreeBounce(color: Color(0xff222831));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.only(top: 30, left: 50, right: 50),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Users',
                      style: TextStyle(
                          color: Color(0xff222831),
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                !loading
                    ? Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Column(children: [
                          Row(
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(
                                    color: Color(0xff222831),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          for (UsersList user in _userList)
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserInfoWidget(
                                                        user: user)));
                                      },
                                      child: Text(
                                        user.firstName + " " + user.lastName,
                                        style: TextStyle(
                                            color: Color(0xff222831),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ))
                              ],
                            ),
                        ]))
                    : Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Center(
                          child: spinkit,
                        ),
                      )
              ],
            )),
      ),
    ));
  }
}
