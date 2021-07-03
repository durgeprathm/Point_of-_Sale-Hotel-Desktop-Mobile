import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class InsertConvertedData {

  Future <dynamic> insertedConvertedData(String cpid,String pdate,String pqty) async
  {
    var map = new Map<String, dynamic>();

    map['cproductId'] = cpid;
    map['purchasedate'] = pdate;
    map['purchaseqty'] = pqty;

    String apifile = 'Convert_Product_Data.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var insertusercreate = await networkHelper.getData();
    return insertusercreate;
  }

}