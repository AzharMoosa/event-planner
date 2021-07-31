import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:going_out_planner/authentication_screen/signup_screen.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  final String _loginTitle = "LOGIN";
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
                      onPressed: () {
                        // Check If Valid
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
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
                                                  SignUpScreen()))
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
