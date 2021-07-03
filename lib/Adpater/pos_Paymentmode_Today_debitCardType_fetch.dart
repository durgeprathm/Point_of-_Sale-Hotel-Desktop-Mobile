import 'package:retailerp/NetworkHelper/network_helper.dart';

class TodayDebitCreditCardTypeFetch {

  Future <dynamic> getTodayDebitCreditCardTypeFetch(String Id,String date) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = Id;
    map['SalesDate'] = date;


    String apifile = 'Fetch_Todays_DebitCredit_Card.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var todaydebitcreditcardtypefetch = await networkHelper.getData();
    return todaydebitcreditcardtypefetch;
  }

}