import 'package:retailerp/NetworkHelper/network_helper.dart';

class TodaysDebitPaymentModeFetch {

  Future <dynamic> getTodaysDebitPaymentModeFetch(String PaymentMode,String todays_Date) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "0";
    map['SalesPaymentCardType'] = PaymentMode;
    map['SalesDate'] = todays_Date;

    String apifile = 'Fetch_card_Details_from_Sales.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var todaysdebitpaymentmodefetch = await networkHelper.getData();
    return todaysdebitpaymentmodefetch;
  }

}