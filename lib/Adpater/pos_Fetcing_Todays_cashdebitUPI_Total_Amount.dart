import 'package:retailerp/NetworkHelper/network_helper.dart';

class TodaysCashDebitUpiTotalAmountFetch {

  Future <dynamic> getTodaysCashDebitUpiTotalAmountFetch(String Date,String Payment) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "1";
    map['SalesDate'] = Date;
    map['SalesPaymentMode'] = Payment;


    String apifile = 'Fetching_Todays_Total_Amount.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var todayscashdebitupitotalamountfetch = await networkHelper.getData();
    return todayscashdebitupitotalamountfetch;
  }

}