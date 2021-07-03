import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/LocalDbModels/product_category.dart';

typedef OnRowSelect = void Function(int index);

class StockCategoryDataTableSource extends DataTableSource {
  StockCategoryDataTableSource({
    @required List<ProductCategory> StockCatgeoryData,
  })  : _StockCatgeoryData = StockCatgeoryData,
        assert(StockCatgeoryData != null);

  final List<ProductCategory> _StockCatgeoryData;

  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _StockCatgeoryData.length) {
      return null;
    }
    final _stockcategoryreports = _StockCatgeoryData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${_stockcategoryreports.catid}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_stockcategoryreports.pCategoryname}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_stockcategoryreports.pParentCategoryName}',
          textAlign: TextAlign.right,
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _StockCatgeoryData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(ProductCategory d) getField, bool ascending) {
    _StockCatgeoryData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
