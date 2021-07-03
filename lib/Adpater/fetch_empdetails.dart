import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class FetchEmpDetails {

  Future <dynamic> getempdetails() async
  {
    var map = new Map<String, dynamic>();

    map['actionid'] = "2";
    String apifile = 'Create_new_emp.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var insertusercreate = await networkHelper.getData();
    return insertusercreate;
  }

}