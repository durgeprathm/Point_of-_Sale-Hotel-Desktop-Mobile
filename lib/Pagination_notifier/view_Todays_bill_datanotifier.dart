import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;
import 'package:retailerp/EhotelModel/EhotelSales.dart';

class ViewTodayBillDataNotifier extends ChangeNotifier {
  // List<Sales> _salesModel = [];
  SalesDataNotifier() {
  }
  List<EhotelSales> get ViewTodayModel => _ViewTodayModel;

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
  var _ViewTodayModel = <EhotelSales>[];

  void addSalesBillData(EhotelSales item) {
    _ViewTodayModel.add(item);
    notifyListeners();
  }

  void clear() {
    _ViewTodayModel.clear();
    notifyListeners();
  }

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

}
