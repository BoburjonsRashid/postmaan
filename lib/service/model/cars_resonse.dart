// To parse this JSON data, do
//
//     final cars = carsFromJson(jsonString);

import 'dart:convert';

List<Cars> carsFromJson(String str) => List<Cars>.from(json.decode(str).map((x) => Cars.fromJson(x)));

String carsToJson(List<Cars> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cars {
  DateTime? createdAt;
  String? name;
  String? color;
  int? number;
  String? id;

  Cars({
     this.createdAt,
    this.name,
     this.color,
     this.number,
     this.id,
  });

  factory Cars.fromJson(Map<String, dynamic> json) => Cars(
    createdAt: DateTime.parse(json["createdAt"]),
    name: json["name"],
    color: json["color"],
    number: json["number"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt,
    "name": name,
    "color": color,
    "number": number,
    "id": id,
  };
}
