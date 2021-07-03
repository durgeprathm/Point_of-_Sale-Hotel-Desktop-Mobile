import 'package:retailerp/NetworkHelper/network_helper.dart';

class ShopFetch {

  Future <dynamic> getshopfetch (String ShopId) async
  {
    var map = new Map<String, dynamic>();
    map['ShopId'] = ShopId;

    String apifile = 'Fetch_Shop.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var shopdata = await networkHelper.getData();
    return shopdata;
  }

}