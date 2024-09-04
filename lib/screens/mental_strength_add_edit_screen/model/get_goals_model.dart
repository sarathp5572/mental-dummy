// To parse this JSON data, do
//
//     final getGoalsModel = getGoalsModelFromJson(jsonString);

import 'dart:convert';

GetGoalsModel getGoalsModelFromJson(String str) =>
    GetGoalsModel.fromJson(json.decode(str));

String getGoalsModelToJson(GetGoalsModel data) => json.encode(data.toJson());

class GetGoalsModel {
  bool? status;
  String? text;
  String? currentPage;
  int? pageCount;
  int? totalCount;
  String? source;
  List<Goal>? goals;

  GetGoalsModel({
    this.status,
    this.text,
    this.currentPage,
    this.pageCount,
    this.totalCount,
    this.source,
    this.goals,
  });

  factory GetGoalsModel.fromJson(Map<String, dynamic> json) => GetGoalsModel(
        status: json["status"],
        text: json["text"],
        currentPage: json["currentPage"],
        pageCount: json["pageCount"],
        totalCount: json["totalCount"],
        source: json["source"],
        goals: json["goals"] == null
            ? []
            : List<Goal>.from(json["goals"]!.map((x) => Goal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "text": text,
        "currentPage": currentPage,
        "pageCount": pageCount,
        "totalCount": totalCount,
        "source": source,
        "goals": goals == null
            ? []
            : List<dynamic>.from(goals!.map((x) => x.toJson())),
      };
}

class Goal {
  String? id;
  String? title;
  String? type;
  String? goalStartdate;
  String? goalEnddate;
  String? goalStatus;
  int? goalCompletePercent;

  Goal({
    this.id,
    this.title,
    this.type,
    this.goalStartdate,
    this.goalEnddate,
    this.goalStatus,
    this.goalCompletePercent,
  });

  factory Goal.fromJson(Map<String, dynamic> json) => Goal(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        goalStartdate: json["goal_startdate"],
        goalEnddate: json["goal_enddate"],
        goalStatus: json["goal_status"],
        goalCompletePercent: json["goal_complete_percent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "goal_startdate": goalStartdate,
        "goal_enddate": goalEnddate,
        "goal_status": goalStatus,
        "goal_complete_percent": goalCompletePercent,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
