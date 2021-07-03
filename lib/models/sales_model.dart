import 'dart:collection';
import 'package:flutter/foundation.dart';

class SalesItem {
  int _Salesid;
  String _SalesCustomername;

  String _SalesDate;
  String _SalesProductName;
  double _SalesProductRate;
  int _SalesProductQty;
  String _SalesProductSubTotal;
  String _SalesSubTotal;
  String _SalesDiscount;
  int _SalesGST;
  String _SalesTotal;
  String _SalesNarration;
  String _SalesPaymentMode;

  SalesItem(
      this._Salesid,
      this._SalesCustomername,
      this._SalesDate,
      this._SalesProductName,
      this._SalesProductRate,
      this._SalesProductQty,
      this._SalesProductSubTotal,
      this._SalesSubTotal,
      this._SalesDiscount,
      this._SalesGST,
      this._SalesTotal,
      this._SalesNarration,
      this._SalesPaymentMode);

  SalesItem.cust(this._Salesid,this._SalesProductName, this._SalesProductRate,
      this._SalesProductQty, this._SalesProductSubTotal, this._SalesGST);

  SalesItem.copyWith(
      this._SalesCustomername,
      this._SalesDate,
      this._SalesProductName,
      this._SalesProductRate,
      this._SalesProductQty,
      this._SalesProductSubTotal,
      this._SalesSubTotal,
      this._SalesDiscount,
      this._SalesGST,
      this._SalesTotal,
      this._SalesNarration,
      this._SalesPaymentMode);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (Salesid != null) {
      map['Sales_id'] = _Salesid;
    }
    map['Sales_Customer_Name'] = _SalesCustomername;
    map['Sales_Date'] = _SalesDate;
    map['Sales_Product_Name'] = _SalesProductName;
    map['Sales_Rate'] = _SalesProductRate;
    map['Sales_Quntity'] = _SalesProductQty;
    map['Sales_Product_SubTotal'] = _SalesProductSubTotal;
    map['Sales_SubTotal'] = _SalesSubTotal;
    map['Sales_Discount'] = _SalesDiscount;
    map['Sales_GST'] = _SalesGST;
    map['Sales_Total_Amount'] = _SalesTotal;
    map['Sales_Narration'] = _SalesNarration;
    map['Sales_Payment_Mode'] = _SalesPaymentMode;
    return map;
  }

  // Extract a Note object from a Map object

  SalesItem.fromMapObject(Map<String, dynamic> map) {
    this._Salesid = map['Sales_id'];
    this._SalesCustomername = map['Sales_Customer_Name'];
    this._SalesDate = map['Sales_Date'];
    this._SalesProductName = map['Sales_Product_Name'];
    this._SalesProductRate = map['Sales_Rate'];
    this._SalesProductQty = map['Sales_Quntity'];
    this._SalesProductSubTotal = map['Sales_Product_SubTotal'];
    this._SalesSubTotal = map['Sales_SubTotal'];
    this._SalesDiscount = map['Sales_Discount'];
    this._SalesGST = map['Sales_GST'];
    this._SalesTotal = map['Sales_Total_Amount'];
    this._SalesNarration = map['Sales_Narration'];
    this._SalesPaymentMode = map['Sales_Payment_Mode'];
  }

  String get SalesPaymentMode => _SalesPaymentMode;

  set SalesPaymentMode(String value) {
    _SalesPaymentMode = value;
  }

  String get SalesNarration => _SalesNarration;

  set SalesNarration(String value) {
    _SalesNarration = value;
  }

  String get SalesTotal => _SalesTotal;

  set SalesTotal(String value) {
    _SalesTotal = value;
  }

  int get SalesGST => _SalesGST;

  set SalesGST(int value) {
    _SalesGST = value;
  }

  String get SalesDiscount => _SalesDiscount;

  set SalesDiscount(String value) {
    _SalesDiscount = value;
  }

  String get SalesSubTotal => _SalesSubTotal;

  set SalesSubTotal(String value) {
    _SalesSubTotal = value;
  }

  String get SalesProductSubTotal => _SalesProductSubTotal;

  set SalesProductSubTotal(String value) {
    _SalesProductSubTotal = value;
  }

  int get SalesProductQty => _SalesProductQty;

  set SalesProductQty(int value) {
    _SalesProductQty = value;
  }

  double get SalesProductRate => _SalesProductRate;

  set SalesProductRate(double value) {
    _SalesProductRate = value;
  }

  String get SalesProductName => _SalesProductName;

  set SalesProductName(String value) {
    _SalesProductName = value;
  }

  String get SalesDate => _SalesDate;

  set SalesDate(String value) {
    _SalesDate = value;
  }

  String get SalesCustomername => _SalesCustomername;

  set SalesCustomername(String value) {
    _SalesCustomername = value;
  }

  int get Salesid => _Salesid;

  set Salesid(int value) {
    _Salesid = value;
  }
}

class SalesModel with ChangeNotifier {
  List<SalesItem> _salesItems = [];

  int get itemCount {
    return _salesItems.length;
  }

  UnmodifiableListView<SalesItem> get pSales {
    return UnmodifiableListView(_salesItems);
  }

  double get totalAmount {
    var total = 0.0;
    _salesItems.forEach((element) {
      // total += (element.SalesProductRate * element.SalesProductQty) ;
      total += double.parse(element.SalesProductSubTotal);
    });

    return total;
  }

  void addSalesProduct(SalesItem item) {
    _salesItems.add(item);
    notifyListeners();
  }

  void updateSalesProduct(int proId,String proname, double rate, int gst, int qty,
      String prosubtotal, SalesItem item) {
    item.Salesid = proId;
    item.SalesProductName = proname;
    item.SalesProductRate = rate;
    item.SalesGST = gst;
    item.SalesProductQty = qty;
    item.SalesProductSubTotal = prosubtotal;
    notifyListeners();
  }

  void removeItem(SalesItem item) {
    _salesItems.remove(item);
    notifyListeners();
  }

  void clear() {
    _salesItems.clear();
    notifyListeners();
  }
}
