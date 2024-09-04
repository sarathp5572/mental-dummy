// To parse this JSON data, do
//
//     final socialMediaModel = socialMediaModelFromJson(jsonString);

import 'dart:convert';

SocialMediaModel socialMediaModelFromJson(String str) =>
    SocialMediaModel.fromJson(json.decode(str));

String socialMediaModelToJson(SocialMediaModel data) =>
    json.encode(data.toJson());

class SocialMediaModel {
  bool? status;
  String? text;
  String? userId;
  String? firstname;
  String? email;
  String? phone;
  String? note;
  String? createdAt;
  String? dob;
  int? loggedStatus;
  String? profileurl;
  String? interests;
  String? userToken;
  bool? accountEnabled;
  String? isSubscribed;

  SocialMediaModel({
    this.status,
    this.text,
    this.userId,
    this.firstname,
    this.email,
    this.phone,
    this.note,
    this.createdAt,
    this.dob,
    this.loggedStatus,
    this.profileurl,
    this.interests,
    this.userToken,
    this.accountEnabled,
    this.isSubscribed,
  });

  factory SocialMediaModel.fromJson(Map<String, dynamic> json) =>
      SocialMediaModel(
        status: json["status"],
        text: json["text"],
        userId: json["user_id"],
        firstname: json["firstname"],
        email: json["email"],
        phone: json["phone"],
        note: json["note"],
        createdAt: json["created_at"],
        dob: json["dob"],
        loggedStatus: json["logged_status"],
        profileurl: json["profileurl"],
        interests: json["interests"],
        userToken: json["user_token"],
        accountEnabled: json["account_enabled"],
        isSubscribed: json["is_subscribed"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "text": text,
        "user_id": userId,
        "firstname": firstname,
        "email": email,
        "phone": phone,
        "note": note,
        "created_at": createdAt,
        "dob": dob,
        "logged_status": loggedStatus,
        "profileurl": profileurl,
        "interests": interests,
        "user_token": userToken,
        "account_enabled": accountEnabled,
        "is_subscribed": isSubscribed,
      };
}
