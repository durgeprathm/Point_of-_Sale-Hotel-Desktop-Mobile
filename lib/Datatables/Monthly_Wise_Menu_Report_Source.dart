import 'package:flutter/material.dart';
import 'package:retailerp/EhotelModel/Ehotelmenu.dart';

typedef OnRowSelect = void Function(int index);

class MonthlyWiseMenuReportDataTableSource extends DataTableSource {
  MonthlyWiseMenuReportDataTableSource(
      {@required List<Ehotelmenu> MonthlyWiseMenuReportData,
      @required BuildContext context})
      : _MonthlyWiseMenuReportData = MonthlyWiseMenuReportData,
        assert(MonthlyWiseMenuReportData != null),
        conxt = context;

  final List<Ehotelmenu> _MonthlyWiseMenuReportData;
  final BuildContext conxt;

  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _MonthlyWiseMenuReportData.length) {
      return null;
    }
    final _monthlywisemenu = _MonthlyWiseMenuReportData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${_monthlywisemenu.menu_id}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_monthlywisemenu.Menu_Name}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_monthlywisemenu.Menu_Cat_Name}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_monthlywisemenu.Menu_Qty_Sum}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_monthlywisemenu.Menu_Rate}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_monthlywisemenu.Menu_total_amount}',
          textAlign: TextAlign.left,
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _MonthlyWiseMenuReportData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(Ehotelmenu d) getField, bool ascending) {
    _MonthlyWiseMenuReportData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
