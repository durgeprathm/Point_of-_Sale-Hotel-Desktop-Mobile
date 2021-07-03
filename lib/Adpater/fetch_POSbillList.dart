
import 'package:retailerp/NetworkHelper/network_helper.dart';

class POSBillList {

  Future <dynamic> getBillList (String date) async
  {
    var map = new Map<String, dynamic>();
    map['TodaysDate'] = date;

    String apifile = 'fetch_POStodaybill.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var menuList  = await networkHelper.getData();
    return menuList;
  }

}