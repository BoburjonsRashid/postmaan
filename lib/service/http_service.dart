

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:postman/service/model/cars_resonse.dart';
import 'package:postman/service/model/users_model.dart';

import 'model/humans_model.dart';


class Network {
  static String BASE = "64ab0f4a0c6d844abedf2536.mockapi.io";
  static Map<String, String> headers = {'Content-Type': 'application/json'};
  /* Http Apis*/
  static String API_LIST = "/humans";
  static String API_GET = "/humans";
  static String API_CREATE = "/humans/";
  static String API_UPDATE = "/humans/"; //{id}
  static String API_DELETE = "/humans/"; //{id}

  /* Http Requests*/
  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(BASE, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(BASE, api);
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 202) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DEL(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await delete(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

/* Http Response*/
  static Map<String, dynamic> paramsEmpty() {
    Map<String, dynamic> params = {};
    return params;
  }

  static Map<String, dynamic> paramsCreate(Humans humans) {
    Map<String, dynamic> params = {};
    params.addAll({
      'name': humans.name ,
      'age': humans.age.toString(),
      'id': humans.id.toString(),
    });
    return params;
  }

  static Map<String, dynamic> paramsUpdate(Humans humans) {
    Map<String, dynamic> params = {};
    params.addAll({
      'name': humans.name.toString() ,
      'age': humans.age.toString(),
      'id': humans.id.toString(),
    });
    return params;
  }

/* Http Parsing*/
  static List <Humans> parsePostList(String response) {
    dynamic json = jsonDecode(response);
    var data = List<Humans>.from(json.map((x)=>Humans.fromJson(x)));
    return data;
  }
}