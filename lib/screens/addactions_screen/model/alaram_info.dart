import 'package:hive/hive.dart';

part "alaram_info.g.dart";

//
// @HiveType(typeId: 1)
// class AlarmInfo {
//   int? id;
//   String? title; // Title of the alarm
//   String? description; // Description or details of the alarm
//   String? startDate; // The start date when the alarm should trigger
//   String? endDate; // The end date when the alarm should trigger
//   String? startTime; // The start time when the alarm should trigger
//   String? endTime; // The end time when the alarm should trigger
//   String? repeat; // To indicate the repeat interval: 'Daily', 'Weekly', etc.
//
//   AlarmInfo({
//     this.id,
//     this.title,
//     this.description,
//     this.startDate,
//     this.endDate,
//     this.startTime,
//     this.endTime,
//     this.repeat,
//   });
//
//   factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
//         id: json['id'],
//         title: json['title'],
//         description: json['description'],
//         startDate: json['startDate'],
//         endDate: json['endDate'],
//         startTime: json['startTime'],
//         endTime: json['endTime'],
//         repeat: json['repeat'],
//       );
//
//   Map<String, dynamic> toMap() => {
//         'id': id,
//         'title': title,
//         'description': description,
//         'startDate': startDate,
//         'endDate': endDate,
//         'startTime': startTime,
//         'endTime': endTime,
//         'repeat': repeat,
//       };
// }
@HiveType(typeId: 1)
class AlarmInfo {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? startDate;

  @HiveField(4)
  String? endDate;

  @HiveField(5)
  String? startTime;

  @HiveField(6)
  String? endTime;

  @HiveField(7)
  String? repeat;

  AlarmInfo({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.repeat,
  });

  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        repeat: json['repeat'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'startDate': startDate,
        'endDate': endDate,
        'startTime': startTime,
        'endTime': endTime,
        'repeat': repeat,
      };
}
