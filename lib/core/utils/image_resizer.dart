

import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';

class ImageResizer {
  static Future<File> compressFile(File file) async{
    File compressedFile = await FlutterNativeImage.compressImage(file.path,quality: 5,);
    return compressedFile;
  }
}