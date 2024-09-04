// To parse this JSON data, do
//
//     final journalChartViewModel = journalChartViewModelFromJson(jsonString);

import 'dart:convert';

JournalChartViewModel journalChartViewModelFromJson(String str) =>
    JournalChartViewModel.fromJson(json.decode(str));

String journalChartViewModelToJson(JournalChartViewModel data) =>
    json.encode(data.toJson());

class JournalChartViewModel {
  bool? status;
  String? text;
  Chartpercentage? chartpercentage;
  Info? info;

  JournalChartViewModel({
    this.status,
    this.text,
    this.chartpercentage,
    this.info,
  });

  factory JournalChartViewModel.fromJson(Map<String, dynamic> json) =>
      JournalChartViewModel(
        status: json["status"],
        text: json["text"],
        chartpercentage: json["chartpercentage"] == null
            ? null
            : Chartpercentage.fromJson(json["chartpercentage"]),
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "text": text,
        "chartpercentage": chartpercentage?.toJson(),
        "info": info?.toJson(),
      };
}

class Chartpercentage {
  int? optimalPercent;
  int? stressfullPercent;
  int? passivePercent;
  int? destructivePercent;

  Chartpercentage({
    this.optimalPercent,
    this.stressfullPercent,
    this.passivePercent,
    this.destructivePercent,
  });

  factory Chartpercentage.fromJson(Map<String, dynamic> json) =>
      Chartpercentage(
        optimalPercent: json["optimal_percent"],
        stressfullPercent: json["stressfull_percent"],
        passivePercent: json["passive_percent"],
        destructivePercent: json["destructive_percent"],
      );

  Map<String, dynamic> toJson() => {
        "optimal_percent": optimalPercent,
        "stressfull_percent": stressfullPercent,
        "passive_percent": passivePercent,
        "destructive_percent": destructivePercent,
      };
}

class Info {
  String? optimalText;
  String? passiveText;
  String? stressfulText;
  String? destructiveText;

  Info({
    this.optimalText,
    this.passiveText,
    this.stressfulText,
    this.destructiveText,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        optimalText: json["optimal_text"],
        passiveText: json["passive_text"],
        stressfulText: json["stressful_text"],
        destructiveText: json["destructive_text"],
      );

  Map<String, dynamic> toJson() => {
        "optimal_text": optimalText,
        "passive_text": passiveText,
        "stressful_text": stressfulText,
        "destructive_text": destructiveText,
      };
}
