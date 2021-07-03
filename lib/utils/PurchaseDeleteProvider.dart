import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/Purchase.dart';

class PurchaseDeleteProvider extends ChangeNotifier{
  List<Purchase> _purchase = [

  ];

  UnmodifiableListView<Purchase> get purchase {
    return UnmodifiableListView(_purchase);
  }

  int get productCount {
    return _purchase.length;
  }

 void addPurchase(Purchase purchase)  {
    _purchase.add(purchase);
    print("I am in Provider");
    notifyListeners();
  }

  void deletePurchase(Purchase purchase) {
    _purchase.remove(purchase);
    notifyListeners();
  }



}