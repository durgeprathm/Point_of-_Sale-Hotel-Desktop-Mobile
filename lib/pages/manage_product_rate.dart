import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/Adpater/pos_product_rate_fetch.dart';
import 'package:retailerp/Datatables/Manage_Product_Rate_Source.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/LocalDbModels/product_rate.dart';
import 'package:retailerp/Pagination_notifier/Manage_Product_Rate_datanotifier.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/popup_menu.dart';
import 'package:retailerp/pages/add_product_rate_screen.dart';
import 'package:retailerp/pages/update_product_rate_screen.dart';
import 'package:retailerp/pages/update_product_screen.dart';
import 'package:retailerp/providers/popup_menu_item.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/utils/my_navigator.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';
import 'package:sqflite/sqflite.dart';

class ManageProductRate extends StatefulWidget {
  @override
  _ManageProductRateState createState() => _ManageProductRateState();
}

class _ManageProductRateState extends State<ManageProductRate> {
  PopupMenu _selectedMenu = productRatePopupMenu2[0];
  DatabaseHelper databaseHelper = DatabaseHelper();
  int count = 0;
  int rowcountofdata;
  String stringConvertIdValue;
  List<ProductRate> productRateList = new List();
  List<ProductRate> searchProductRateList = [];
  ProductRate product;
  TextEditingController searchController = TextEditingController();

  bool _showCircle = false;
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = Text("Manage Product Rate");

  @override
  void initState() {
    super.initState();
    Provider.of<ManageProductRateDataNotifier>(context, listen: false).clear();
    _getProRate();
  }

  static const int kTabletBreakpoint = 552;

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

