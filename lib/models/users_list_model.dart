// To parse this JSON data, do
//
//     final usersList = usersListFromJson(jsonString);

import 'dart:convert';

List<UsersList> usersListFromJson(String str) =>
    List<UsersList>.from(json.decode(str).map((x) => UsersList.fromJson(x)));

String usersListToJson(List<UsersList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersList {
  UsersList({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  String id;
  String firstName;
  String lastName;
  String email;

  factory UsersList.fromJson(Map<String, dynamic> json) => UsersList(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
      };
}
