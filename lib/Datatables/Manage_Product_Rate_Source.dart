import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/LocalDbModels/product_rate.dart';
import 'package:retailerp/pages/manage_product_rate.dart';
import 'package:retailerp/pages/update_product_rate_screen.dart';

typedef OnRowSelect = void Function(int index);

class ManageProductRateDataTableSource extends DataTableSource {
  ManageProductRateDataTableSource(
      {@required List<ProductRate> ManageProductRateData,
      @required BuildContext context})
      : _ManageProductRateData = ManageProductRateData,
        assert(ManageProductRateData != null),
        conxt = context;

  final List<ProductRate> _ManageProductRateData;
  final BuildContext conxt;
  String updatedNameCat;
  TextEditingController menucatNameController = TextEditingController();
  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _ManageProductRateData.length) {
      return null;
    }
    final _manageproductrate = _ManageProductRateData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${index + 1}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_manageproductrate.proDate}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_manageproductrate.proName}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_manageproductrate.proCatName}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_manageproductrate.proRate}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_manageproductrate.proGST}',
          textAlign: TextAlign.left,
        )),
        DataCell(
          Center(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                  ),
                  color: Colors.green,
                  onPressed: () {
                    navigateToUpdate(index, _ManageProductRateData);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                  ),
                  color: Colors.red,
                  onPressed: () {
                    _showMyDialog(_ManageProductRateData[index].proRateId);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void navigateToUpdate(index, productRateList) async {
    bool result;
    result = await Navigator.of(conxt).push(MaterialPageRoute(
        builder: (context) => UpdateProductRateScreen(index, productRateList)));

    // if (result == true) {
    //   _getProRate();
    // }
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
                  ProductFetch productdelete = new ProductFetch();
                  var result =
                      await productdelete.productRateDataDelete(id.toString());
                  var res = result['resid'];
                  if (res == 200) {
                    print("//////////////////Print result//////$result");
                    print("///delete id///$id");
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(conxt).push(MaterialPageRoute(
                        builder: (context) => ManageProductRate()));
                  } else {
                    String msg = res["message"];
                    Fluttertoast.showToast(
                      msg: msg,
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Colors.black38,
                      textColor: Color(0xffffffff),
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
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
  int get rowCount => _ManageProductRateData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(ProductRate d) getField, bool ascending) {
    _ManageProductRateData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
