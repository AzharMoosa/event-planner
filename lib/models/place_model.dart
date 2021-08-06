// To parse this JSON data, do
//
//     final place = placeFromJson(jsonString);

import 'dart:convert';

import 'package:going_out_planner/models/places_model.dart';

PlaceModel placeFromJson(String str) => PlaceModel.fromJson(json.decode(str));

String placeToJson(PlaceModel data) => json.encode(data.toJson());
