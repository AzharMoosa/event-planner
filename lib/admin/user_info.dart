import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:going_out_planner/models/users_list_model.dart';
import 'package:going_out_planner/settings/admin_page.dart';
import 'package:going_out_planner/assets/constants.dart' as Constants;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:going_out_planner/models/user_model.dart';

class UserInfoWidget extends StatefulWidget {
  final UsersList user;

  const UserInfoWidget({Key? key, required this.user}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState(user);
}

Future<UserModel?> _updateUser(
    String firstName, String lastName, String email) async {
  final prefs = await SharedPreferences.getInstance();
  final id = prefs.getString('id') ?? "";
  final token = prefs.getString('token') ?? "";

  final Map data = {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
  };

  final response =
      await http.put(Uri.parse(Constants.API_URL_UPDATE_USER + "/$id"),
          headers: {
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonEncode(data));

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

class _UserInfoState extends State<UserInfoWidget> {
  final UsersList userInfo;
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  _UserInfoState(this.userInfo);

  void initState() {
    super.initState();
    firstNameController.text = userInfo.firstName;
    lastNameController.text = userInfo.lastName;
    emailController.text = userInfo.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.BLACK,
          title: Text('User Info',
              style: TextStyle(
                  color: Constants.LIGHT,
                  fontSize: 21,
                  fontWeight: FontWeight.w700)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(
                      top: 40,
                      left: 40,
                      right: 40,
                    ),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20),
                      controller: firstNameController,
                      decoration: InputDecoration(
                          labelText: "First Name",
                          fillColor: Constants.GREY,
                          filled: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 20),
                          prefixStyle: TextStyle(fontSize: 50),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter First Name';
                        }
                        return null;
                      },
                    ),
                  ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(
                      top: 40,
                      left: 40,
                      right: 40,
                    ),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20),
                      controller: lastNameController,
                      decoration: InputDecoration(
                          labelText: "Last Name",
                          fillColor: Constants.GREY,
                          filled: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 20),
                          prefixStyle: TextStyle(fontSize: 50),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Last Name';
                        }
                        return null;
                      },
                    ),
                  ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(
                      top: 40,
                      left: 40,
                      right: 40,
                    ),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20),
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: "Email",
                          fillColor: Constants.GREY,
                          filled: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 20),
                          prefixStyle: TextStyle(fontSize: 50),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        return null;
                      },
                    ),
                  ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 50.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          final String firstName = firstNameController.text;
                          final String lastName = lastNameController.text;
                          final String email = emailController.text;

                          final UserModel? user =
                              await _updateUser(firstName, lastName, email);

                          if (user != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminPageWidget()));
                          }
                        },
                        child: Text(
                          'Update Profile'.toUpperCase(),
                          style:
                              TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Constants.BUTTON_PRIMARY,
                            onPrimary: Constants.LIGHT,
                            minimumSize: Size(238, 43),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            )),
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}
