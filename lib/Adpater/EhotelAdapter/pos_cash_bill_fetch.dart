import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class CashBillFetch {

  Future <dynamic> getCashBillFetch (String forallrecords,String firstdate,String lastdate) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "0";
    map['forall'] = forallrecords;
    map['firstdate'] = firstdate;
    map['lastdate'] = lastdate;

    String apifile = 'view_cash_bill.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var cashbilldata = await networkHelper.getData();
    return cashbilldata;
  }

}