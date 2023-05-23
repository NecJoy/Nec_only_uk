import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../values/app_color.dart';

class TextThemeX{
  static TextTheme textThemeLight(){
    return TextTheme(
      displayMedium: TextStyle( fontSize: 19.sp,color: AppColor.kWhiteColor,fontWeight: FontWeight.w600),
      displaySmall: TextStyle(fontSize: 17.sp,color: AppColor.kBlackColor,fontWeight: FontWeight.w400),
      headlineMedium: TextStyle( fontSize: 18.sp,color: AppColor.kGreenColor,fontWeight: FontWeight.w500),
      headlineSmall: TextStyle(fontSize: 13.sp,color: AppColor.kGreenColor,fontWeight: FontWeight.w500),
      titleLarge: TextStyle(fontSize: 15,color: AppColor.kGreyColor,fontWeight: FontWeight.w500),
      labelLarge: TextStyle(fontSize: 14.sp,color: AppColor.kWhiteColor,fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 12.sp,color: AppColor.kBlackColor,fontWeight: FontWeight.normal),
      
      //This Color Use Text Button : titleSmall
      titleSmall: TextStyle(fontSize: 11.sp,color: AppColor.kGreyColor,fontWeight: FontWeight.w400),
      bodyLarge: TextStyle(fontSize: 14.sp,color: AppColor.kBlackColor,fontWeight: FontWeight.w500),
      //bodyMedium : use normal body text 
      bodyMedium: TextStyle(fontSize: 12.sp,color: AppColor.kBlackColor,fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontSize: 10.sp,color: AppColor.kSecondaryColor,fontWeight: FontWeight.w600),
    );
  }


  static TextTheme  textThemeDark(){
    return TextTheme(
      displayMedium: TextStyle( fontSize: 34,color: AppColor.kWhiteColor,fontWeight: FontWeight.w600),
    );
  }
}



