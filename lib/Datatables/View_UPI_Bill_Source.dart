import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/POSUIONE/bill_reprint.dart';
import 'package:retailerp/pages/Preview_sales.dart';

typedef OnRowSelect = void Function(int index);

class ViewUPIBillDataTableSource extends DataTableSource {
  ViewUPIBillDataTableSource(
      {@required List<EhotelSales> ViewUPIBillData,
      @required BuildContext context})
      : _ViewUPIBillData = ViewUPIBillData,
        assert(ViewUPIBillData != null),
        conxt = context;

  final List<EhotelSales> _ViewUPIBillData;
  final BuildContext conxt;

  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _ViewUPIBillData.length) {
      return null;
    }
    final _viewUPIbill = _ViewUPIBillData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${_viewUPIbill.menuid}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewUPIbill.customername}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_viewUPIbill.medate}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewUPIbill.totalamount}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewUPIbill.discount.isNotEmpty ? _viewUPIbill.discount : '0.00'}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewUPIbill.paymodename}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewUPIbill.accounttypename}',
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
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    if (_ViewUPIBillData != null) {
                      Navigator.push(
                          conxt,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PreviewSales(index, _ViewUPIBillData)));
                    }
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
                        _ViewUPIBillData[index].menuname.split("#").toList();
                    var RATE =
                        _ViewUPIBillData[index].menurate.split("#").toList();
                    var Quant =
                        _ViewUPIBillData[index].menuquntity.split("#").toList();
                    var ProSubtotal = _ViewUPIBillData[index]
                        .menusubtotal
                        .split("#")
                        .toList();
                    var GSTPER =
                        _ViewUPIBillData[index].menugst.split("#").toList();

                    Navigator.push(
                        conxt,
                        MaterialPageRoute(
                            builder: (context) => BillRePrint(
                                ProductName,
                                RATE,
                                Quant,
                                ProSubtotal,
                                GSTPER,
                                _ViewUPIBillData[index].Subtotal.toString(),
                                _ViewUPIBillData[index].discount.toString(),
                                _ViewUPIBillData[index].totalamount.toString(),
                                _ViewUPIBillData[index].customername.toString(),
                                _ViewUPIBillData[index].medate.toString(),
                                _ViewUPIBillData[index]
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
              //   //               EditSaleScreenNew(index, UpiBillList)));
              //   // },
              // ),
              // IconButton(
              //   icon: Icon(
              //     Icons.delete,
              //   ),
              //   color: Colors.red,
              //   onPressed: () {
              //     _showMyDialog(UpiBillList[index].menusalesid);
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
  int get rowCount => _ViewUPIBillData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(EhotelSales d) getField, bool ascending) {
    _ViewUPIBillData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
