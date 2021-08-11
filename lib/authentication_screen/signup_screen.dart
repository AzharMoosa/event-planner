import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:going_out_planner/authentication_screen/login_screen.dart';
import 'package:going_out_planner/main_menu/main_menu.dart';
import 'package:going_out_planner/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:going_out_planner/assets/constants.dart' as Constants;

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

Future<UserModel?> registerUser(
    String firstName, String lastName, String email, String password) async {
  final Map data = {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'password': password
  };
  final response = await http.post(Uri.parse(Constants.API_URL_REGISTER),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(data));
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

class _SignUpState extends State<SignUpWidget> {
  final String _loginTitle = "SIGN UP";
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 70.0),
                    child: Text(
                      _loginTitle,
                      style: TextStyle(
                          color: Constants.BLACK,
                          fontSize: 35,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(
                    top: 50,
                    left: 40,
                    right: 40,
                  ),
                  child: TextFormField(
                    style: TextStyle(fontSize: 20),
                    controller: firstNameController,
                    decoration: InputDecoration(
                        hintText: "First Name",
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
                            vertical: 20.0, horizontal: 20.0)),
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
                    top: 30,
                    left: 40,
                    right: 40,
                  ),
                  child: TextFormField(
                    style: TextStyle(fontSize: 20),
                    controller: lastNameController,
                    decoration: InputDecoration(
                        hintText: "Last Name",
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
                            vertical: 20.0, horizontal: 20.0)),
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
                    top: 30,
                    left: 40,
                    right: 40,
                  ),
                  child: TextFormField(
                    style: TextStyle(fontSize: 20),
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
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
                            vertical: 20.0, horizontal: 20.0)),
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
                    top: 30,
                    left: 40,
                    right: 40,
                  ),
                  child: TextFormField(
                    style: TextStyle(fontSize: 20),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: "Password",
                        fillColor: Constants.GREY,
                        filled: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 20),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0)),
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
                    top: 30,
                    left: 40,
                    right: 40,
                  ),
                  child: TextFormField(
                    style: TextStyle(fontSize: 20),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                        hintText: "Confirm Password",
                        fillColor: Constants.GREY,
                        filled: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 20),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Confirm Password';
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
                        final String password = passwordController.text;
                        final String confirmPassword =
                            confirmPasswordController.text;

                        if (password != confirmPassword) {
                          return;
                        }

                        final UserModel? user = await registerUser(
                            firstName, lastName, email, password);

                        if (user != null) {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString("token", user.token);
                          prefs.setString("id", user.id);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainMenuWidget()));
                        }
                      },
                      child: Text(
                        'Sign Up'.toUpperCase(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account?",
                        style: TextStyle(fontSize: 15, color: Constants.BLACK),
                        children: [
                          TextSpan(
                              text: ' Log In',
                              style:
                                  TextStyle(color: Constants.BUTTON_SECONDARY),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreenWidget()))
                                    })
                        ],
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
