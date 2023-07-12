// To parse this JSON data, do
//
//     final humans = humansFromJson(jsonString);

import 'dart:convert';

List<Humans> humansFromJson(String str) => List<Humans>.from(json.decode(str).map((x) => Humans.fromJson(x)));

String humansToJson(List<Humans> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Humans {
  String? name;
  String? age;
  String? id;

  Humans({
    this.name,
    this.age,
    this.id,
  });

  factory Humans.fromJson(Map<String, dynamic> json) => Humans(
    name: json["name"],
    age: json["age"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "age": age,
    "id": id,
  };
}
