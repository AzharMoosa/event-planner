import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:going_out_planner/assets/constants.dart' as Constants;
import 'package:going_out_planner/authentication_screen/signup_screen.dart';
import 'package:going_out_planner/models/user_model.dart';
import '../main_menu/main_menu.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

Future<UserModel?> loginUser(String email, String password) async {
  final Map data = {'email': email, 'password': password};
  final response = await http.post(Uri.parse(Constants.API_URL_LOGIN),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(data));
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

class _LoginScreenState extends State<LoginScreenWidget> {
  final String _loginTitle = "LOGIN";
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
                    margin: const EdgeInsets.only(top: 100.0),
                    child: Text(
                      _loginTitle,
                      style: TextStyle(
                          color: Color(0xff222831),
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
                    top: 100,
                    left: 40,
                    right: 40,
                  ),
                  child: TextFormField(
                    style: TextStyle(fontSize: 20),
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
                        fillColor: Color(0xFFD4D4D4),
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
                    top: 40,
                    left: 40,
                    right: 40,
                  ),
                  child: TextFormField(
                    style: TextStyle(fontSize: 20),
                    controller: passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        hintText: "Password",
                        fillColor: Color(0xFFD4D4D4),
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
                Container(
                    margin: const EdgeInsets.only(top: 50.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final String email = emailController.text;
                        final String password = passwordController.text;

                        final UserModel? user =
                            await loginUser(email, password);

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
                        'Login'.toUpperCase(),
                        style:
                            TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xff3F72AF),
                          onPrimary: Color(0xffEEEEEE),
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
                        text: "Don't Have An Account?",
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff222831)),
                        children: [
                          TextSpan(
                              text: ' Sign Up',
                              style: TextStyle(color: Color(0xfff67280)),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpWidget()))
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
