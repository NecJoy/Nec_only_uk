// To parse this JSON data, do
//
//     final pushNotificationModel = pushNotificationModelFromJson(jsonString);

import 'dart:convert';

PushNotificationModel pushNotificationModelFromJson(String str) => PushNotificationModel.fromJson(json.decode(str));

String pushNotificationModelToJson(PushNotificationModel data) => json.encode(data.toJson());

class PushNotificationModel {
    PushNotificationModel({
        this.id,
        this.title,
        this.body,
        this.sendTime,
        this.imageUrl
    });
    int? id;
    String? title;
    String? body;
    DateTime? sendTime;
    String? imageUrl;

    factory PushNotificationModel.fromJson(Map<String, dynamic> json) => PushNotificationModel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        sendTime: json["sendTime"] != null ? DateTime.parse(json["sendTime"]) : null,
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
      "id": id,
      "title": title,
      "body": body,
      "sendTime": sendTime?.toIso8601String(),
      "imageUrl": imageUrl
    };
}
