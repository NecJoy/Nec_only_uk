// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
    AddressModel({
        this.postcode,
        this.latitude,
        this.longitude,
        this.addresses,
    });

    String? postcode;
    double? latitude;
    double? longitude;
    List<Address>? addresses;

    factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        postcode: json["postcode"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "postcode": postcode,
        "latitude": latitude,
        "longitude": longitude,
        "addresses": List<dynamic>.from(addresses!.map((x) => x.toJson())),
    };
}

class Address {
    Address({
        this.formattedAddress,
        this.thoroughfare,
        this.buildingName,
        this.subBuildingName,
        this.subBuildingNumber,
        this.buildingNumber,
        this.line1,
        this.line2,
        this.line3,
        this.line4,
        this.locality,
        this.townOrCity,
        this.county,
        this.district,
        this.country,
    });

    List<String>? formattedAddress;
    String? thoroughfare;
    String? buildingName;
    String? subBuildingName;
    String? subBuildingNumber;
    String? buildingNumber;
    String? line1;
    String? line2;
    String? line3;
    String? line4;
    String? locality;
    String? townOrCity;
    String? county;
    String? district;
    String? country;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        formattedAddress: List<String>.from(json["formatted_address"].map((x) => x)),
        thoroughfare: json["thoroughfare"],
        buildingName: json["building_name"],
        subBuildingName: json["sub_building_name"],
        subBuildingNumber: json["sub_building_number"],
        buildingNumber: json["building_number"],
        line1: json["line_1"],
        line2: json["line_2"],
        line3: json["line_3"],
        line4: json["line_4"],
        locality: json["locality"],
        townOrCity: json["town_or_city"],
        county: json["county"],
        district: json["district"],
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "formatted_address": List<dynamic>.from(formattedAddress!.map((x) => x)),
        "thoroughfare": thoroughfare,
        "building_name": buildingName,
        "sub_building_name": subBuildingName,
        "sub_building_number": subBuildingNumber,
        "building_number": buildingNumber,
        "line_1": line1,
        "line_2": line2,
        "line_3": line3,
        "line_4": line4,
        "locality": locality,
        "town_or_city": townOrCity,
        "county": county,
        "district": district,
        "country": country,
    };
}
