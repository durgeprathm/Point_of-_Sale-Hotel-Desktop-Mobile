import 'package:retailerp/NetworkHelper/network_helper.dart';

class ProductCompanyFetch {

  Future <dynamic> getProductCompanyFetch (String ProductId) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = ProductId;

    String apifile = 'Fetch_SortProductCategory.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var productcompanyfetch = await networkHelper.getData();
    return productcompanyfetch;
  }

}