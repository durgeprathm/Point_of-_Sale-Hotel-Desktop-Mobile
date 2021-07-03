import 'package:intl/intl.dart';
import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class SalesInsert {

  String formattedTime;
  //-------------------------------------Insert POS Order to Sales Table START--------------------------
  Future<dynamic> insertPOSOrder(String actionId,
      String paymode,
      String narration,
      String date,
      String  customerid,
      String customername,
      String mobileno,
      String subtotal,
      String discount,
      String totalamt,
      String menuId,
      String menuqty,
      String menurate,
      String menusubtotal,
      String menugst,
      String PayModeAccountType,
      String PayModeBankId,
      ) async {
    DateTime now = DateTime.now();
    formattedTime = DateFormat('kk:mm').format(now);

    var map = new Map<String, dynamic>();
    map['actionId'] = "0";
    map['paymodename'] = paymode;
    map['PayModeAccountType'] = PayModeAccountType;
    map['PayModeBankId'] = PayModeBankId;
    map['Narration'] = narration;
    map['medate'] = date;
    map['transcationid'] = "";
    map['customerid'] = customerid;
    map['customername'] = customername;
    map['mobilenumber'] = mobileno;

    map['Subtotal'] = subtotal;
    map['discount'] = discount;
    map['totalamount'] = totalamt;
    map['menuid'] = menuId;
    map['menuqty'] = menuqty;
    map['menurate'] = menurate;
    map['menustotal'] = menusubtotal;
    map['menugstper'] = menugst;

    map['WaiterID'] = "";
    map['salestime'] = formattedTime;


    String apifile = 'insert_sales_enteries.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile, data: map);
    var insertsales = await networkHelper.getData();
    return insertsales;
  }

  //-------------------------------------Insert POS Order to Sales Table END--------------------------
  Future<dynamic> getpossalesinsert(
      String S_cutomername,
      String S_Date,
      String S_ProductName,
      String S_ProductRate,
      String S_ProductQty,
      String S_ProductSubTotal,
      String S_SubTotal,
      String S_Discount,
      String S_GST,
      String S_TotalAmount,
      String S_Narration,
      String S_PaymentMode,
      String S_productsid,
      String S_CardType,
      String S_NameonCard,
      String S_CardNumber,
      String S_BankName,
      String S_UPITransationNumber,
      String S_PaymentCardType) async {
    var map = new Map<String, dynamic>();
    map['scustomername'] = S_cutomername;
    map['sdate'] = S_Date;
    map['sproductname'] = S_ProductName;
    map['sproductrate'] = S_ProductRate;
    map['sproductqty'] = S_ProductQty;
    map['sproductsubtotal'] = S_ProductSubTotal;
    map['ssubtotal'] = S_SubTotal;
    map['sdiscount'] = S_Discount;
    map['sGST'] = S_GST;
    map['stotalamount'] = S_TotalAmount;
    map['snarration'] = S_Narration;
    map['spaymode'] = S_PaymentMode;
    map['sproductsid'] = S_productsid;
    map['SalesCardType'] = S_CardType;
    map['SalesNameonCard'] = S_NameonCard;
    map['SalesCardNumber'] = S_CardNumber;
    map['SalesBankName'] = S_BankName;
    map['SalesUPITransationNumber'] = S_UPITransationNumber;
    map['SalesPaymentCardType'] = S_PaymentCardType;

    String apifile = 'insert_sales_enteries.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var insertsales = await networkHelper.getData();
    return insertsales;
  }

  Future<dynamic> getSalesHotelInsert(
      String customerid,
      String S_cutomername,
      String mobilenumber,
      String S_Date,
      String menuid,
      String menurate,
      String menuqty,
      String menustotal,
      String S_SubTotal,
      String S_Discount,
      String menugstper,
      String S_TotalAmount,
      String S_Narration,
      String S_PaymentMode,
      String S_productsid,
      String S_CardType,
      String S_NameonCard,
      String S_CardNumber,
      String S_BankName,
      String S_UPITransationNumber,
      String S_PaymentCardType) async {
    var map = new Map<String, dynamic>();
    map['actionId'] = '0';
    map['customerid'] = customerid;
    map['customername'] = S_cutomername;
    map['mobilenumber'] = mobilenumber;
    map['medate'] = S_Date;
    map['menuid'] = menuid;
    map['menurate'] = menurate;
    map['menuqty'] = menuqty;
    map['menustotal'] = menustotal;
    map['Subtotal'] = S_SubTotal;
    map['discount'] = S_Discount;
    map['menugstper'] = menugstper;
    map['totalamount'] = S_TotalAmount;
    map['Narration'] = S_Narration;
    map['paymodename'] = S_PaymentMode;
    // map['sproductsid'] = S_productsid;
    // map['SalesCardType'] = S_CardType;
    // map['SalesNameonCard'] = S_NameonCard;
    // map['SalesCardNumber'] = S_CardNumber;
    // map['SalesBankName'] = S_BankName;
    map['transcationid'] = S_UPITransationNumber;
    // map['SalesPaymentCardType'] = S_PaymentCardType;

    String apifile = 'insert_sales_enteries.php';
    NetworkHelperHotel networkHelper =
    new NetworkHelperHotel(apiname: apifile, data: map);
    var insertsales = await networkHelper.getData();
    return insertsales;
  }

  Future<dynamic> getpossalesinsertWihId(
      String sproductsid,
      String S_cutomername,
      String S_Date,
      String S_ProductName,
      String S_ProductRate,
      String S_ProductQty,
      String S_ProductSubTotal,
      String S_SubTotal,
      String S_Discount,
      String S_GST,
      String S_TotalAmount,
      String S_Narration,
      String S_PaymentMode) async {
    var map = new Map<String, dynamic>();
    map['sproductsid'] = sproductsid;
    map['scustomername'] = S_cutomername;
    map['sdate'] = S_Date;
    map['sproductname'] = S_ProductName;
    map['sproductrate'] = S_ProductRate;
    map['sproductqty'] = S_ProductQty;
    map['sproductsubtotal'] = S_ProductSubTotal;
    map['ssubtotal'] = S_SubTotal;
    map['sdiscount'] = S_Discount;
    map['sGST'] = S_GST;
    map['stotalamount'] = S_TotalAmount;
    map['snarration'] = S_Narration;
    map['spaymode'] = S_PaymentMode;

    String apifile = 'sales_insert.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var insertsales = await networkHelper.getData();
    return insertsales;
  }

  Future<dynamic> updateSalesDataWihId(
      String salesId,
      String sproductsid,
      String S_cutomername,
      String S_Date,
      String S_ProductName,
      String S_ProductRate,
      String S_ProductQty,
      String S_ProductSubTotal,
      String S_SubTotal,
      String S_Discount,
      String S_GST,
      String S_TotalAmount,
      String S_Narration,
      String S_PaymentMode) async {
    var map = new Map<String, dynamic>();
    map['UpdateSalesId'] = salesId;
    map['productids'] = sproductsid;
    map['SalesCustomerName'] = S_cutomername;
    map['SalesDate'] = S_Date;
    map['SalesProductName'] = S_ProductName;
    map['SalesProductRate'] = S_ProductRate;
    map['SalesProductQty'] = S_ProductQty;
    map['SalesProductSubTotal'] = S_ProductSubTotal;
    map['SalesSubTotal'] = S_SubTotal;
    map['SalesDiscount'] = S_Discount;
    map['SalesGST'] = S_GST;
    map['SalesTotalAmount'] = S_TotalAmount;
    map['SalesNarration'] = S_Narration;
    map['SalesPayMentMode'] = S_PaymentMode;

    String apifile = 'Update_sales.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var insertsales = await networkHelper.getData();
    return insertsales;
  }
}
