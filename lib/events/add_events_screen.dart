import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:going_out_planner/models/places_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:going_out_planner/assets/constants.dart' as Constants;
import 'package:http/http.dart' as http;

class AddEventsScreenWidget extends StatefulWidget {
  const AddEventsScreenWidget({Key? key}) : super(key: key);

  @override
  _AddEventsScreenState createState() => _AddEventsScreenState();
}

class _AddEventsScreenState extends State<AddEventsScreenWidget> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController postalCodeController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController limitController = new TextEditingController();
  String? _mySelection;
  List<String> data = [];
  bool isCustom = false;
  bool isLimited = false;

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
      List<PlaceModel> places = placeModelFromJson(responseString);
      List<String> tmp = [];
      for (var i = 0; i < places.length; i++) {
        tmp.add(places[i].name);
      }
      setState(() {
        data = tmp;
      });
      return placeModelFromJson(responseString);
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    this._getPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff222831),
        title: Text('Create Events',
            style: TextStyle(
                color: Color(0xffeeeeee),
                fontSize: 21,
                fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
        margin: const EdgeInsets.only(top: 30, left: 50, right: 50),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: TextFormField(
                    style: TextStyle(fontSize: 18),
                    controller: nameController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                    ],
                    decoration: InputDecoration(
                        labelText: 'Event Name',
                        fillColor: Color(0xFFD4D4D4),
                        filled: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 18),
                        prefixStyle: TextStyle(fontSize: 50),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter An Event Name';
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
                  ),
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(200),
                    ],
                    style: TextStyle(fontSize: 18),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: descriptionController,
                    decoration: InputDecoration(
                        labelText: "Event Description",
                        fillColor: Color(0xFFD4D4D4),
                        filled: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 18),
                        prefixStyle: TextStyle(fontSize: 50),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter An Event Name';
                      }
                      return null;
                    },
                  ),
                ))
              ],
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 30.0, right: 10),
                    child: Text('Custom Event',
                        style: TextStyle(
                            color: Color(0xff222831),
                            fontSize: 18,
                            fontWeight: FontWeight.w700))),
                Container(
                  margin: const EdgeInsets.only(top: 30.0),
                  child: Checkbox(
                    checkColor: Color(0xffeeeeee),
                    activeColor: Color(0xff222831),
                    value: this.isCustom,
                    onChanged: (bool? value) {
                      setState(() {
                        this.isCustom = value!;
                      });
                    },
                  ),
                )
              ],
            ),
            !isCustom
                ? Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30.0, right: 20),
                        child: Text(
                          'Place',
                          style: TextStyle(
                              color: Color(0xff222831),
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 30.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(color: Color(0xFFD4D4D4)),
                            child: DropdownButton(
                              dropdownColor: Color(0xFFD4D4D4),
                              items: data.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item),
                                  value: item.toString(),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                setState(() {
                                  _mySelection = newVal as String?;
                                });
                              },
                              value: _mySelection,
                            ),
                          ))
                    ],
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: TextFormField(
                              style: TextStyle(fontSize: 18),
                              controller: addressController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                              ],
                              decoration: InputDecoration(
                                  labelText: "Address",
                                  fillColor: Color(0xFFD4D4D4),
                                  filled: true,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 18),
                                  prefixStyle: TextStyle(fontSize: 50),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter An Adress Name';
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
                            ),
                            child: TextFormField(
                              style: TextStyle(fontSize: 18),
                              controller: postalCodeController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                              ],
                              decoration: InputDecoration(
                                  labelText: "Post Code",
                                  fillColor: Color(0xFFD4D4D4),
                                  filled: true,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 18),
                                  prefixStyle: TextStyle(fontSize: 50),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter An Adress Name';
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
                            ),
                            child: TextFormField(
                              style: TextStyle(fontSize: 18),
                              controller: cityController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                              ],
                              decoration: InputDecoration(
                                  labelText: "City",
                                  fillColor: Color(0xFFD4D4D4),
                                  filled: true,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 18),
                                  prefixStyle: TextStyle(fontSize: 50),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter An Adress Name';
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
                            ),
                            child: TextFormField(
                              style: TextStyle(fontSize: 18),
                              controller: countryController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                              ],
                              decoration: InputDecoration(
                                  labelText: "Country",
                                  fillColor: Color(0xFFD4D4D4),
                                  filled: true,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 18),
                                  prefixStyle: TextStyle(fontSize: 50),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter An Adress Name';
                                }
                                return null;
                              },
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 30.0, right: 10),
                    child: Text('Add Limit',
                        style: TextStyle(
                            color: Color(0xff222831),
                            fontSize: 18,
                            fontWeight: FontWeight.w700))),
                Container(
                  margin: const EdgeInsets.only(top: 30.0),
                  child: Checkbox(
                    checkColor: Color(0xffeeeeee),
                    activeColor: Color(0xff222831),
                    value: this.isLimited,
                    onChanged: (bool? value) {
                      setState(() {
                        this.isLimited = value!;
                      });
                    },
                  ),
                )
              ],
            ),
            isLimited
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          controller: limitController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], //
                          decoration: InputDecoration(
                              labelText: "Number Of People",
                              fillColor: Color(0xFFD4D4D4),
                              filled: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 18),
                              prefixStyle: TextStyle(fontSize: 50),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter An Adress Name';
                            }
                            return null;
                          },
                        ),
                      ))
                    ],
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Create Event'.toUpperCase(),
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
          ],
        ),
      ))),
    );
  }
}
