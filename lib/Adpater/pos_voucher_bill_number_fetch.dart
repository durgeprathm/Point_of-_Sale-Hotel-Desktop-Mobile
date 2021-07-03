import 'package:retailerp/NetworkHelper/network_helper.dart';

class VoucherBillNoFetch{

  Future <dynamic> getVoucherBillNoFetch(String VoucherBillDate,String VoucherCustomerName) async
  {
    var map = new Map<String, dynamic>();
    map['VoucherBillDate'] = VoucherBillDate;
    map['VoucherCustomerName'] = VoucherCustomerName;
       print("in adpter//date//$VoucherBillDate//name/////$VoucherCustomerName");
    String apifile = 'Voucher_Bill_No.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var voucherbillnodata = await networkHelper.getData();
    return voucherbillnodata;
  }

}