import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class SalesDateWiseFetch {

  Future <dynamic> getSalesDateWiseFetchFetch (String DateFrom, String DateTo) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "5";
    map['sdate'] = DateFrom;
    map['edate'] = DateTo;

    String apifile = 'Month_wise_Sales_reports.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var salesdatewisefetch = await networkHelper.getData();
    return salesdatewisefetch;
  }

}