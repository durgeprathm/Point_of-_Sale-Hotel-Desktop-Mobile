import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class AllMenuFetch {

  Future <dynamic> getAllMenuFetch() async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "0";

    String apifile = 'month_wise_menu_sales_reports.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var allsalesdata = await networkHelper.getData();
    return allsalesdata;
  }

}