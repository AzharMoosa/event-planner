import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:going_out_planner/models/places_model.dart';
import 'package:going_out_planner/places/place_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:going_out_planner/assets/constants.dart' as Constants;

class SearchScreenWidget extends StatefulWidget {
  const SearchScreenWidget({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreenWidget> {
  List<PlaceModel> _placeList = [];
  TextEditingController controller = new TextEditingController();
  List<PlaceModel> _searchResult = [];
  bool loading = true;

  _SearchScreenState();

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
        for (dynamic user in tmp) {
          _placeList.add(PlaceModel.fromJson(user));
        }
        loading = false;
      });
      return placeModelFromJson(responseString);
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _getPlaces();
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    List<String> splitString = text.split(" ");

    _placeList.forEach((placeInfo) {
      splitString.forEach((str) {
        if (str != "" &&
            placeInfo.name.toLowerCase().contains(str.toLowerCase())) {
          _searchResult.add(placeInfo);
        }
      });
    });

    setState(() {
      _searchResult = _searchResult.toSet().toList();
    });
  }

  final spinkit = SpinKitThreeBounce(color: Color(0xff222831));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Color(0xffEEEEEE),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: _searchResult.length != 0 || controller.text.isNotEmpty
                  ? SingleChildScrollView(
                      child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, right: 50, left: 50),
                          child: Column(
                            children: [
                              for (var place in _searchResult)
                                Row(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        width: 320,
                                        height: 150,
                                        child: Card(
                                          child: Container(
                                            width: 320,
                                            height: 108,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                image: DecorationImage(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Colors
                                                                .black
                                                                .withOpacity(
                                                                    0.5),
                                                            BlendMode.dstATop),
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        'images/card-bg-1.jpg'))),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(children: [
                                                  Row(
                                                    children: [
                                                      Text(place.name,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Color(
                                                                  0xff000000)))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                          child: Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 10),
                                                        child: Text(
                                                            '${place.description.substring(0, place.description.length <= Constants.DESCRIPTION_CUTOFF ? place.description.length : Constants.DESCRIPTION_CUTOFF)}...',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xff000000))),
                                                      ))
                                                    ],
                                                  )
                                                ])),
                                          ),
                                        ))
                                  ],
                                )
                            ],
                          )))
                  : !loading && _placeList.length > 0
                      ? SingleChildScrollView(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  top: 10, right: 50, left: 50),
                              child: Column(
                                children: [
                                  for (var place in _placeList.sublist(0, 3))
                                    Row(
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
                                                height: 150,
                                                child: Card(
                                                  child: Container(
                                                    width: 320,
                                                    height: 108,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                        image: DecorationImage(
                                                            colorFilter:
                                                                ColorFilter.mode(
                                                                    Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5),
                                                                    BlendMode
                                                                        .dstATop),
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                                'images/card-bg-1.jpg'))),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      place
                                                                          .name,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          color:
                                                                              Color(0xff000000)))
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Flexible(
                                                                      child:
                                                                          Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10),
                                                                    child: Text(
                                                                        '${place.description.substring(0, place.description.length <= Constants.DESCRIPTION_CUTOFF ? place.description.length : Constants.DESCRIPTION_CUTOFF)}...',
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: Color(0xff000000))),
                                                                  ))
                                                                ],
                                                              )
                                                            ])),
                                                  ),
                                                )))
                                      ],
                                    )
                                ],
                              )))
                      : Container(
                          child: Center(
                            child: spinkit,
                          ),
                        )),
        ],
      ),
    );
  }
}
