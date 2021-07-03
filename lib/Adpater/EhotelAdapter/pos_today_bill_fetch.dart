import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class TodayBillFetch {

  Future <dynamic> getTodayBillFetch(String Todays_Date) async
  {
    var map = new Map<String, dynamic>();
    map['medate'] = Todays_Date;
    map['actionId'] = "0";

    String apifile = 'Day_wise_Sales_reports.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var todaybilldata = await networkHelper.getData();
    return todaybilldata;
  }

}