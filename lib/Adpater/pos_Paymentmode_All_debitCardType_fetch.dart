import 'package:retailerp/NetworkHelper/network_helper.dart';

class AllDebitCardTypeFetch {

  Future <dynamic> getAllDebitCardTypeFetch(String Id) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = Id;


    String apifile = 'Fetch_Debit_Card_Type.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var alldebitcardtypefetch = await networkHelper.getData();
    return alldebitcardtypefetch;
  }

}