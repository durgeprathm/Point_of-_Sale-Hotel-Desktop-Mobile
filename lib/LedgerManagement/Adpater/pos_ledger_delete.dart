import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class SupplierDelete {

  Future <dynamic> getSupplierDelete (String Supplier_Id) async
  {
    var map = new Map<String, dynamic>();
    map['DeleteSupplierId'] = Supplier_Id;

    String apifile = 'Delete_Supplier.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var supplierdata = await networkHelper.getData();
    return supplierdata;
  }

}