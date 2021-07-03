import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:retailerp/Adpater/pos_customer-fetch.dart';
import 'package:retailerp/LocalDbModels/customer_model.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/popup_menu.dart';
import 'package:retailerp/pages/Update_customer_screen.dart';
import 'package:retailerp/pages/add_customer_screen.dart';
import 'package:retailerp/providers/popup_menu_item.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';

class ManageCustomer extends StatefulWidget {
  @override
  _ManageCustomerState createState() => _ManageCustomerState();
}

class _ManageCustomerState extends State<ManageCustomer> {
  PopupMenu _selectedMenu = customerPopupMenu2[0];
  DatabaseHelper databaseHelper = DatabaseHelper();
  int count = 0;
  String stringConvertIdValue;
  List<CustomerModel> customerList = [];
  List<CustomerModel> searchCustomerList = [];
  CustomerModel customer;

  // List<CustomerModel> selectedProCat;
  TextEditingController searchController = TextEditingController();
  bool _showCircle = false;
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = Text("Manage Customer");

  @override
  void initState() {
    super.initState();
    _getCustomer();
    // selectedProCat = [];
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
    var tabletWidth = MediaQuery.of(context).size.width * 0.25;
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Customer"),
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
              return customerPopupMenu2.map((PopupMenu popupMenu) {
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
              Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Center(
                        child:
                        DataTable(columns: [
                          DataColumn(
                              label: Expanded(
                                child: Container(
                                  child: Text('Sr No',
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold)),
                                ),
                              )),
                          DataColumn(
                              label: Expanded(
                                child: Container(
                                  child: Text('Name',
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold)),
                                ),
                              )),
                          DataColumn(
                              label: Expanded(
                                child: Container(
                                  child: Text('Mobile No',
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold)),
                                ),
                              )),
                          DataColumn(
                              label: Expanded(
                                child: Container(
                                  child: Text('Address',
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold)),
                                ),
                              )),
                          DataColumn(
                              label: Expanded(
                                child: Container(
                                  child: Text('Balance',
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold)),
                                ),
                              )),
                          DataColumn(
                              label: Expanded(
                                child: Container(
                                  child: Text('Date',
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold)),
                                ),
                              )),
                          DataColumn(
                              label: Expanded(
                                child: Container(
                                  child: Text('Action',
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold)),
                                ),
                              )),
                        ], rows: getDataRowList())),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // body: SafeArea(
      //   child: customerList != null
      //       ? SingleChildScrollView(
      //           child: Container(
      //             margin: const EdgeInsets.all(5.0),
      //             padding: const EdgeInsets.all(3.0),
      //             decoration:
      //                 BoxDecoration(border: Border.all(color: PrimaryColor)),
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               crossAxisAlignment: CrossAxisAlignment.stretch,
      //               children: [
      //                 DataTable(
      //                   columns: [
      //                     DataColumn(
      //                         label: Text('Sr No',
      //                             style:
      //                                 TextStyle(fontWeight: FontWeight.bold))),
      //                     DataColumn(
      //                         label: Text('Name',
      //                             style:
      //                                 TextStyle(fontWeight: FontWeight.bold))),
      //                     DataColumn(
      //                         label: Text('Mobile No',
      //                             style:
      //                                 TextStyle(fontWeight: FontWeight.bold))),
      //                     DataColumn(
      //                         label: Text('Address',
      //                             style:
      //                                 TextStyle(fontWeight: FontWeight.bold))),
      //                     DataColumn(
      //                         label: Text('Balance',
      //                             style:
      //                                 TextStyle(fontWeight: FontWeight.bold))),
      //                     DataColumn(
      //                         label: Text('Date',
      //                             style:
      //                                 TextStyle(fontWeight: FontWeight.bold))),
      //                     DataColumn(
      //                         label: Text('Action',
      //                             style:
      //                                 TextStyle(fontWeight: FontWeight.bold))),
      //                     DataColumn(
      //                         label: Text('',
      //                             style:
      //                                 TextStyle(fontWeight: FontWeight.bold))),
      //                   ],
      //                   rows: customerList
      //                       .map(
      //                         (cust) => DataRow(
      //                             // selected: selectedProCat.contains(cust),
      //                             cells: [
      //                               DataCell(Text('${cust.custId}',
      //                                   textAlign: TextAlign.center)),
      //                               DataCell(
      //                                 Text(cust.custName.toString(),
      //                                     textAlign: TextAlign.center),
      //                               ),
      //                               DataCell(Text(
      //                                   '${cust.custMobileNo.toString()}',
      //                                   textAlign: TextAlign.center)),
      //                               DataCell(Text('${cust.custEmail}',
      //                                   textAlign: TextAlign.center)),
      //                               DataCell(Text('${cust.custAddress}',
      //                                   textAlign: TextAlign.center)),
      //                               DataCell(Text('${cust.date}',
      //                                   textAlign: TextAlign.center)),
      //                               DataCell(
      //                                 FlatButton.icon(
      //                                     onPressed: () {
      //                                       setState(() {
      //                                         navigateToUpdate(cust.custId);
      //                                       });
      //                                     },
      //                                     icon: Icon(
      //                                       Icons.edit,
      //                                       color: Colors.green,
      //                                     ),
      //                                     label: Text('')),
      //                               ),
      //                               DataCell(
      //                                 FlatButton.icon(
      //                                     onPressed: () async {
      //                                       var result = await databaseHelper
      //                                           .deleteCustomer(cust.custId);
      //                                       if (result != 0) {
      //                                         setState(() {
      //                                           print('Delete Succcess');
      //                                           _getCustomer();
      //                                         });
      //                                       } else {}
      //                                     },
      //                                     icon: Icon(
      //                                       Icons.delete,
      //                                       color: Colors.red,
      //                                     ),
      //                                     label: Text('')),
      //                               ),
      //                             ]),
      //                       )
      //                       .toList(),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         )
      //       : Container(
      //           child: Text(''),
      //         ),
      // ),
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
                          builder: (context) => AddCustomerScreen()))
                      .then((value) => _reload(value));
                  // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  //   return AddCustomerScreen();
                  // }));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < searchCustomerList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(searchCustomerList[index].custId.toString())),
      DataCell(Text(searchCustomerList[index].custName)),
      DataCell(Text(searchCustomerList[index].custMobileNo.toString())),
      DataCell(Text(searchCustomerList[index].custAddress.toString())),
      DataCell(Text(searchCustomerList[index].taxSupplier.toString())),
      DataCell(Text(searchCustomerList[index].date.toString())),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
              ),
              color: Colors.green,
              onPressed: () {
                navigateToUpdate(index, searchCustomerList);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
              ),
              color: Colors.red,
              onPressed: () {
                _showMyDialog(searchCustomerList[index].custId);
              },
            ),
          ],
        ),
      ),
    ]);
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
                        "Manage Customer",
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
              return customerPopupMenu2.map((PopupMenu popupMenu) {
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
                        itemCount: searchCustomerList.length,
                        itemBuilder: (context, index) {
                          // print("//in index////$index");
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Name: ",
                                            style: textHintTextStyle),
                                        Text(
                                            "${searchCustomerList[index].custName}",
                                            style: textLabelTextStyle),
                                      ],
                                    ),
                                    Text("${customerList[index].date}",
                                        style: headsubTextStyle),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Text("Mobile No: ",
                                        style: headHintTextStyle),
                                    Text(
                                        "${searchCustomerList[index].custMobileNo}",
                                        style: headsubTextStyle),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Text("Address: ", style: headHintTextStyle),
                                    Text(
                                        "${searchCustomerList[index].custAddress}",
                                        style: headsubTextStyle),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Balance: ",
                                            style: headHintTextStyle),
                                        Text(
                                            "Rs.${searchCustomerList[index].taxSupplier}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            navigateToUpdate(
                                                index, searchCustomerList);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            _showMyDialog(
                                                searchCustomerList[index]
                                                    .custId);
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
      //                     builder: (context) => AddCustomerScreen()))
      //                 .then((value) => _reload(value));
      //             // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      //             //   return AddCustomerScreen();
      //             // }));
      //           },
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
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

  void navigateToUpdate(
    int rowID,
    customerList,
  ) async {
    bool result = await Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => UpdateCustomerScreen(rowID, customerList)))
        .then((value) => _reload(value));

    //     await Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return UpdateCustomerScreen(rowID);
    // }));

    if (result == true) {
      _getCustomer();
    }
  }

  // void updateListView() {
  //   final Future<Database> dbFuture = databaseHelper.initializeDatabase();
  //   dbFuture.then((value) {
  //     Future<List<CustomerModel>> todoListFuture =
  //         databaseHelper.getCustomerList();
  //     todoListFuture.then((customerList) {
  //       setState(() {
  //         this.customerList = customerList;
  //         this.count = customerList.length;
  //       });
  //     });
  //   });
  // }

  _reload(value) {
    _getCustomer();
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
                  CustomerFetch productdelete = new CustomerFetch();
                  var result =
                      await productdelete.customerDataDelete(id.toString());
                  var res = result['resid'];
                  if (res == 200) {
                    print("//////////////////Print result//////$result");
                    print("///delete id///$id");
                    Navigator.of(context).pop();
                    _getCustomer();
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

  void _getCustomer() async {
    setState(() {
      _showCircle = true;
    });
    CustomerFetch customerfetch = new CustomerFetch();
    var customerData = await customerfetch.getCustomerFetch("1");
    var resid = customerData["resid"];
    if (resid == 200) {
      var rowcount = customerData["rowcount"];
      if (rowcount > 0) {
        var customersd = customerData["customer"];
        print(customersd.length);
        List<CustomerModel> tempCustomer = [];
        for (var n in customersd) {
          CustomerModel pro = CustomerModel.withId(
              int.parse(n["CustomerId"]),
              n["CustomerDate"],
              n["CustomerName"],
              n["CustomerMobNo"],
              n["CustomerEmail"],
              n["CustomerAddress"],
              n["CustomerCreditType"],
              n["CustomerTaxSupplier"],
              int.parse(n["CustomerType"]));
          tempCustomer.add(pro);
        }
        setState(() {
          customerList = tempCustomer;
          searchCustomerList = customerList;
          _showCircle = false;
        });
        searchController.addListener(() {
          setState(() {
            if (customerList != null) {
              String s = searchController.text;
              searchCustomerList = customerList
                  .where((element) =>
                      element.custId
                          .toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.date
                          .toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.custName
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.custMobileNo
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.custCreditType
                          .toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()))
                  .toList();
            }
          });
        });
        print("//////SalesList/////////$customerList.length");
      } else {
        setState(() {
          _showCircle = false;
        });
        String msg = customerData["message"];
        Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black38,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }

      // List<String> tempCustomerNames = [];
      // for(int i=0;i<customerList.length;i++){
      //   tempCustomerNames.add(customerList[i].custName);
      // }
      // setState(() {
      //   this.customerName = tempCustomerNames;
      // });
      // print(customerName);
    } else {
      setState(() {
        _showCircle = false;
      });
      String msg = customerData["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
