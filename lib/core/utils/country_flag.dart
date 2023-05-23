
List CountryFlag = [
 "assets/country_flag/austria.svg",
 "assets/country_flag/canada.svg",
 "assets/country_flag/cyprus.svg",
 "assets/country_flag/french.svg",
 "assets/country_flag/germany.svg",
 "assets/country_flag/greece.svg",
 "assets/country_flag/italy.svg",
 "assets/country_flag/new_zealand.svg",
 "assets/country_flag/portugal.svg",
 "assets/country_flag/south_africa.svg",
 "assets/country_flag/spain.svg",
 "assets/country_flag/united_kingdom.svg",
 "assets/country_flag/bangladesh.svg",
 "assets/country_flag/bolivia.svg",
 "assets/country_flag/india.svg",
 "assets/country_flag/ireland.svg",
 "assets/country_flag/pakistan.svg",
  "assets/country_flag/sri.svg",
  "assets/country_flag/demo_flag.svg",
];

Map<String, dynamic> countryflag = {
  'AUSTRIA' : CountryFlag[0],
  'CANADA' : CountryFlag[1],
  'CYPRUS': CountryFlag[2],
  'FRANCE' : CountryFlag[3],
  'GERMANY' :CountryFlag[4],
  'GREECE': CountryFlag[5],
  'ITALY' : CountryFlag[6],
  'NEW ZEALAND' : CountryFlag[7],
  'PORTUGAL': CountryFlag[8],
  'SOUTH AFRICA' : CountryFlag[9],
  'SPAIN' : CountryFlag[10],
  'UNITED KINGDOM' : CountryFlag[11],
  'BANGLADESH': CountryFlag[12],
  'BOLIVIA': CountryFlag[13],
  'INDIA': CountryFlag[14],
  'IRELAND': CountryFlag[15],
  'PAKISTAN': CountryFlag[16],
  'DEMO': CountryFlag[18]
};


class flagWithCountry {
  static showflagWithCountry(countryID){
    switch(countryID){
      case "18":{
        return CountryFlag[0];
      }
      case "278" : {
        return CountryFlag[1];
      }
      case "275" : {
        return CountryFlag[2];
      }
      case "86" : {
        return CountryFlag[3];
      }
      case "91" : {
        return CountryFlag[4];
      }case "99" : {
        return CountryFlag[5];
      }
      case "123" : {
        return CountryFlag[6];
      }
      case "NEW ZEALAND" : {
        return CountryFlag[7];
      }
      case "192" : {
        return CountryFlag[8];
      }
      case "198" : {
        return CountryFlag[9];
      }
      case "223" : {
        return CountryFlag[10];
      }
      case "197" : {
        return CountryFlag[11];
      }
      case "23" : {
        return CountryFlag[12];
      }
      case "BOLIVIA" : {
        return CountryFlag[13];
      }
      case "115" : {
        return CountryFlag[14];
      }
      case "IRELAND" : {
        return CountryFlag[15];
      }
      case "179" : {
        return CountryFlag[16];
      }
      default: {
        return CountryFlag[18];
      } 
    }

  }
}
