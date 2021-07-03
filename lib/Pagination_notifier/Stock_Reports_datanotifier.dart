import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;
import 'package:retailerp/LocalDbModels/product_model.dart';

class StockReportsDataNotifier extends ChangeNotifier {

  SalesDataNotifier() {
  }
  List<ProductModel> get StockReportsModel => _StockReportsModel;

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
  var _StockReportsModel = <ProductModel>[];

  void addStockReportsData(ProductModel item) {
    _StockReportsModel.add(item);
    notifyListeners();
  }

  void clear() {
    _StockReportsModel.clear();
    notifyListeners();
  }

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

}
