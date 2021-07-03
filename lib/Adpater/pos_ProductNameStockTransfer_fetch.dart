import 'package:retailerp/NetworkHelper/network_helper.dart';

class ProductNameStockTransferFetch {

  Future <dynamic> getProductNameStockTransferFetch (String Product_Id) async
  {
    var map = new Map<String, dynamic>();
    map['ProductId'] = Product_Id;

    String apifile = 'Fetch_Product.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var productnamestocktransferfetchdata = await networkHelper.getData();
    return productnamestocktransferfetchdata;
  }

}