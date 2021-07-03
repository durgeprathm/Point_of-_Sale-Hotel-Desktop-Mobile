import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class MenuList {

  Future<dynamic> getMenuWithID(
       String menu_Id, String menucat) async {
    var map = new Map<String, dynamic>();

    if (menucat == "0") {
      map['actionId'] = menucat;

    } else {
      map['actionId'] = "1";
      map['mcatid'] = menucat;
    }

    String apifile = 'pos_menuFetch.php';
    NetworkHelperHotel networkHelper =  new NetworkHelperHotel(apiname: apifile, data: map);
    var menuList = await networkHelper.getData();
    return menuList;

  }


  Future<dynamic> getMenu(String menu_Id) async {
    var map = new Map<String, dynamic>();
    map['MenuId'] = menu_Id;

    String apifile = 'pos_menuFetch.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var menuList = await networkHelper.getData();
    return menuList;
  }

  Future<dynamic> getHotelMenu(String menu_Id) async {
    var map = new Map<String, dynamic>();
    map['MenuId'] = menu_Id;
    String apifile = 'fetch_menu.php';
    NetworkHelperHotel networkHelper =
        new NetworkHelperHotel(apiname: apifile, data: map);
    var menuList = await networkHelper.getData();
    return menuList;
  }

  Future<dynamic> getMenuDelete(String menu_Id) async {
    var map = new Map<String, dynamic>();
    map['DeleteMenuId'] = menu_Id;

    String apifile = 'Delete_Menu.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var menuList = await networkHelper.getData();
    return menuList;
  }
}
