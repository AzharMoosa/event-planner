// To parse this JSON data, do
//
//     final event = createdEventFromJson(jsonString);

import 'dart:convert';

import 'package:going_out_planner/models/places_model.dart';

EventModel eventFromJson(String str) => EventModel.fromJson(json.decode(str));

String eventToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel(
      {required this.isCustom,
      required this.id,
      required this.name,
      required this.description,
      required this.hostUser,
      required this.createdAt,
      required this.updatedAt,
      required this.v,
      required this.date,
      this.place,
      required this.location,
      this.limit});

  bool isCustom;
  String id;
  String name;
  String description;
  String hostUser;
  String date;
  String? place;
  int? limit;
  Location location;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        isCustom: json["isCustom"],
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        date: json["date"],
        place: json["place"],
        location: Location.fromJson(json["location"]),
        hostUser: json["hostUser"],
        limit: json["limit"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "isCustom": isCustom,
        "_id": id,
        "name": name,
        "date": date,
        "place": place,
        "location": location.toJson(),
        "limit": limit,
        "description": description,
        "hostUser": hostUser,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
