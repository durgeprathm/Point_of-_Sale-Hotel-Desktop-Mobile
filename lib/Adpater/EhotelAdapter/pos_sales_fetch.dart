import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class SalesFetch {
  Future<dynamic> getSalesFetch(String Sales_Id) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = Sales_Id;

    String apifile = 'view_all_bill.php';
    NetworkHelperHotel networkHelper =
        new NetworkHelperHotel(apiname: apifile, data: map);
    var salesdata = await networkHelper.getData();
    return salesdata;
  }

  Future<dynamic> getDatewiseSalesFetch(
      action, suplierId, String fromDate, String toDate) async {
    var map = new Map<String, dynamic>();
    if (action == '0') {
      map['actionId'] = action;
    }
    else if (action == '1') {
      map['actionId'] = action;
      map['sdate'] = fromDate;
      map['edate'] = toDate;
    }

    String apifile = 'view_all_bill.php';
    NetworkHelperHotel networkHelper =
        new NetworkHelperHotel(apiname: apifile, data: map);
    var purchasedata = await networkHelper.getData();
    return purchasedata;
  }


////////////////new/////////////////////////////////////////
  Future<dynamic> getmanagesalesFetch(
      String action,String allrecords,String accounttype,String paymentmode, String fromDate, String toDate) async {
    var map = new Map<String, dynamic>();
    if (action == '0') {
      map['actionId'] = action;
      map['allrecords'] = allrecords;
      map['accounttype'] = accounttype;
      map['paymentmode'] = paymentmode;
      map['firstdate'] = fromDate;
      map['lastdate'] = toDate;
    }


    String apifile = 'view_all_bill.php';
    NetworkHelperHotel networkHelper =
    new NetworkHelperHotel(apiname: apifile, data: map);
    var purchasedata = await networkHelper.getData();
    return purchasedata;
  }
}
