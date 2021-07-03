import 'package:retailerp/NetworkHelper/network_helper.dart';

class VoucherBillTotalAmountFetch{

  Future <dynamic> getVoucherBillNoFetch(String VoucherBillTotalAmount) async
  {
    var map = new Map<String, dynamic>();
    map['VoucherSalesid'] = VoucherBillTotalAmount;
    String apifile = 'Fetch_Voucher_TotalAmount.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var voucherbilltotalamountdata = await networkHelper.getData();
    return voucherbilltotalamountdata;
  }

}