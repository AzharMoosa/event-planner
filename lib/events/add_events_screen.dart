import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:going_out_planner/main_menu/main_menu.dart';
import 'package:going_out_planner/models/event_model.dart';
import 'package:going_out_planner/models/places_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:going_out_planner/assets/constants.dart' as Constants;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddEventsScreenWidget extends StatefulWidget {
  const AddEventsScreenWidget({Key? key}) : super(key: key);

  @override
  _AddEventsScreenState createState() => _AddEventsScreenState();
}

Future<EventModel?> createEvent(
  String name,
  String description,
  String date,
  bool isCustom,
  String? place,
  Map<String, dynamic> location,
  int? limit,
) async {
  final Map data = {
    'name': name,
    'description': description,
    "isCustom": isCustom,
    "date": date,
    "place": place,
    "location": location,
    "limit": limit
  };
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? "";
  final response = await http.post(Uri.parse(Constants.API_URL_CREATE_EVENT),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
      body: jsonEncode(data));

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return eventFromJson(responseString);
  } else {
    return null;
  }
}

class _AddEventsScreenState extends State<AddEventsScreenWidget> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController postalCodeController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController limitController = new TextEditingController();
  String? _mySelection;
  List<String> data = [];
  Map<String, String> idMap = new Map();
  Map<String, Map<String, dynamic>> locationMap = new Map();
  bool isCustom = false;
  bool isLimited = false;
  bool loading = true;

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
        PlaceModel place = places[i];
        tmp.add(place.name);
        idMap[place.name] = place.id;
        locationMap[place.name] = place.location.toJson();
      }
      setState(() {
        data = tmp;
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
    this._getPlaces();
  }

  final spinkit = SpinKitThreeBounce(color: Color(0xff222831));

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
      body: !loading
          ? SafeArea(
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
                              return 'Please Enter An Event Description';
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
                          onTap: () async {
                            DateTime? date = DateTime(1900);
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());

                            date = (await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100)));

                            if (date != null) {
                              dateController.text =
                                  DateFormat('dd/MM/yyyy').format(date);
                            }
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(200),
                          ],
                          style: TextStyle(fontSize: 18),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: dateController,
                          decoration: InputDecoration(
                              labelText: "Event Date",
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
                              return 'Please Enter An Event Date';
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
                              margin:
                                  const EdgeInsets.only(top: 30.0, right: 20),
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
                                  decoration:
                                      BoxDecoration(color: Color(0xFFD4D4D4)),
                                  child: DropdownButton(
                                    dropdownColor: Color(0xFFD4D4D4),
                                    items: data.map((item) {
                                      return new DropdownMenuItem(
                                        child: new SizedBox(
                                            width: 200, child: new Text(item)),
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
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 20.0)),
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
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 20.0)),
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
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 20.0)),
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
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 20.0)),
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
                            onPressed: () async {
                              String name = nameController.text;
                              String description = descriptionController.text;
                              String date = dateController.text;
                              String? place;
                              Map<String, dynamic>? location =
                                  locationMap[_mySelection];
                              int? limit;
                              if (isCustom) {
                                String address = addressController.text;
                                String postalCode = postalCodeController.text;
                                String city = cityController.text;
                                String country = countryController.text;

                                location = new Location(
                                        address: address,
                                        postalCode: postalCode,
                                        city: city,
                                        country: country)
                                    .toJson();
                              } else {
                                place = idMap[_mySelection];
                              }

                              if (isLimited) {
                                limit = int.parse(limitController.text);
                              }
                              await createEvent(name, description, date,
                                  isCustom, place, location!, limit);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainMenuWidget()));
                            },
                            child: Text(
                              'Create Event'.toUpperCase(),
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
                  ),
                ],
              ),
            )))
          : spinkit,
    );
  }
}
