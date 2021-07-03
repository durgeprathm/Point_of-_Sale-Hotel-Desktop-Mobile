import 'package:retailerp/NetworkHelper/network_helper.dart';

class ProductCategoryFetch {

  Future <dynamic> getProductCategoryFetch (String ProductCatId) async
  {
    var map = new Map<String, dynamic>();
    map['ProductCategoriesId'] = ProductCatId;

    String apifile = 'Fetch_Product_Category.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var productcategoryfetch = await networkHelper.getData();
    return productcategoryfetch;
  }

}