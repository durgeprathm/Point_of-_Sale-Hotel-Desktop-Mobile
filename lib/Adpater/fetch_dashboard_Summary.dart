import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class FetchDashboardSummary {

  Future <dynamic> getdashboardSummary() async
  {
    var map = new Map<String, dynamic>();

    map['actionId'] = "0";
    String apifile = 'Fetch_Overall_Sales_Report.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var insertusercreate = await networkHelper.getData();
    return insertusercreate;
  }

}