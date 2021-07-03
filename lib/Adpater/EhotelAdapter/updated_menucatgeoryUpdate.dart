import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class UpdateMenuCategoryName {

  Future <dynamic> updateCategoryName (String id,String NameCat) async
  {
    var map = new Map<String, dynamic>();
    map['MenucategioresId'] = id;
    map['Menucategioresname'] = NameCat;

    String apifile = 'Update_Menu_CategoryV3.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var menuList  = await networkHelper.getData();
    return menuList;
  }

}