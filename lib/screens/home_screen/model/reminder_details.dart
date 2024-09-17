import 'dart:convert';

ReminderDetails reminderDetailsFromJson(String str) =>
    ReminderDetails.fromJson(json.decode(str));

String reminderDetailsToJson(ReminderDetails data) => json.encode(data.toJson());

class ReminderDetails {
  bool? status;
  String? text;
  List<Reminder>? reminders;

  ReminderDetails({
    this.status,
    this.text,
    this.reminders,
  });

  factory ReminderDetails.fromJson(Map<String, dynamic> json) => ReminderDetails(
    status: json["status"],
    text: json["text"],
    reminders: List<Reminder>.from(json.entries
        .where((entry) => int.tryParse(entry.key) != null)
        .map((entry) => Reminder.fromJson(entry.value))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "text": text,
    if (reminders != null)
      for (int i = 0; i < reminders!.length; i++) "$i": reminders![i].toJson(),
  };
}

class Reminder {
  String? goalId;
  String? actionId;
  String? reminderId;
  String? reminderTitle;
  String? reminderDesc;
  String? reminderStartDate;
  String? reminderEndDate;
  String? fromTime;
  String? toTime;
  String? reminderBefore;
  String? reminderRepeat;

  Reminder({
    this.goalId,
    this.actionId,
    this.reminderId,
    this.reminderTitle,
    this.reminderDesc,
    this.reminderStartDate,
    this.reminderEndDate,
    this.fromTime,
    this.toTime,
    this.reminderBefore,
    this.reminderRepeat,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
    goalId: json["goal_id"],
    actionId: json["action_id"],
    reminderId: json["reminder_id"],
    reminderTitle: json["reminder_title"],
    reminderDesc: json["reminder_desc"],
    reminderStartDate: json["reminder_startdate"],
    reminderEndDate: json["reminder_enddate"],
    fromTime: json["from_time"],
    toTime: json["to_time"],
    reminderBefore: json["reminder_before"],
    reminderRepeat: json["reminder_repeat"],
  );

  Map<String, dynamic> toJson() => {
    "goal_id": goalId,
    "action_id": actionId,
    "reminder_id": reminderId,
    "reminder_title": reminderTitle,
    "reminder_desc": reminderDesc,
    "reminder_startdate": reminderStartDate,
    "reminder_enddate": reminderEndDate,
    "from_time": fromTime,
    "to_time": toTime,
    "reminder_before": reminderBefore,
    "reminder_repeat": reminderRepeat,
  };
}
