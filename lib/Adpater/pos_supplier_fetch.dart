import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class SupplierFetch {
  Future<dynamic> getSupplierFetch(String Supplier_Id) async {
    var map = new Map<String, dynamic>();
    map['actionid'] = Supplier_Id;

    String apifile = 'Fetch_Supplier.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var supplierdata = await networkHelper.getData();
    return supplierdata;
  }



  // Future<dynamic> getHotelSupplierFetch(String Supplier_Id) async {
  //   var map = new Map<String, dynamic>();
  //   map['SupplierId'] = "0";
  //
  //   String apifile = 'Fetch_Supplier.php';
  //   NetworkHelperHotel networkHelper =
  //   new NetworkHelperHotel(apiname: apifile, data: map);
  //   var supplierdata = await networkHelper.getData();
  //   return supplierdata;
  // }


}
