import 'package:retailerp/Repository/database_creator.dart';

class Purchase {
  int _srNo;
  int _Purchaseid;
  String _PurchaseCompanyname;
  String _Purchaseinvoice;
  String _PurchaseDate;
  String _PurchaseProductName;
  String _PurchaseProductRate;
  String _PurchaseProductQty;
  String _PurchaseProductSubTotal;
  String _PurchaseSubTotal;
  String _PurchaseDiscount;
  String _PurchaseGST;
  String _PurchaseMiscellaneons;
  String _PurchaseTotal;
  String _PurchaseNarration;
  String _PurchaseProducts;
  String _PurchaseIds;

  String _purchasesupplierid;
  String _SupplierCustomername;
  String _SupplierComapanyPersonName;
  String _SupplierMobileNumber;
  String _SupplierEmail;
  String _SupplierAddress;
  String _SupplierGSTNumber;

  Purchase(
      this._Purchaseid,
      this._PurchaseCompanyname,
      this._Purchaseinvoice,
      this._PurchaseDate,
      this._PurchaseProductName,
      this._PurchaseProductRate,
      this._PurchaseProductQty,
      this._PurchaseProductSubTotal,
      this._PurchaseSubTotal,
      this._PurchaseDiscount,
      this._PurchaseGST,
      this._PurchaseMiscellaneons,
      this._PurchaseTotal,
      this._PurchaseNarration,
      this._PurchaseIds);

  Purchase.withSupplier(
      this._srNo,
    this._Purchaseid,
    this._PurchaseCompanyname,
    this._Purchaseinvoice,
    this._PurchaseDate,
    this._PurchaseIds,
    this._PurchaseProductName,
    this._PurchaseProductRate,
    this._PurchaseProductQty,
    this._PurchaseProductSubTotal,
    this._PurchaseSubTotal,
    this._PurchaseDiscount,
    this._PurchaseGST,
    this._PurchaseMiscellaneons,
    this._PurchaseTotal,
    this._PurchaseNarration,
    this._purchasesupplierid,
    this._SupplierCustomername,
    this._SupplierComapanyPersonName,
    this._SupplierMobileNumber,
    this._SupplierEmail,
    this._SupplierAddress,
    this._SupplierGSTNumber,
  );

  Purchase.copyWithIds(
      this._PurchaseIds,
      this._PurchaseCompanyname,
      this._PurchaseDate,
      this._PurchaseProductName,
      this._PurchaseProductRate,
      this._PurchaseProductQty,
      this._PurchaseProductSubTotal,
      this._PurchaseSubTotal,
      this._PurchaseDiscount,
      this._PurchaseGST,
      this._PurchaseMiscellaneons,
      this._PurchaseTotal,
      this._PurchaseNarration);

  Purchase.withProducts(
      this._Purchaseid,
      this._PurchaseCompanyname,
      this._PurchaseDate,
      this._PurchaseProductName,
      this._PurchaseProductRate,
      this._PurchaseProductQty,
      this._PurchaseProductSubTotal,
      this._PurchaseSubTotal,
      this._PurchaseDiscount,
      this._PurchaseGST,
      this._PurchaseMiscellaneons,
      this._PurchaseTotal,
      this._PurchaseNarration,
      this._PurchaseProducts);


  Purchase.onlyProducts(
      this._srNo,
      this._PurchaseDate,
      this._PurchaseIds,
      this._PurchaseProductName,
      this._PurchaseProductRate,
      this._PurchaseProductQty,
      this._PurchaseGST,
      this._PurchaseProductSubTotal);

  int get Purchaseid => _Purchaseid;

  set Purchaseid(int value) {
    _Purchaseid = value;
  }


  int get srNo => _srNo;

  set srNo(int value) {
    _srNo = value;
  }

  String get PurchaseCompanyname => _PurchaseCompanyname;

  set PurchaseCompanyname(String value) {
    _PurchaseCompanyname = value;
  }

  String get PurchaseDate => _PurchaseDate;

  set PurchaseDate(String value) {
    _PurchaseDate = value;
  }

  String get PurchaseProductName => _PurchaseProductName;

  set PurchaseProductName(String value) {
    _PurchaseProductName = value;
  }

  String get PurchaseProductRate => _PurchaseProductRate;

  set PurchaseProductRate(String value) {
    _PurchaseProductRate = value;
  }

  String get PurchaseProductQty => _PurchaseProductQty;

  set PurchaseProductQty(String value) {
    _PurchaseProductQty = value;
  }

