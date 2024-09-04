// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) =>
    VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  bool? status;
  String? text;
  String? userId;
  String? firstname;
  String? email;
  String? phone;
  String? countryCode;
  String? note;
  String? dob;
  String? loggedStatus;
  String? profileurl;
  String? interests;
  String? userToken;
  bool? accountEnabled;
  String? isSubscribed;
  String? createdAt;

  VerifyOtpModel({
    this.status,
    this.text,
    this.userId,
    this.firstname,
    this.email,
    this.phone,
    this.countryCode,
    this.note,
    this.dob,
    this.loggedStatus,
    this.profileurl,
    this.interests,
    this.userToken,
    this.accountEnabled,
    this.isSubscribed,
    this.createdAt,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
        status: json["status"],
        text: json["text"],
        userId: json["user_id"],
        firstname: json["firstname"],
        email: json["email"],
        phone: json["phone"],
        countryCode: json["country_code"],
        note: json["note"],
        dob: json["dob"],
        loggedStatus: json["logged_status"],
        profileurl: json["profileurl"],
        interests: json["interests"],
        userToken: json["user_token"],
        accountEnabled: json["account_enabled"],
        isSubscribed: json["is_subscribed"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "text": text,
        "user_id": userId,
        "firstname": firstname,
        "email": email,
        "phone": phone,
        "country_code": countryCode,
        "note": note,
        "dob": dob,
        "logged_status": loggedStatus,
        "profileurl": profileurl,
        "interests": interests,
        "user_token": userToken,
        "account_enabled": accountEnabled,
        "is_subscribed": isSubscribed,
        "created_at": createdAt,
      };
}
