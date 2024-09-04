// To parse this JSON data, do
//
//     final getPlansModel = getPlansModelFromJson(jsonString);

import 'dart:convert';

GetPlansModel getPlansModelFromJson(String str) =>
    GetPlansModel.fromJson(json.decode(str));

String getPlansModelToJson(GetPlansModel data) => json.encode(data.toJson());

class GetPlansModel {
  bool? status;
  String? text;
  List<Plan>? plans;

  GetPlansModel({
    this.status,
    this.text,
    this.plans,
  });

  factory GetPlansModel.fromJson(Map<String, dynamic> json) => GetPlansModel(
        status: json["status"],
        text: json["text"],
        plans: json["plans"] == null
            ? []
            : List<Plan>.from(json["plans"]!.map((x) => Plan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "text": text,
        "plans": plans == null
            ? []
            : List<dynamic>.from(plans!.map((x) => x.toJson())),
      };
}

class Plan {
  String? id;
  String? name;
  String? price;
  String? planInterval;
  String? intervalCount;
  String? planValidity;
  String? status;

  Plan({
    this.id,
    this.name,
    this.price,
    this.planInterval,
    this.intervalCount,
    this.planValidity,
    this.status,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        planInterval: json["plan_interval"],
        intervalCount: json["interval_count"],
        planValidity: json["plan_validity"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "plan_interval": planInterval,
        "interval_count": intervalCount,
        "plan_validity": planValidity,
        "status": status,
      };
}
