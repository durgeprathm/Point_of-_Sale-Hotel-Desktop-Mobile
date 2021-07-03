import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class DeleteMenuCat {

  Future <dynamic> getDeleteMenuCat(String menucatId) async
  {
    var map = new Map<String, dynamic>();
    map['DeleteMenucategioresId'] = menucatId;

    String apifile = 'Delete_Menu_Category.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var upibilldata = await networkHelper.getData();
    return upibilldata;
  }

}

// DeleteMenucategioresId
// /home1/ehotelmanagement/public_html/Poonam_POSAPI/Pos_poonam/Delete_Menu_Category.php