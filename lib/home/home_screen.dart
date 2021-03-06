import 'dart:io';

import 'package:flutter/material.dart';
import 'package:event_planner/models/places_model.dart';
import 'package:event_planner/models/user_model.dart';
import 'package:event_planner/places/place_info.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_planner/assets/constants.dart' as Constants;
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

Future<List<PlaceModel>?> _getPlaces() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? "";
  final response = await http.get(
    Uri.parse(Constants.API_URL_PLACES),
    headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return placeModelFromJson(responseString);
  } else {
    return null;
  }
}

final spinkit = SpinKitThreeBounce(color: Constants.BLACK);

class _HomeScreenState extends State<HomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<UserModel?>(
            future: _getUserInfo(),
            builder:
                (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    margin: const EdgeInsets.only(top: 200), child: spinkit);
              } else {
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));
                else
                  return SafeArea(
                      child: Container(
                          margin: const EdgeInsets.only(
                              top: 20, right: 50, left: 50),
                          child: Column(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Text('Welcome',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Constants.BLACK))
                                      ]),
                                      Row(
                                        children: [
                                          Text(
                                              snapshot.data!.firstName +
                                                  " " +
                                                  snapshot.data!.lastName,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Constants
                                                      .BUTTON_SECONDARY))
                                        ],
                                      ),
                                    ],
                                  )),
                              Container(
                                margin: const EdgeInsets.only(top: 40),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child: Icon(Icons.local_fire_department,
                                          color: Constants.PRIMARY, size: 30),
                                    ),
                                    Text(
                                      'Popular',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Constants.PRIMARY,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )));
              }
            },
          ),
          FutureBuilder<List<PlaceModel>?>(
              future: _getPlaces(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<PlaceModel>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else {
                  if (snapshot.hasError)
                    return Center(child: Text('Error: ${snapshot.error}'));
                  else {
                    return SingleChildScrollView(
                        child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (var place in snapshot.data!.sublist(0, 3))
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlaceInfoScreenWidget(
                                                            place: place)));
                                          },
                                          child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 20),
                                              width: 320,
                                              height: 160,
                                              child: Card(
                                                child: Container(
                                                  width: 320,
                                                  height: 160,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          colorFilter:
                                                              new ColorFilter
                                                                      .mode(
                                                                  Colors.white
                                                                      .withOpacity(
                                                                          0.4),
                                                                  BlendMode
                                                                      .dstATop),
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              place.image))),
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: Column(children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child: Text(
                                                                    place.name,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        color: Colors
                                                                            .black)))
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Flexible(
                                                                child:
                                                                    Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10),
                                                              child: Text(
                                                                  '${place.location.address}, ${place.location.postalCode}, ${place.location.city}, ${place.location.country}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color: Colors
                                                                          .black)),
                                                            ))
                                                          ],
                                                        )
                                                      ])),
                                                ),
                                              )))
                                    ],
                                  )
                              ],
                            )));
                  }
                }
              })
        ],
      ),
    );
  }
}
