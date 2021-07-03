import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class DateWiseFetch {

  Future <dynamic> getCashBillDateWiseFetch (String DateFrom, String DateTo,String Pay) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "7";
    map['sdate'] = DateFrom;
    map['edate'] = DateTo;
    map['paymodename'] = Pay;

    String apifile = 'Month_wise_Sales_reports.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var cashbilldata = await networkHelper.getData();
    return cashbilldata;
  }

}