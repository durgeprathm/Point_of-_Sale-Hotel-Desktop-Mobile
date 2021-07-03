import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class ProductFetch {

  Future <dynamic> getposproduct (String ProductId) async
  {
    var map = new Map<String, dynamic>();
    map['ProductId'] = ProductId;

    String apifile = 'Fetch_Product.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var posproductdata = await networkHelper.getData();
    return posproductdata;
  }


  Future <dynamic> getposHotelproduct (String ProductId) async
  {
    var map = new Map<String, dynamic>();
    map['ProductId'] = ProductId;

    String apifile = 'fetch_product.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var posproductdata = await networkHelper.getData();
    return posproductdata;
  }

  Future <dynamic> getProductCategory (String ProductCatId) async
  {
    var map = new Map<String, dynamic>();
    map['ProductCategoriesId'] = ProductCatId;

    String apifile = 'Fetch_Product_Category.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var posproductdata = await networkHelper.getData();
    return posproductdata;
  }

  Future <dynamic> productCategoryDelete (String ProductCatId) async
  {
    var map = new Map<String, dynamic>();
    map['DeleteProductcategoriesId'] = ProductCatId;

    String apifile = 'Delete_Product_Category.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var posproductdata = await networkHelper.getData();
    return posproductdata;
  }

  Future <dynamic> productDataDelete (String productId) async
  {
    var map = new Map<String, dynamic>();
    map['DeleteProductId'] = productId;

    String apifile = 'Delete_Product.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var posproductdata = await networkHelper.getData();
    return posproductdata;
  }

  Future <dynamic> productRateDataDelete (String productRateId) async
  {
    var map = new Map<String, dynamic>();
    map['DeleteProductRateId'] = productRateId;

    String apifile = 'Delete_Product_Rate.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var posproductdata = await networkHelper.getData();
    return posproductdata;
  }

}