import 'package:retailerp/NetworkHelper/network_helper.dart';

class ShopBankACTypeFetch {
  Future<dynamic> getShopBankACTypeFetch(String Id) async {
    var map = new Map<String, dynamic>();
    map['ActionId'] = Id;

    String apifile = 'Fetch_Shop_Bank.php';
    NetworkHelper networkHelper =
    new NetworkHelper(apiname: apifile, data: map);
    var accounttypedata = await networkHelper.getData();
    return accounttypedata;
  }
}