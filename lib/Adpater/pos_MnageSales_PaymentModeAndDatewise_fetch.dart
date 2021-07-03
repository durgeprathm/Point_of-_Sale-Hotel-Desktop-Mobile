import 'package:retailerp/NetworkHelper/network_helper.dart';

class ManegeSalesPaymentModeDateWiseFetch {

  Future <dynamic> getManageSalesPaymentModeDateWiseFetch(String paymentmode,String Datefrom,String dateto) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "1";
    map['SalesPaymentMode'] = paymentmode;
    map['sdate'] = Datefrom;
    map['edate'] = dateto;

    String apifile = 'Fetch_ManageSalesPayment_Mode.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var managesalespaymentmodedatewisefetch = await networkHelper.getData();
    return managesalespaymentmodedatewisefetch;
  }

  Future<dynamic> getManageSalesDateWiseFetch(
      String Datefrom, String dateto) async {
    var map = new Map<String, dynamic>();
    map['sdate'] = Datefrom;
    map['edate'] = dateto;

    String apifile = 'fetch_sales_sortby_date.php';
    NetworkHelper networkHelper =
    new NetworkHelper(apiname: apifile, data: map);
    var managesalespaymentmodedatewisefetch = await networkHelper.getData();
    return managesalespaymentmodedatewisefetch;
  }

}