import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class DebitBillFetch{

  Future <dynamic> getDebitBillFetch(String DebitBill_Id) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "0";
    map['SalesId'] = DebitBill_Id;

    String apifile = 'View_debit_bill.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var debitbilldata = await networkHelper.getData();
    return debitbilldata;
  }

}