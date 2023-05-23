// To parse this JSON data, do
//
//     final ResetPasswordModel = ResetPasswordModelFromJson(jsonString);

import 'dart:convert';

ResetPasswordModel ResetPasswordModelFromJson(String str) => ResetPasswordModel.fromJson(json.decode(str));

String ResetPasswordModelToJson(ResetPasswordModel data) => json.encode(data.toJson());

class ResetPasswordModel {
    ResetPasswordModel({
        this.loginId,
        this.birthDate,
    });

    String? loginId;
    DateTime? birthDate;

    factory ResetPasswordModel.fromJson(Map<String, dynamic> json) => ResetPasswordModel(
        loginId: json["loginID"],
        birthDate: DateTime.parse(json["birthDate"]),
    );

    Map<String, dynamic> toJson() => {
        "loginID": loginId,
        "birthDate": birthDate?.toIso8601String(),
    };
}
