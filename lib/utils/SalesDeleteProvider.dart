import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/Sales.dart';

class SalesDeleteProvider extends ChangeNotifier{
  List<Sales> _sales = [

  ];

  UnmodifiableListView<Sales> get sales {
    return UnmodifiableListView(_sales);
  }

  int get productCount {
    return _sales.length;
  }

  void addSales(Sales sales)  {
    _sales.add(sales);
    print("I am in Provider");
    notifyListeners();
  }

  void deleteSales(Sales sales) {
    _sales.remove(sales);
    notifyListeners();
  }



}