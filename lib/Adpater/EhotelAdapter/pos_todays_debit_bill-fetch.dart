import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class TodaydebitBillFetch {

  Future <dynamic> getTodaydebitBillFetch(String Todays_Date) async
  {
    var map = new Map<String, dynamic>();
    map['medate'] = Todays_Date;
    map['actionId'] = "2";



    String apifile = 'Day_wise_Sales_reports.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var todaydebitbill = await networkHelper.getData();
    return todaydebitbill;
  }

}