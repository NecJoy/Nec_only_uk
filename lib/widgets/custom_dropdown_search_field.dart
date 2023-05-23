// ignore_for_file: deprecated_member_use
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../core/values/app_color.dart';

class CustomDropdownScarchField<T> extends StatelessWidget {
  // final List<String>? items;
  final List<T>? items;
  final T? selectedItem;
  final String? label;
  // final void Function(String?)? onChanged;
  final ValueChanged<T?>? onChanged;
  // final String? Function(String?)? validator;
    /// display if the input is invalid, or null otherwise.
  final FormFieldValidator<T>? validator;
  final DropdownSearchItemAsString<T>? itemAsString;
  final bool?   showSearchBox;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? dropDownButton;
  final bool? isFilteredOnline;
  final dynamic typeOfData;
  final TextStyle? hintStyle;
  final String? searchhintText;
  // final T? selectedItem;
  // final Future<List<String>> Function(String?)? onFind;
  final DropdownSearchOnFind<T>? onFind;
  // final String Function(String?)? itemAsString;
  final Widget Function(BuildContext, String?)? loadingBuilder;
  const CustomDropdownScarchField({
    Key? key,
    this.items,
    this.selectedItem,
    this.label,
    this.onChanged,
    this.validator,
    this.hintText,
    this.prefixIcon,
    this.dropDownButton,
    this.showSearchBox = false,
    this.onFind,
    this.itemAsString,
    this.typeOfData,
    this.isFilteredOnline,
    this.hintStyle,
    this.searchhintText,
    this.loadingBuilder
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      onFind: onFind,
      loadingBuilder: loadingBuilder ?? (BuildContext context, s){
        return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColor.kPrimaryColor, backgroundColor: AppColor.kWhiteColor,),
              SizedBox(height: 16,),
              Text("Data Loading...")
            ],
        ));
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
        validator:validator,
        showAsSuffixIcons: true,
        showSearchBox: showSearchBox ?? true,
        dropDownButton: dropDownButton ?? Icon(
          Icons.arrow_drop_down,
          size: 35,
          color: AppColor.kBlackColor,
        ),
        itemAsString:itemAsString,
        mode: Mode.BOTTOM_SHEET,
        items: items,
        label: label,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "search".tr + "$searchhintText".capitalizeFirst!.toString(),
            suffixIcon: Icon(Icons.search,color: AppColor.kBlackColor,),
            focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.kGreyColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.kGreyColor),
            ),
          )
        ),
        dropdownSearchDecoration: InputDecoration(
          prefixIcon:prefixIcon,
          hintText: hintText,
          hintStyle: hintStyle ?? Theme.of(context).textTheme.titleSmall,
          errorStyle: TextStyle(
          color: AppColor.kSecondaryColor,
          fontSize: 10.sp,
          ),
          contentPadding: EdgeInsets.only(left: 16),
          filled: true,
          fillColor: AppColor.kSeaGreenColor,
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
        ),
        onChanged: onChanged,
        selectedItem: selectedItem,
        popupShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
    );
  }
}

