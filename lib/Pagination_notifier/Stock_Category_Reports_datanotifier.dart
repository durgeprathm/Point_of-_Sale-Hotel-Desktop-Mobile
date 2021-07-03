import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;
import 'package:retailerp/LocalDbModels/product_category.dart';

class StockCategoryReportsDataNotifier extends ChangeNotifier {
  // List<Sales> _salesModel = [];
  SalesDataNotifier() {
  }
  List<ProductCategory> get StockCategoryReportsModel => _StockCategoryReportsModel;

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
  var _StockCategoryReportsModel = <ProductCategory>[];

  void addStockCategoryData(ProductCategory item) {
    _StockCategoryReportsModel.add(item);
    notifyListeners();
  }

  void clear() {
    _StockCategoryReportsModel.clear();
    notifyListeners();
  }

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

}
