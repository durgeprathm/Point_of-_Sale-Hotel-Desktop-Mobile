import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Adpater/pos_sales_delete.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/editPOSUI/table_pos_frontpage_edit.dart';
import 'package:retailerp/pages/Manage_Sales.dart';
import 'package:retailerp/pages/Preview_sales.dart';

typedef OnRowSelect = void Function(int index);

class ViewSalesBookDataTableSource extends DataTableSource {
  ViewSalesBookDataTableSource(
      {@required List<EhotelSales> ViewSalesBookData,
      @required BuildContext context})
      : _ViewSalesBookData = ViewSalesBookData,
        assert(ViewSalesBookData != null),
        conxt = context;

  final List<EhotelSales> _ViewSalesBookData;
  final BuildContext conxt;

  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _ViewSalesBookData.length) {
      return null;
    }
    final _viewsalesbookbill = _ViewSalesBookData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${_viewsalesbookbill.menusalesid}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewsalesbookbill.medate}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_viewsalesbookbill.customername}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewsalesbookbill.totalamount}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewsalesbookbill.discount.isNotEmpty ? _viewsalesbookbill.discount : '0.00'}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewsalesbookbill.paymodename}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_viewsalesbookbill.accounttypename}',
          textAlign: TextAlign.left,
        )),
        DataCell(
          Center(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.preview,
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                        conxt,
                        MaterialPageRoute(
                            builder: (context) =>
                                PreviewSales(index, _ViewSalesBookData)));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                  ),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                        conxt,
                        MaterialPageRoute(
                            builder: (context) =>
                                TablePosEdit(index, _ViewSalesBookData)));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                  ),
                  color: Colors.red,
                  onPressed: () {
                    _showMyDialog(_ViewSalesBookData[index].menusalesid);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _ViewSalesBookData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(EhotelSales d) getField, bool ascending) {
    _ViewSalesBookData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }

  Future<void> _showMyDialog(int id) async {
    return showDialog<void>(
      context: conxt,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              "Want To Delete!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Delete'),
                onPressed: () async {
                  SalesDelete salesdelete = new SalesDelete();
                  var result = await salesdelete.getSalesDelete(id.toString());
                  print("///delete id///$id");
                  Navigator.of(context).pop();
                  var resid = result["resid"];
                  if (resid == 200) {
                    // _getSales('0', '', '', '');
                    //_getSales('1', '', _fromDatetext.text, _toDatetext.text);
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ManageSales(),
                      ),
                    );
                  } else {}
                  //_getSales();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
