import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class ShopFetch {

  Future <dynamic> getShopFetch (String Shop_Id) async
  {
    var map = new Map<String, dynamic>();
    map['ShopId'] = Shop_Id;

    String apifile = 'Fetch_Shop.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var shopdata = await networkHelper.getData();
    return shopdata;
  }


}