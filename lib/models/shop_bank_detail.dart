import 'dart:collection';

import 'package:flutter/material.dart';

class ShopBankDetailsItems {
  String _bankHolderName;
  String _bankName;
  String _bankAcNo;
  String _bankAcType;
  String _bankIFSCCode;

  ShopBankDetailsItems(this._bankHolderName, this._bankName, this._bankAcNo,
      this._bankAcType, this._bankIFSCCode);

  String get bankIFSCCode => _bankIFSCCode;

  set bankIFSCCode(String value) {
    _bankIFSCCode = value;
  }

  String get bankAcType => _bankAcType;

  set bankAcType(String value) {
    _bankAcType = value;
  }

  String get bankAcNo => _bankAcNo;

  set bankAcNo(String value) {
    _bankAcNo = value;
  }

  String get bankName => _bankName;

  set bankName(String value) {
    _bankName = value;
  }

  String get bankHolderName => _bankHolderName;

  set bankHolderName(String value) {
    _bankHolderName = value;
  }
}

class ShopBankDetails with ChangeNotifier {
  List<ShopBankDetailsItems> _purchaseItems = [];

  int get itemCount {
    return _purchaseItems.length;
  }

  UnmodifiableListView<ShopBankDetailsItems> get pbank {
    return UnmodifiableListView(_purchaseItems);
  }

  void addPurchaseProduct(ShopBankDetailsItems item) {
    _purchaseItems.add(item);
    notifyListeners();
  }

  void updatePurchaseProduct(
      String bankHolderName,
      String bankName,
      String bankAcNo,
      String bankAcType,
      String bankIFSCCode,
      ShopBankDetailsItems item) {
    item.bankHolderName = bankHolderName.toString();
    item.bankName = bankName;
    item.bankAcNo = bankAcNo;
    item.bankAcType = bankAcType;
    item.bankIFSCCode = bankIFSCCode;
    notifyListeners();
  }

  void removeItem(ShopBankDetailsItems item) {
    _purchaseItems.remove(item);
    notifyListeners();
  }

  void clear() {
    _purchaseItems.clear();
    notifyListeners();
  }
}
