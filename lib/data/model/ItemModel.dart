// To parse this JSON data, do
//
//     final itemModel = itemModelFromMap(jsonString);

import 'dart:convert';

ItemModel itemModelFromMap(String str) => ItemModel.fromMap(json.decode(str));

String itemModelToMap(ItemModel data) => json.encode(data.toMap());

class ItemModel {
  String? by;
  int? id;
  List<int>? kids;
  int? parent;
  String? text;
  int? time;
  String? type;
  String? url;
  int? descendants;
  int? score;

  ItemModel({
    this.by,
    this.id,
    this.kids,
    this.parent,
    this.text,
    this.time,
    this.type,
    this.url,
    this.descendants,
    this.score
  });

  ItemModel copyWith({
    String? by,
    int? id,
    List<int>? kids,
    int? parent,
    String? text,
    int? time,
    String? type,
    String? url,
    int? descendants,
    int? score
  }) =>
      ItemModel(
        by: by ?? this.by,
        id: id ?? this.id,
        kids: kids ?? this.kids,
        parent: parent ?? this.parent,
        text: text ?? this.text,
        time: time ?? this.time,
        type: type ?? this.type,
        url: url ?? this.url,
        descendants: descendants?? this.descendants,
        score: score?? this.score
      );

  factory ItemModel.fromMap(Map<String, dynamic> json) => ItemModel(
    by: json["by"],
    id: json["id"],
    kids: json["kids"] == null ? [] : List<int>.from(json["kids"]!.map((x) => x)),
    parent: json["parent"],
    text: json["title"],
    time: json["time"],
    type: json["type"],
    url: json["url"],
    descendants: json["descendants"],
    score: json["score"]
  );

  Map<String, dynamic> toMap() => {
    "by": by,
    "id": id,
    "kids": kids == null ? [] : List<dynamic>.from(kids!.map((x) => x)),
    "parent": parent,
    "text": text,
    "time": time,
    "type": type,
    "url": url,
    "descendants" : descendants,
    "score" : score,

  };
}
