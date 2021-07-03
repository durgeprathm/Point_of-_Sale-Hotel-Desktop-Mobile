import 'package:retailerp/NetworkHelper/network_helper.dart';

class MenuCatFetchItems{

  Future <dynamic> getCatMenuFetch(String MenuCatName) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "2";
    map['Menucategioresname'] = MenuCatName;

    String apifile = 'Fetch_menu.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var menucatfetchitems = await networkHelper.getData();
    return menucatfetchitems;
  }

}