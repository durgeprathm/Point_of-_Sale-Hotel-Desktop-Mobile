import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/Datatables/Manage_Product_Source.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/MobilePages/mobile_update_product_screen.dart';
import 'package:retailerp/Pagination_notifier/Manage_Product_datanotifier.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/popup_menu.dart';
import 'package:retailerp/pages/add_product_screen.dart';
import 'package:retailerp/pages/update_product_screen.dart';
import 'package:retailerp/providers/popup_menu_item.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';

class ManageProduct extends StatefulWidget {
  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  PopupMenu _selectedMenu = productPopupMenu1[0];
  DatabaseHelper databaseHelper = DatabaseHelper();
  int count = 0;
  String stringConvertIdValue;
  List<ProductModel> productList = [];
  List<ProductModel> searchProductList = [];
  ProductModel product;
  int rowcountdata;

  static const int kTabletBreakpoint = 552;
  TextEditingController searchController = TextEditingController();

  bool _showCircle = false;
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = Text("Manage Product");

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileManagepurchase();
    } else {
      content = _buildTabletManagepurchase();
    }

    return content;
  }

  // List<ProductModel> selectedProCat;

  @override
  void initState() {
    Provider.of<ManageProductsDataNotifier>(context, listen: false).clear();
    super.initState();
    _getProducts();
    // updateListView();
    // selectedProCat = [];
  }

  Widget _buildTabletManagepurchase() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.18;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.25;
    final _provider = context.watch<ManageProductsDataNotifier>();
    final _model = _provider.ManageProductsModel;
    final _dtSource = ManageProductsDataTableSource(
        ManageProductsData: _model, cont: context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // Navigator.pop(context);
              // MyNavigator.goToDashboard(context);
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: _showCircle
                ? Center(child: CircularProgressIndicator())
                : rowcountdata == 0
                ? Padding(
              padding: const EdgeInsets.all(40.0),
              child: Material(
                shape: Border.all(color: Colors.blueGrey, width: 5),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      "No  Product Available!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: Colors.red),
                    ),
                  ),
                ),
              ),
            )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: tabletWidth,
                              height: 40,
                              child: TextField(
                                controller: searchController,
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                                decoration: InputDecoration(
                                    hintText: "Start typing here..",
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.search),
                                      color: PrimaryColor,
                                      onPressed: () {},
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomPaginatedTable(
                        dataColumns: _colGen(_provider),
                        // header: const Text("Sales Day Wise Report"),
                        onRowChanged: (index) => _provider.rowsPerPage = index,
                        rowsPerPage: _provider.rowsPerPage,
                        source: _dtSource,
                        showActions: true,
                        sortColumnIndex: _provider.sortColumnIndex,
                        sortColumnAsc: _provider.sortAscending,
                      ),
                    ],
                  ),
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: "btn1",
                backgroundColor: PrimaryColor,
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => AddProductScreen()))
                      .then((value) => _reload(value));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileManagepurchase() {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        actions: [
          Row(
            children: [
              IconButton(
                icon: actionIcon,
                onPressed: () {
                  setState(() {
                    if (actionIcon.icon == Icons.search) {
                      actionIcon = new Icon(
                        Icons.close,
                        color: Colors.white,
                      );
                      appBarTitle = TextField(
                        controller: searchController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                            prefixIcon:
                                new Icon(Icons.search, color: Colors.white),
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.white)),
                      );
                    } else {
                      actionIcon = new Icon(
                        Icons.search,
                        color: Colors.white,
                      );
                      appBarTitle = new Text(
                        "Manage Product",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      );
                      searchController.clear();
                    }
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(Navigator.defaultRouteName));
                },
              ),
            ],
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
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _showCircle,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: GestureDetector(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: searchProductList.length,
                        itemBuilder: (context, index) {
                          print("//in index////$index");
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Product Name: ",
                                        style: textHintTextStyle),
                                    Text("${searchProductList[index].proName}",
                                        style: textLabelTextStyle),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Text("Product Category: ",
                                        style: headHintTextStyle),
                                    Text(
                                        "${searchProductList[index].proCategory}",
                                        style: headsubTextStyle),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Text("Balance Stock: ",
                                        style: headHintTextStyle),
                                    Text(
                                        "${searchProductList[index].proOpeningBal}",
                                        style: headsubTextStyle),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Selling Price: ",
                                            style: headHintTextStyle),
                                        Text(
                                            "${searchProductList[index].proSellingPrice}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             EditPurchaseScreenNew(
                                            //                 index, productList)));
                                            navigateToUpdate(
                                                index, searchProductList);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            _showMyDialog(
                                                searchProductList[index].proId);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider()
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: Stack(
      //   children: <Widget>[
      //     Padding(
      //       padding: EdgeInsets.only(right: 25),
      //       child: Align(
      //         alignment: Alignment.bottomRight,
      //         child: FloatingActionButton(
      //           heroTag: "btn1",
      //           backgroundColor: PrimaryColor,
      //           child: Icon(Icons.add),
      //           onPressed: () {
      //             Navigator.of(context)
      //                 .push(MaterialPageRoute(
      //                     builder: (context) => AddProductScreen()))
      //                 .then((value) => _reload(value));
      //           },
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  List<DataColumn> _colGen(
    ManageProductsDataNotifier _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text("Product NO"),
          numeric: true,
          tooltip: "Product NO",
        ),
        DataColumn(
          label: Text('Product Name'),
          tooltip: 'Product Name',
        ),
        DataColumn(
          label: Text('Category'),
          tooltip: 'Category',
        ),
        DataColumn(
          label: Text('Balance stock'),
          tooltip: 'Balance stock',
        ),
        DataColumn(
          label: Text('Selling price'),
          tooltip: 'Selling price',
        ),
        DataColumn(
          label: Text('Action'),
          tooltip: 'Action',
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(ProductModel sale) getField,
    int colIndex,
    bool asc,
    ManageProductsDataNotifier _provider,
  ) {
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  void _selectedPopMenu(PopupMenu popupMenu) {
    setState(() {
      _selectedMenu = popupMenu;
      print(_selectedMenu.title);
    });
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < searchProductList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  DataRow getRow(int index) {
    var serNo = index + 1;
    return DataRow(cells: [
      DataCell(Center(child: Text(serNo.toString()))),
      // DataCell(Text(productList[index].proDate)),
      DataCell(Center(child: Text(searchProductList[index].proName))),
      DataCell(Center(child: Text(searchProductList[index].proCategory))),
      DataCell(Center(
          child: Text(searchProductList[index].proOpeningBal.toString()))),
      // DataCell(Text(productList[index].proPurchasePrice.toString())),
      DataCell(Center(
          child: Text(searchProductList[index].proSellingPrice.toString()))),
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
                  navigateToUpdate(index, searchProductList);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                color: Colors.red,
                onPressed: () {
                  _showMyDialog(searchProductList[index].proId);
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  // Future<String> getStringText() async {
  //   stringConvertIdValue = await databaseHelper.getParentProductName(1);
  //   print('Values: $stringConvertIdValue');
  // }

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
                    _getProducts();
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

      //     await Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return MobileUpdateProductScreen(rowID);
      // }));
    } else {
      result = await Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) => UpdateProductScreen(rowID, productList)))
          .then((value) => _reload(value));

      //     await Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return UpdateProductScreen(rowID);
      // }));
    }

    if (result == true) {
      _getProducts();
    }
  }

  void _getProducts() async {
    setState(() {
      _showCircle = true;
    });
    ProductFetch Productfetch = new ProductFetch();
    var productData = await Productfetch.getposproduct("1");
    var resid = productData["resid"];
    if (resid == 200) {
      var rowcount = productData["rowcount"];
      rowcountdata=rowcount;
      if (rowcount > 0) {
        var productsd = productData["product"];
        print(productsd.length);
        List<ProductModel> products = [];
        for (var n in productsd) {
          ProductModel pro = ProductModel.withId(
              int.parse(n['ProductId']),
              n['ProductType'],
              int.parse(n['ProductCode']),
              n['ProductName'],
              n['ProductCompanyName'],
              n['ProductCategories'],
              int.parse(n['ProductCategoriesID']),
              0,
              double.parse(n['ProductSellingPrice']),
              n['HSNCode'],
              n['Tax'],
              '',
              n['Unit'],
              int.parse(n['ProductOpeningBalance']),
              n['ProductBillingMethod'],
              n['IntegratedTax'],
              '');
          products.add(pro);
          Provider.of<ManageProductsDataNotifier>(context, listen: false)
              .addProductMangeData(pro);
        }

        setState(() {
          productList = products;
          _showCircle = false;
          searchProductList = productList;
          // showspinnerlog = false;
        });

        searchController.addListener(() {
          setState(() {
            if (productList != null) {
              String s = searchController.text;
              searchProductList = productList
                  .where((element) =>
                      element.proId
                          .toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.proCode
                          .toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.proName.toLowerCase().contains(s.toLowerCase()) ||
                      element.proComName
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.proCategory
                          .toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()))
                  .toList();
            }
          });
        });
      } else {
        setState(() {
          _showCircle = false;
        });

        String msg = productData["message"];
        Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: PrimaryColor,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      setState(() {
        _showCircle = false;
      });
      String msg = productData["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  _reload(value) {
    _getProducts();
  }
}
