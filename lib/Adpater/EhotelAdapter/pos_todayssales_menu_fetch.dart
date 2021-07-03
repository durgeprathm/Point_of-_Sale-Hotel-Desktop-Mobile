import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class TodaysMenuFetch {

  Future <dynamic> getTodaysMenuFetch(String TodaysDate) async
  {
    var map = new Map<String, dynamic>();
    map['sedate'] = TodaysDate;
    map['actionId'] = "0";

      String apifile = 'Day_wise_menu_sales_report.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var menusalesdata = await networkHelper.getData();
    return menusalesdata;
  }

}