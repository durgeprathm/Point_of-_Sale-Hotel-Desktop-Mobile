import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/EhotelAdapter/fetch_customizedproduct.dart';
import 'package:retailerp/Adpater/fetch_menuList.dart';
import 'package:retailerp/Adpater/pos_purchase_fetch.dart';
import 'package:retailerp/Adpater/pos_purchse_delete.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/Datatables/Manage_Customize_Product_Source.dart';
import 'package:retailerp/Pagination_notifier/Manage_Customize_Product_datanotifier.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/CutomizedProductModel.dart';
import 'package:retailerp/models/menu.dart';
import 'package:retailerp/pages/edit_menu_screen_new.dart';
import 'package:retailerp/pages/preview_menu.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';
import 'package:sqflite/sqflite.dart';

class ManageMenu extends StatefulWidget {
  @override
  _ManageMenuState createState() => _ManageMenuState();
}

class _ManageMenuState extends State<ManageMenu> {
  @override
  // DatabaseHelper databaseHelper = DatabaseHelper();
  List<Menu> menuList = [];
  List<Menu> searchMenuList = [];
  int count;
  final dateFormat = DateFormat("yyyy-MM-dd");
  final initialValue = DateTime.now();
  DateTime fromValue = DateTime.now();
  DateTime toValue = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;
  bool Datetofromenable = false;
  int rowcountdata;

  FetchCustomizedProduct fetchCustomizedProduct = new FetchCustomizedProduct();
  List<CustoProductModel> cpList = [];

  TextEditingController searchController = TextEditingController();

