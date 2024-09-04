// To parse this JSON data, do
//
//     final journalsModel = journalsModelFromJson(jsonString);

import 'dart:convert';

JournalsModel journalsModelFromJson(String str) =>
    JournalsModel.fromJson(json.decode(str));

String journalsModelToJson(JournalsModel data) => json.encode(data.toJson());

class JournalsModel {
  bool? status;
  String? text;
  String? currentPage;
  int? pageCount;
  int? totalCount;
  String? source;
  List<Journal>? journals;

  JournalsModel({
    this.status,
    this.text,
    this.currentPage,
    this.pageCount,
    this.totalCount,
    this.source,
    this.journals,
  });

  factory JournalsModel.fromJson(Map<String, dynamic> json) => JournalsModel(
        status: json["status"],
        text: json["text"],
        currentPage: json["currentPage"],
        pageCount: json["pageCount"],
        totalCount: json["totalCount"],
        source: json["source"],
        journals: json["journals"] == null
            ? []
            : List<Journal>.from(
                json["journals"]!.map((x) => Journal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "text": text,
        "currentPage": currentPage,
        "pageCount": pageCount,
        "totalCount": totalCount,
        "source": source,
        "journals": journals == null
            ? []
            : List<dynamic>.from(journals!.map((x) => x.toJson())),
      };
}

class Journal {
  String? userId;
  String? journalId;
  String? journalTitle;
  String? journalDesc;
  String? journalDatetime;
  String? displayImage;
  String? displayType;

  Journal({
    this.userId,
    this.journalId,
    this.journalTitle,
    this.journalDesc,
    this.journalDatetime,
    this.displayImage,
    this.displayType,
  });

  factory Journal.fromJson(Map<String, dynamic> json) => Journal(
        userId: json["user_id"],
        journalId: json["journal_id"],
        journalTitle: json["journal_title"],
        journalDesc: json["journal_desc"],
        journalDatetime: json["journal_datetime"],
        displayImage: json["display_image"],
        displayType: json["display_type"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "journal_id": journalId,
        "journal_title": journalTitle,
        "journal_desc": journalDesc,
        "journal_datetime": journalDatetime,
        "display_image": displayImage,
        "display_type": displayType,
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
