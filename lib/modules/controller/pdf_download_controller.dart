
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:necmoney/core/utils/helpers.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PdfDownloadController extends GetxController {
  Dio dio = Dio();
  var downloadStart = false.obs;
  var progressValue = "".obs;
  var indexNumber = "0".obs;
  Future downLoadPdf (String fileName, String pdfurl)async{
    downloadStart.value = true;
    try{
    var dir =  await getTemporaryDirectory();
    await dio.download(
      pdfurl,
      "${dir.path}/$fileName",
       onReceiveProgress: (int x , int y){
         progressValue.value = ((x / y) * 100).toStringAsFixed(0);
         pdfview("${dir.path}/$fileName",);
       }
      );
     Helpers.showAlartMessageWidget(msg: "Receipt download complete. File Opening, You save file");
     downloadStart.value = false;
    }catch(e){
      downloadStart.value = false;
      Helpers.dengerAlert(message: "Your receipt copy not found");
    }
  }
  
  void pdfview (String? filePath){
     OpenFile.open(filePath);
  }

}