import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;
import 'package:retailerp/models/Purchase.dart';

class ManagePurchaseDataNotifier extends ChangeNotifier {
  // List<Sales> _salesModel = [];
  SalesDataNotifier() {
  }
  List<Purchase> get ManagePurchaseModel => _ManagePurchaseModel;

  // SORT COLUMN INDEX...

  int get sortColumnIndex => _sortColumnIndex;

  set sortColumnIndex(int sortColumnIndex) {
    _sortColumnIndex = sortColumnIndex;
    notifyListeners();
  }

  // SORT ASCENDING....

  bool get sortAscending => _sortAscending;

  set sortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    notifyListeners();
  }

  int get rowsPerPage => _rowsPerPage;

  set rowsPerPage(int rowsPerPage) {
    _rowsPerPage = rowsPerPage;
    notifyListeners();
  }

  // -------------------------------------- INTERNALS --------------------------------------------
  //
  var _ManagePurchaseModel = <Purchase>[];

  void addManagePurchaseData(Purchase item) {
    _ManagePurchaseModel.add(item);
    notifyListeners();
  }

  void clear() {
    _ManagePurchaseModel.clear();
    notifyListeners();
  }

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

}