  Widget _buildTabletManagepurchase() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.18;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.25;
    final _provider = context.watch<ManageProductRateDataNotifier>();
    final _model = _provider.ManageProductRateModel;
    final _dtSource = ManageProductRateDataTableSource(
        ManageProductRateData: _model, context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Product Rate"),
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
              return productRatePopupMenu2.map((PopupMenu popupMenu) {
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
                : rowcountofdata == 0
                    ? Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Material(
                          shape: Border.all(color: Colors.blueGrey, width: 5),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Text(
                                "No Product Rate Available!",
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
                          SizedBox(
                            height: 6,
                          ),
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
                          // Expanded(
                          //   child: SingleChildScrollView(
                          //     child: Container(
                          //       child: Center(
                          //           child: DataTable(columns: [
                          //         DataColumn(
                          //             label: Expanded(
                          //           child: Container(
                          //             child: Center(
                          //               child: Text('Sr No',
                          //                   style: tableColmTextStyle),
                          //             ),
                          //           ),
                          //         )),
                          //         DataColumn(
                          //             label: Expanded(
                          //           child: Container(
                          //             child: Center(
                          //               child: Text('Date',
                          //                   style: tableColmTextStyle),
                          //             ),
                          //           ),
                          //         )),
                          //         DataColumn(
                          //             label: Expanded(
                          //           child: Container(
                          //             child: Center(
                          //               child: Text('Product',
                          //                   style: tableColmTextStyle),
                          //             ),
                          //           ),
                          //         )),
                          //         DataColumn(
                          //             label: Expanded(
                          //           child: Container(
                          //             child: Center(
                          //               child: Text('Category',
                          //                   style: tableColmTextStyle),
                          //             ),
                          //           ),
                          //         )),
                          //         DataColumn(
                          //             label: Expanded(
                          //           child: Container(
                          //             child: Center(
                          //               child: Text('Rate',
                          //                   style: tableColmTextStyle),
                          //             ),
                          //           ),
                          //         )),
                          //         DataColumn(
                          //             label: Expanded(
                          //           child: Container(
                          //             child: Center(
                          //               child: Text('GST',
                          //                   style: tableColmTextStyle),
                          //             ),
                          //           ),
                          //         )),
                          //         DataColumn(
                          //             label: Expanded(
                          //           child: Container(
                          //             child: Center(
                          //               child: Text('Action',
                          //                   style: tableColmTextStyle),
                          //             ),
                          //           ),
                          //         )),
                          //       ], rows: getDataRowList())),
                          //     ),
                          //   ),
                          // ),
                          CustomPaginatedTable(
                            dataColumns: _colGen(_provider),
                            // header: const Text("Sales Day Wise Report"),
                            onRowChanged: (index) =>
                                _provider.rowsPerPage = index,
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
                          builder: (context) => AddProductRateScreen()))
                      .then((value) => _reload(value));

                  // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  //   return AddProductRateScreen();
                  // }));
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
                        "Manage Product Rate",
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
              return productRatePopupMenu2.map((PopupMenu popupMenu) {
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
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: GestureDetector(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: searchProductRateList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("Product Name: ",
                                          style: textHintTextStyle),
                                      Text(
                                          "${searchProductRateList[index].proName}",
                                          style: textLabelTextStyle),
                                    ],
                                  ),
                                  Text(
                                      "${searchProductRateList[index].proDate}",
                                      style: headsubTextStyle),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text("Product Category: ",
                                      style: headHintTextStyle),
                                  Text(
                                      "${searchProductRateList[index].proCatName}",
                                      style: headsubTextStyle),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text("Rate: ", style: headHintTextStyle),
                                  Text(
                                      "${searchProductRateList[index].proRate}",
                                      style: headsubTextStyle),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("GST: ", style: headHintTextStyle),
                                      Text(
                                          "${searchProductRateList[index].proGST}",
                                          style: headsubTextStyle),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          navigateToUpdate(
                                              index, searchProductRateList);
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _showMyDialog(
                                              searchProductRateList[index]
                                                  .proRateId);
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
      //                     builder: (context) => AddProductRateScreen()))
      //                 .then((value) => _reload(value));
      //
      //             // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      //             //   return AddProductRateScreen();
      //             // }));
      //           },
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  List<DataColumn> _colGen(
    ManageProductRateDataNotifier _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text(
            "Sr No",
            style: tableColmTextStyle,
          ),
          numeric: true,
          tooltip: "Sr No",
        ),
        DataColumn(
          label: Text(
            'Date',
            style: tableColmTextStyle,
          ),
          tooltip: 'Date',
        ),
        DataColumn(
          label: Text('Product', style: tableColmTextStyle),
          tooltip: 'Product',
        ),
        DataColumn(
          label: Text('Category', style: tableColmTextStyle),
          tooltip: 'Category',
        ),
        DataColumn(
          label: Text('Rate', style: tableColmTextStyle),
          tooltip: 'Rate',
        ),
        DataColumn(
          label: Text('GST', style: tableColmTextStyle),
          tooltip: 'GST',
        ),
        DataColumn(
          label: Text('Action', style: tableColmTextStyle),
          tooltip: 'Action',
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(ProductRate sale) getField,
    int colIndex,
    bool asc,
    ManageProductRateDataNotifier _provider,
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
    for (int i = 0; i < searchProductRateList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  DataRow getRow(int index) {
    var serNo = index + 1;
    return DataRow(cells: [
      DataCell(Center(child: Text(serNo.toString()))),
      DataCell(Center(child: Text(searchProductRateList[index].proDate))),
      DataCell(Center(child: Text(searchProductRateList[index].proName))),
      DataCell(Center(
          child: Text(searchProductRateList[index].proCatName.toString()))),
      DataCell(
          Center(child: Text(searchProductRateList[index].proRate.toString()))),
      DataCell(
          Center(child: Text(searchProductRateList[index].proGST.toString()))),
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
                  navigateToUpdate(index, searchProductRateList);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                color: Colors.red,
                onPressed: () {
                  _showMyDialog(searchProductRateList[index].proRateId);
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  void navigateToUpdate(index, productRateList) async {
    bool result;
    result = await Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) =>
                UpdateProductRateScreen(index, productRateList)))
        .then((value) => _reload(value));

    if (result == true) {
      _getProRate();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((value) {
      Future<List<ProductRate>> todoListFuture =
          databaseHelper.getProductRateCustList();
      todoListFuture.then((productRateList) {
        setState(() {
          this.productRateList = productRateList;
          this.count = productRateList.length;
        });
      });
    });
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        productRateList.sort((a, b) => a.proName.compareTo(b.proName));
      } else {
        productRateList.sort((a, b) => b.proName.compareTo(a.proName));
      }
    }
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
                      await productdelete.productRateDataDelete(id.toString());
                  var res = result['resid'];
                  if (res == 200) {
                    print("//////////////////Print result//////$result");
                    print("///delete id///$id");
                    Navigator.of(context).pop();
                    _getProRate();
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

  void _getProRate() async {
    setState(() {
      _showCircle = true;
    });
    ProductFetchRate productRatefetch = new ProductFetchRate();
    var supplierData = await productRatefetch.getProductRate("1");
    print(supplierData);
    var resid = supplierData["resid"];
    if (resid == 200) {
      var rowcount = supplierData["rowcount"];
      rowcountofdata = rowcount;
      if (rowcount > 0) {
        var tempproductRatesd = supplierData["productrate"];
        List<ProductRate> tempproductRate = [];
        for (var n in tempproductRatesd) {
          ProductRate pro = ProductRate.withId(
              int.parse(n['ProductRateId']),
              int.parse(n['productId']),
              n['ProductName'],
              n['ProductCategioes'],
              n['ProductDate'],
              double.parse(n['ProductRate']),
              0,
              int.parse(n['ProductGST']));
          tempproductRate.add(pro);
          Provider.of<ManageProductRateDataNotifier>(context, listen: false)
              .addManageProductRateData(pro);
        }
        setState(() {
          this.productRateList = tempproductRate;
          searchProductRateList = productRateList;
          _showCircle = false;
        });
        searchController.addListener(() {
          setState(() {
            if (productRateList != null) {
              String s = searchController.text;
              searchProductRateList = productRateList
                  .where((element) =>
                      element.proId
                          .toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.proCatName
                          .toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.proName.toLowerCase().contains(s.toLowerCase()) ||
                      element.proDate.toLowerCase().contains(s.toLowerCase()) ||
                      element.proRate
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
        String msg = supplierData["message"];

        Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black38,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      setState(() {
        _showCircle = false;
      });
      String msg = supplierData["message"];

      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  _reload(value) {
    _getProRate();
  }
}
