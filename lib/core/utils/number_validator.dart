List numberValidator = [
  "00000000000",
  "11111111111",
  "22222222222",
  "33333333333",
  "44444444444",
  "55555555555",
  "66666666666",
  "77777777777",
  "88888888888",
  "99999999999"
];

class AccoutNumberValidator {

  static ValidatorFormate(dynamic value , int leanth){
        if(value!.isEmpty){
          return "Account number is required";
        }else if(value.length < 2){
          return "Please enter a valid account number";
        }else if ( value.toString().split("").where((element) => element.toString().contains("0")).length >= leanth){
            return "Please enter a valid account number";
        }else if (value.toString().split("").where((element) => element.toString().contains("1")).length >= leanth){
            return "Please enter a valid account number";
        }else if (value.toString().split("").where((element) => element.toString().contains("2")).length >= leanth){
            return "Please enter a valid account number";
        }else if (value.toString().split("").where((element) => element.toString().contains("3")).length >= leanth){
            return "Please enter a valid account number";
        }else if (value.toString().split("").where((element) => element.toString().contains("4")).length >= leanth){
            return "Please enter a valid account number";
        }else if (value.toString().split("").where((element) => element.toString().contains("5")).length >= leanth){
            return "Please enter a valid account number";
        }else if (value.toString().split("").where((element) => element.toString().contains("6")).length >= leanth){
            return "Please enter a valid account number";
        }else if (value.toString().split("").where((element) => element.toString().contains("7")).length >= leanth){
            return "Please enter a valid account number";
        }else if (value.toString().split("").where((element) => element.toString().contains("8")).length >= leanth){
            return "Please enter a valid account number";
        }else if (value.toString().split("").where((element) => element.toString().contains("9")).length >= leanth){
            return "Please enter a valid account number";
        }
  } 

}