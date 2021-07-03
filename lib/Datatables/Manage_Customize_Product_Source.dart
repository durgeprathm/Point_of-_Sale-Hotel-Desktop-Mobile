import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:retailerp/Adpater/Delete_Customizsed_products.dart';
import 'package:retailerp/models/CutomizedProductModel.dart';
import 'package:retailerp/pages/manage_menu.dart';

typedef OnRowSelect = void Function(int index);

class ManageCustomizeProductTableSource extends DataTableSource {
  ManageCustomizeProductTableSource(
      {@required List<CustoProductModel> ManageCustomizeProductData,
      @required BuildContext context})
      : _ManageCustomizeProductData = ManageCustomizeProductData,
        assert(ManageCustomizeProductData != null),
        conxt = context;

  final List<CustoProductModel> _ManageCustomizeProductData;
  final BuildContext conxt;
  String updatedNameCat;
  @override
  DataRow getRow(int index) {
    var srNo = index + 1;
    assert(index >= 0);
    if (index >= _ManageCustomizeProductData.length) {
      return null;
    }
    final _managecustomizeproduct = _ManageCustomizeProductData[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(
          '${index + 1}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_managecustomizeproduct.cpname}',
          textAlign: TextAlign.right,
        )),
        DataCell(Text(
          '${_managecustomizeproduct.cpprice}',
          textAlign: TextAlign.left,
        )),
        DataCell(
          Row(
            children: [
              // IconButton(
              //   icon: Icon(
              //     Icons.preview,
              //   ),
              //   color: Colors.blue,
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) =>
              //                 PreviewMenu(index, searchMenuList)));
              //   },
              // ),
              // IconButton(
              //   icon: Icon(
              //     Icons.edit,
              //   ),
              //   color: Colors.green,
              //   onPressed: () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               EditMenuScreenNew(index, searchMenuList)));
              //navigateToUpdate(index, _ManageCustomizeProductData);
              //   },
              // ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                color: Colors.red,
                onPressed: () {
                  _showMyDialog(_ManageCustomizeProductData[index].cpid);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog(String id) async {
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
                  DeleteCustomizeProducts deletecustomizeproducts =
                      new DeleteCustomizeProducts();
                  var result = await deletecustomizeproducts
                      .getDeleteCustomizeProducts(id.toString());
                  var res = result["resid"];
                  var message = result["message"];
                  if (res == 200) {
                    print("///delete id///$id");
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(conxt).push(
                        MaterialPageRoute(builder: (context) => ManageMenu()));
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

  // void navigateToUpdate(rowID, productList) async {
  //   var screenOrien = MediaQuery.of(conxt).orientation;
  //   bool result;
  //   result = await Navigator.of(conxt)
  //       .push(MaterialPageRoute(
  //       builder: (context) => EditMenuScreenNew(rowID, productList)));
  //
  //   //     await Navigator.push(context, MaterialPageRoute(builder: (context) {
  //   //   return UpdateProductScreen(rowID);
  //   // }));
  //
  //   if (result == true) {
  //     _getMenu();
  //   }
  // }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _ManageCustomizeProductData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(
      Comparable<T> Function(CustoProductModel d) getField, bool ascending) {
    _ManageCustomizeProductData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
