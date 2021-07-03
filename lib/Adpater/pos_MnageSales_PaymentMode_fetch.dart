import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class ManegeSalesPaymentModeFetch {

  Future <dynamic> getManageSalesPaymentModeFetch(String PaymentMode) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "6";
    map['paymodename'] = PaymentMode;

    String apifile = 'Month_wise_Sales_reports.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var managesalespaymentmodefetch = await networkHelper.getData();
    return managesalespaymentmodefetch;
  }

}