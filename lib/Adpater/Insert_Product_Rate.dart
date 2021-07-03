import 'package:retailerp/NetworkHelper/network_helper.dart';

class InsertProductRate {
  Future<dynamic> getInsertProductRate(
    String productId,
    String ProductName,
    String ProductCategioes,
    String ProductDate,
    String ProductRate,
    String gstper,
  ) async {
    var map = new Map<String, dynamic>();
    map["productId"] = productId;
    map["ProductName"] = ProductName;
    map["ProductCategioes"] = ProductCategioes;
    map["ProductDate"] = ProductDate;
    map["ProductRate"] = ProductRate;
    map["gstper"] = gstper;

    String apifile = 'Insert_Product_Rate.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var insertproductrate = await networkHelper.getData();
    return insertproductrate;
  }
}
