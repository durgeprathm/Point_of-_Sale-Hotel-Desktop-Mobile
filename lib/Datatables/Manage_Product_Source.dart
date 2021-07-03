import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/MobilePages/mobile_update_product_screen.dart';
import 'package:retailerp/pages/manage_product.dart';
import 'package:retailerp/pages/update_product_screen.dart';

class ManageProductsDataTableSource extends DataTableSource {
  ManageProductsDataTableSource(
      {@required List<ProductModel> ManageProductsData,
      @required BuildContext cont})
      : _ManageProductsData = ManageProductsData,
        assert(ManageProductsData != null),
        context = cont;

  final List<ProductModel> _ManageProductsData;
  BuildContext context;

  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _ManageProductsData.length) {
      return null;
    }
    final _allcashreports = _ManageProductsData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${_allcashreports.proId}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_allcashreports.proName}',
          textAlign: TextAlign.left,
        )),
        DataCell(Text(
          '${_allcashreports.proCategory}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_allcashreports.proOpeningBal}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_allcashreports.proSellingPrice}',
          textAlign: TextAlign.right,
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
                    navigateToUpdate(index, _ManageProductsData);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                  ),
                  color: Colors.red,
                  onPressed: () {
                    _showMyDialog(_ManageProductsData[index].proId);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog(int id) async {
    return showDialog<void>(
      context: context,
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
                      await productdelete.productDataDelete(id.toString());
                  var res = result['resid'];
                  if (res == 200) {
                    print("//////////////////Print result//////$result");
                    print("///delete id///$id");
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ManageProduct(),
                      ),
                    );
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

  void navigateToUpdate(rowID, productList) async {
    var screenOrien = MediaQuery.of(context).orientation;
    bool result;
    if (screenOrien == Orientation.portrait) {
      result = await Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) =>
                  MobileUpdateProductScreen(rowID, productList)))
          .then((value) => _reload(value));
    } else {
      result = await Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) => UpdateProductScreen(rowID, productList)))
          .then((value) => _reload(value));
    }

    if (result == true) {
      //_getProducts();
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ManageProduct(),
        ),
      );
    }
  }

  _reload(value) {
    //_getProducts();
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => ManageProduct(),
      ),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _ManageProductsData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(
      Comparable<T> Function(ProductModel d) getField, bool ascending) {
    _ManageProductsData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
