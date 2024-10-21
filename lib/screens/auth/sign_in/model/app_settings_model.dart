import 'dart:convert';

SettingsModel settingsModelFromJson(String str) =>
    SettingsModel.fromJson(json.decode(str));

String settingsModelToJson(SettingsModel data) => json.encode(data.toJson());

class SettingsModel {
  bool? status;
  String? text;
  String? isSubscribed;
  List<Setting>? settings;

  SettingsModel({
    this.status,
    this.text,
    this.isSubscribed,
    this.settings,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
    status: json["status"],
    text: json["text"],
    isSubscribed: json["is_subscribed"],
    settings: json["settings"] == null
        ? []
        : List<Setting>.from(json["settings"].map((x) => Setting.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "text": text,
    "is_subscribed": isSubscribed,
    "settings": settings == null
        ? []
        : List<dynamic>.from(settings!.map((x) => x.toJson())),
  };
}

class Setting {
  String? id;
  String? type;
  String? isRequired;
  String? title;
  String? message;
  String? link;
  String? linkUrl;
  String? status;

  Setting({
    this.id,
    this.type,
    this.isRequired,
    this.title,
    this.message,
    this.link,
    this.linkUrl,
    this.status,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
    id: json["id"],
    type: json["type"],
    isRequired: json["is_required"],
    title: json["title"],
    message: json["message"],
    link: json["link"],
    linkUrl: json["link_url"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "is_required": isRequired,
    "title": title,
    "message": message,
    "link": link,
    "link_url": linkUrl,
    "status": status,
  };
}
