// To parse this JSON data, do
//
//     final placeModel = placeModelFromJson(jsonString);

import 'dart:convert';

List<PlaceModel> placeModelFromJson(String str) =>
    List<PlaceModel>.from(json.decode(str).map((x) => PlaceModel.fromJson(x)));

String placeModelToJson(List<PlaceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlaceModel {
  PlaceModel({
    required this.location,
    required this.keywords,
    required this.rating,
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.info,
    required this.user,
    required this.v,
  });

  Location location;
  List<String> keywords;
  double rating;
  String id;
  String name;
  String description;
  String image;
  String info;
  String user;
  int v;

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
        location: Location.fromJson(json["location"]),
        keywords: List<String>.from(json["keywords"].map((x) => x)),
        rating: json["rating"].toDouble(),
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        info: json["info"],
        user: json["user"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
        "rating": rating,
        "_id": id,
        "name": name,
        "description": description,
        "image": image,
        "info": info,
        "user": user,
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
