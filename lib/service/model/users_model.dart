// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  int? createdAt;
  String? name;
  int? age;
  String? language;
  String? id;

  Users({
    this.createdAt,
    this.name,
    this.age,
    this.language,
    this.id,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    createdAt: json["createdAt"],
    name: json["name"],
    age: json["age"],
    language: json["language"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt,
    "name": name,
    "age": age,
    "language": language,
    "id": id,
  };
}