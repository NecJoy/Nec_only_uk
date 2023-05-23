
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:necmoney/data/model/display_rate_model.dart';

import '../../../core/values/app_color.dart';
import '../../../modules/controller/display_rate_controller.dart';
import '../../../modules/controller/home_controller.dart';
import '../../../routes/routes.dart';


class DisplayRateScreen extends StatefulWidget{
  DisplayRateScreen({ Key? key }) : super(key: key);

  @override
  State<DisplayRateScreen> createState() => _DisplayRateScreenState();
}

class _DisplayRateScreenState extends State<DisplayRateScreen> with WidgetsBindingObserver{
final HomeController _homeController = Get.put(HomeController());

final DisplayRateController _displayRateController = DisplayRateController();
var errorLodder = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _displayRateController.getMoneyRate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("today'sRate".tr, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
        backgroundColor: AppColor.kPrimaryColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: (){
              _homeController.calculateLenght();
              Get.toNamed(Routes.NOTIFICATION_SCREEN);
            }, 
            icon: Obx(()=> badges.Badge(
                position: badges.BadgePosition.topEnd(top: -5, end: -3),
                badgeContent: Text(_homeController.notoficationLength.toString(), style: TextStyle(color: AppColor.kWhiteColor, fontSize: 10),),
                child: Icon(Icons.notifications, color: AppColor.kWhiteColor, size: 28,),
              ),
            )
          ),
          SizedBox(width: 10,)
        ],
        // centerTitle: true,
      ),
      body: StreamBuilder<List<DisplayRateModel>>(
      stream: _displayRateController.getMoneyRate(),
      builder: (BuildContext context , AsyncSnapshot<List<DisplayRateModel>> snapshot){
          if(snapshot.hasError){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1.5,
                  child: SvgPicture.asset("assets/logo/no_data.svg"),
                ),
                Text("Database connection error! Please try again".tr,
                  style: TextStyle(
                  color: AppColor.kGreyColor,
                  fontSize: 14, 
                  ),
                ),
                SizedBox(height: 8.0,),
                if(errorLodder == false)...[
                  MaterialButton(
                  shape: const CircleBorder(),
                  color: AppColor.kPrimaryColor,
                  padding: const EdgeInsets.all(10),
                  onPressed: () async{
                    setState(() {
                      errorLodder = true;
                      _displayRateController.getMoneyRate();
                    });
                  },
                  child: const Icon(
                    Icons.refresh,
                    size: 24,
                    color: AppColor.kWhiteColor,
                  ),
                ),
                ]else...[
                  CircularProgressIndicator(color: AppColor.kGreenColor,),
                ]
              ],
            );
          }else if (snapshot.connectionState == ConnectionState.waiting){
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: SvgPicture.asset("assets/logo/no_data.svg"),
                  ),
                  CircularProgressIndicator(color: AppColor.kPrimaryColor, backgroundColor: AppColor.kWhiteColor,),
                ],
            );
          }else if (snapshot.data!.isEmpty){
            return Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1.5,
                  child: SvgPicture.asset("assets/logo/no_data.svg"),
                ),
                Text("reciverNotFound".tr,
                  style: TextStyle(
                    color: AppColor.kGreyColor,
                    fontSize: 14, 
                    ),
                ),
              ],
            );
          }else if(snapshot.hasData){
            /*
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollStartNotification) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("To day to Rate  ${snapshot.data![0].issueRate}"),
                        backgroundColor: Colors.grey[800],
                        duration: Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.fromLTRB(0, kToolbarHeight + MediaQuery.of(context).padding.top, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.0),
                        ),
                      ),
                    );

                } else if (notification is ScrollUpdateNotification) {
                  print('Scroll updated: ${notification.scrollDelta}');
                } else if (notification is ScrollEndNotification) {
                  print('Scroll ended');
                }
                return true;
              },
              child:  Column(
              children: [
                Expanded(
                  child: Scrollbar(
                    child: RefreshIndicator(
                      onRefresh: ()async{
                        setState(() {
                          _displayRateController.getMoneyRate();
                        });
                      },
                      backgroundColor: AppColor.kPrimaryColor,
                      color: Colors.white,
                      displacement: 25,
                      strokeWidth: 2,
                      child: AnimationLimiter(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index){
                              var _data = snapshot.data![index];
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 600),
                                child: SlideAnimation(
                                  // verticalOffset: 50.0,
                                  horizontalOffset: 100.0,
                                  child: FadeInAnimation(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                                      child: Card(
                                        color: AppColor.kWhiteColor,
                                        elevation: 10,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            color: AppColor.kSeaGreenColor.withOpacity(0.4),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  _data.country.toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.kGreenColor,
                                                  ),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                Text(
                                                  _data.currency + _data.issueRate,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.kSecondaryColor
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }, 
                          ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            );
             */ 
            
            return Column(
              children: [
                Expanded(
                  child: Scrollbar(
                    child: RefreshIndicator(
                      onRefresh: ()async{
                        setState(() {
                          _displayRateController.getMoneyRate();
                        });
                      },
                      backgroundColor: AppColor.kPrimaryColor,
                      color: Colors.white,
                      displacement: 25,
                      strokeWidth: 2,
                      child: AnimationLimiter(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index){
                              var _data = snapshot.data![index];
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 600),
                                child: SlideAnimation(
                                  // verticalOffset: 50.0,
                                  horizontalOffset: 100.0,
                                  child: FadeInAnimation(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                                      child: Card(
                                        color: AppColor.kWhiteColor,
                                        elevation: 10,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            color: AppColor.kSeaGreenColor.withOpacity(0.4),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  _data.country.toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.kGreenColor,
                                                  ),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                Text(
                                                  _data.currency + _data.issueRate,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.kSecondaryColor
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }, 
                          ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}



