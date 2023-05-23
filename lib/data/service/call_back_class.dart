import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:necmoney/core/utils/log.dart';

class CallBackClass{
  static void callback(String id, DownloadTaskStatus status, int progress) {
    Logger(key: "Progress", value: progress);
    Logger(key: "Status", value: status);
    Logger(key: "Id", value: id);
  }
}