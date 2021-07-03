import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class SupplierFetch {
  Future<dynamic> getSupplierFetch(String allrecords,String accounttype) async {
    var map = new Map<String, dynamic>();
    map['actionid'] = "0";
    map['allrecords'] = allrecords;
    map['accounttype'] = accounttype;

    String apifile = 'Fetch_Supplier.php';
    NetworkHelperHotel networkHelper =
        new NetworkHelperHotel(apiname: apifile, data: map);
    var supplierdata = await networkHelper.getData();
    return supplierdata;
  }


}
