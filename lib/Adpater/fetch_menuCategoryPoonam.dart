import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class POSMenuCatList {

  Future <dynamic> getPosMenuList () async
  {
    var map = new Map<String, dynamic>();
    map['Menuscat'] = "1";

    String apifile = 'fetch_menucatg.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var menuList  = await networkHelper.getData();
    return menuList;
  }

}