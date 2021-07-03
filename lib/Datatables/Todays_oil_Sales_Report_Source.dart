import 'package:flutter/material.dart';
import 'package:retailerp/EhotelModel/Ehotelmenu.dart';

typedef OnRowSelect = void Function(int index);

class TodaysOilSalesReportDataTableSource extends DataTableSource {
  TodaysOilSalesReportDataTableSource(
      {@required List<Ehotelmenu> TodaysOilSalesReportData,
      @required BuildContext context})
      : _TodaysOilSalesReportData = TodaysOilSalesReportData,
        assert(TodaysOilSalesReportData != null),
        conxt = context;

  final List<Ehotelmenu> _TodaysOilSalesReportData;
  final BuildContext conxt;

  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _TodaysOilSalesReportData.length) {
      return null;
    }
    final _todaysoilsales = _TodaysOilSalesReportData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${_todaysoilsales.menu_id}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_todaysoilsales.Menu_Name}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_todaysoilsales.Menu_Cat_Name}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_todaysoilsales.Menu_Qty_Sum}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_todaysoilsales.Menu_Rate}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_todaysoilsales.Menu_total_amount}',
          textAlign: TextAlign.left,
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _TodaysOilSalesReportData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(Ehotelmenu d) getField, bool ascending) {
    _TodaysOilSalesReportData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
