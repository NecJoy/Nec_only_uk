

class Strings {
    //Web view page url
  static String termsConditionUrl = "https://necmoney.com/term-condition.php";

  static String privacyPolicyUrl = "https://necmoney.com/privacy.php";

  static String aboutUsUrl = "https://necmoney.com/about.php";

  static String faqPageUrl = "https://necmoney.com/nec-faqs.php";

  static String twakUrl = "https://tawk.to/chat/5ca7226153f1e453fb8c42ea/default";
  
  static String supportNumberNecMoney = "4402037696109";
  static String whatsAppPhoneNumber = "+8801319992612";
  static String necMoneyUrl = "https://necmoney.com/";

  static String playRatingUrl = "https://play.google.com/store/apps/details?id=com.necmoney.necmoneyapp";
  static String appStoreRatingUrl = "https://apps.apple.com/us/app/nec-money/id1476959641";
  //Base url
  // TT issue date time change And Link change

  //static String baseUrl = "https://uat.necmoney.eu/Mobile/api";
  static String baseUrl = "https://mapp.necmoney.com/api";
  //static String baseUrl = "https://mapp.necmoney.app/necmoneyonlinepay/api";
  static String countryUrl = "GlobalService/GetRegisterCountries";
  static String birthCountryUrl = "GlobalService/GetCountriesByModeID?ModeID=1";
  static String getRemitterWithDependencies   = "GlobalService/GetRemitterWithDependencies";
  static String countryCityUrl = "GlobalService/GetCities?Filter=Bangladesh&CountryId=23";
  static String saveProgileUrl = "GlobalService/SaveProfile";
  static String  getBenefsForTT ="GlobalService/GetBenefsForTTIssue?status=1";
  static String documentUpload = "GlobalService/UploadDoxs";
  static String remitterDocumentTypes = "GlobalService/GetRemitterSetupAndDoxs?remitterTypeID=";
  static String issuedPlace = "GlobalService/GetRemitterWithDependencies?RemitterID=0";
  static String updateMyPasswordUrl = "UserService/UpdateMyPassword";
  static String incomeSources = "GlobalService/GetRemitterWithDependencies?RemitterID=0";
  static const String addressBaseUrl = "https://api.getaddress.io/find";
  static const String postCode = "nn13er"; 
  static const String addressApiKey = "1CJ_HdTvNU6r2-DZW7DAeQ34691";




  //Url
  static String loginUrl = "UserService/Login";
  static String fromCountryUrl =  "admin/country";
  static String activationUrl = "UserService/ActivateNow";
  static String resendActivationUrl = "UserService/ResendActivationCode";
  static String toCountryUrl =  "admin/country";
  static String registerUrl = "UserService/Register";
  static String resetPasswordUrl = "UserService/ResetPassword";
  static String updatePasswordUrl = "UserService/UpdateMyPassword";
  static String displayRateUrl = "MiscService/GetDisplayRate?IncludeLastTran=true";
  static String transactionHistoryUrl = "MiscService/GetByRemitter?";
  static String cancelTransaction = "MiscService/ApplyForCancel";
  static String correctionTransaction = "MiscService/ApplyForCorrection";
  static String paymentTypeUrl = "GlobalService/GetPaymentModes?Status=0";
  static String getCountriesUrl = "GlobalService/GetCountriesByModeID?";
  static String getSubcompaniesUrl = "GlobalService/GetSubcompanies?";
  static String getCountryPayCity = "GlobalService/GetSubcompaniesCities?";
  static String getSubcompaniesBranchesUrl = "GlobalService/GetSubcompanyBranches?";
  static String getCurrenciesUrl = "GlobalService/GetCurrenciesByModeID?";
  static String getSubcompaniesCitysUrl = "GlobalService/GetSubcompaniesCities?";
  static String trackTransactionUrl = "GlobalService/TrackRemittance";
  static String getBankCitiesUrl = "GlobalService/GetBankCities?";
  static String getBankBranchesUrl = "GlobalService/GetBankBranches?";
  static String saveReceiver ="GlobalService/SaveBeneficiary";
  static String getDealingRate ="GlobalService/GetDealingRate?";
  static String saveRemittance = "GlobalService/SaveRemittance";
  static String getCustomerCommission = "GlobalService/GetCustomerCommission?";
  static String report = " https://mapp.necmoney.com/Reports/";
    // static String report = "https://mapp.necmoney.app/necmoneyonlinepay/Reports/";
    // static String report = "https://uat.necmoney.eu/Mobile/Reports/";
    // static String report = "https://uat2.necmoney.eu/Mobile/Reports/";
  static String getRemitter = "GlobalService/GetRemitterWithDependencies?";
  static String relationshipUrl = "GlobalService/GetBenefDependencies?beneficiaryID=0";
  static String instrumentUrl = "GlobalService/GetBenefsForTTIssue?";
  static String purposeUrl = "GlobalService/GetBenefsForTTIssue?";
  static String createTxn365Token = "MiscService/createTxn365Token";


  static String personaldataUrl = "";
  static String addressUpdateUrl = "";
  static String EuResidench = "Eu Residench";
  static String DateofBirth = "Date of birth";
  static String DocumentDateIssue = "Document date issue";
  static String DocumentDateExpire = "Document date expire";
  static String SavingsAccountTypeID = "193";


  //Receiver Details
  static String newReceiver  = "New Receiver";
  static String oldReceiver = "Old Receiver";
  static String fromSendMoney  = "From Send Money";
  static String deliveryMethod = "Delivery Method";
  static String hideSenderInfo = "Hide sender info";
  static String hideSenderInfoBack = "Hide sender info back";
  static String accountPayee = "ACCOUNT PAYEE";
  static String agree = "agree";

  static String oldRecevierTransaction  =  "Old Recevier Transaction";
  static String newRecevierTransaction  =  "New Recevier Transaction";
  // visa Card payment 
  static const String visaMasterCardPayment = "Visa Master Card Payment";
  static const String unKnown = "UnKnown";

  static String playStoreLink = "https://play.google.com/store/apps/details?id=com.necmoney.necmoneyapp";

  static String appStoreLink = "https://apps.apple.com/us/app/nec-money/id1476959641";

  static const String dummyPdf = "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
  //Payment Type 

  static const String bank = "Bank";
  static const String cash = "Cash";
  static const String wallet = "Wallet";

  static const String loginID = "loginID";
  static const String birthDate = "birthDate";
  static const String canadaSupport = "13065001823";
  static const String successfully = "Beneficiary saved successfully...";
  static const String activated = "You are already activated";
  static const String idPasswordNotMatch = "LoginID or Password does not match.";
  static const String alreadyRegistered = "Yor are already registered, Please activate your account...";
  static const String unAssigned = "Invalid use of Integer operation on ID of type: Unassigned";

}