  bool _showCircle = false;
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = Text("Manage Customize Product");
  bool spinner = false;
  @override
  void initState() {
    Provider.of<ManageCustomizeProductDataNotifier>(context, listen: false)
        .clear();
    _getMenu();
    _getCPNameList();
  }

  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  _getCPNameList() async {
    setState(() {
      spinner = true;
    });
    var response = await fetchCustomizedProduct.getCustomizedProduct();
    var message = response["message"];
    var resid = response["resid"];
    print("resid////////////////////////${resid}");
    List<CustoProductModel> cplistTemp = [];
    if (resid == 200) {
      var rowcount = response["rowcount"];
      print("rowcount////////////////////////${rowcount}");
      rowcountdata = rowcount;
      if(rowcount>0)
        {
          var productsd = response["CustomizedProductlist"];
          print(productsd.length);
          for (var n in productsd) {
            CustoProductModel pro = CustoProductModel(
                n['CustomizedProductId'],
                n['CustomizedProductName'],
                n['CustomizedProductPrice'],
                n['CustomizedProductDate'],
                n['Productid'],
                n['Productname'],
                n['Productquntity'],
                n['Productcatid']);
            cplistTemp.add(pro);
            Provider.of<ManageCustomizeProductDataNotifier>(context, listen: false)
                .addManageCustomizeProductData(pro);
          }
          setState(() {
            print("rowcountdata////////////////////////${rowcountdata}");
            cpList = cplistTemp;
            spinner = false;
          });
        }else
          {
            setState(() {
              spinner = false;
            });
            Fluttertoast.showToast(
                msg: message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }

    } else {
      setState(() {
        spinner = false;
      });
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileManageMenu();
    } else {
      content = _buildTabletManageMenu();
    }

    return content;
  }

//-------------------------------------------
//---------------Tablet Mode Start-------------//
  Widget _buildTabletManageMenu() {
    // void handleClick(String value) {
    //   switch (value) {
    //     case 'Add Menu':
    //       Navigator.push(
    //           context, MaterialPageRoute(builder: (context) => AddMenu()));
    //       break;
    //     case 'Import Sales':
    //       Navigator.push(context,
    //           MaterialPageRoute(builder: (context) => ImportMenu()));
    //       break;
    //     case 'Add Supplier':
    //       Navigator.push(context,
    //           MaterialPageRoute(builder: (context) => AddSupplierDetails()));
    //       break;
    //     case 'Manage Suppliers':
    //       Navigator.push(context,
    //           MaterialPageRoute(builder: (context) => ManageSuppliers()));
    //       break;
    //   }
    // }
    var tabletWidth = MediaQuery.of(context).size.width * 0.18;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.25;
    final _provider = context.watch<ManageCustomizeProductDataNotifier>();
    final _model = _provider.ManageCustomizeProductModel;
    final _dtSource = ManageCustomizeProductTableSource(
        ManageCustomizeProductData: _model, context: context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.shoppingBag),
            SizedBox(
              width: 20.0,
            ),
            Text('Manage Customize Product'),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: spinner
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
                                "No Customized Product Available!",
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
                            height: 10,
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
                                SizedBox(
                                  width: 10,
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
                          //             child: Text('Sr No',
                          //                 style: TextStyle(
                          //                     fontSize: 20, fontWeight: FontWeight.bold)),
                          //           ),
                          //         )),
                          //         DataColumn(
                          //             label: Expanded(
                          //           child: Container(
                          //             width: 200,
                          //             child: Text('Product',
                          //                 style: TextStyle(
                          //                     fontSize: 20, fontWeight: FontWeight.bold)),
                          //           ),
                          //         )),
                          //         DataColumn(
                          //             label: Expanded(
                          //           child: Container(
                          //             child: Text('Price',
                          //                 style: TextStyle(
                          //                     fontSize: 20, fontWeight: FontWeight.bold)),
                          //           ),
                          //         )),
                          //         DataColumn(
                          //             label: Expanded(
                          //           child: Container(
                          //             width: 50,
                          //             child: Text('Action',
                          //                 style: TextStyle(
                          //                     fontSize: 20, fontWeight: FontWeight.bold)),
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
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobileManageMenu() {
    // void handleClick(String value) {
    //   switch (value) {
    //     case 'Add Menu':
    //       Navigator.push(
    //           context, MaterialPageRoute(builder: (context) => AddMenu()));
    //       break;
    //     case 'Import Sales':
    //       Navigator.push(context,
    //           MaterialPageRoute(builder: (context) => ImportMenu()));
    //       break;
    //     case 'Add Supplier':
    //       Navigator.push(context,
    //           MaterialPageRoute(builder: (context) => AddSupplierDetails()));
    //       break;
    //     case 'Manage Suppliers':
    //       Navigator.push(context,
    //           MaterialPageRoute(builder: (context) => ManageSuppliers()));
    //       break;
    //   }
    // }

    return Scaffold(
      backgroundColor: Colors.white,
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
                        "Manage Menu",
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
          // PopupMenuButton<String>(
          //   onSelected: handleClick,
          //   itemBuilder: (BuildContext context) {
          //     return {
          //       'Add Menu',
          //       'Import Menu',
          //       'Add Supplier',
          //       'Manage Suppliers',
          //     }.map((String choice) {
          //       return PopupMenuItem<String>(
          //         value: choice,
          //         child: Text(choice),
          //       );
          //     }).toList();
          //   },
          // ),
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
                        itemCount: searchMenuList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Menu Name: ",
                                            style: textHintTextStyle),
                                        Text(
                                            "${searchMenuList[index].menuName}",
                                            style: textLabelTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Category:          ",
                                            style: headHintTextStyle),
                                        Text(
                                            "${searchMenuList[index].menucategory.toString()}",
                                            style: tablecolumname),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Amount:            ",
                                            style: headHintTextStyle),
                                        Text(
                                            "Rs.${searchMenuList[index].menuRate.toString()}",
                                            style: tablecolumname),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // IconButton(
                                        //   onPressed: () {
                                        //     Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //             builder: (context) =>
                                        //                 PreviewMenu(index,
                                        //                     searchMenuList)));
                                        //   },
                                        //   icon: Icon(
                                        //     Icons.preview,
                                        //     color: Colors.blue,
                                        //   ),
                                        // ),
                                        // IconButton(
                                        //   onPressed: () {
                                        //     Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //             builder: (context) =>
                                        //                 EditMenuScreenNew(index,
                                        //                     searchMenuList)));
                                        //   },
                                        //   icon: Icon(
                                        //     Icons.edit,
                                        //     color: Colors.green,
                                        //   ),
                                        // ),
                                        IconButton(
                                          onPressed: () {
                                            _showMyDialog(
                                                searchMenuList[index].id);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                  ],
                                )
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
    );
  }

//---------------Mobile Mode End-------------//

  // void ShowMenudetails() {
  //   final Future<Database> dbFuture = databaseHelper.initializeDatabase();
  //   dbFuture.then((value) {
  //     Future<List<Menu>> menuListFuture =
  //         databaseHelper.getmenuList();
  //     menuListFuture.then((MenuCatList) {
  //       setState(() {
  //         this.menuList = MenuCatList;
  //         this.count = MenuCatList.length;
  //         print("Printing Purchalist//${count}");
  //       });
  //     });
  //   });
  // }

  List<DataColumn> _colGen(
    ManageCustomizeProductDataNotifier _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text(
            "Sr No",
            style: tablecolumname,
          ),
          numeric: true,
          tooltip: "Sr No",
        ),
        DataColumn(
          label: Text(
            'Product Name',
            style: tablecolumname,
          ),
          tooltip: 'Product Name',
        ),
        DataColumn(
          label: Text(
            'Product Price',
            style: tablecolumname,
          ),
          tooltip: 'Product Price',
        ),
        DataColumn(
          label: Text(
            'Action',
            style: tablecolumname,
          ),
          tooltip: 'Action',
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(CustoProductModel sale) getField,
    int colIndex,
    bool asc,
    ManageCustomizeProductDataNotifier _provider,
  ) {
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  DataRow getRow(int index) {
    int serNo = index + 1;
    return DataRow(cells: [
      DataCell(Text(serNo.toString())),
      DataCell(Text(cpList[index].cpname)),
      DataCell(Text(cpList[index].cpprice.toString())),
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
            IconButton(
              icon: Icon(
                Icons.edit,
              ),
              color: Colors.green,
              onPressed: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               EditMenuScreenNew(index, searchMenuList)));
                navigateToUpdate(index, searchMenuList);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
              ),
              color: Colors.red,
              onPressed: () {
                _showMyDialog(searchMenuList[index].id);
              },
            ),
          ],
        ),
      ),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < cpList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  Future<void> _showMyDialog(String id) async {
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
                  MenuList purchasedelete = new MenuList();
                  var result =
                      await purchasedelete.getMenuDelete(id.toString());
                  print("///delete id///$id");
                  Navigator.of(context).pop();
                  _getMenu();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //-------------------------------------
//from server
  void _getMenu() async {
    setState(() {
      _showCircle = true;
    });
    MenuList purchasefetch = new MenuList();
    var purchaseData = await purchasefetch.getMenu("0");
    print('$purchaseData');
    var resid = purchaseData["resid"];
    if (resid == 200) {
      var rowcount = purchaseData["rowcount"];

      if (rowcount > 0) {
        var purchasesd = purchaseData["menu"];
        List<Menu> tempMenu = [];
        print(purchasesd.length);
        for (var n in purchasesd) {
          Menu pro = Menu.onlymenu(
              n["MenuId"],
              n["MenuName"],
              n["Menucategory"],
              n["Menucategioresname"],
              n["MenuRate"],
              n["MenuGST"]);
          tempMenu.add(pro);
        }

        setState(() {
          menuList = tempMenu;
          searchMenuList = menuList;
          _showCircle = false;
        });
        print("//////purchaselist/////////$menuList.length");

        searchController.addListener(() {
          setState(() {
            if (menuList != null) {
              String s = searchController.text;
              searchMenuList = menuList
                  .where((element) =>
                      element.id
                          .toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.menuName
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.menucategory
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.menuRate
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
        String msg = purchaseData["message"];
        Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: PrimaryColor,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      String msg = purchaseData["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void navigateToUpdate(rowID, productList) async {
    var screenOrien = MediaQuery.of(context).orientation;
    bool result;
    result = await Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => EditMenuScreenNew(rowID, productList)))
        .then((value) => _reload(value));

    //     await Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return UpdateProductScreen(rowID);
    // }));

    if (result == true) {
      _getMenu();
    }
  }

  _reload(value) {
    _getMenu();
  }
}
