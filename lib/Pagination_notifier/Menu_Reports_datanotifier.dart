import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;
import 'package:retailerp/models/menu.dart';

class MenuReportsDataNotifier extends ChangeNotifier {
  // List<Sales> _salesModel = [];
  SalesDataNotifier() {
  }
  List<Menu> get MenuReportsModel => _MenuReportsModel;

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
  var _MenuReportsModel = <Menu>[];

  void addMenuReportsData(Menu item) {
    _MenuReportsModel.add(item);
    notifyListeners();
  }

  void clear() {
    _MenuReportsModel.clear();
    notifyListeners();
  }

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

}
