// To parse this JSON data, do
//
//     final updateMyPassword = updateMyPasswordFromJson(jsonString);

import 'dart:convert';

UpdateMPasswordModel updateMyPasswordFromJson(String str) => UpdateMPasswordModel.fromJson(json.decode(str));

String updateMyPasswordToJson(UpdateMPasswordModel data) => json.encode(data.toJson());

class UpdateMPasswordModel {
    UpdateMPasswordModel({
        this.oldPassword,
        this.password,
        this.confirmPassword,
    });

    String? oldPassword;
    String? password;
    String? confirmPassword;

    factory UpdateMPasswordModel.fromJson(Map<String, dynamic> json) => UpdateMPasswordModel(
        oldPassword: json["OldPassword"],
        password: json["Password"],
        confirmPassword: json["ConfirmPassword"],
    );

    Map<String, dynamic> toJson() => {
        "OldPassword": oldPassword,
        "Password": password,
        "ConfirmPassword": confirmPassword,
    };
}
