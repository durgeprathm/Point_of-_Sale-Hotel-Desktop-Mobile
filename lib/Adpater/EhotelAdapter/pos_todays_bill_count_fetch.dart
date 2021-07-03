import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class TodayCountBillFetch {

  Future <dynamic> getTodayCountBillFetch(String Todays_Date) async
  {
    var map = new Map<String, dynamic>();
    map['medate'] = Todays_Date;
    map['actionId'] = "4";



    String apifile = 'Day_wise_Sales_reports.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var todaycountbill = await networkHelper.getData();
    return todaycountbill;
  }

}