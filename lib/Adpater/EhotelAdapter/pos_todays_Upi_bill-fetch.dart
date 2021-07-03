import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class TodayupiBillFetch {

  Future <dynamic> getTodayupiBillFetch(String Todays_Date) async
  {
    var map = new Map<String, dynamic>();
    map['medate'] = Todays_Date;
    map['actionId'] = "3";



    String apifile = 'Day_wise_Sales_reports.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var todayupibill = await networkHelper.getData();
    return todayupibill;
  }

}