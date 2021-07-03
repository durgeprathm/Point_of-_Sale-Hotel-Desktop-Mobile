import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class UpiBillFetch {

  Future <dynamic> getUpiBillFetch() async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "0";

    String apifile = 'view_UPI_bill.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var upibilldata = await networkHelper.getData();
    return upibilldata;
  }

}