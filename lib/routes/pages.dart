import 'package:get/get.dart';
import 'package:necmoney/modules/screens/onboard/privacy_permission_screen.dart';
import 'package:necmoney/modules/screens/password/forgot_password_screen.dart';
import 'package:necmoney/modules/screens/sender/sender_screen_canada.dart';
import '../../../modules/screens/more/about_screen.dart';
import '../../../modules/screens/more/contactus_screen.dart';
import '../../../modules/screens/more/feedback_screen.dart';
import '../../../modules/layout/base_nav_layout_screen.dart';
import '../../../modules/layout/send_money_base_layout_screen.dart';
import '../../../modules/screens/documents/add_new_document_screen.dart';
import '../../../modules/screens/more/cancel_transaction_screen.dart';
import '../../../modules/screens/more/chat_screen.dart';
import '../../../modules/screens/more/check_rate_and_fee.dart';
import '../../../modules/screens/more/correction_transaction_screen.dart';
import '../../../modules/screens/more/faq_screen.dart';
import '../../../modules/screens/more/privacy_policy_screen.dart';
import '../../../modules/screens/more/trems_and_conditions_screen.dart';
import '../../../modules/screens/onboard/onboard_screen.dart';
import '../../../modules/screens/rate/display_rate_screen.dart';
import '../../../modules/screens/receiver/receiver_data_edit_screen.dart';
import '../../../modules/screens/sendmoney/payment_gateway_screen.dart';
import '../../../modules/screens/signin/signin_screen.dart';
import '../../../modules/screens/signup/otp_verification_screen.dart';
import '../../../modules/screens/signup/signup_screen_one.dart';
import '../../../modules/screens/signup/signup_screen_two.dart';
import '../../../modules/screens/track/track_transaction_screen.dart';
import '../../../routes/routes.dart';
import '../../../modules/screens/more/notifications_screen.dart';
import '../../../modules/screens/sender/sender_details_update_screen.dart';
import '../../../modules/screens/documents/upload_document_screen.dart';
import '../../../modules/screens/sendmoney/payment_successful_screen.dart';
import '../../../modules/screens/sender/sender_details_base_screen.dart';
import '../modules/screens/password/password_change_screen.dart';
import '../modules/screens/receiver/receiver_list_screen.dart';


class AppScreens { 
  static final screens = [
    GetPage(name: Routes.BASE_NAV_LAYOUT, page:()=> BaseNavLayoutScreen(), transition: Transition.leftToRight, transitionDuration: const Duration(milliseconds: 500)),
    GetPage(name: Routes.ONBOARD_SCREEN, page:()=> OnboardScreen(),transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.SIGNIN_SCREEN, page:()=> SigninScreen(),transition: Transition.zoom,transitionDuration: const Duration(milliseconds: 250)),
    GetPage(name: Routes.SIGNUP_SCREEN_ONE, page:()=> SignUpScreenOne(),transition: Transition.zoom,transitionDuration: const Duration(milliseconds: 250)),
    GetPage(name: Routes.SIGNUP_SCREEN_TWO, page:()=> SignUpScreenTwo(),transition: Transition.cupertino,transitionDuration: const Duration(milliseconds: 250)),
    GetPage(name: Routes.UPDATE_PASSWORD_SCREEN, page:()=> UpdatePasswordScreen(), transition: Transition.zoom,transitionDuration: const Duration(milliseconds: 250)),
    GetPage(name: Routes.DISPLAY_RATE_SCREEN, page:()=> DisplayRateScreen()),
    GetPage(name: Routes.CANCELTRANSACTION, page:()=> CancelTransaction()),
    GetPage(name: Routes.CORRECTIONTRANSACTION, page:()=> CorrectionTransaction()),
    GetPage(name: Routes.TERMS_CONDITIONS, page:()=> TermsConditionsScreen()),
    GetPage(name: Routes.SENDER_DETAILS_BASE_SCREEN, page:()=>SanderDetilasBaseScreen(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 500)),
    GetPage(name: Routes.SENDER_DETAILS_UPDATE_SCREEN , page: ()=> SenderDetailsUpdateScreen(),transition: Transition.zoom,transitionDuration: const Duration(milliseconds: 250)),
    GetPage(name: Routes.SEND_MONEY_BASE_LAYOUT, page: ()=> SendMoneyBaseLayoutScreen(),  transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 400)),
    GetPage(name: Routes.NOTIFICATION_SCREEN, page: ()=> NotificationScreen()),
    GetPage(name: Routes.TRACK_TRANSACTION, page: ()=> TrackTranscationScreen(),transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 500)),
    GetPage(name: Routes.RECEIVER_EDIT_SCREEN, page:()=>ReceiverEditScreen(), transition: Transition.zoom,transitionDuration: const Duration(milliseconds: 250)),
    GetPage(name: Routes.RECEIVER_LIST_SCREEN, page:()=>ReciverListScreen(), transition: Transition.zoom,transitionDuration: const Duration(milliseconds: 250)),
    GetPage(name: Routes.FAQ_SCREEN, page:()=>FaqScreen()),
    GetPage(name: Routes.CHAT_SCREEN, page:()=>ChatScreen()),
    GetPage(name: Routes.OTP_VERIFICATION_SCREEN, page:()=>OTPVerificationScreen(),transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 500)),
    GetPage(name: Routes.PAYMENT_SUCCESSFUL_SCREEN, page: ()=> PaymentSuccessfulScreen()),
    GetPage(name: Routes.CHECK_RATE_FEE, page: ()=> CheckRateAndFee()),
    GetPage(name: Routes.UPLOAD_DOCUMENT_SCREEN, page: ()=> UploadDocumnetScreen()),
    GetPage(name: Routes.ADD_NEW_DOCUMNETS, page:()=> AddNewDocumentScreen()),
    GetPage(name: Routes.PAYMENT_GATEWAY_SCREEN, page:()=> PaymentGatewayScreen()),
    GetPage(name: Routes.CHECK_RATE_AND_FEE, page:()=> CheckRateAndFee(),transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 500)),
    GetPage(name: Routes.CONTARCT_SCREEN, page:()=> ContactScreen(),transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 500)),
    GetPage(name: Routes.FEEDBACK_SCREEN, page:()=> FeedbackScreen(),transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 500)),
    GetPage(name: Routes.ABOUT_SCREEN, page:()=> AboutUsScreen()),
    GetPage(name: Routes.PRIVACY_POLICY_SCREEN, page:()=> PrivacyPolicyScreen()),
    GetPage(name: Routes.TERMS_AND_CONDITION_SCREEN, page:()=> TermsConditionsScreen()),
    GetPage(name: Routes.ADD_NEW_DOCUMENT_SCREEN, page:()=> AddNewDocumentScreen(),transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 500)),
    GetPage(name: Routes.FORGOT_PASSWORD, page:()=> ForgotPasswordScreen(), transition: Transition.zoom,transitionDuration: const Duration(milliseconds: 250)),
    GetPage(name: Routes.PRIVACY_PERMISSION, page:()=> PrivacyPermission()),
    GetPage(name: Routes.SENDER_INFO_SCREEN_CANADA, page:()=> SenderInfoScreenCanada()),
  ];
} 

