import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class FetchDailyCalculation {

  Future <dynamic> getdailyCalculation(String date) async
  {
    var map = new Map<String, dynamic>();

    map['actionId'] = "0";
    map['Paymodedate'] = date;

    String apifile = 'Fetch_Daily_Sales_Calculation_New.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var insertusercreate = await networkHelper.getData();
    return insertusercreate;
  }

}