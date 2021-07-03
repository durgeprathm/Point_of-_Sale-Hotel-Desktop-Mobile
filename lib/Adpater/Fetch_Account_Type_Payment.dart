import 'package:retailerp/NetworkHelper/network_helper.dart';

class FetchAccountTypePayment{
  Future<dynamic> getFetchAccountTypePayment(String Id) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = Id;

    String apifile = 'Fetch_All_Account_Type_Related_to_Payment_Mode.php';
    NetworkHelper networkHelper =
    new NetworkHelper(apiname: apifile, data: map);
    var fetchaccounttypePayment = await networkHelper.getData();
    return fetchaccounttypePayment;
  }
}