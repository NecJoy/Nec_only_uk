import 'package:flutter/material.dart';
import '../core/values/app_color.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? icon;
  const CustomTextFormField({
    Key? key, 
    this.controller, 
    this.hintText, 
    this.label, 
    this.keyboardType, 
    this.obscureText = false, 
    this.suffixIcon, 
    this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        icon: icon,
        label: label != null ? Text(label!) : Text(""),
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.zero,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.kBlackColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.kBlackColor),
        ),
        hintText: hintText
      ),
    );
  }
}