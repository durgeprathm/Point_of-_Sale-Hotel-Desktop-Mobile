import 'package:flutter/material.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';

typedef OnRowSelect = void Function(int index);

class StockReportsDataTableSource extends DataTableSource {
  StockReportsDataTableSource({
    @required List<ProductModel> StockReportsData,
  })  : _StockReportsData = StockReportsData,
        assert(StockReportsData != null);

  final List<ProductModel> _StockReportsData;

  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _StockReportsData.length) {
      return null;
    }
    final _stockreport = _StockReportsData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${index+1}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_stockreport.proName}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_stockreport.proComName}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_stockreport.proCategory}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_stockreport.productpurchse}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_stockreport.productsale}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_stockreport.productremaing}',
          textAlign: TextAlign.right,
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _StockReportsData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(
      Comparable<T> Function(ProductModel d) getField, bool ascending) {
    _StockReportsData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
