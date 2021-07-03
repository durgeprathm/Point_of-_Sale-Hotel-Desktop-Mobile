import 'package:retailerp/NetworkHelper/network_helper.dart';

class FetchStockReport {

  Future <dynamic> getFetchStockReport() async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "0";



    String apifile = 'stock_report_product_wise.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var fetchdtockreport = await networkHelper.getData();
    return fetchdtockreport;
  }

}