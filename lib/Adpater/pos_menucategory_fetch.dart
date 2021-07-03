import 'package:retailerp/NetworkHelper/network_helper.dart';

class MenuCategoryFetchItems{

  Future <dynamic> getMenuCategoryFetch(String MenuCat_Id) async
  {
    var map = new Map<String, dynamic>();
    map['MenucategioresId'] = MenuCat_Id;

    String apifile = 'Fetch_Menu_Catgory.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var menucategoryfetchitems = await networkHelper.getData();
    return menucategoryfetchitems;
  }

}