import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:going_out_planner/admin/create_place.dart';
import 'package:going_out_planner/models/place_model.dart';
import 'package:going_out_planner/models/places_model.dart';
import 'package:going_out_planner/assets/constants.dart' as Constants;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminPlaceInfoWidget extends StatefulWidget {
  const AdminPlaceInfoWidget({Key? key}) : super(key: key);

  @override
  _AdminPlaceInfoState createState() => _AdminPlaceInfoState();
}

Future<PlaceModel?> _createPlace() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? "";
  final response = await http.post(
    Uri.parse(Constants.API_URL_CREATE_PLACE),
    headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return placeFromJson(responseString);
  } else {
    return null;
  }
}

class _AdminPlaceInfoState extends State<AdminPlaceInfoWidget> {
  bool loading = true;
  List<PlaceModel> _placeList = [];

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

      setState(() {
        List<dynamic> tmp = jsonDecode(response.body);
        for (dynamic place in tmp) {
          _placeList.add(PlaceModel.fromJson(place));
        }
        loading = false;
      });
      return placeModelFromJson(responseString);
    } else {
      return null;
    }
  }

  void initState() {
    super.initState();
    _getPlaces();
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
                      'Places',
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
                          for (PlaceModel place in _placeList)
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(top: 30),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreatePlaceWidget(
                                                        place: place)));
                                      },
                                      child: Text(
                                        place.name,
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
                      ),
                Row(
                  children: [
                    Container(
                        width: 300,
                        margin: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          onPressed: () async {
                            PlaceModel? place = await _createPlace();
                            setState(() {
                              _placeList.clear();
                              _getPlaces();
                            });
                            if (place != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreatePlaceWidget(
                                            place: place,
                                          )));
                            }
                          },
                          child: Text(
                            'Create Place'.toUpperCase(),
                            style: TextStyle(
                                fontFamily: 'Montserrat', fontSize: 16),
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
                )
              ],
            )),
      ),
    ));
  }
}
