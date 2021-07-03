import 'package:retailerp/NetworkHelper/network_helper.dart';

class PurchaseDelete {

  Future <dynamic> getPurchaseDelete (String Purchase_Id) async
  {
    var map = new Map<String, dynamic>();
    map['DeletePurchaseId'] = Purchase_Id;

    String apifile = 'Delete_Purchase.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var purchasedata = await networkHelper.getData();
    return purchasedata;
  }

}