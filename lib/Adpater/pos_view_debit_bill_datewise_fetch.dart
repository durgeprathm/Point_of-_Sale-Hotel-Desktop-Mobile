import 'package:retailerp/NetworkHelper/network_helper.dart';

class DebitBillDateWiseFetch{

  Future <dynamic> getDebitBillDateWiseFetch(String DateFrom,String DateTo) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "1";
    map['sdate'] = DateFrom;
    map['edate'] = DateTo;

    String apifile = 'Fetch_Debit_Bill.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var debitbilldata = await networkHelper.getData();
    return debitbilldata;
  }

}