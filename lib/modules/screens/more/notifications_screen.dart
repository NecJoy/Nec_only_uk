import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart' as badges ;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/values/app_color.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/model/push_notification_model.dart';
import '../../../data/service/database_service.dart';
import '../../../modules/controller/home_controller.dart';



class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Random _random = Random();
  HomeController _homeController = Get.put(HomeController());
  var hasFCM = false;
  Future haveNotification()async{
    final _readFCM = await DataBaseService.instance.getReadFCM();
    final _unReadFCM = await DataBaseService.instance.getUnReadFCM();
    if(_readFCM.length > 0 || _unReadFCM.length > 0){
      hasFCM = true;
      setState(() { });
    }
  }

  @override
  void initState() {
    setState(() {
      haveNotification();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor, 
      appBar: CustomAppBar(
        title: "Notifications",
        leading: IconButton(
        onPressed: (){
          Get.back();
          _homeController.calculateLenght();
          }, 
          icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back, color: AppColor.kWhiteColor),
        ),
        actions: [
          Obx(()=> badges.Badge(
              position: badges.BadgePosition.topEnd(top: 8, end: -4),
              badgeContent: Text(_homeController.notoficationLength.toString(), style: TextStyle(color: AppColor.kWhiteColor, fontSize: 12),),
              child: Icon(Icons.notifications, color: AppColor.kWhiteColor, size: 32,),
            ),
          ),
          SizedBox(width: 15,),
        ],
      ),
      body: hasFCM ? SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
             future: DataBaseService.instance.getUnReadFCM(),
              builder: (BuildContext context, AsyncSnapshot<List<PushNotificationModel>> snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting)()=> EasyLoading.show( status: 'Loading...', maskType: EasyLoadingMaskType.black); 
              if(snapshot.hasError)()=> Text("Error ${snapshot.error}");
              return snapshot.hasData ? Column(
                children: [
                  snapshot.data!.isNotEmpty ? Padding(
                    padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
                    child: Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Unread", style: TextStyle(fontSize: 18, color: AppColor.kGreyColor),),
                        TextButton(
                          onPressed: ()async{
                          await DataBaseService.instance.deleteUnreadFCM();
                          _homeController.calculateLenght();
                          setState(() {});
                          }, 
                          child: Text("Clear all".tr, style: TextStyle(fontSize: 18, color: AppColor.kSecondaryColor),),
                        ),
                      ],
                    ),
                  ) : SizedBox(),
                  Container(
                    child: Column(
                      children: snapshot.data!.map((PushNotificationModel pushNotificationModel){
                        return MessageBodyBuilder(
                          onTap: (){
                            final _data = PushNotificationModel(
                              id: _random.nextInt(1000),
                              title: pushNotificationModel.title.toString(),
                              body: pushNotificationModel.body.toString(),
                              sendTime: pushNotificationModel.sendTime,
                              imageUrl: pushNotificationModel.imageUrl.toString()
                            );
                            DataBaseService.instance.addReadFCM(_data);
                            _homeController.calculateLenght();
                            setState(() {});
                            Get.dialog(
                              CustomDialog( 
                                title: pushNotificationModel.title.toString(),
                                body: pushNotificationModel.body.toString(),
                                dateTime: Helpers.getDateTimeFormator(pushNotificationModel.sendTime.toString()),
                                image: pushNotificationModel.imageUrl.toString() == "" || pushNotificationModel.imageUrl == null ? SizedBox() : Image.network(pushNotificationModel.imageUrl.toString(), height: 100, width: 120,fit: BoxFit.fill),
                                onTap: ()async{
                                 await DataBaseService.instance.deleteUnReadFCMbyID(pushNotificationModel.id);
                                 setState(() {});
                                 Get.back();
                                },
                              ),
                            barrierDismissible: false
                          );
                        },
                        onDelete: (){
                          DataBaseService.instance.deleteUnReadFCMbyID(pushNotificationModel.id);
                          _homeController.calculateLenght();
                          setState(() {});
                        },
                        image: pushNotificationModel.imageUrl.toString() == "" || pushNotificationModel.imageUrl == null ?  null : Image.network(pushNotificationModel.imageUrl.toString()),
                        title: pushNotificationModel.title.toString(),
                        body: pushNotificationModel.body.toString(),
                        dateTime: Helpers.getDateTimeFormator(pushNotificationModel.sendTime.toString()),
                        );
                      }
                     ).toList()),
                  ),
                ],
               ) : Center(child: Text("No notification found.", style: TextStyle(fontSize: 18, color: AppColor.kBlackColor),));
              }
            ),
            FutureBuilder(
             future: DataBaseService.instance.getReadFCM(),
              builder: (BuildContext context, AsyncSnapshot<List<PushNotificationModel>> snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting)()=>EasyLoading.show( status: 'Loading...', maskType: EasyLoadingMaskType.black); 
              if(snapshot.hasError)()=> Text("Error ${snapshot.error}");
              return snapshot.hasData ? Column(
                children: [
                 snapshot.data!.isNotEmpty ? Padding(
                    padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
                    child: Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Read", style: TextStyle(fontSize: 18, color: AppColor.kGreyColor),),
                        TextButton(
                          onPressed: ()async{
                            await DataBaseService.instance.deleteReadFCM();
                            setState(() {});
                          }, 
                          child: Text("Clear all", style: TextStyle(fontSize: 18, color: AppColor.kSecondaryColor),),
                        ),
                      ],
                    ),
                  ) : SizedBox(),
                  Container(
                    child: Column(
                      children: snapshot.data!.map((PushNotificationModel pushNotificationModel){
                        return MessageBodyBuilder(
                          onTap: (){
                            Get.dialog(
                              CustomDialog(
                              title: pushNotificationModel.title.toString(),
                              body: pushNotificationModel.body.toString(),
                              dateTime: Helpers.getDateTimeFormator(pushNotificationModel.sendTime.toString()),
                              image: pushNotificationModel.imageUrl.toString() == "" || pushNotificationModel.imageUrl == "null" ? null : Image.network(pushNotificationModel.imageUrl.toString(),height: 100, width: 120, fit: BoxFit.fitWidth),
                              onTap: (){
                                setState(() {
                                  _homeController.calculateLenght();
                                });
                                Get.back();
                              },
                            ),
                            barrierDismissible: true
                          );
                        },
                        onDelete: (){
                          DataBaseService.instance.deleteReadFCMbyID(pushNotificationModel.id);
                          setState(() {});
                        },
                        image: pushNotificationModel.imageUrl.toString() == "" || pushNotificationModel.imageUrl == "null" ? null : Image.network(pushNotificationModel.imageUrl.toString()),
                        title: pushNotificationModel.title.toString(),
                        body: pushNotificationModel.body.toString(),
                        dateTime: Helpers.getDateTimeFormator(pushNotificationModel.sendTime.toString()),
                        );
                      }
                     ).toList()),
                  ),
                 ],
               ) : Text("No notification found.", style: TextStyle(
                  color: AppColor.kBlackColor,
                  fontSize: 16,
                  letterSpacing: 0.2,
               ) ,) ;
              }
            ),
          ],
        ),
      ) : Center(child: Text("No Notification Found", style: TextStyle(fontSize: 18, color: AppColor.kBlackColor))),
    );
  }
}




