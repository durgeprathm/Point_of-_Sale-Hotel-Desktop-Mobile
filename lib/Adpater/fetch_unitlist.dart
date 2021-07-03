import 'package:retailerp/NetworkHelper/network_helper.dart';

class UnitListFetch {

  Future <dynamic> getUnitList () async
  {
    var map = new Map<String, dynamic>();
    map['actionid'] = "0";


    String apifile = 'Fetch_UnitTypeList.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var menuList  = await networkHelper.getData();
    return menuList;
  }

}