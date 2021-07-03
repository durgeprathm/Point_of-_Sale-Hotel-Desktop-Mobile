import 'package:retailerp/NetworkHelper/network_helper.dart';

class LedgerFetch {
  Future<dynamic> getLedgerFetch(String actionId) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = actionId;

    String apifile = 'Fetch_ledger_data.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var supplierdata = await networkHelper.getData();
    return supplierdata;
  }

  Future<dynamic> getLedgerPayTypeFetch(String actionId) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = actionId;

    String apifile = 'fetch_paymode_from_ledger.php';
    NetworkHelper networkHelper =
    new NetworkHelper(apiname: apifile, data: map);
    var supplierdata = await networkHelper.getData();
    return supplierdata;
  }


}
