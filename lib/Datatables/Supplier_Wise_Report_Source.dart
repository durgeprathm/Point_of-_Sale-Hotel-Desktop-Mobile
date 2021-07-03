import 'package:flutter/material.dart';
import 'package:retailerp/LedgerManagement/Models/ledgermodel.dart';

typedef OnRowSelect = void Function(int index);

class SupplierWiseReportDataTableSource extends DataTableSource {
  SupplierWiseReportDataTableSource({
    @required List<Supplier> SupplierWiseReportData,
  @required BuildContext context
  })  : _SupplierWiseReportData = SupplierWiseReportData,

        assert(SupplierWiseReportData != null),conxt = context;

  final List<Supplier> _SupplierWiseReportData;
  final BuildContext conxt;

  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _SupplierWiseReportData.length) {
      return null;
    }
    final _managesupplier = _SupplierWiseReportData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${_managesupplier.Supplierid}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_managesupplier.SupplierComapanyPersonName}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_managesupplier.SupplierComapanyName}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_managesupplier.SupplierMobile}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_managesupplier.SupplierEmail}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_managesupplier.SupplierGSTNumber}',
          textAlign: TextAlign.left,
        )),
      ],
    );
  }


  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _SupplierWiseReportData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(Supplier d) getField, bool ascending) {
    _SupplierWiseReportData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
