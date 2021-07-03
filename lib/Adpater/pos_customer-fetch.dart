import 'package:retailerp/NetworkHelper/network_helper.dart';

class CustomerFetch {
  Future<dynamic> getCustomerFetch(String Customer_Id) async {
    var map = new Map<String, dynamic>();
    map['CustomerId'] = Customer_Id;

    String apifile = 'Fetch_Customer.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var customerdata = await networkHelper.getData();
    return customerdata;
  }

  Future<dynamic> customerDataDelete(String Customer_Id) async {
    var map = new Map<String, dynamic>();
    map['DeleteCustomerID'] = Customer_Id;

    String apifile = 'Delete_Customer.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var customerdata = await networkHelper.getData();
    return customerdata;
  }
}
