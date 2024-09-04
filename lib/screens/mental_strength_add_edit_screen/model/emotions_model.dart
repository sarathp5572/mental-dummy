// To parse this JSON data, do
//
//     final getEmotionsModel = getEmotionsModelFromJson(jsonString);

import 'dart:convert';

GetEmotionsModel getEmotionsModelFromJson(String str) =>
    GetEmotionsModel.fromJson(json.decode(str));

String getEmotionsModelToJson(GetEmotionsModel data) =>
    json.encode(data.toJson());

class GetEmotionsModel {
  bool? status;
  String? text;
  List<Emotion>? emotions;

  GetEmotionsModel({
    this.status,
    this.text,
    this.emotions,
  });

  factory GetEmotionsModel.fromJson(Map<String, dynamic> json) =>
      GetEmotionsModel(
        status: json["status"],
        text: json["text"],
        emotions: json["emotions"] == null
            ? []
            : List<Emotion>.from(
                json["emotions"]!.map((x) => Emotion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "text": text,
        "emotions": emotions == null
            ? []
            : List<dynamic>.from(emotions!.map((x) => x.toJson())),
      };
}

class Emotion {
  String? id;
  String? title;
  // String? userId;

  Emotion({
    this.id,
    this.title,
    // this.userId,
  });

  factory Emotion.fromJson(Map<String, dynamic> json) => Emotion(
        id: json["id"],
        title: json["title"],
        // userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        // "user_id": userId,
      };
}
