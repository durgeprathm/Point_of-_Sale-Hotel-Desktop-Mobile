import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/POSUIONE/bill_reprint.dart';
import 'package:retailerp/pages/Preview_sales.dart';

typedef OnRowSelect = void Function(int index);

class ViewCashBillDataTableSource extends DataTableSource {
  ViewCashBillDataTableSource(
      {@required List<EhotelSales> ViewCashBillData,
      @required BuildContext context})
      : _ViewCashBillData = ViewCashBillData,
        assert(ViewCashBillData != null),
        conxt = context;

  final List<EhotelSales> _ViewCashBillData;
  final BuildContext conxt;

  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _ViewCashBillData.length) {
      return null;
    }
    final _viewcashbill = _ViewCashBillData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${_viewcashbill.customername}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewcashbill.customername}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_viewcashbill.medate}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewcashbill.totalamount}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewcashbill.discount.isNotEmpty ? _viewcashbill.discount : '0.00'}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewcashbill.paymodename}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewcashbill.accounttypename}',
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
                                PreviewSales(index, _ViewCashBillData)));
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
                        _ViewCashBillData[index].menuname.split("#").toList();
                    var RATE =
                        _ViewCashBillData[index].menurate.split("#").toList();
                    var Quant = _ViewCashBillData[index]
                        .menuquntity
                        .split("#")
                        .toList();
                    var ProSubtotal = _ViewCashBillData[index]
                        .menusubtotal
                        .split("#")
                        .toList();
                    var GSTPER =
                        _ViewCashBillData[index].menugst.split("#").toList();

                    Navigator.push(
                        conxt,
                        MaterialPageRoute(
                            builder: (context) => BillRePrint(
                                ProductName,
                                RATE,
                                Quant,
                                ProSubtotal,
                                GSTPER,
                                _ViewCashBillData[index].Subtotal.toString(),
                                _ViewCashBillData[index].discount.toString(),
                                _ViewCashBillData[index].totalamount.toString(),
                                _ViewCashBillData[index]
                                    .customername
                                    .toString(),
                                _ViewCashBillData[index].medate.toString(),
                                _ViewCashBillData[index]
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
  int get rowCount => _ViewCashBillData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(EhotelSales d) getField, bool ascending) {
    _ViewCashBillData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
