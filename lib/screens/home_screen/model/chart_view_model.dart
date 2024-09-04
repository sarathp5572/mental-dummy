// To parse this JSON data, do
//
//     final chartViewModel = chartViewModelFromJson(jsonString);

import 'dart:convert';

ChartViewModel chartViewModelFromJson(String str) =>
    ChartViewModel.fromJson(json.decode(str));

String chartViewModelToJson(ChartViewModel data) => json.encode(data.toJson());

class ChartViewModel {
  bool? status;
  String? text;
  List<Chart>? chart;

  ChartViewModel({
    this.status,
    this.text,
    this.chart,
  });

  factory ChartViewModel.fromJson(Map<String, dynamic> json) => ChartViewModel(
        status: json["status"],
        text: json["text"],
        chart: json["chart"] == null
            ? []
            : List<Chart>.from(json["chart"]!.map((x) => Chart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "text": text,
        "chart": chart == null
            ? []
            : List<dynamic>.from(chart!.map((x) => x.toJson())),
      };
}

class Chart {
  final String emotionValue;
  final String driveValue;
  final int score;
  final String dateTime; // Change the type to DateTime

  Chart({
    required this.emotionValue,
    required this.driveValue,
    required this.score,
    required this.dateTime,
  });

  factory Chart.fromJson(Map<String, dynamic> json) {
    return Chart(
        emotionValue: json["emotion_value"],
        driveValue: json["drive_value"],
        score: json["score"],
        dateTime: json["date_time"]
        // formatDateToString(int.parse(json["date_time"]))

        );
  }

  Map<String, dynamic> toJson() => {
        "emotion_value": emotionValue,
        "drive_value": driveValue,
        "score": score,
        "date_time":
            // formatDateToString(int.parse(dateTime))
            dateTime,
      };
}

//
// class Chart {
//   String? emotionValue;
//   String? driveValue;
//   int? score;
//   String? dateTime;
//
//   Chart({
//     this.emotionValue,
//     this.driveValue,
//     this.score,
//     this.dateTime,
//   });
//
//   factory Chart.fromJson(Map<String, dynamic> json) => Chart(
//         emotionValue: json["emotion_value"],
//         driveValue: json["drive_value"],
//         score: json["score"],
//         dateTime: json["date_time"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "emotion_value": emotionValue,
//         "drive_value": driveValue,
//         "score": score,
//         "date_time": dateTime,
//       };
// }
