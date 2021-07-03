import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class SalesFetchAllDetails {

  Future <dynamic> getSalesFetch(String Sales_Id) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = Sales_Id;

    String apifile = 'Month_wise_Sales_reports.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var salesdata = await networkHelper.getData();
    return salesdata;
  }

}