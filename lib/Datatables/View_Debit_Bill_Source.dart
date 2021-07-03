import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/POSUIONE/bill_reprint.dart';
import 'package:retailerp/pages/Preview_sales.dart';

typedef OnRowSelect = void Function(int index);

class ViewDebitBillDataTableSource extends DataTableSource {
  ViewDebitBillDataTableSource(
      {@required List<EhotelSales> ViewDebitBillData,
      @required BuildContext context})
      : _ViewDebitBillData = ViewDebitBillData,
        assert(ViewDebitBillData != null),
        conxt = context;

  final List<EhotelSales> _ViewDebitBillData;
  final BuildContext conxt;

  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _ViewDebitBillData.length) {
      return null;
    }
    final _viewDebitbill = _ViewDebitBillData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${_viewDebitbill.menusalesid}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewDebitbill.customername}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_viewDebitbill.medate}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewDebitbill.totalamount}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewDebitbill.discount.isNotEmpty ? _viewDebitbill.discount : '0.00'}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewDebitbill.paymodename}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewDebitbill.accounttypename}',
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
                                PreviewSales(index, _ViewDebitBillData)));
                    ;
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
                        _ViewDebitBillData[index].menuname.split("#").toList();
                    var RATE =
                        _ViewDebitBillData[index].menurate.split("#").toList();
                    var Quant = _ViewDebitBillData[index]
                        .menuquntity
                        .split("#")
                        .toList();
                    var ProSubtotal = _ViewDebitBillData[index]
                        .menusubtotal
                        .split("#")
                        .toList();
                    var GSTPER =
                        _ViewDebitBillData[index].menugst.split("#").toList();

                    Navigator.push(
                        conxt,
                        MaterialPageRoute(
                            builder: (context) => BillRePrint(
                                ProductName,
                                RATE,
                                Quant,
                                ProSubtotal,
                                GSTPER,
                                _ViewDebitBillData[index].Subtotal.toString(),
                                _ViewDebitBillData[index].discount.toString(),
                                _ViewDebitBillData[index]
                                    .totalamount
                                    .toString(),
                                _ViewDebitBillData[index]
                                    .customername
                                    .toString(),
                                _ViewDebitBillData[index].medate.toString(),
                                _ViewDebitBillData[index]
                                    .menusalesid
                                    .toString())));
                    ;
                  },
                ),
              ),

              // IconButton(
              //   icon: Icon(
              //     Icons.edit,
              //   ),
              //   color: Colors.green,
              //   // onPressed: () {
              //   //   Navigator.push(
              //   //       context,
              //   //       MaterialPageRoute(
              //   //           builder: (context) =>
              //   //               EditSaleScreenNew(index, DebitBillList)));
              //   // },
              // ),
              // IconButton(
              //   icon: Icon(
              //     Icons.delete,
              //   ),
              //   color: Colors.red,
              //   onPressed: () {
              //     _showMyDialog(DebitBillList[index].menusalesid);
              //   },
              // ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _ViewDebitBillData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(EhotelSales d) getField, bool ascending) {
    _ViewDebitBillData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
