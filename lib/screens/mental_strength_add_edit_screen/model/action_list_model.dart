// To parse this JSON data, do
//
//     final goalActionListModel = goalActionListModelFromJson(jsonString);

import 'dart:convert';

GoalActionListModel goalActionListModelFromJson(String str) =>
    GoalActionListModel.fromJson(json.decode(str));

String goalActionListModelToJson(GoalActionListModel data) =>
    json.encode(data.toJson());

class GoalActionListModel {
  bool? status;
  String? text;
  String? goalId;
  String? goalTitle;
  String? goalStatus;
  List<Action>? actions;

  GoalActionListModel({
    this.status,
    this.text,
    this.goalId,
    this.goalTitle,
    this.goalStatus,
    this.actions,
  });

  factory GoalActionListModel.fromJson(Map<String, dynamic> json) =>
      GoalActionListModel(
        status: json["status"],
        text: json["text"],
        goalId: json["goal_id"],
        goalTitle: json["goal_title"],
        goalStatus: json["goal_status"],
        actions: json["actions"] == null
            ? []
            : List<Action>.from(
                json["actions"]!.map((x) => Action.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "text": text,
        "goal_id": goalId,
        "goal_title": goalTitle,
        "goal_status": goalStatus,
        "actions": actions == null
            ? []
            : List<dynamic>.from(actions!.map((x) => x.toJson())),
      };
}

class Action {
  String? id;
  String? title;
  String? actionStatus;
  String? actionDate;

  Action({
    this.id,
    this.title,
    this.actionStatus,
    this.actionDate,
  });

  factory Action.fromJson(Map<String, dynamic> json) => Action(
        id: json["id"],
        title: json["title"],
        actionStatus: json["action_status"],
        actionDate: json["action_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "action_status": actionStatus,
        "action_date": actionDate,
      };
}