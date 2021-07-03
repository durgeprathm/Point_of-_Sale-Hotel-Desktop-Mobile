import 'package:retailerp/NetworkHelper/network_helper.dart';

class SortCompanyWiseFetch {

  Future <dynamic> getSortCompanyWiseFetch(String ProductCompany) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "2";
    map['ProductCompanyName'] = ProductCompany;


    String apifile = 'Fetch_SortProductCategory.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var sortcompanywisefetch = await networkHelper.getData();
    return sortcompanywisefetch;
  }

}