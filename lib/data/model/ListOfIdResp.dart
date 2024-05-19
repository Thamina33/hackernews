// To parse this JSON data, do
//
//     final listOfIdResp = listOfIdRespFromMap(jsonString);

import 'dart:convert';

List<int> listOfIdRespFromMap(String str) =>
    List<int>.from(json.decode(str).map((x) => x));

String listOfIdRespToMap(List<int> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
