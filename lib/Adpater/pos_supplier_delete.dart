import 'package:retailerp/NetworkHelper/network_helper.dart';

class SupplierDelete {

  Future <dynamic> getSupplierDelete (String Supplier_Id) async
  {
    var map = new Map<String, dynamic>();
    map['DeleteSupplierId'] = Supplier_Id;

    String apifile = 'Delete_Supplier.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var supplierdata = await networkHelper.getData();
    return supplierdata;
  }

}