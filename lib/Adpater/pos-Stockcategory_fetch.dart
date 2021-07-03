import 'package:retailerp/NetworkHelper/network_helper.dart';

class StockCategoryFetchItems{

  Future <dynamic> getStockCategoryFetchItems(String ProductCat_Id) async
  {
    var map = new Map<String, dynamic>();
    map['ProductCategoriesId'] = ProductCat_Id;

    String apifile = 'Fetch_Product_Category.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var stockcategoryfetchitems = await networkHelper.getData();
    return stockcategoryfetchitems;
  }

}