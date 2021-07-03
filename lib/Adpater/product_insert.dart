import 'package:retailerp/NetworkHelper/network_helper.dart';

class ProductInsert {
  Future<dynamic> getProductinsert(
      String Purchase_CompanyName,
      String Purchase_Date,
      String Purchase_ProductName,
      String Purchase_ProductRate,
      String Purchase_ProductQty,
      String Purchase_ProductSubTotal,
      String Purchase_SubTotal,
      String Purchase_Discount,
      String Purchase_GST,
      String Purchase_Miscellaneons,
      String Purchase_TotalAmount,
      String Purchase_Narration) async {
    var map = new Map<String, dynamic>();

    map['PurchaseCompanyName'] = Purchase_CompanyName;
    map['PurchaseDate'] = Purchase_Date;
    map['PurchaseProductName'] = Purchase_ProductName;
    map['PurchaseProductRate'] = Purchase_ProductRate;
    map['PurchaseProductQty'] = Purchase_ProductQty;
    map['PurchaseProductSubTotal'] = Purchase_ProductSubTotal;
    map['PurchaseSubTotal'] = Purchase_SubTotal;
    map['PurchaseDiscount'] = Purchase_Discount;
    map['PurchaseGST'] = Purchase_GST;
    map['PurchaseMiscellaneons'] = Purchase_Miscellaneons;
    map['PurchaseTotalAmount'] = Purchase_TotalAmount;
    map['PurchaseNarration'] = Purchase_Narration;

    String apifile = 'Purchase_Insert.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var insertPurchase = await networkHelper.getData();
    return insertPurchase;
  }

  Future<dynamic> getpospurchaseinsertWithIds(
      String proIds,
      String Purchase_CompanyName,
      String Purchase_Date,
      String Purchase_ProductName,
      String Purchase_ProductRate,
      String Purchase_GST,
      String Purchase_ProductQty,
      String Purchase_ProductSubTotal,
      String Purchase_SubTotal,
      String Purchase_Discount,
      String Purchase_Miscellaneons,
      String Purchase_TotalAmount,
      String Purchase_Narration) async {
    var map = new Map<String, dynamic>();
    map['productsid'] = proIds;
    map['PurchaseCompanyName'] = Purchase_CompanyName;
    map['PurchaseDate'] = Purchase_Date;
    map['PurchaseProductName'] = Purchase_ProductName;
    map['PurchaseProductRate'] = Purchase_ProductRate;
    map['PurchaseProductQty'] = Purchase_ProductQty;
    map['PurchaseProductSubTotal'] = Purchase_ProductSubTotal;
    map['PurchaseSubTotal'] = Purchase_SubTotal;
    map['PurchaseDiscount'] = Purchase_Discount;
    map['PurchaseGST'] = Purchase_GST;
    map['PurchaseMiscellaneons'] = Purchase_Miscellaneons;
    map['PurchaseTotalAmount'] = Purchase_TotalAmount;
    map['PurchaseNarration'] = Purchase_Narration;

    String apifile = 'Purchase_Insert.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var insertPurchase = await networkHelper.getData();
    return insertPurchase;
  }

  Future<dynamic> getpospurchaseUpdateWithIds(
      String purchaseId,
      String proIds,
      String Purchase_CompanyName,
      String Purchase_Date,
      String Purchase_ProductName,
      String Purchase_ProductRate,
      String Purchase_GST,
      String Purchase_ProductQty,
      String Purchase_ProductSubTotal,
      String Purchase_SubTotal,
      String Purchase_Discount,
      String Purchase_Miscellaneons,
      String Purchase_TotalAmount,
      String Purchase_Narration) async {
    var map = new Map<String, dynamic>();
    map['UpdatedPurchaseId'] = purchaseId;
    map['productids'] = proIds;
    map['PurchaseComapanyName'] = Purchase_CompanyName;
    map['PurchaseDate'] = Purchase_Date;
    map['PurchaseProductName'] = Purchase_ProductName;
    map['PurchaseProductRate'] = Purchase_ProductRate;
    map['PurchaseProductQty'] = Purchase_ProductQty;
    map['PurchaseProductSubTotal'] = Purchase_ProductSubTotal;
    map['PurchaseSubTotal'] = Purchase_SubTotal;
    map['PurchaseDiscount'] = Purchase_Discount;
    map['PurchaseGST'] = Purchase_GST;
    map['PurchaseMiscellaneons'] = Purchase_Miscellaneons;
    map['PurchaseTotalAmount'] = Purchase_TotalAmount;
    map['PurchaseNarration'] = Purchase_Narration;

    String apifile = 'Update_Purchase.php';
    NetworkHelper networkHelper =
    new NetworkHelper(apiname: apifile, data: map);
    var insertPurchase = await networkHelper.getData();
    return insertPurchase;
  }

}
