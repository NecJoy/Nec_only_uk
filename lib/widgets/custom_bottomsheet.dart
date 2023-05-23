import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:necmoney/core/values/app_color.dart';
import 'package:necmoney/widgets/custom_outline_button.dart';


class CustomBottomSheet extends StatelessWidget {
  final  void Function() confirmPressed;
  final  void Function() editPressed;
  const CustomBottomSheet({
    Key? key,
    required this.confirmPressed,
    required this.editPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
        height: Get.height/2.5,
        width: Get.width,
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                alignment: Alignment.topRight,
                width: Get.width,
                child: Icon(Icons.cancel_outlined,color: AppColor.kPrimaryColor,),
              ),
            ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.kSeaGreenColor,
                ),
                child: Center(
                  child: SvgPicture.asset('assets/icon/lock_icon.svg'),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text('confirmYourInformaiton'.tr,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Text('yourInformationShouldExactlyMatchwhat\'sonYourID.MismatchedInformationWillDelayyourTtransfer.'.tr,
              textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              SizedBox(
              height: 32,
              ),
            Column(
              children: [
                  CustomOutlineButton(
                  buttonLevel: 'Confirm',
                  color: AppColor.kWhiteColor,
                  onPressed: confirmPressed,
                  width: Get.width/1.2,
                  borderColor: AppColor.kPrimaryColor,
                  levelColor: AppColor.kPrimaryColor,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CustomOutlineButton(
                    buttonLevel: 'Edit',
                    color: AppColor.kWhiteColor,
                    onPressed: editPressed,
                    width: Get.width/1.2,
                    borderColor: AppColor.kPrimaryColor,
                    levelColor: AppColor.kPrimaryColor,
                  ),
                ],
              ),
            ],
         ),
        );
  }
}

// showModalBottomSheet(
//   context: context,
//   shape:RoundedRectangleBorder(
//     borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//         ),
//   ),
//   builder: (BuildContext context){
//       return CustomBottomSheet(
//         confirmPressed: (){},
//         editPressed: (){},
//       );
//     },
// );