class CustomDialog extends StatelessWidget {
  final String?  body;
  final String? title;
  final String? dateTime;
  final VoidCallback? onTap;
  final Widget? image;
  const CustomDialog({
    Key? key, this.body, this.dateTime, this.title, this.onTap, this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
    contentPadding: EdgeInsets.zero,
    titlePadding: EdgeInsets.zero,
    insetPadding: EdgeInsets.symmetric(horizontal: 15),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onTap, 
          icon: Icon(Icons.cancel, color: AppColor.kSecondaryColor, size: 28,)
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: SvgPicture.asset('assets/icon/nec_money.svg', height: 30,),
        ),
      ],
    ),
    content: Container(
      height: Get.height * 0.75,
      width: Get.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          image != null ?  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image!,
              ],
            ) : SizedBox(),
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!, 
                    style: Theme.of(context).textTheme.headlineSmall, 
                  ),
                  SizedBox(height: 8,),
                  Text(
                    body!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 16,),
                  Text("$dateTime",style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
   );
  }
}

class MessageBodyBuilder extends StatelessWidget {
  const MessageBodyBuilder({
    Key? key, this.body, this.dateTime, this.title, this.onTap, this.onDelete, this.image
  }) : super(key: key);
  final String? title;
  final String? body;
  final String? dateTime;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final Widget? image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 8,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.kSeagreyColor),
              borderRadius: BorderRadius.circular(4)
            ),
            child: ListTile(
             dense: true,
             leading: image != null ? Container(
               color: Colors.red,
                 child: image,
             ) : null,
             title: Padding(
               padding: const EdgeInsets.symmetric(vertical: 4),
               child: Text(
                 title!, 
                 style: Theme.of(context).textTheme.headlineSmall, 
                 overflow: TextOverflow.clip,
                 maxLines: 1,
               ),
             ),
             subtitle: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   body!,
                   maxLines: 2,
                   style: Theme.of(context).textTheme.bodyMedium,
                   overflow: TextOverflow.clip
                 ),
                 SizedBox(height: 8,),
                 Text(
                   "$dateTime",
                   style: Theme.of(context).textTheme.titleSmall
                 ),
               ],
             ),
             isThreeLine: true,
             trailing: IconButton(
               onPressed: onDelete, 
               icon: Icon(Icons.delete, color: AppColor.kSecondaryColor.withOpacity(0.75),)
             ),
                ),
          ),
        ),
      ),
    );
  }
}


