import 'package:flutter/material.dart';
import 'package:retailerp/models/Purchase.dart';

typedef OnRowSelect = void Function(int index);

class PurchaseReportsDataTableSource extends DataTableSource {
  PurchaseReportsDataTableSource({
    @required List<Purchase> PurchaseReportsData,
  })  : _PurchaseReportsData = PurchaseReportsData,
        assert(PurchaseReportsData != null);

  final List<Purchase> _PurchaseReportsData;

  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _PurchaseReportsData.length) {
      return null;
    }
    final _purchsereport = _PurchaseReportsData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${_purchsereport.Purchaseid}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_purchsereport.PurchaseDate}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_purchsereport.PurchaseCompanyname}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_purchsereport.Purchaseinvoice}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_purchsereport.PurchaseDiscount.isNotEmpty ? _purchsereport.PurchaseDiscount : '0.00'}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_purchsereport.PurchaseMiscellaneons.isNotEmpty ? _purchsereport.PurchaseMiscellaneons : '0.00'}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_purchsereport.PurchaseTotal}',
          textAlign: TextAlign.right,
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _PurchaseReportsData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(Purchase d) getField, bool ascending) {
    _PurchaseReportsData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
