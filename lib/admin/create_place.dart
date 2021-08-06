import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:going_out_planner/models/places_model.dart';
import 'package:going_out_planner/settings/admin_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:going_out_planner/assets/constants.dart' as Constants;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreatePlaceWidget extends StatefulWidget {
  const CreatePlaceWidget({Key? key}) : super(key: key);

  @override
  _CreatePlaceState createState() => _CreatePlaceState();
}

Future<Null> _createPlace(String name, String description, String image,
    String ratings, String info, Map<String, dynamic> location) async {
  final Map data = {
    'name': name,
    'description': description,
    "image": image,
    "ratings": double.parse(ratings),
    "info": info,
    "location": location,
  };
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? "";
  await http.post(Uri.parse(Constants.API_URL_CREATE_PLACE),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
      body: jsonEncode(data));

  return null;
}

class _CreatePlaceState extends State<CreatePlaceWidget> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController imageController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController postalCodeController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController ratingsController = new TextEditingController();
  TextEditingController infoController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff222831),
          title: Text('Create Place',
              style: TextStyle(
                  color: Color(0xffeeeeee),
                  fontSize: 21,
                  fontWeight: FontWeight.w700)),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
          margin: const EdgeInsets.only(top: 10, left: 50, right: 50),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 30.0, right: 10),
                      child: Text('Place Name',
                          style: TextStyle(
                              color: Color(0xff222831),
                              fontSize: 18,
                              fontWeight: FontWeight.w700))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: TextFormField(
                      style: TextStyle(fontSize: 18),
                      controller: nameController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      decoration: InputDecoration(
                          labelText: 'Place Name',
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
                          return 'Please Enter An Place Name';
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
                      child: Text('Place Description',
                          style: TextStyle(
                              color: Color(0xff222831),
                              fontSize: 18,
                              fontWeight: FontWeight.w700))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(
                      top: 20,
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
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 30.0, right: 10),
                      child: Text('Location',
                          style: TextStyle(
                              color: Color(0xff222831),
                              fontSize: 18,
                              fontWeight: FontWeight.w700))),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.only(
                          top: 20,
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
                      child: Text('Info',
                          style: TextStyle(
                              color: Color(0xff222831),
                              fontSize: 18,
                              fontWeight: FontWeight.w700))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: TextFormField(
                      style: TextStyle(fontSize: 18),
                      controller: infoController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      decoration: InputDecoration(
                          labelText: 'Info',
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
                          return 'Please Enter Info';
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
                      child: Text('Image',
                          style: TextStyle(
                              color: Color(0xff222831),
                              fontSize: 18,
                              fontWeight: FontWeight.w700))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: TextFormField(
                      style: TextStyle(fontSize: 18),
                      controller: imageController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      decoration: InputDecoration(
                          labelText: 'Image',
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
                          return 'Please Enter Image';
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
                      margin: const EdgeInsets.only(
                          top: 30.0, right: 10, bottom: 20),
                      child: Text('Rating',
                          style: TextStyle(
                              color: Color(0xff222831),
                              fontSize: 18,
                              fontWeight: FontWeight.w700))),
                ],
              ),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      ratingsController.text = rating.toString();
                    },
                  ),
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
                      controller: ratingsController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      decoration: InputDecoration(
                          labelText: "Rating",
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
                          return 'Please Enter An Rating';
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
                      margin: const EdgeInsets.only(top: 30.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          String name = nameController.text;
                          String description = descriptionController.text;
                          String address = addressController.text;
                          String postalCode = postalCodeController.text;
                          String city = cityController.text;
                          String country = countryController.text;
                          Map<String, dynamic>? location = new Location(
                                  address: address,
                                  postalCode: postalCode,
                                  city: city,
                                  country: country)
                              .toJson();
                          String image = imageController.text;
                          String ratings = ratingsController.text;
                          String info = infoController.text;

                          await _createPlace(name, description, image, ratings,
                              info, location);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminPageWidget()));
                        },
                        child: Text(
                          'Create Place'.toUpperCase(),
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
        ))));
  }
}
