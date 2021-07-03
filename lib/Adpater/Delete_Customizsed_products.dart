import 'package:retailerp/NetworkHelper/network_helper.dart';

class DeleteCustomizeProducts {
  Future<dynamic> getDeleteCustomizeProducts(String CustomizedProductId) async {
    var map = new Map<String, dynamic>();
    map['CustomizedProductId'] = CustomizedProductId;

    String apifile = 'Delete_Customized_Product.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var deletecustomizeproducts = await networkHelper.getData();
    return deletecustomizeproducts;
  }
}
