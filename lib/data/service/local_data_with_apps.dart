class RemitterLocalDateCollaction{


 static String exchangeLCIsoCode(String countryID){
   switch(countryID) { 
      case "197": {
        return "GBP";
      } 
      case "278": {
        return "CAD";
      } 
      default: {
        return "GBP";
      } 
   } 

  }
   
  // static Map <String , String > exchangeLCIsoCode = {
  //   "197" : "GBP",
  //   "278" : "CAD"
  // };


 static String remitNoPrefix(String countryID){
   switch(countryID) { 
      case "197": {
        return "GB";
      } 
      case "278": {
        return "CA";
      } 
      default: {
        return "GBP";
      } 
   } 

  }
  // static Map <String , String> remitNoPrefix = {
  //    "197" : "GB",
  //    "278" : "CA"
  // };

  
  static String countryName(String countryID){
   switch(countryID) { 
      case "197": {
        return "UNITED KINGDOM";
      } 
      case "278": {
        return "CANADA";
      } 
      default: {
        return "UNITED KINGDOM";
      } 
   } 

  }
  // static Map <String , String > countryName = {
  //   "197" : "UNITED KINGDOM",
  //   "278" : "CANADA",
  // };




}