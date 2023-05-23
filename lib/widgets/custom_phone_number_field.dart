// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:necmoney/core/values/app_color.dart';
import 'package:sizer/sizer.dart';

import '../dependency/phone_number_field/countries.dart';
import '../dependency/phone_number_field/intl_phone_field.dart';
import '../dependency/phone_number_field/phone_number.dart';




class CustomPhoneNumberField extends StatelessWidget {
  final void Function(PhoneNumber)? onChanged;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final List<String>? country = ["BD", "IN","GB"];
  List<String>? countryIsoCode = ["BD","NG","PK","GB"];
  final void Function(PhoneNumber?)? onSaved;
  final void Function(Country)? onCountryChanged;
  final void Function(String)? onSubmitted;
  final bool? autofocus;
  final String? flag;
  final String? initialCountryCode;
  final String? hintText;
  final TextStyle? hintStyle;
  final  Widget? label;
 final  List<TextInputFormatter>? inputFormatters;
  CustomPhoneNumberField({
    Key? key,
    this.onChanged,
    this.controller,
    this.suffixIcon,
    this.onSaved,
    this.onCountryChanged,
    this.onSubmitted,
    this.autofocus,
    this.countryIsoCode,
    this.flag,
    this.initialCountryCode,
    this.hintText,
    this.hintStyle,
    this.label,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntlPhoneField(
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          autofocus: autofocus ?? false,
          readOnly: false,
          flag: flag,
          controller: controller,
          // showCountryFlag: false,
          initialCountryCode: initialCountryCode == null ? "BD" : initialCountryCode,
          onSaved: onSaved,
          // showDropdownIcon: false,
          onCountryChanged: onCountryChanged,
          textInputAction: TextInputAction.done,
          inputFormatters: inputFormatters ?? [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            LengthLimitingTextInputFormatter(15),
           // FilteringTextInputFormatter.deny(RegExp(r'^0+')),
          ],
          disableLengthCheck:false,
          countries: countryIsoCode,
          dropdownIconPosition: IconPosition.trailing,
          dropdownIcon: Divider(),
          flagsButtonPadding: EdgeInsets.only(left: 8),
          decoration: InputDecoration(
            label: label,
            isDense: true,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: hintStyle,
            filled: true,
            fillColor: AppColor.kSeaGreenColor,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.kGreenColor,
              ),
            ),
            errorStyle: TextStyle(
              color: AppColor.kSecondaryColor,
              fontSize: 10.sp,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.kGreenColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.kGreenColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.kGreenColor),
            ),
            contentPadding: EdgeInsets.all(0)
          ),
        ),
      ],
    );
  }
}

