// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/session_timer.dart';
import 'package:necmoney/modules/controller/send_money_base_controller.dart';
import 'package:sizer/sizer.dart';
import '../../core/values/app_color.dart';
import '../../data/enams/enum.dart';
import '../../modules/controller/base_nav_layout_controller.dart';
import '../../modules/controller/receiver_list_controller.dart';
import '../controller/transaction_history_controller.dart';
import '../screens/history/history_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/more/more_screen.dart';
import '../screens/rate/display_rate_screen.dart';
import '../screens/receiver/receiver_list_screen.dart';



class BaseNavLayoutScreen extends StatelessWidget {
  BaseNavLayoutScreen({Key? key}) : super(key: key);

  final BaseNavController _baseNavcontroller = Get.put(BaseNavController());
  final ReceiverListController _receiverListController = Get.put(ReceiverListController());
  final SendMoneyBaseController _sendMoneyBaseController = Get.put(SendMoneyBaseController());
  final TransactionHistoryController _transactionHistoryController = Get.put(TransactionHistoryController());
  final SessionTimerController _sessionTimerController = Get.put(SessionTimerController());
  final List<Widget>screens = [
    HomeScreen(),
    DisplayRateScreen(),
    ReciverListScreen(),
    HistoryScreen(),
    MoreScreen(),
  ];

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
     _sessionTimerController.checkSession = true;
    DateTime timeBackPressed = DateTime.now();
    return WillPopScope(
      onWillPop: ()async {
        if(_baseNavcontroller.currentTab.value.index == 1){
          _baseNavcontroller.currentTab.value= BaseNavScreen.HomeScreen;;
          return false;
        }else if(_baseNavcontroller.currentTab.value.index == 2){
          _baseNavcontroller.currentTab.value = BaseNavScreen.HomeScreen;
          return false;
        }
        else if(_baseNavcontroller.currentTab.value.index == 3){
          _baseNavcontroller.currentTab.value = BaseNavScreen.HomeScreen;
          return false;
        }
        else if(_baseNavcontroller.currentTab.value.index == 4){
          _baseNavcontroller.currentTab.value = BaseNavScreen.HomeScreen;
          return false;
        }else{
          final differeance = DateTime.now().difference(timeBackPressed);
          timeBackPressed = DateTime.now();
          if (differeance >= Duration(milliseconds:300 )) {
             final snack = SnackBar(content: Text('Press Double Back button to Exit'),duration: Duration(seconds: 2),);
             ScaffoldMessenger.of(context).showSnackBar(snack);
            return false;
          } else {
            SystemNavigator.pop();
            return true;
          }
        }
      }, 
      child: Scaffold(
        backgroundColor: AppColor.kWhiteColor,
        bottomNavigationBar: Container(
          width: Get.width,
          height: 56,
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.only(bottom: 15),
          color: AppColor.kWhiteColor,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: bottomnavigationitem( index : BaseNavScreen.HomeScreen, icon : 'assets/icon/home_icon.svg',label: 'home'.tr)),
              Expanded(child: bottomnavigationitem( index : BaseNavScreen.DisplayRateScreen, icon : 'assets/icon/highest_rates.svg', label : 'rate'.tr)),
              Expanded(child: bottomnavigationitem( index : BaseNavScreen.SendMoneyScreen, icon : 'assets/icon/send.svg', label : 'send'.tr)),
              Expanded(child: bottomnavigationitem( index : BaseNavScreen.HistoryScreen, icon : 'assets/icon/history_icon.svg', label : 'history'.tr)),
              Expanded(child: bottomnavigationitem( index : BaseNavScreen.MoreScreen, icon : 'assets/icon/more_icon02.svg', label : 'more'.tr)),
            ],
          ),
        ),
        body: Obx(()=> screens[_baseNavcontroller.currentTab.value.index]),
      ),
    );
  }


  
  Widget bottomnavigationitem({required Enum index, required String icon, required String label}) {
    return Obx(() => ( GestureDetector(
        onTap: _baseNavcontroller.apiProgress.value == true ? null : (){
          _baseNavcontroller.currentTab.value = index as BaseNavScreen;
          if(index == BaseNavScreen.DisplayRateScreen){
            // _displayRateController.getDisplayRate();
          }else if(index == BaseNavScreen.DisplayRateScreen){
            // _displayRateController.getDisplayRate();
          }else if (index == BaseNavScreen.HistoryScreen){
            _transactionHistoryController.endDate.value = DateTime.now().toString();
            _transactionHistoryController.remittance.clear();
            _transactionHistoryController.startDate.value = "";
          }else if(index == BaseNavScreen.SendMoneyScreen){
            // _reciverListController.getBeneficiaryData();
            _sendMoneyBaseController.pageController =  PageController(viewportFraction: 1.0);
            _receiverListController.backButton = false;
          }
          
        },
        child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: index == _baseNavcontroller.currentTab.value ? AppColor.kPrimaryColor : Colors.transparent,
              ),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(icon,color: index == _baseNavcontroller.currentTab.value ? Colors.white: AppColor.kPrimaryColor,width: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      label,style: TextStyle(
                      color: index == _baseNavcontroller.currentTab.value ?  Colors.white: Colors.black,
                      fontSize: 10.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
         )
       ),
    );
  }
}





