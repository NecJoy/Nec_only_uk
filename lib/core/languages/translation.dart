
import 'package:get/get.dart';
import 'package:necmoney/core/languages/bn.dart';
import 'package:necmoney/core/languages/en-us.dart';


class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'bn': bn,
    'en_US': en_US,
  };
}