import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/values/app_color.dart';

class CustomRateCheckField extends StatelessWidget {
  final String? hintext;
  final String? currencyname;
  final Widget? label;
  final String? countryflag;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? Function(String?)?onChanged; 
  final Function(String)? onFieldSubmitted;
  final FocusNode?  focusNode;
  final List<TextInputFormatter>? inputFormatters;
  const CustomRateCheckField({
    Key? key,
    this.hintext,
    this.currencyname,
    this.countryflag,
    this.controller,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.label,
    this.inputFormatters,
    this.onFieldSubmitted
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      focusNode: focusNode,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: onFieldSubmitted,
      // keyboardType: TextInputType.numberWithOptions(decimal: true,signed: true),
      keyboardType : TextInputType.number,
      inputFormatters: inputFormatters ?? [
        FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
        LengthLimitingTextInputFormatter(15),
      ],
      decoration: InputDecoration(
        hintText:hintext,
        hintStyle: TextStyle(color: AppColor.kBlackColor, fontSize: 14),
        label: label,
        isDense: true,
        filled: true,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            currencyname!.toUpperCase(),
            style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.kBlackColor,
            ),
          ),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColor.kWhiteColor,
            radius: 10,
            child: ClipRRect(
              child: SvgPicture.asset("$countryflag"),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        fillColor: AppColor.kSeaGreenColor,
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
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.kSecondaryColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.kGreenColor),
        ),
      ),
    );
  }
}