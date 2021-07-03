import 'package:retailerp/NetworkHelper/network_helper.dart';

class FetchPaymentMode {

  Future <dynamic> getFetchPaymentMode() async
  {
    var map = new Map<String, dynamic>();
    map['actionid'] = "0";


    String apifile = 'Fetch_All_paymode_type.php';
    NetworkHelper networkHelper = new NetworkHelper(
        apiname: apifile, data: map);
    var fetchpaymentmode = await networkHelper.getData();
    return fetchpaymentmode;
  }
}