import 'dart:collection';

import 'package:flutter/foundation.dart';

class PurchaseItem {
  int _Purchaseid;
  String _PurchaseCompanyname;
  String _PurchaseDate;
  String _PurchaseProductName;
  double _PurchaseProductRate;
  int _PurchaseProductQty;
  String _PurchaseProductSubTotal;
  String _PurchaseSubTotal;
  String _PurchaseDiscount;
  int _PurchaseGST;
  String _PurchaseMiscellaneons;
  String _PurchaseTotal;
  String _PurchaseNarration;

  PurchaseItem.cust(
      this._Purchaseid,
      this._PurchaseProductName,
      this._PurchaseProductRate,
      this._PurchaseGST,
      this._PurchaseProductQty,
      this._PurchaseProductSubTotal);

  PurchaseItem(
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
      this._PurchaseNarration);

  PurchaseItem.copyWith(
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

  int get Purchaseid => _Purchaseid;

  set Purchaseid(int value) {
    _Purchaseid = value;
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

  PurchaseItem.fromMapObject(Map<String, dynamic> map) {
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

  double get PurchaseProductRate => _PurchaseProductRate;

  set PurchaseProductRate(double value) {
    _PurchaseProductRate = value;
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

  int get PurchaseGST => _PurchaseGST;

  set PurchaseGST(int value) {
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

  int get PurchaseProductQty => _PurchaseProductQty;

  set PurchaseProductQty(int value) {
    _PurchaseProductQty = value;
  }
}

class PurchaseModel with ChangeNotifier {
  List<PurchaseItem> _purchaseItems = [];

  int get itemCount {
    return _purchaseItems.length;
  }

  UnmodifiableListView<PurchaseItem> get pProduct {
    return UnmodifiableListView(_purchaseItems);
  }

  double get totalAmount {
    var total = 0.0;
    _purchaseItems.forEach((element) {
      // total += element.PurchaseProductRate * element.PurchaseProductQty;
      total += double.parse(element.PurchaseProductSubTotal);
    });

    return total;
  }

  void addPurchaseProduct(PurchaseItem item) {
    _purchaseItems.add(item);
    notifyListeners();
  }

  void updatePurchaseProduct(int proId, String proname, double rate, int gst,
      int qty, String prosubtotal, PurchaseItem item) {
    item.Purchaseid = proId;
    item.PurchaseProductName = proname;
    item.PurchaseProductRate = rate;
    item.PurchaseGST = gst;
    item.PurchaseProductQty = qty;
    item.PurchaseProductSubTotal = prosubtotal;
    notifyListeners();
  }

  void removeItem(PurchaseItem item) {
    _purchaseItems.remove(item);
    notifyListeners();
  }

  void clear() {
    _purchaseItems.clear();
    notifyListeners();
  }
}
