
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class AccountTypeFetch {
  Future<dynamic> getAccountTypeFetch(String Id) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = Id;

    String apifile = 'Fetch_Account_Type.php';
    NetworkHelperHotel networkHelper =
    new NetworkHelperHotel(apiname: apifile, data: map);
    var accounttypedata = await networkHelper.getData();
    return accounttypedata;
  }
}