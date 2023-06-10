// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? status;
  int? error;
  Messages? messages;

  UserModel({
    this.status,
    this.error,
    this.messages,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        error: json["error"],
        messages: json["messages"] == null
            ? null
            : Messages.fromJson(json["messages"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "messages": messages?.toJson(),
      };
}

class Messages {
  String? userId;
  String? username;
  String? pin;
  String? age;
  String? hobby;
  String? error;
  DateTime? createdAt;

  Messages({
    this.userId,
    this.username,
    this.pin,
    this.age,
    this.hobby,
    this.error,
    this.createdAt,
  });

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        userId: json["user_id"],
        username: json["username"],
        pin: json["pin"],
        age: json["age"],
        hobby: json["hobby"],
        error: json["error"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "pin": pin,
        "age": age,
        "hobby": hobby,
        "error": error,
        "created_at": createdAt?.toIso8601String(),
      };
}
