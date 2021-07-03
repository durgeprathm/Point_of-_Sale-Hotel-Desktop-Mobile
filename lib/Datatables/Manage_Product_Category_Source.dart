import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/LocalDbModels/product_category.dart';
import 'package:retailerp/pages/manage_product_category.dart';
import 'package:retailerp/pages/update_product_category_screen.dart';

typedef OnRowSelect = void Function(int index);

class ManageProductCategoryDataTableSource extends DataTableSource {
  ManageProductCategoryDataTableSource(
      {@required List<ProductCategory> ManageProductCategoryData,
      @required BuildContext context})
      : _ManageProductCategoryData = ManageProductCategoryData,
        assert(ManageProductCategoryData != null),
        conxt = context;

  final List<ProductCategory> _ManageProductCategoryData;
  final BuildContext conxt;
  String updatedNameCat;
  TextEditingController menucatNameController = TextEditingController();
  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _ManageProductCategoryData.length) {
      return null;
    }
    final _managemenucatgeory = _ManageProductCategoryData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${index + 1}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_managemenucatgeory.pCategoryname}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_managemenucatgeory.pParentCategoryName}',
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
                    navigateToUpdate(index, _ManageProductCategoryData);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                  ),
                  color: Colors.red,
                  onPressed: () {
                    _showMyDialog(_ManageProductCategoryData[index].catid);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void navigateToUpdate(index, productCategory) async {
    Navigator.of(conxt).push(MaterialPageRoute(
        builder: (context) =>
            UpdateProductCategoryScreen(index, productCategory)));
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
                  ProductFetch salesdelete = new ProductFetch();
                  var result =
                      await salesdelete.productCategoryDelete(id.toString());
                  var res = result["resid"];
                  var message = result["message"];
                  if (res == 200) {
                    print("///delete id///$id");
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(conxt).push(MaterialPageRoute(
                        builder: (context) => ManageProductCategory()));
                    Fluttertoast.showToast(
                        msg: message,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    Fluttertoast.showToast(
                        msg: message,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
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
  int get rowCount => _ManageProductCategoryData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(
      Comparable<T> Function(ProductCategory d) getField, bool ascending) {
    _ManageProductCategoryData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
