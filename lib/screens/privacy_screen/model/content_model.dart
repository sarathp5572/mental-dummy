// To parse this JSON data, do
//
//     final policyModel = policyModelFromJson(jsonString);

import 'dart:convert';

PolicyModel policyModelFromJson(String str) =>
    PolicyModel.fromJson(json.decode(str));

String policyModelToJson(PolicyModel data) => json.encode(data.toJson());

class PolicyModel {
  bool? status;
  String? text;
  String? title;
  String? description;

  PolicyModel({
    this.status,
    this.text,
    this.title,
    this.description,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) => PolicyModel(
        status: json["status"],
        text: json["text"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "text": text,
        "title": title,
        "description": description,
      };
}