  String get PurchaseProductSubTotal => _PurchaseProductSubTotal;

  set PurchaseProductSubTotal(String value) {
    _PurchaseProductSubTotal = value;
  }

  String get PurchaseSubTotal => _PurchaseSubTotal;

  set PurchaseSubTotal(String value) {
    _PurchaseSubTotal = value;
  }

  String get PurchaseDiscount => _PurchaseDiscount;

  set PurchaseDiscount(String value) {
    _PurchaseDiscount = value;
  }

  String get PurchaseGST => _PurchaseGST;

  set PurchaseGST(String value) {
    _PurchaseGST = value;
  }

  String get PurchaseMiscellaneons => _PurchaseMiscellaneons;

  set PurchaseMiscellaneons(String value) {
    _PurchaseMiscellaneons = value;
  }

  String get PurchaseTotal => _PurchaseTotal;

  set PurchaseTotal(String value) {
    _PurchaseTotal = value;
  }

  String get PurchaseNarration => _PurchaseNarration;

  set PurchaseNarration(String value) {
    _PurchaseNarration = value;
  }

  String get PurchaseProducts => _PurchaseProducts;

  set PurchaseProducts(String value) {
    _PurchaseProducts = value;
  }

  String get PurchaseIds => _PurchaseIds;

  set PurchaseIds(String value) {
    _PurchaseIds = value;
  }

  String get Purchaseinvoice => _Purchaseinvoice;

  set Purchaseinvoice(String value) {
    _Purchaseinvoice = value;
  }

  String get purchasesupplierid => _purchasesupplierid;

  set purchasesupplierid(String value) {
    _purchasesupplierid = value;
  }

  String get SupplierCustomername => _SupplierCustomername;

  set SupplierCustomername(String value) {
    _SupplierCustomername = value;
  }

  String get SupplierComapanyPersonName => _SupplierComapanyPersonName;

  set SupplierComapanyPersonName(String value) {
    _SupplierComapanyPersonName = value;
  }

  String get SupplierMobileNumber => _SupplierMobileNumber;

  set SupplierMobileNumber(String value) {
    _SupplierMobileNumber = value;
  }

  String get SupplierEmail => _SupplierEmail;

  set SupplierEmail(String value) {
    _SupplierEmail = value;
  }

  String get SupplierAddress => _SupplierAddress;

  set SupplierAddress(String value) {
    _SupplierAddress = value;
  }

  String get SupplierGSTNumber => _SupplierGSTNumber;

  set SupplierGSTNumber(String value) {
    _SupplierGSTNumber = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (Purchaseid != null) {
      map['Purchase_id'] = _Purchaseid;
    }
    map['purchase_Company_Name'] = _PurchaseCompanyname;
    map['purchase_Date'] = _PurchaseDate;
    map['purchase_Product_Name'] = _PurchaseProductName;
    map['purchase_Rate'] = _PurchaseProductRate;
    map['purchase_Quntity'] = _PurchaseProductQty;
    map['purchase_Product_SubTotal'] = _PurchaseProductSubTotal;
    map['purchase_SubTotal'] = _PurchaseSubTotal;
    map['purchase_Discount'] = _PurchaseDiscount;
    map['purchase_GST'] = _PurchaseGST;
    map['purchase_Miscellaneons'] = _PurchaseMiscellaneons;
    map['purchase_Total_Amount'] = _PurchaseTotal;
    map['purchase_Narration'] = _PurchaseNarration;
    return map;
  }

  // Extract a Note object from a Map object

  Purchase.fromMapObject(Map<String, dynamic> map) {
    this._Purchaseid = map['Purchase_id'];
    this._PurchaseCompanyname = map['purchase_Company_Name'];
    this._PurchaseDate = map['purchase_Date'];
    this._PurchaseProductName = map['purchase_Product_Name'];
    this._PurchaseProductRate = map['purchase_Rate'];
    this._PurchaseProductQty = map['purchase_Quntity'];
    this._PurchaseProductSubTotal = map['purchase_Product_SubTotal'];
    this._PurchaseSubTotal = map['purchase_SubTotal'];
    this._PurchaseDiscount = map['purchase_Discount'];
    this._PurchaseGST = map['purchase_GST'];
    this._PurchaseMiscellaneons = map['purchase_Miscellaneons'];
    this._PurchaseTotal = map['purchase_Total_Amount'];
    this._PurchaseNarration = map['purchase_Narration'];
  }
}
