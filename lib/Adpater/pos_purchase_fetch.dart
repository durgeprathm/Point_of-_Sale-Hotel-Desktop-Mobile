import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class PurchaseFetch {
  // Future<dynamic> getPurchaseFetch(String Purchase_Id) async {
  //   var map = new Map<String, dynamic>();
  //   map['PurchaseId'] = Purchase_Id;
  //
  //   String apifile = 'Fetch_Purchase.php';
  //   NetworkHelper networkHelper =
  //       new NetworkHelper(apiname: apifile, data: map);
  //   var purchasedata = await networkHelper.getData();
  //   return purchasedata;
  // }
  //
  // Future<dynamic> getPurchaseReportFetch(String fromDate, String toDate) async {
  //   var map = new Map<String, dynamic>();
  //   map['sdate'] = fromDate;
  //   map['edate'] = toDate;
  //   String apifile = 'purchase_report.php';
  //   NetworkHelper networkHelper =
  //       new NetworkHelper(apiname: apifile, data: map);
  //   var purchasedata = await networkHelper.getData();
  //   return purchasedata;
  // }

  Future<dynamic> getDatewisePurchaseReportFetch(String forall,String supplierid, String fromDate, String toDate) async {
    var map = new Map<String, dynamic>();
    // if (action == '0') {
    //   map['actionId'] = action;
    // } else if (action == '1') {
    //   map['actionId'] = action;
    //   map['SupplierId'] = suplierId;
    // } else if (action == '2') {
    //   map['actionId'] = action;
    //   map['sdate'] = fromDate;
    //   map['edate'] = toDate;
    // } else if (action == '3') {
    //   map['actionId'] = action;
    //   map['supplierid'] = suplierId;
    //   map['sdate'] = fromDate;
    //   map['edate'] = toDate;
    // }
    map['actionId'] = "0";
    map['forall'] = forall;
    map['withsupplier'] = supplierid;
    map['firstdate'] = fromDate;
    map['lastdate'] = toDate;

    String apifile = 'fetch_purchse_report.php';
    NetworkHelperHotel networkHelper =
        new NetworkHelperHotel(apiname: apifile, data: map);
    var purchasedata = await networkHelper.getData();
    return purchasedata;
  }




  // Future<dynamic> getProdoctwisePurchaseReportFetch(
  //     action, peproductid, String fromDate, String toDate) async {
  //   var map = new Map<String, dynamic>();
  //   if (action == '0') {
  //     map['actionId'] = action;
  //   } else if (action == '1') {
  //     map['actionId'] = action;
  //     map['sdate'] = fromDate;
  //     map['edate'] = toDate;
  //   } else if (action == '2') {
  //     map['actionId'] = action;
  //     map['peproductid'] = peproductid;
  //     // map['edate'] = toDate;
  //   } else if (action == '3') {
  //     map['actionId'] = action;
  //     map['peproductid'] = peproductid;
  //     map['sdate'] = fromDate;
  //     map['edate'] = toDate;
  //   }
  //
  //   String apifile = 'fetch_product_purchase.php';
  //   NetworkHelperHotel networkHelper =
  //   new NetworkHelperHotel(apiname: apifile, data: map);
  //   var purchasedata = await networkHelper.getData();
  //   return purchasedata;
  // }




  Future<dynamic> getReturnPurchaseFetch(String Purchase_Id) async {
    var map = new Map<String, dynamic>();
    map['PurchaseId'] = Purchase_Id;

    String apifile = 'fetch_return_purchase.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var purchasedata = await networkHelper.getData();
    return purchasedata;
  }

  Future<dynamic> getFilterReturnPurchaseFetch(
      String action, String sCompanyName, String sDate, String eDate) async {
    var map = new Map<String, dynamic>();
    if (action == '1') {
      map['actionId'] = action;
      map['PurchaseCustomername'] = sCompanyName;
    } else if (action == '2') {
      map['actionId'] = action;
      map['PurchaseCustomername'] = sCompanyName;
      map['sdate'] = sDate;
      map['edate'] = eDate;
    } else {
      map['actionId'] = action;
    }
    String apifile = 'fetch_manage_purchase_return.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var supplierdata = await networkHelper.getData();
    return supplierdata;
  }

  Future<dynamic> getFilterProductWisePurchaseFetch(
      String action, String sCompanyName, String sDate, String eDate) async {
    var map = new Map<String, dynamic>();
    if (action == '1') {
      map['actionId'] = action;
      map['PurchaseCustomername'] = sCompanyName;
    } else if (action == '2') {
      map['actionId'] = action;
      map['PurchaseCustomername'] = sCompanyName;
      map['sdate'] = sDate;
      map['edate'] = eDate;
    } else {
      map['actionId'] = action;
    }
    String apifile = 'fetch_productwise_purchase.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var supplierdata = await networkHelper.getData();
    return supplierdata;
  }
}
