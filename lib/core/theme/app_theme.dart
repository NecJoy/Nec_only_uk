import 'package:flutter/material.dart';
import 'package:necmoney/core/theme/text_theme.dart';
import 'package:necmoney/core/values/app_color.dart';



class AppTheme{
    static  lighTheme(){
    return ThemeData(
      textTheme: TextThemeX.textThemeLight(),
      splashColor: AppColor.kPrimaryColor.withOpacity(0.5),
    );
  }

  static darkTheme (){
    return ThemeData(
      textTheme: TextThemeX.textThemeDark()
    );
  }
}


