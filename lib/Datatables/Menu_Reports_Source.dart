import 'package:flutter/material.dart';
import 'package:retailerp/models/menu.dart';

typedef OnRowSelect = void Function(int index);

class MenuReportsDataTableSource extends DataTableSource {
  MenuReportsDataTableSource({
    @required List<Menu> MenuReportsData,
  })  : _MenuReportsData = MenuReportsData,
        assert(MenuReportsData != null);

  final List<Menu> _MenuReportsData;

  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _MenuReportsData.length) {
      return null;
    }
    final _menureports = _MenuReportsData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${_menureports.id}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_menureports.menuName}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_menureports.menucategory}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_menureports.menuRate}',
          textAlign: TextAlign.right,
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _MenuReportsData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(Menu d) getField, bool ascending) {
    _MenuReportsData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
