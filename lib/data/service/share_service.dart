import 'package:share_plus/share_plus.dart';

class ShareService{

  static Future<void> shareDocument(
    {
      required String data
    })async{
    await  Share.share("$data", subject: "Share receipt");
  }
 
}