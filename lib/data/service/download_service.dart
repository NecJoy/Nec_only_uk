// import 'dart:io';


import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'dart:async';

class DownloadService{

  static const debug = true;

  static Future<void> requestDownload({required String link}) async {
    if(Platform.isAndroid ){
      Directory? androidDirectory = await getExternalStorageDirectory();
      final taskId = await FlutterDownloader.enqueue(
        url: link,
        fileName: link.split("/").last,
        savedDir: androidDirectory!.path,
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
        saveInPublicStorage: true,
     );
      if(taskId != null){
        OpenFilex.open("${androidDirectory.path}/${link.split("/").last}}"); //When get api then change dummy.pdf file name
      }
    } else {
      Directory? iosDirectory = await getLibraryDirectory();
      final taskId = await FlutterDownloader.enqueue(
        url: link,
        fileName: link.split("/").last,
        savedDir: iosDirectory.path,
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
        saveInPublicStorage: true,
     );
     if(taskId != null){
        OpenFilex.open("${iosDirectory.path}/${link.split("/").last}}");//When get api then change dummy.pdf file name
      }
    }
  
  }
  

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    if (debug) {
      print('Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    }
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }


}