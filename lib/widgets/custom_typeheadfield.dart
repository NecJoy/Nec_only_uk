import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../core/values/app_color.dart';
class CustomTypeheadField<T> extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final FutureOr<Iterable<T>> Function(String ) suggestionsCallback ;
  final Widget Function(BuildContext, T) itemBuilder;
  final void Function(T) onSuggestionSelected;
  final String? noData ;
  final int? maxLines;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final FocusNode? focusNode ;
  final AxisDirection? direction;
  final Widget? suffixIcon;
  final  bool hideKeyboard;
  final void Function()? onTap;
  const CustomTypeheadField({
    Key? key,
    this.controller,
    required this.suggestionsCallback,
    required this.itemBuilder,
    required this.onSuggestionSelected,
    required this.hintText,
    this.noData,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.focusNode,
    this.direction,
    this.suffixIcon,
    this.onTap,
    this.hideKeyboard = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<T>(
    direction: direction ?? AxisDirection.up,
    noItemsFoundBuilder: (BuildContext context){
        return Center(child: Text("Data not found"));
    },
    loadingBuilder: (BuildContext context){
      return Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColor.kPrimaryColor, backgroundColor: AppColor.kWhiteColor,),
            SizedBox(height: 16,),
            Text("Data Loading...")
          ],
      ));
    },
    suggestionsBoxController: SuggestionsBoxController(
      
    ),
    hideKeyboard: hideKeyboard,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    suggestionsBoxDecoration:SuggestionsBoxDecoration(
      color: AppColor.kWhiteColor,
      shadowColor: AppColor.kWhiteColor,
      borderRadius: BorderRadius.circular(12),
      
    ) ,
    textFieldConfiguration: TextFieldConfiguration(
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      onTap: onTap,
      controller: controller,
      focusNode: focusNode,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintMaxLines: 3,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        hintText: hintText,
        fillColor: AppColor.kSeaGreenColor,
        suffixIcon: suffixIcon ?? Icon(Icons.arrow_drop_down, size: 33, color: AppColor.kBlackColor,),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.kGreenColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.kGreenColor),
        ),
        focusedErrorBorder:OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.kGreenColor),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.kSecondaryColor),
        ),
      )
    ),
    suggestionsCallback: suggestionsCallback,
    itemBuilder: itemBuilder,
    errorBuilder: (context, suggestion){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text("$noData")),
      );
    },
    onSuggestionSelected: onSuggestionSelected,
    validator:validator,
    
    );
  }
}

















