import 'package:flutter/material.dart';
import 'package:retailerp/LedgerManagement/Adpater/pos_ledger_delete.dart';
import 'package:retailerp/LedgerManagement/Manage_Ledger.dart';
import 'package:retailerp/LedgerManagement/Models/ledgermodel.dart';
import 'package:retailerp/pages/Edit_Suppliers.dart';
import 'package:retailerp/pages/Preview_Suppliers.dart';

typedef OnRowSelect = void Function(int index);

class ManageSupplierDataTableSource extends DataTableSource {
  ManageSupplierDataTableSource({
    @required List<Supplier> ManageSupplieData,
  @required BuildContext context
  })  : _ManageSupplieDataData = ManageSupplieData,

        assert(ManageSupplieData != null),conxt = context;

  final List<Supplier> _ManageSupplieDataData;
  final BuildContext conxt;

  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _ManageSupplieDataData.length) {
      return null;
    }
    final _managesupplier = _ManageSupplieDataData[index];
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
        DataCell(
          Row(
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
                              PreviewSuppliers(index, _ManageSupplieDataData)));
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
                              EditSupplierDetails(index, _ManageSupplieDataData)));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                color: Colors.red,
                onPressed: () {
                  _showMyDialog(_ManageSupplieDataData[index].Supplierid);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog(int id) async {
    return showDialog<void>(
      context: conxt,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              "Do You Want To Delete!",
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
                  // SupplierDelete supplierdelete = new SupplierDelete();
                  // var result =
                  //     await supplierdelete.getSupplierDelete(id.toString());
                  // print("//////////////////Print result//////$result");
                  // print("///delete id///$id");
                  // Navigator.of(context).pop();
                  // _getSupplier();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _ManageSupplieDataData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(Supplier d) getField, bool ascending) {
    _ManageSupplieDataData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
