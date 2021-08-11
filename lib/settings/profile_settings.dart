import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:going_out_planner/main_menu/main_menu.dart';
import 'package:going_out_planner/models/user_model.dart';
import 'package:going_out_planner/assets/constants.dart' as Constants;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingsWidget extends StatefulWidget {
  const ProfileSettingsWidget({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

Future<UserModel?> _updateUser(
    String firstName, String lastName, String email, String password) async {
  final prefs = await SharedPreferences.getInstance();
  final id = prefs.getString('id') ?? "";
  final token = prefs.getString('token') ?? "";

  final Map data = {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'password': password
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

class _ProfileSettingsState extends State<ProfileSettingsWidget> {
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  bool loading = true;

  final spinkit = SpinKitThreeBounce(color: Constants.BLACK);

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

      setState(() {
        firstNameController.text = userModelFromJson(responseString).firstName;
        lastNameController.text = userModelFromJson(responseString).lastName;
        emailController.text = userModelFromJson(responseString).email;
        loading = false;
      });

      return userModelFromJson(responseString);
    } else {
      return null;
    }
  }

  void initState() {
    super.initState();
    _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.BLACK,
          title: Text('Profile Settings',
              style: TextStyle(
                  color: Constants.LIGHT,
                  fontSize: 21,
                  fontWeight: FontWeight.w700)),
        ),
        body: !loading
            ? SingleChildScrollView(
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
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.only(
                            top: 40,
                            left: 40,
                            right: 40,
                          ),
                          child: TextFormField(
                            style: TextStyle(fontSize: 20),
                            controller: passwordController,
                            decoration: InputDecoration(
                                labelText: "Password",
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
                                return 'Please Enter Password';
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
                            controller: confirmPasswordController,
                            decoration: InputDecoration(
                                labelText: "Confirm Password",
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
                                return 'Please Enter Confirm Password';
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
                                final String firstName =
                                    firstNameController.text;
                                final String lastName = lastNameController.text;
                                final String email = emailController.text;
                                final String password = passwordController.text;
                                final String confirmPassword =
                                    confirmPasswordController.text;

                                if (password.isNotEmpty &&
                                    password != confirmPassword) {
                                  return;
                                }

                                final UserModel? user = await _updateUser(
                                    firstName, lastName, email, password);

                                if (user != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MainMenuWidget()));
                                }
                              },
                              child: Text(
                                'Update Profile'.toUpperCase(),
                                style: TextStyle(
                                    fontFamily: 'Montserrat', fontSize: 16),
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
              )
            : Container(
                child: Center(
                  child: spinkit,
                ),
              ));
  }
}
