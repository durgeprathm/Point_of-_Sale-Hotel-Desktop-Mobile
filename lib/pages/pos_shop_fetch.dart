
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class ShopFetch {

  Future <dynamic> getshopfetch (String ShopId) async
  {
    var map = new Map<String, dynamic>();
    map['ShopId'] = ShopId;

    String apifile = 'Fetch_Shop.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var shopdata = await networkHelper.getData();
    return shopdata;
  }

}