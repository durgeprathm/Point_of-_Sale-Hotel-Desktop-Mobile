import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Adpater/pos_purchse_delete.dart';
import 'package:retailerp/LedgerManagement/Adpater/pos_ledger_delete.dart';
import 'package:retailerp/models/Purchase.dart';
import 'package:retailerp/pages/Manage_Purchase.dart';
import 'package:retailerp/pages/Preview_Purchase.dart';
import 'package:retailerp/pages/edit_perchase_screen_new.dart';

typedef OnRowSelect = void Function(int index);

class ManagePurchaseDataTableSource extends DataTableSource {
  ManagePurchaseDataTableSource(
      {@required List<Purchase> ManagePurchaseData,
      @required BuildContext context})
      : _ManagePurchaseData = ManagePurchaseData,
        assert(ManagePurchaseData != null),
        conxt = context;

  final List<Purchase> _ManagePurchaseData;
  final BuildContext conxt;

  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _ManagePurchaseData.length) {
      return null;
    }
    final _managepurchse = _ManagePurchaseData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${_managepurchse.Purchaseid}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_managepurchse.PurchaseDate}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_managepurchse.PurchaseCompanyname}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_managepurchse.Purchaseinvoice}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_managepurchse.PurchaseMiscellaneons.isNotEmpty ? _managepurchse.PurchaseMiscellaneons : '0.00'}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_managepurchse.PurchaseDiscount.isNotEmpty ? _managepurchse.PurchaseDiscount : '0.00'}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_managepurchse.PurchaseTotal}',
          textAlign: TextAlign.right,
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
                                PreviewPurchase(index, _ManagePurchaseData)));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                  ),
                  color: Colors.green,
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => EditPurchaseScreenNew(
                    //             index, searchPurchaseList)));

                    Navigator.of(conxt).push(MaterialPageRoute(
                        builder: (context) =>
                            EditPurchaseScreenNew(index, _ManagePurchaseData)));
                    // .then((value) => _reload(value));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                  ),
                  color: Colors.red,
                  onPressed: () {
                    _showMyDialog(_ManagePurchaseData[index].Purchaseid);
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
  int get rowCount => _ManagePurchaseData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(Purchase d) getField, bool ascending) {
    _ManagePurchaseData.sort((a, b) {
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
                  PurchaseDelete purchasedelete = new PurchaseDelete();
                  var result =
                      await purchasedelete.getPurchaseDelete(id.toString());
                  print("//////////////////Print result//////$result");
                  print("///delete id///$id");
                  // Navigator.of(context).pop();
                  // _getPurchase('0', '', '', '');

                  Navigator.pushReplacement<void, void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => Managepurchase(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
