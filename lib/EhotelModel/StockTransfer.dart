import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:retailerp/Repository/database_creator.dart';

class StockTranfer {

  int _StockTranferid;
  String _StockTranferDepartmentname ;
  String _StockTranferDate;
  String _StockTranferProductId;
  String _StockTranferProductName;
  String _StockTranferProductQty;
  String _StockTranferNarration;
  int _StockTranferDepartmentid;
  int _srno;




  StockTranfer(this._srno,this._StockTranferid, this._StockTranferDepartmentname, this._StockTranferDate, this._StockTranferProductName,this._StockTranferProductQty, this._StockTranferNarration);
  StockTranfer.Ehotel(this._StockTranferid, this._StockTranferDepartmentname, this._StockTranferDate,this._StockTranferProductId, this._StockTranferProductName,this._StockTranferProductQty, this._StockTranferNarration,this._StockTranferDepartmentid);
  StockTranfer.yes(this._StockTranferDepartmentname, this._StockTranferDate, this._StockTranferProductName,this._StockTranferProductQty, this._StockTranferNarration,this._StockTranferDepartmentid);

  StockTranfer.copyWith(this._StockTranferDepartmentname, this._StockTranferDate, this._StockTranferProductName,this._StockTranferProductQty, this._StockTranferNarration);
  StockTranfer.cust(this._StockTranferProductName,this._StockTranferProductQty);
  StockTranfer.custWithId(this._StockTranferProductId,this._StockTranferProductName,this._StockTranferProductQty);


  int get srno => _srno;

  set srno(int value) {
    _srno = value;
  }

  String get StockTranferProductId => _StockTranferProductId;

  set StockTranferProductId(String value) {
    _StockTranferProductId = value;
  }

  int get StockTranferDepartmentid => _StockTranferDepartmentid;

  set StockTranferDepartmentid(int value) {
    _StockTranferDepartmentid = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_StockTranferid != null) {
      map['StockTranfer_id'] = _StockTranferid;
    }
    map['StockTranfer_Department_name'] =  _StockTranferDepartmentname;
    map['StockTranfer_Date'] = _StockTranferDate;
    map['StockTranfer_Product_Name'] = _StockTranferProductName;
    map['StockTranfer_Product_Qty'] = _StockTranferProductQty;
    map['StockTranfer_Narration'] = _StockTranferNarration;
    return map;
  }


  // Extract a Note object from a Map object

  StockTranfer.fromMapObject(Map<String, dynamic> map) {
    this._StockTranferid = map['StockTranfer_id'];
    this._StockTranferDepartmentname = map['StockTranfer_Department_name'];
    this._StockTranferDate = map['StockTranfer_Date'];
    this._StockTranferProductName = map['Sales_Product_Name'];
    this._StockTranferProductQty = map['StockTranfer_Product_Qty'];
    this._StockTranferNarration = map['StockTranfer_Narration'];
  }

  String get StockTranferNarration => _StockTranferNarration;

  set StockTranferNarration(String value) {
    _StockTranferNarration = value;
  }

  String get StockTranferProductQty => _StockTranferProductQty;

  set StockTranferProductQty(String value) {
    _StockTranferProductQty = value;
  }

  String get StockTranferProductName => _StockTranferProductName;

  set StockTranferProductName(String value) {
    _StockTranferProductName = value;
  }

  String get StockTranferDate => _StockTranferDate;

  set StockTranferDate(String value) {
    _StockTranferDate = value;
  }

  String get StockTranferDepartmentname => _StockTranferDepartmentname;

  set StockTranferDepartmentname(String value) {
    _StockTranferDepartmentname = value;
  }

  int get StockTranferid => _StockTranferid;

  set StockTranferid(int value) {
    _StockTranferid = value;
  }
}


//-------------------Provider-------------------------------------
class StockTranferProvider with ChangeNotifier {
  List<StockTranfer> _stockTranferItems = [];

  int get itemCount {
    return _stockTranferItems.length;
  }

  UnmodifiableListView<StockTranfer> get pStockTranfer {
    return UnmodifiableListView(_stockTranferItems);
  }


  void addStockTranfer(StockTranfer item) {
    _stockTranferItems.add(item);
    notifyListeners();
  }

  // void updateSalesProduct(int proId,String proname, double rate, int gst, int qty,
  //     String prosubtotal, SalesItem item) {
  //   item.Salesid = proId;
  //   item.SalesProductName = proname;
  //   item.SalesProductRate = rate;
  //   item.SalesGST = gst;
  //   item.SalesProductQty = qty;
  //   item.SalesProductSubTotal = prosubtotal;
  //   notifyListeners();
  // }

  void removeItem(StockTranfer item) {
    _stockTranferItems.remove(item);
    notifyListeners();
  }

  void clear() {
    _stockTranferItems.clear();
    notifyListeners();
  }
}
