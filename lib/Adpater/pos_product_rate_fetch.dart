import 'package:retailerp/NetworkHelper/network_helper.dart';

class ProductFetchRate {

  Future <dynamic> getProductRate (String ProductId) async
  {
    var map = new Map<String, dynamic>();
    map['ProductRateId'] = ProductId;

    String apifile = 'Fetch_Product_Rate.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var posproductdata = await networkHelper.getData();
    return posproductdata;
  }

}