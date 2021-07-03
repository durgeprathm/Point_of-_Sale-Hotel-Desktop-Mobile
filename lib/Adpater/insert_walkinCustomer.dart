import 'package:retailerp/NetworkHelper/network_helper.dart';

class WalkinCustomer {

  Future <dynamic> sendWalkinData (String cdate,String cname,String cmobno) async
  {
    var map = new Map<String, dynamic>();
    map['action'] = "walkin";
    map['CustomerDate'] = cdate;
    map['CustomerName'] = cname;
    map['CustomerMobileNumber'] = cmobno;
    map['CustomerType'] = "1";


    String apifile = 'Insert_Customer.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var customerdata = await networkHelper.getData();
    return customerdata;
  }

}