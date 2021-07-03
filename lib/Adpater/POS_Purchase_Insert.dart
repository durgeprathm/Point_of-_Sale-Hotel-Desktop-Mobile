import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class PurchaseInsert {
  Future<dynamic> getpospurchaseinsert(
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
      String purchasesupplierid,
      String purchaseinvoice,
      String Purchase_Date,
      String proIds,
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
    map['actionId'] = '0';
    map['purchasesupplierid'] = purchasesupplierid;
    map['purchaseinvoice'] = purchaseinvoice;
    map['PurchaseDate'] = Purchase_Date;
    map['proid'] = proIds;
    // map['PurchaseProductName'] = Purchase_ProductName;
    map['prorate'] = Purchase_ProductRate;
    map['proqty'] = Purchase_ProductQty;
    map['prostotal'] = Purchase_ProductSubTotal;
    map['PurchaseSubTotal'] = Purchase_SubTotal;
    map['progstper'] = Purchase_GST;
    map['PurchaseDiscount'] = Purchase_Discount;
    map['PurchaseMiscellaneons'] = Purchase_Miscellaneons;
    map['PurchaseTotalAmount'] = Purchase_TotalAmount;
    map['PurchaseNarration'] = Purchase_Narration;

    String apifile = 'insert_purchse_enteries.php';
    NetworkHelperHotel networkHelper =
        new NetworkHelperHotel(apiname: apifile, data: map);
    var insertPurchase = await networkHelper.getData();
    return insertPurchase;
  }

  Future<dynamic> getposUpdatePurchaseinsertWithIds(
      String purchaseId,
      String purchasesupplierid,
      String purchaseinvoice,
      String Purchase_Date,
      String proIds,
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
    map['actionId'] = '0';
    map['purchaseid'] = purchaseId;
    map['purchasesupplierid'] = purchasesupplierid;
    map['purchaseinvoiceno'] = purchaseinvoice;
    map['purchasedate'] = Purchase_Date;
    map['purchaseproductid'] = proIds;
    // map['PurchaseProductName'] = Purchase_ProductName;
    map['purchaserate'] = Purchase_ProductRate;
    map['purchasequntity'] = Purchase_ProductQty;
    map['purchaseproductsubtotal'] = Purchase_ProductSubTotal;
    map['purchasesubtotal'] = Purchase_SubTotal;
    map['purchasegst'] = Purchase_GST;
    map['purchasediscount'] = Purchase_Discount;
    map['purchasemis'] = Purchase_Miscellaneons;
    map['purchasetotal'] = Purchase_TotalAmount;
    map['purchasenaration'] = Purchase_Narration;

    String apifile = 'update_purchase_data.php';
    NetworkHelperHotel networkHelper =
    new NetworkHelperHotel(apiname: apifile, data: map);
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


  Future<dynamic> getReturnPurchaseInsertWithIds(
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

    String apifile = 'return_purchase_insert.php';
    NetworkHelper networkHelper =
    new NetworkHelper(apiname: apifile, data: map);
    var insertPurchase = await networkHelper.getData();
    return insertPurchase;
  }

  Future<dynamic> getReturnPurchaseUpdateWithIds(
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

    String apifile = 'update_return_purchase.php';
    NetworkHelper networkHelper =
    new NetworkHelper(apiname: apifile, data: map);
    var insertPurchase = await networkHelper.getData();
    return insertPurchase;
  }


}
