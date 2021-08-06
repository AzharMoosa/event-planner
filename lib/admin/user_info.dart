import 'package:flutter/material.dart';
import 'package:going_out_planner/models/users_list_model.dart';

class UserInfoWidget extends StatefulWidget {
  final UsersList user;

  const UserInfoWidget({Key? key, required this.user}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState(user);
}

class _UserInfoState extends State<UserInfoWidget> {
  final UsersList userInfo;

  _UserInfoState(this.userInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff222831),
          title: Text('User Info',
              style: TextStyle(
                  color: Color(0xffeeeeee),
                  fontSize: 21,
                  fontWeight: FontWeight.w700)),
        ),
        body: SingleChildScrollView(
            child: Container(
          margin:
              const EdgeInsets.only(top: 30, left: 50, right: 50, bottom: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'First Name',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      '${userInfo.firstName}',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Last Name',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      )),
                ],
              ),
              Row(
                children: [
                  Container(
                      width: 300,
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        '${userInfo.lastName}',
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      )),
                ],
              ),
              Row(
                children: [
                  Container(
                      width: 300,
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        userInfo.email,
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        'User ID',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      )),
                ],
              ),
              Row(
                children: [
                  Container(
                      width: 300,
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        userInfo.id,
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            ],
          ),
        )));
  }
}
