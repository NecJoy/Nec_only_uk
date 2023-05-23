

import 'dart:convert';

FeedBackModel feedBackModelFromJson(String str) => FeedBackModel.fromJson(json.decode(str));

String feedBackModelToJson(FeedBackModel data) => json.encode(data.toJson());

class FeedBackModel {
    FeedBackModel({
      this.name,
      this.email,
      this.message,
      this.rating,
      this.files
    });

    String? name;
    String? email;
    String? message;
    dynamic rating;
    List? files;

    factory FeedBackModel.fromJson(Map<String, dynamic> json) => FeedBackModel(
      name: json["name"],
      email: json["emai"],
      message: json["message"],
      rating: json["rating"],
      files: json["files"],
    );

    Map<String, dynamic> toJson() => {
      "name": name,
      "email": email,
      "message": message,
      "rating": rating,
      "files": files,
    };
}
