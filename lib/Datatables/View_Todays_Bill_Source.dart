import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/POSUIONE/bill_reprint.dart';
import 'package:retailerp/pages/Preview_sales.dart';

typedef OnRowSelect = void Function(int index);

class ViewTodaysBillDataTableSource extends DataTableSource {
  ViewTodaysBillDataTableSource(
      {@required List<EhotelSales> ViewTodaysBillData,
      @required BuildContext context})
      : _ViewTodaysBillData = ViewTodaysBillData,
        assert(ViewTodaysBillData != null),
        conxt = context;

  final List<EhotelSales> _ViewTodaysBillData;
  final BuildContext conxt;

  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _ViewTodaysBillData.length) {
      return null;
    }
    final _viewtodaysbill = _ViewTodaysBillData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${_viewtodaysbill.menusalesid}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewtodaysbill.customername}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_viewtodaysbill.discount.isNotEmpty ? _viewtodaysbill.discount : '0.00'}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewtodaysbill.totalamount}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewtodaysbill.paymodename}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewtodaysbill.accounttypename}',
          textAlign: TextAlign.left,
        )),
        DataCell(
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0, left: 12.0),
                child: IconButton(
                  icon: Icon(
                    Icons.preview,
                    size: 25,
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                        conxt,
                        MaterialPageRoute(
                            builder: (context) =>
                                PreviewSales(index, _ViewTodaysBillData)));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0, left: 12.0),
                child: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.print,
                    size: 25,
                  ),
                  color: Colors.blueGrey,
                  onPressed: () {
                    var ProductName =
                        _ViewTodaysBillData[index].menuname.split("#").toList();
                    var RATE =
                        _ViewTodaysBillData[index].menurate.split("#").toList();
                    var Quant = _ViewTodaysBillData[index]
                        .menuquntity
                        .split("#")
                        .toList();
                    var ProSubtotal = _ViewTodaysBillData[index]
                        .menusubtotal
                        .split("#")
                        .toList();
                    var GSTPER =
                        _ViewTodaysBillData[index].menugst.split("#").toList();

                    Navigator.push(
                        conxt,
                        MaterialPageRoute(
                            builder: (context) => BillRePrint(
                                ProductName,
                                RATE,
                                Quant,
                                ProSubtotal,
                                GSTPER,
                                _ViewTodaysBillData[index].Subtotal.toString(),
                                _ViewTodaysBillData[index].discount.toString(),
                                _ViewTodaysBillData[index]
                                    .totalamount
                                    .toString(),
                                _ViewTodaysBillData[index]
                                    .customername
                                    .toString(),
                                _ViewTodaysBillData[index].medate.toString(),
                                _ViewTodaysBillData[index]
                                    .menusalesid
                                    .toString())));
                    ;
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _ViewTodaysBillData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(EhotelSales d) getField, bool ascending) {
    _ViewTodaysBillData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
