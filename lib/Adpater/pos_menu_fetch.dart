import 'package:retailerp/NetworkHelper/network_helper.dart';

class MenuFetchItems{

  Future <dynamic> getMenuFetch(String Menu_Id) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = Menu_Id;

    String apifile = 'Fetch_menu.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var menudata = await networkHelper.getData();
    return menudata;
  }

}