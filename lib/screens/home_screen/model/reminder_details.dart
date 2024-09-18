// To parse this JSON data, do
//
//     final remindersDetails = remindersDetailsFromJson(jsonString);

import 'dart:convert';

RemindersDetails remindersDetailsFromJson(String str) => RemindersDetails.fromJson(json.decode(str));

String remindersDetailsToJson(RemindersDetails data) => json.encode(data.toJson());

class RemindersDetails {
  bool? status;
  String? text;
  List<Reminder>? reminders;

  RemindersDetails({
    this.status,
    this.text,
    this.reminders,
  });

  factory RemindersDetails.fromJson(Map<String, dynamic> json) => RemindersDetails(
    status: json["status"],
    text: json["text"],
    reminders: json["reminders"] == null ? [] : List<Reminder>.from(json["reminders"]!.map((x) => Reminder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "text": text,
    "reminders": reminders == null ? [] : List<dynamic>.from(reminders!.map((x) => x.toJson())),
  };
}

class Reminder {
  String? goalId;
  String? actionId;
  String? reminderId;
  String? reminderTitle;
  String? reminderDesc;
  String? reminderStartdate;
  String? reminderEnddate;
  String? fromTime;
  String? toTime;
  String? reminderBefore;
  String? reminderRepeat;
  String? imageUrl;

  Reminder({
    this.goalId,
    this.actionId,
    this.reminderId,
    this.reminderTitle,
    this.reminderDesc,
    this.reminderStartdate,
    this.reminderEnddate,
    this.fromTime,
    this.toTime,
    this.reminderBefore,
    this.reminderRepeat,
    this.imageUrl,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
    goalId: json["goal_id"],
    actionId: json["action_id"],
    reminderId: json["reminder_id"],
    reminderTitle: json["reminder_title"],
    reminderDesc: json["reminder_desc"],
    reminderStartdate: json["reminder_startdate"],
    reminderEnddate: json["reminder_enddate"],
    fromTime: json["from_time"],
    toTime: json["to_time"],
    reminderBefore: json["reminder_before"],
    reminderRepeat:json["reminder_repeat"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "goal_id": goalId,
    "action_id": actionId,
    "reminder_id": reminderId,
    "reminder_title": reminderTitle,
    "reminder_desc": reminderDesc,
    "reminder_startdate": reminderStartdate,
    "reminder_enddate": reminderEnddate,
    "from_time": fromTime,
    "to_time": toTime,
    "reminder_before": reminderBefore,
    "reminder_repeat": reminderRepeat,
    "image_url": imageUrl,
  };
}
