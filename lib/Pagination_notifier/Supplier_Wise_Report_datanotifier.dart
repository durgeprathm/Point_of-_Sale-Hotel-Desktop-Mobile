import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;
import 'package:retailerp/LedgerManagement/Models/ledgermodel.dart';

class SupplierWiseReportDataNotifier extends ChangeNotifier {
  // List<Sales> _salesModel = [];
  SalesDataNotifier() {}
  List<Supplier> get SupplierWiseReportModel =>
      _SupplierWiseReportModel;

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
  var _SupplierWiseReportModel = <Supplier>[];

  void addSupplierWiseData(Supplier item) {
    _SupplierWiseReportModel.add(item);
    notifyListeners();
  }

  void clear() {
    _SupplierWiseReportModel.clear();
    notifyListeners();
  }

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
}
