// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  bool? status;
  String? text;
  String? userId;
  String? firstname;
  String? email;
  String? phone;
  String? note;
  String? dob;
  String? loggedStatus;
  String? profileurl;
  String? interests;
  String? userToken;
  bool? accountEnabled;
  String? isSubscribed;
  String? createdAt;

  SignUpModel({
    this.status,
    this.text,
    this.userId,
    this.firstname,
    this.email,
    this.phone,
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

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        status: json["status"],
        text: json["text"],
        userId: json["user_id"],
        firstname: json["firstname"],
        email: json["email"],
        phone: json["phone"],
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