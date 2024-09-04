// To parse this JSON data, do
//
//     final actionsDetailsModel = actionsDetailsModelFromJson(jsonString);

import 'dart:convert';

ActionsDetailsModel actionsDetailsModelFromJson(String str) =>
    ActionsDetailsModel.fromJson(json.decode(str));

String actionsDetailsModelToJson(ActionsDetailsModel data) =>
    json.encode(data.toJson());

class ActionsDetailsModel {
  bool? status;
  String? text;
  String? source;
  Actions? actions;

  ActionsDetailsModel({
    this.status,
    this.text,
    this.source,
    this.actions,
  });

  factory ActionsDetailsModel.fromJson(Map<String, dynamic> json) =>
      ActionsDetailsModel(
        status: json["status"],
        text: json["text"],
        source: json["source"],
        actions:
            json["actions"] == null ? null : Actions.fromJson(json["actions"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "text": text,
        "source": source,
        "actions": actions?.toJson(),
      };
}

class Actions {
  String? goalId;
  String? goalTitle;
  String? actionId;
  String? actionTitle;
  String? actionDetails;
  String? actionStatus;
  String? actionDatetime;
  Location? location;
  List<GemMedia>? gemMedia;

  Actions({
    this.goalId,
    this.goalTitle,
    this.actionId,
    this.actionTitle,
    this.actionDetails,
    this.actionStatus,
    this.actionDatetime,
    this.location,
    this.gemMedia,
  });

  factory Actions.fromJson(Map<String, dynamic> json) => Actions(
        goalId: json["goal_id"],
        goalTitle: json["goal_title"],
        actionId: json["action_id"],
        actionTitle: json["action_title"],
        actionDetails: json["action_details"],
        actionStatus: json["action_status"],
        actionDatetime: json["action_datetime"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        gemMedia: json["gem_media"] == null
            ? []
            : List<GemMedia>.from(
                json["gem_media"]!.map((x) => GemMedia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "goal_id": goalId,
        "goal_title": goalTitle,
        "action_id": actionId,
        "action_title": actionTitle,
        "action_details": actionDetails,
        "action_status": actionStatus,
        "action_datetime": actionDatetime,
        "location": location?.toJson(),
        "gem_media": gemMedia == null
            ? []
            : List<dynamic>.from(gemMedia!.map((x) => x.toJson())),
      };
}

class GemMedia {
  String? mediaId;
  String? gemId;
  String? mediaType;
  String? gemMedia;
  String? videoThumb;

  GemMedia({
    this.mediaId,
    this.gemId,
    this.mediaType,
    this.gemMedia,
    this.videoThumb,
  });

  factory GemMedia.fromJson(Map<String, dynamic> json) => GemMedia(
        mediaId: json["media_id"],
        gemId: json["gem_id"],
        mediaType: json["media_type"],
        gemMedia: json["gem_media"],
        videoThumb: json["video_thumb"],
      );

  Map<String, dynamic> toJson() => {
        "media_id": mediaId,
        "gem_id": gemId,
        "media_type": mediaType,
        "gem_media": gemMedia,
        "video_thumb": videoThumb,
      };
}

class Location {
  String? locationId;
  String? locationName;
  String? locationAddress;
  String? locationLatitude;
  String? locationLongitude;

  Location({
    this.locationId,
    this.locationName,
    this.locationAddress,
    this.locationLatitude,
    this.locationLongitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        locationId: json["location_id"],
        locationName: json["location_name"],
        locationAddress: json["location_address"],
        locationLatitude: json["location_latitude"],
        locationLongitude: json["location_longitude"],
      );

  Map<String, dynamic> toJson() => {
        "location_id": locationId,
        "location_name": locationName,
        "location_address": locationAddress,
        "location_latitude": locationLatitude,
        "location_longitude": locationLongitude,
      };
}
