import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class TodaysSalesPaymentModeFetch {

  Future <dynamic> getTodaysSalesPaymentModeFetch(String todays_Paymode,String todays_Date) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "6";
    map['paymodename'] = todays_Paymode;
    map['paymodedate'] = todays_Date;

    String apifile = 'Day_wise_Sales_reports.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var todaysalespaymentmodefetch = await networkHelper.getData();
    return todaysalespaymentmodefetch;
  }

}