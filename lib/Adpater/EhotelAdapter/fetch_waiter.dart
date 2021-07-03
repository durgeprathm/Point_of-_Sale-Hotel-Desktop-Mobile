import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class FetchWaiter {

  Future <dynamic> getwaiter() async
  {
    var map = new Map<String, dynamic>();

    map['actionid'] = "1";

    String apifile = 'Create_new_emp.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var insertusercreate = await networkHelper.getData();
    return insertusercreate;
  }

}