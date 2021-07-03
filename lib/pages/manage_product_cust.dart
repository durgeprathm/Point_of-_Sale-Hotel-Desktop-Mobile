import 'dart:io';

import 'package:data_tables/data_tables.dart';
import 'package:flutter/material.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/popup_menu.dart';
import 'package:retailerp/providers/popup_menu_item.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/my_navigator.dart';
import 'package:sqflite/sqflite.dart';

class ManageProductCust extends StatefulWidget {
  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProductCust> {
  PopupMenu _selectedMenu = productPopupMenu1[0];
  DatabaseHelper databaseHelper = DatabaseHelper();
  int count = 0;
  String stringConvertIdValue;
  List<ProductModel> _items;
  ProductModel product;

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsOffset = 0;

  // List<ProductModel> selectedProCat;

  @override
  void initState() {
    super.initState();
    updateListView();
    // selectedProCat = [];
  }

  void _sort<T>(
      Comparable<T> getField(ProductModel d), int columnIndex, bool ascending) {
    _items.sort((ProductModel a, ProductModel b) {
      if (!ascending) {
        final ProductModel c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // Navigator.pop(context);
              // MyNavigator.goToDashboard(context);
              Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          new PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              size: 28,
              color: Colors.white,
            ),
            itemBuilder: (BuildContext context) {
              return productPopupMenu1.map((PopupMenu popupMenu) {
                return new PopupMenuItem(
                    value: popupMenu,
                    child: new ListTile(
                      dense: true,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      leading: popupMenu.icon,
                      title: new Text(popupMenu.title),
                    ));
              }).toList();
            },
            onSelected: _selectedPopMenu,
          )
        ],
      ),
      body: NativeDataTable.builder(
        columns: <DataColumn>[
          DataColumn(
              label:
                  Text('Sr No', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label:
                  Text('Code', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Product',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Category',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Balance stock',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Purchasing price',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Selling price',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label:
                  Text('Image', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('', style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        rowsPerPage: _rowsPerPage,
        itemCount: _items?.length ?? 0,
        firstRowIndex: _rowsOffset,
        handleNext: () async {
          setState(() {
            _rowsOffset += _rowsPerPage;
          });
        },
        handlePrevious: () {
          setState(() {
            _rowsOffset -= _rowsPerPage;
          });
        },
        itemBuilder: (int index) {
          ProductModel pro = _items[index];
          return DataRow.byIndex(index: index, selected: pro.selected,
              onSelectChanged: (bool value) {
                if (pro.selected != value) {
                  setState(() {
                    pro.selected = value;
                  });
                }
              },cells: <DataCell>[
            DataCell(Text('${pro.proId}', textAlign: TextAlign.center)),
            DataCell(
              Text(pro.proCode.toString(), textAlign: TextAlign.center),
            ),
            DataCell(Text('${pro.proName}', textAlign: TextAlign.center)),
            DataCell(Text('${pro.proCategory}', textAlign: TextAlign.center)),
            DataCell(Text('${pro.proOpeningBal}', textAlign: TextAlign.center)),
            DataCell(
                Text('${pro.proPurchasePrice}', textAlign: TextAlign.center)),
            DataCell(
                Text('${pro.proSellingPrice}', textAlign: TextAlign.center)),
            DataCell(
              pro.proImage == null
                  ? Text('No image', textAlign: TextAlign.center)
                  : Image.file(File('${pro.proImage}')),
            ),
            DataCell(
              FlatButton.icon(
                  onPressed: () {
                    print('Image Path ${pro.proImage}');
                    // setState(() {
                    //   navigateToUpdate(
                    //       pro.catid,
                    //       pro.pParentId,
                    //       pro.pname);
                    // });
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                  label: Text('')),
            ),
            DataCell(
              FlatButton.icon(
                  onPressed: () async {
                    //   var result = await databaseHelper
                    //       .deleteProductCateory(
                    //           pro.catid);
                    //   if (result != 0) {
                    //     setState(() {
                    //       print('Delete Succcess');
                    //       updateListView();
                    //     });
                    //   } else {}
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: Text('')),
            ),
          ]);
        },
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        onRefresh: () async {
          await new Future.delayed(new Duration(seconds: 3));
          setState(() {

          });
          return null;
        },
        onRowsPerPageChanged: (int value) {
          setState(() {
            _rowsPerPage = value;
          });
          print("New Rows: $value");
        },
        mobileItemBuilder: (BuildContext context, int index) {
          final i = _items[index];
          return ListTile(
            title: Text(i?.proName),
          );
        },
        onSelectAll: (bool value) {
          for (var row in _items) {
            setState(() {
              row.selected = value;
            });
          }
        },
        rowCountApproximate: true,
      ),

    );
  }

  void _selectedPopMenu(PopupMenu popupMenu) {
    setState(() {
      _selectedMenu = popupMenu;
      print(_selectedMenu.title);
    });
  }

  // Future<String> getStringText() async {
  //   stringConvertIdValue = await databaseHelper.getParentProductName(1);
  //   print('Values: $stringConvertIdValue');
  // }

  void navigateToUpdate(int rowID, int cType, String cName) async {
    stringConvertIdValue = await databaseHelper.getParentProductName(cType);
    // bool result =
    //     await Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return UpdateProductScreen(product, rowID, cType, cName);
    // }));

    // if (result == true) {
    //   updateListView();
    // }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((value) {
      Future<List<ProductModel>> todoListFuture =
          databaseHelper.getProductList();
      todoListFuture.then((items) {
        setState(() {
          this._items = items;
          this.count = items.length;
        });
      });
    });
  }
}
