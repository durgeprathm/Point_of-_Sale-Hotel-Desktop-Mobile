import 'package:retailerp/NetworkHelper/network_helper.dart';

class SalesDelete {

  Future <dynamic> getSalesDelete(String Sales_Id) async
  {
    var map = new Map<String, dynamic>();
    map['DeleteSalesId'] = Sales_Id;

    String apifile = 'Delete_sales.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var salesdata = await networkHelper.getData();
    return salesdata;
  }

}