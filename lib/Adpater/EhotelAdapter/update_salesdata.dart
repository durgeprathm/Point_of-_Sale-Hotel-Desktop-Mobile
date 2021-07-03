import 'package:retailerp/NetworkHelper/network_helper.dart';

class SalesUpdate {

  //-------------------------------------Insert POS Order to Sales Table START--------------------------
  Future<dynamic> updateSalesOrder(
      String custId,
      String custName,
      String custNo,
      String subtotal,
      String discount,
      String totalamount,
      String salesid,
      String date,
      String productid,
      String productqty,
      String productrate,
      String productgst,
      String productsubtotal,
      String trasncid,
      String salesnarr,
      String paymodename
      ) async {

    var map = new Map<String, dynamic>();
    map['customerid'] = custId;
    map['customername'] = custName;
    map['mobilenumber'] = custNo;
    map['Subtotal'] = subtotal;
    map['discount'] = discount;
    map['totalamount'] = totalamount;
    map['Salesid'] = salesid;
    map['medate'] = date;
    map['productid'] = productid;
    map['productqty'] = productqty;
    map['productrate'] = productrate;
    map['productgst'] = productgst;
    map['productSubtotal'] = productsubtotal;
    map['transcationid'] = trasncid;
    map['SalesNarration'] = salesnarr;
    map['paymodename'] = paymodename;

    String apifile = 'Update_sales.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile, data: map);
    var insertsales = await networkHelper.getData();
    return insertsales;
  }

}

