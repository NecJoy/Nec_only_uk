
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../../../core/utils/session_timer.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_button.dart';
import '../../../core/values/app_color.dart';

class OnboardScreen extends StatefulWidget {

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}
class _OnboardScreenState extends State<OnboardScreen> {
  final SessionTimerController _sessionTimerController = Get.put(SessionTimerController());
  int _current = 0;
  bool isLoading = false;
  List imagelist = [];

  @override
  void initState() {
    _sessionTimerController.checkSession = false;
    getImageSlider();
    super.initState();
  }

  Future  getImageSlider() async{
    setState(() {isLoading = true;});
    var responce =  await http.get(Uri.parse("https://appimg.necmoney.eu/api/select-image"));
    setState(() {isLoading = false;});
    if(responce.statusCode == 200){
      var _data = jsonDecode(responce.body);
      for(var i in _data){
        setState(() {
          imagelist.add(i["slide_image"]);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        await SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColor.kWhiteColor,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                   isLoading ? SizedBox(
                    width: Get.width,
                    height: 32.h,
                    child: Shimmer.fromColors(
                      baseColor: AppColor.kBlackColor.withOpacity(0.10),
                      highlightColor: AppColor.kGreyColor.withOpacity(0.04),
                      child: Container(
                        height: 32.h,
                        width: Get.width,
                        color: AppColor.kBlackColor,
                        ),
                       ),
                      ) : CarouselSlider(
                      options: CarouselOptions(
                        height: 32.h,
                        autoPlay: true,
                        autoPlayInterval : const Duration(seconds: 3),
                        viewportFraction: 2.0,
                        enlargeCenterPage: true,
                        initialPage: 0,
                        onPageChanged: (index, resion){
                          setState(() {
                            _current = index;
                          });
                        }
                      ),
                      items: imagelist.map((i) {
                        int index = imagelist.indexOf(i); 
                        return Builder(
                          builder: (BuildContext context) {
                            return CachedNetworkImage(
                              placeholder: (context, url) =>  Center(
                                child: SizedBox(
                                  child: Shimmer.fromColors(
                                  baseColor: AppColor.kBlackColor.withOpacity(0.10),
                                  highlightColor: AppColor.kGreyColor.withOpacity(0.04),
                                  child: Container(
                                    height: 32.h,
                                    width: Get.width,
                                     color: AppColor.kBlackColor
                                   )
                                  ),
                                )
                               ),
                              imageUrl: '${imagelist[index]}'
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for(int index = 0; index <imagelist.length; index++)
                      Container(
                        width: 16.0,
                        height: 4.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: _current == index ? AppColor.kGreenColor : AppColor.kSeagreyColor,
                        ),
                       ),
                      ]
                    ),
                  ],
                ),
                AspectRatio(
                  aspectRatio: 1.7.sp,
                  child: Image.asset("assets/nec_money.jpg"),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  CustomButton(
                    buttonLevel: 'logIn'.tr,
                    color: AppColor.kSecondaryColor,
                    onPressed: (){                       
                      Get.toNamed(Routes.SIGNIN_SCREEN);
                    },
                  ),
                  SizedBox(width: 8,),
                  CustomButton(
                    buttonLevel: 'createAccount'.tr,
                    color: AppColor.kPrimaryColor,
                    onPressed: (){
                      Get.toNamed(Routes.SIGNUP_SCREEN_ONE);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



