
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_color.dart';
import '../../../modules/screens/sender/sender_screen_four.dart';
import '../../../modules/screens/sender/sender_screen_one.dart';
import '../../../modules/screens/sender/sender_screen_three.dart';
import '../../../modules/screens/sender/sender_screen_two.dart';
import '../../../modules/screens/documents/upload_document_screen.dart';
import '../../../routes/routes.dart';
import '../../controller/sender_detials_controller.dart';




// ignore: must_be_immutable
class SanderDetilasBaseScreen extends StatefulWidget {
 SanderDetilasBaseScreen({Key? key}) : super(key: key);

  @override
  State<SanderDetilasBaseScreen> createState() => _SanderDetilasBaseScreenState();
}

class _SanderDetilasBaseScreenState extends State<SanderDetilasBaseScreen> {
  final SenderDetailsController  _senderDetailsController = Get.put(SenderDetailsController());
  var currentScreen = 0;
  double calculateProgreessValue (pagesLength){
    var  progressvalue = currentScreen.toDouble()/ pagesLength.toDouble();
    return progressvalue; 
  }
  @override
  Widget build(BuildContext context) {
    //_senderDetailsController.getRemittersetup();
    return WillPopScope(
      onWillPop: ()async{
        if(_senderDetailsController.senderDetailsPageController.offset == 0.0){
          _senderDetailsController.senderDetailsPageController = PageController(viewportFraction: 1.0);
          Get.toNamed(Routes.BASE_NAV_LAYOUT);
          }else if (currentScreen == 4){
            _senderDetailsController.senderDetailsPageController = PageController(viewportFraction: 1.0);
            Get.toNamed(Routes.BASE_NAV_LAYOUT);
          }else{
          _senderDetailsController.senderDetailsPageController.previousPage(
            duration:Duration(microseconds: 200), curve:Curves.easeInOut,
          );
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.kGreenColor,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: (){
              if(_senderDetailsController.senderDetailsPageController.offset == 0.0){
                Get.toNamed(Routes.BASE_NAV_LAYOUT);
              }else if (currentScreen == 4){
                Get.toNamed(Routes.BASE_NAV_LAYOUT);
              }else{
                _senderDetailsController.senderDetailsPageController.previousPage(
                  duration:Duration(microseconds: 200), curve:Curves.easeInOut,
                );
              }
            },
            child: Icon(Icons.close)
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("senderDetails".tr,
              style: Theme.of(context).textTheme.labelLarge,
              ),
              SizedBox(
                height: 8,
              ),
              LinearProgressIndicator(
                value:calculateProgreessValue(5),
                backgroundColor: AppColor.kWhiteColor,
                color: AppColor.kYellow,
              ),
            ],
          ),
        ),
        body: SafeArea(
          child:PageView(
            controller:_senderDetailsController.senderDetailsPageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index){
              setState(() {
                currentScreen = index;
              });
            },
            children: [
              SenderDetailsScreenOne(),
              SenderDetailsScreenTwo(),
              SenderDetailsScreenThree(),
              SenderDetailsScreenFour(),
              UploadDocumnetScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

































