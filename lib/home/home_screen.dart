import 'dart:io';

import 'package:flutter/material.dart';
import 'package:going_out_planner/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:going_out_planner/assets/constants.dart' as Constants;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Future<UserModel?> _getUserInfo() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? "";
  final response = await http.get(
    Uri.parse(Constants.API_URL_USER_INFO),
    headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

final spinkit = SpinKitThreeBounce(color: Color(0xff222831));

class _HomeScreenState extends State<HomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: _getUserInfo(),
      builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return spinkit;
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Center(child: new Text('${snapshot.data!.firstName}'));
        }
      },
    );
  }
}
