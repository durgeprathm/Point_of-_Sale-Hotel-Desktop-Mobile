import 'package:retailerp/NetworkHelper/network_helper.dart';

class SortCategoryWiseFetch {

  Future <dynamic> getSortCategoryWiseFetch(String ProductCat) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "0";
    map['ProductcategoriesId'] = ProductCat;


    String apifile = 'Fetch_SortProductCategory.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var sortcategorywisefetch = await networkHelper.getData();
    return sortcategorywisefetch;
  }

}