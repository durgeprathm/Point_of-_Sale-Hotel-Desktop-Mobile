import 'dart:convert';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class DataUpload {
  Future<dynamic> uploadProductData(
      String ptype,
      String pcode,
      String pname,
      String pcmpname,
      String pcatg,
      String psellingprice,
      String hsnCode,
      String ptax,
      String punit,
      String popenblnc,
      String ppbillmethod,
      String intigtax,
      File pro_image,
      String flag) async {
    String URL =
        "https://ehotelmanagement.com//aruntailgirni_api/insert_product.php";
    var request = http.MultipartRequest("POST", Uri.parse(URL));

    request.fields["ptype"] = ptype;
    request.fields["pcode"] = pcode;
    request.fields["pname"] = pname;
    request.fields["pcmpname"] = pcmpname;
    request.fields["pcatg"] = pcatg;
    request.fields["psellingprice"] = psellingprice;
    request.fields["hsncode"] = hsnCode;
    request.fields["ptax"] = ptax;
    request.fields["punit"] = punit;
    request.fields["popenblnc"] = popenblnc;
    request.fields["ppbillmethod"] = ppbillmethod;
    request.fields["intigtax"] = intigtax;
    request.fields["pqty"] = '';
    request.fields["flag"] = flag;

    if (pro_image != null) {
      var stream =
          http.ByteStream(DelegatingStream.typed(pro_image.openRead()));
      final length = await pro_image.length();

      request.files.add(http.MultipartFile(
        'productimg',
        stream,
        length,
        filename: basename(pro_image.path),
      ));
    } else {
      request.fields["productimg"] = '';
    }

    http.Response res = await http.Response.fromStream(await request.send());
    Map<String, dynamic> jsonObject = json.decode(res.body);
    return jsonObject;
  }

  Future<dynamic> updateProductData(
      String productId,
      String ptype,
      String pcode,
      String pname,
      String pcmpname,
      String pcatg,
      String psellingprice,
      String hsnCode,
      String ptax,
      String punit,
      String popenblnc,
      String ppbillmethod,
      String intigtax,
      File pro_image) async {
    String URL =
        "https://ehotelmanagement.com//aruntailgirni_api/Update_Product.php";
    var request = http.MultipartRequest(
        ""
        "POST",
        Uri.parse(URL));
    request.fields["UpdatedProductId"] = productId;
    request.fields["ProductType"] = ptype;
    request.fields["ProductCode"] = pcode;
    request.fields["ProductName"] = pname;
    request.fields["ProductCompanyName"] = pcmpname;
    request.fields["ProductCategories"] = pcatg;
    request.fields["ProductSellingPrice"] = psellingprice;
    request.fields["HSNCode"] = hsnCode;
    request.fields["Tax"] = ptax;
    request.fields["Unit"] = punit;
    request.fields["ProductOpeningBalance"] = popenblnc;
    request.fields["ProductBillingMethod"] = ppbillmethod;
    request.fields["IntegratedTax"] = intigtax;
    request.fields["ProductQty"] = '';
    request.fields["ProductisDeleted"] = '0';

    if (pro_image != null) {
      var stream =
          http.ByteStream(DelegatingStream.typed(pro_image.openRead()));
      final length = await pro_image.length();

      request.files.add(http.MultipartFile(
        'ProductImg',
        stream,
        length,
        filename: basename(pro_image.path),
      ));
    } else {
      request.fields["ProductImg"] = '';
    }

    http.Response res = await http.Response.fromStream(await request.send());
    Map<String, dynamic> jsonObject = json.decode(res.body);
    return jsonObject;
  }

  Future<dynamic> uploadCustomerData(
      String customerDate,
      String customerName,
      String customerMobileNumber,
      String customerEmail,
      String customerAddress,
      String customerCreditType,
      String customerTaxSupplier,
      int customerType) async {
    String URL =
        "https://ehotelmanagement.com//aruntailgirni_api/Insert_Customer.php";
    var request = http.MultipartRequest("POST", Uri.parse(URL));

    request.fields["CustomerDate"] = customerDate;
    request.fields["CustomerName"] = customerName;
    request.fields["CustomerMobileNumber"] = customerMobileNumber;
    request.fields["CustomerEmail"] = customerEmail;
    request.fields["CustomerAddress"] = customerAddress;
    request.fields["CustomerCreditType"] = customerCreditType;
    request.fields["CustomerTaxSupplier"] = customerTaxSupplier;
    request.fields["CustomerType"] = customerType.toString();
    request.fields["action"] = 'regular';
    http.Response res = await http.Response.fromStream(await request.send());
    Map<String, dynamic> jsonObject = json.decode(res.body);
    return jsonObject;
  }

  Future<dynamic> updateCustomerData(
      String customerID,
      String customerDate,
      String customerName,
      String customerMobileNumber,
      String customerEmail,
      String customerAddress,
      String customerCreditType,
      String customerTaxSupplier,
      int customerType) async {
    String URL =
        "https://ehotelmanagement.com//aruntailgirni_api/Update_Customer.php";
    var request = http.MultipartRequest("POST", Uri.parse(URL));
    request.fields["UpdatedCustomerID"] = customerID;
    request.fields["CustomerDate"] = customerDate;
    request.fields["CustomerName"] = customerName;
    request.fields["CustomerMobileNo"] = customerMobileNumber;
    request.fields["CustomerEmail"] = customerEmail;
    request.fields["CustomerAddress"] = customerAddress;
    request.fields["CustomerCreditType"] = customerCreditType;
    request.fields["CustomerTaxSupplier"] = customerTaxSupplier;
    request.fields["CustomerType"] = customerType.toString();
    request.fields["action"] = 'regular';
    http.Response res = await http.Response.fromStream(await request.send());
    Map<String, dynamic> jsonObject = json.decode(res.body);
    return jsonObject;
  }

  Future<dynamic> uploadProCatData(
    String ProductCategoriesName,
    String productCategioresParentId,
    String productCategioresParentName,
  ) async {
    String URL =
        "https://ehotelmanagement.com//aruntailgirni_api/Insert_Product_Category.php";
    var request = http.MultipartRequest("POST", Uri.parse(URL));

    request.fields["ProductCategoriesName"] = ProductCategoriesName;
    request.fields["productCategioresParentId"] = productCategioresParentId;
    request.fields["productCategioresParentName"] = productCategioresParentName;
    http.Response res = await http.Response.fromStream(await request.send());
    Map<String, dynamic> jsonObject = json.decode(res.body);
    return jsonObject;
  }

  Future<dynamic> upDateProCatData(
    String ProductCategoriesId,
    String ProductCategoriesName,
    String productCategioresParentId,
    String productCategioresParentName,
  ) async {
    String URL =
        "https://ehotelmanagement.com//aruntailgirni_api/Update_Product_Category.php";
    var request = http.MultipartRequest("POST", Uri.parse(URL));
    request.fields["UpdatedProductCategoriesId"] = ProductCategoriesId;
    request.fields["ProductCategoriesName"] = ProductCategoriesName;
    request.fields["ProductCategioresParentId"] = productCategioresParentId;
    request.fields["ProductCategioresParentName"] = productCategioresParentName;
    http.Response res = await http.Response.fromStream(await request.send());
    Map<String, dynamic> jsonObject = json.decode(res.body);
    return jsonObject;
  }

  Future<dynamic> uploadProductRateData(
      String UpdatedProductRateId,
      String productId,
      String ProductName,
      String ProductCategioes,
      String ProductDate,
      String ProductRate,
      String gstper) async {
    String URL =
        "https://ehotelmanagement.com//aruntailgirni_api/Update_Product_Rate.php";
    var request = http.MultipartRequest("POST", Uri.parse(URL));

    request.fields["UpdatedProductRateId"] = UpdatedProductRateId;
    request.fields["productId"] = productId;
    request.fields["ProductName"] = ProductName;
    request.fields["ProductCategioes"] = ProductCategioes;
    request.fields["ProductDate"] = ProductDate;
    request.fields["ProductRate"] = ProductRate;
    request.fields["gstper"] = gstper;

    http.Response res = await http.Response.fromStream(await request.send());
    Map<String, dynamic> jsonObject = json.decode(res.body);
    return jsonObject;
  }

  Future<dynamic> uploadCustomizedProduct(
      String cpname,
      String cpdate,
      String productid,
      String productqty,
      String productprice,
      String cpprice,
      String cpcatid,
      String cphsn,
      String cpunit,
      String cpob,
      String cpgst,
      String cpamanyName,
      String productcode,
      String containsTotalPrice) async {
    var map = new Map<String, dynamic>();

    map['CustomizedProductName'] = cpname;
    map['CustomizedProductDate'] = cpdate;
    map['CustomizedProductHSNCode'] = cphsn;
    map['CustomizedProductUnitType'] = cpunit;
    map['CustomizedProductOB'] = cpob;
    map['CustomizedProductGST'] = cpgst;
    map['productid'] = productid;
    map['productqty'] = productqty;
    map['productprice'] = productprice;
    map['CustomizedProductPrice'] = cpprice;
    map['ProductCatID'] = cpcatid;
    map['CustomizedProductCompanyname'] = cpamanyName;
    map['CustomizedProductCode'] = productcode;
    map['CustomizedContainsTotalPrice'] = containsTotalPrice;

    String apifile = 'Insert_Customized_Product_Enteries.php';
    NetworkHelperHotel networkHelper =
        new NetworkHelperHotel(apiname: apifile, data: map);
    var cproductresponse = await networkHelper.getData();
    return cproductresponse;
  }

  Future<dynamic> uploadUpdateMenuData(
      String menuId,
      String MenuName,
      String MenuProductId,
      String MenuProductName,
      String MenuProductQty,
      String Menucategory,
      String MenuRate,
      String MenuGST) async {
    String URL =
        "http://ehotelmanagement.com//aruntailgirni_api/Update_Menu.php";
    var request = http.MultipartRequest("POST", Uri.parse(URL));
    request.fields["MenuId"] = menuId;
    request.fields["MenuName"] = MenuName;
    request.fields["MenuProductId"] = MenuProductId;
    request.fields["MenuProductName"] = MenuProductName;
    request.fields["MenuProductQty"] = MenuProductQty;
    request.fields["Menucategory"] = Menucategory;
    request.fields["MenuRate"] = MenuRate;
    if (MenuGST.isEmpty || MenuGST == null) {
      request.fields["gst"] = '0';
    } else {
      request.fields["gst"] = MenuGST;
    }

    http.Response res = await http.Response.fromStream(await request.send());
    Map<String, dynamic> jsonObject = json.decode(res.body);
    return jsonObject;
  }

  Future<dynamic> uploadProductMenuData(
    String menuCatName,
  ) async {
    String URL =
        "https://ehotelmanagement.com//aruntailgirni_api/Insert_Menu_Category.php";
    var request = http.MultipartRequest("POST", Uri.parse(URL));

    request.fields["Menucategioresname"] = menuCatName;

    http.Response res = await http.Response.fromStream(await request.send());
    Map<String, dynamic> jsonObject = json.decode(res.body);
    return jsonObject;
  }
}
