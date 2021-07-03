import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class UpiBillDatewiseFetch {

  Future <dynamic> getUpiBillDateWiseFetch(String DateFrom,String DateTo) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "1";
    map['sdate'] = DateFrom;
    map['edate'] = DateTo;

    String apifile = 'Fetch_Upi_Bill.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var upibilldatewisedata = await networkHelper.getData();
    return upibilldatewisedata;
  }

}