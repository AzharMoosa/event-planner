// To parse this JSON data, do
//
//     final eventsList = eventsListFromJson(jsonString);

import 'dart:convert';

EventsList eventsListFromJson(String str) =>
    EventsList.fromJson(json.decode(str));

String eventsListToJson(EventsList data) => json.encode(data.toJson());

class EventsList {
  EventsList({
    required this.events,
  });

  List<Event> events;

  factory EventsList.fromJson(Map<String, dynamic> json) => EventsList(
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
      };
}

class Event {
  Event({
    required this.location,
    required this.isCustom,
    required this.id,
    required this.name,
    required this.description,
    required this.place,
    required this.limit,
    required this.hostUser,
    required this.createdAt,
    required this.updatedAt,
    required this.date,
    required this.v,
  });

  Location location;
  bool isCustom;
  String id;
  String name;
  String description;
  String date;
  dynamic place;
  dynamic limit;
  String hostUser;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        location: Location.fromJson(json["location"]),
        isCustom: json["isCustom"],
        id: json["_id"],
        name: json["name"],
        date: json["date"],
        description: json["description"],
        place: json["place"],
        limit: json["limit"],
        hostUser: json["hostUser"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "isCustom": isCustom,
        "_id": id,
        "name": name,
        "description": description,
        "date": date,
        "place": place,
        "limit": limit,
        "hostUser": hostUser,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Location {
  Location({
    required this.address,
    required this.postalCode,
    required this.city,
    required this.country,
  });

  String address;
  String postalCode;
  String city;
  String country;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        address: json["address"],
        postalCode: json["postalCode"],
        city: json["city"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "postalCode": postalCode,
        "city": city,
        "country": country,
      };
}
