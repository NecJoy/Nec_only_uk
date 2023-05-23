// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

SignInModel signInModelFromJson(String str) => SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
    SignInModel({
        this.loginId,
        this.password,
        this.tryCount,
    });

    String? loginId;
    String? password;
    int? tryCount;

    factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        loginId: json["loginID"],
        password: json["password"],
        tryCount: json["tryCount"],
    );

    Map<String, dynamic> toJson() => {
        "loginID": loginId,
        "password": password,
        "tryCount": tryCount,
    };
}


