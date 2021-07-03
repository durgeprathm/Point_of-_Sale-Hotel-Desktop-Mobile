
import 'package:retailerp/NetworkHelper/network_helper.dart';

class ManagerLogin {

  Future <dynamic> getUser (String Username,String Password) async
  {
    var map = new Map<String, dynamic>();
    map['username'] = Username;
    map['password'] = Password;

    String apifile = 'manager_login.php'; 
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var menuList  = await networkHelper.getData();
    return menuList;
  }

}