import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/pos_purchase_fetch.dart';
import 'package:retailerp/Adpater/pos_purchse_delete.dart';
import 'package:retailerp/Adpater/pos_supplier_fetch.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/Purchase.dart';
import 'package:retailerp/models/supplier.dart';
import 'package:retailerp/pages/edit_perchase_screen_new.dart';
import 'package:retailerp/pages/edit_return_purchase_screen_new.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:sqflite/sqflite.dart';

import 'Add_Supliers.dart';
import 'Add_purchase.dart';
import 'Import_purchase.dart';
import 'Manage_Suppliers.dart';
import 'Edit_Perchase_Screen.dart';
import 'Preview_Purchase.dart';
import 'dashboard.dart';

class ManageRetrunPurchase extends StatefulWidget {
  @override
  _ManageRetrunPurchaseState createState() => _ManageRetrunPurchaseState();
}

class _ManageRetrunPurchaseState extends State<ManageRetrunPurchase> {
  @override
  // DatabaseHelper databaseHelper = DatabaseHelper();
  List<Purchase> purchaseList = new List();
  List<Supplier> SupplierList = new List();
  List<String> companyNameList = new List();
  List<Purchase> searchPurchaseList = [];

  int count;
  final dateFormat = DateFormat("yyyy-MM-dd");
  final initialValue = DateTime.now();
  final _fromDatetext = TextEditingController();
  final _toDatetext = TextEditingController();
  DateTime fromValue = DateTime.now();
  DateTime toValue = DateTime.now();
  bool _fromDatevalidate = false;
  bool _toDatevalidate = false;
  int changedCount = 0;
  int savedCount = 0;
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;
  bool Datetofromenable = false;
  String cName;
  bool _showCircle = false;

  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = Text("Manage Purchase Return");
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // ShowPurchasedetails();
    _getPurchase();
    _getSupplier();
  }

  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileManageRetrunPurchase();
    } else {
      content = _buildTabletManageRetrunPurchase();
    }

    return content;
  }

//-------------------------------------------
//---------------Tablet Mode Start-------------//
  Widget _buildTabletManageRetrunPurchase() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;
    void handleClick(String value) {
      switch (value) {
        case 'Add Purchase':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPurchase()));
          break;
        case 'Import Sales':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImportPurchase()));
          break;
        case 'Add Supplier':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddSupplierDetails()));
          break;
        case 'Manage Suppliers':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ManageSuppliers()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.shoppingBag),
            SizedBox(
              width: 20.0,
            ),
            Text('Manage Purchase Return'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Add Purchase',
                'Import Purchase',
                'Add Supplier',
                'Manage Suppliers',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _showCircle,
          child: SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
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
                    Container(
                      height: 40,
                      width: tabletWidth,
                      child: DropdownSearch(
                        isFilteredOnline: true,
                        showClearButton: true,
                        showSearchBox: true,
                        items: companyNameList,
                        selectedItem: 'All',
                        label: "Company Name",
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) {
                          cName = value;
                          if (cName != null) {
                            if (cName == 'All') {
                              print('$cName');
                              setState(() {
                                _showCircle = true;
                              });
                              _getFilterPurchase('0', '', '', '');
                            } else {
                              setState(() {
                                _showCircle = true;
                              });
                              print('$cName');
                              _getFilterPurchase('1', cName, '', '');
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: tabletWidth,
                      child: DateTimeField(
                        controller: _fromDatetext,
                        format: dateFormat,
                        keyboardType: TextInputType.number,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                        autovalidate: autoValidate,
                        validator: (date) =>
                            date == null ? 'Invalid date' : null,
                        onChanged: (date) => setState(() {
                          fromValue = date;
                          print('Selected Date: ${date}');
                        }),
                        onSaved: (date) => setState(() {
                          fromValue = date;
                          print('Selected value Date: $fromValue');
                          savedCount++;
                        }),
                        resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                        readOnly: readOnly,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'From Date',
                          errorText:
                              _fromDatevalidate ? 'Enter From Date' : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: tabletWidth,
                      height: 40,
                      child: DateTimeField(
                        controller: _toDatetext,
                        format: dateFormat,
                        keyboardType: TextInputType.number,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                        autovalidate: autoValidate,
                        validator: (date) =>
                            date == null ? 'Invalid date' : null,
                        onChanged: (date) => setState(() {
                          toValue = date;
                          print('Selected Date: ${toValue}');
                        }),
                        onSaved: (date) => setState(() {
                          toValue = date;
                          print('Selected value Date: $_toDatetext');
                          savedCount++;
                        }),
                        resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                        readOnly: readOnly,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'To Date',
                          errorText:
                              _toDatevalidate ? 'Enter Purchase Date' : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      child: Material(
                        elevation: 5.0,
                        color: PrimaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                        child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _fromDatetext.text.isEmpty
                                  ? _fromDatevalidate = true
                                  : _fromDatevalidate = false;
                              _toDatetext.text.isEmpty
                                  ? _toDatevalidate = true
                                  : _toDatevalidate = false;

                              int dateDiff = toValue.difference(fromValue).inDays;
                              print('Date: $dateDiff');
                              if (dateDiff >= 0) {
                                setState(() {
                                  _showCircle = true;
                                });
                                _getFilterPurchase('2', cName, _fromDatetext.text,
                                    _toDatetext.text);
                                // _getbothpaymentDate(PaymentMode,_fromDatetext.text, _toDatetext.text);
                              } else {
                                Fluttertoast.showToast(
                                  msg:
                                      "Select from date must be less than to date!!!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.black38,
                                  textColor: Color(0xffffffff),
                                  gravity: ToastGravity.BOTTOM,
                                );
                              }
                            });
                            CircularProgressIndicator();
                            // _toDatetext.clear();
                          },
                          minWidth: 75,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "Go",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Divider(),
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
                      width: 200,
                      child: Text('Supplier Name',
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
                      child: Text('Total',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Container(
                      width: 50,
                      child: Text('Action',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  )),
                ], rows: getDataRowList()),
              ],
            )),
          ),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobileManageRetrunPurchase() {
    void handleClick(String value) {
      switch (value) {
        case 'Add Purchase':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPurchase()));
          break;
        case 'Import Sales':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImportPurchase()));
          break;
        case 'Add Supplier':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddSupplierDetails()));
          break;
        case 'Manage Suppliers':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ManageSuppliers()));
          break;
      }
    }

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
                        "Manage Purchase Return",
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
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Add Purchase',
                'Import Purchase',
                'Add Supplier',
                'Manage Suppliers',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _showCircle,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        child: DateTimeField(
                          controller: _fromDatetext,
                          format: dateFormat,
                          keyboardType: TextInputType.number,
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                          autovalidate: autoValidate,
                          validator: (date) =>
                              date == null ? 'Invalid date' : null,
                          onChanged: (date) => setState(() {
                            fromValue = date;
                            print('Selected Date: ${date}');
                          }),
                          onSaved: (date) => setState(() {
                            fromValue = date;
                            print('Selected value Date: $fromValue');
                            savedCount++;
                          }),
                          resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                          readOnly: readOnly,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'From Date',
                            errorText:
                                _fromDatevalidate ? 'Enter From Date' : null,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        child: DateTimeField(
                          controller: _toDatetext,
                          format: dateFormat,
                          keyboardType: TextInputType.number,
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                          autovalidate: autoValidate,
                          validator: (date) =>
                              date == null ? 'Invalid date' : null,
                          onChanged: (date) => setState(() {
                            toValue = date;
                            print('Selected Date: ${toValue}');
                          }),
                          onSaved: (date) => setState(() {
                            toValue = date;
                            print('Selected value Date: $_toDatetext');
                            savedCount++;
                          }),
                          resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                          readOnly: readOnly,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'To Date',
                            errorText:
                                _toDatevalidate ? 'Enter Purchase Date' : null,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 60,
                      height: 40,
                      child: Material(
                        elevation: 5.0,
                        color: PrimaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                        child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _fromDatetext.text.isEmpty
                                  ? _fromDatevalidate = true
                                  : _fromDatevalidate = false;
                              _toDatetext.text.isEmpty
                                  ? _toDatevalidate = true
                                  : _toDatevalidate = false;

                              int dateDiff =
                                  toValue.difference(fromValue).inDays;
                              print('Date: $dateDiff');
                              if (dateDiff >= 0) {
                                _getFilterPurchase('2', cName,
                                    _fromDatetext.text, _toDatetext.text);
                              } else {
                                Fluttertoast.showToast(
                                  msg:
                                      "Select from date must be less than to date!!!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.black38,
                                  textColor: Color(0xffffffff),
                                  gravity: ToastGravity.BOTTOM,
                                );
                              }
                            });
                          },
                          minWidth: 60,
                          height: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              "Go",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: searchPurchaseList.length,
                      itemBuilder: (context, index) {
                        print("//in index////$index");
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Invoice No:- ${searchPurchaseList[index].Purchaseid.toString()} ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "${searchPurchaseList[index].PurchaseDate}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("Company Name: ",
                                          style: headHintTextStyle),
                                      Text(
                                          "${searchPurchaseList[index].PurchaseCompanyname}",
                                          style: headsubTextStyle),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Text("Total Amount:      ",
                                          style: headHintTextStyle),
                                      Text(
                                          "Rs.${searchPurchaseList[index].PurchaseTotal.toString()}",
                                          style: headsubTextStyle),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PreviewPurchase(index,
                                                          searchPurchaseList)));
                                        },
                                        icon: Icon(
                                          Icons.preview,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditReturnPurchaseScreenNew(
                                                          index,
                                                          searchPurchaseList)));
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _showMyDialog(
                                              searchPurchaseList[index]
                                                  .Purchaseid);
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
            ],
          ),
        ),
      ),
    );
  }

//---------------Mobile Mode End-------------//

  // void ShowPurchasedetails() {
  //   final Future<Database> dbFuture = databaseHelper.initializeDatabase();
  //   dbFuture.then((value) {
  //     Future<List<Purchase>> purchaseListFuture =
  //         databaseHelper.getpurchaseList();
  //     purchaseListFuture.then((PurchaseCatList) {
  //       setState(() {
  //         this.purchaseList = PurchaseCatList;
  //         this.count = PurchaseCatList.length;
  //         print("Printing Purchalist//${count}");
  //       });
  //     });
  //   });
  // }

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(searchPurchaseList[index].Purchaseid.toString())),
      DataCell(Text(searchPurchaseList[index].PurchaseCompanyname)),
      DataCell(Text(searchPurchaseList[index].PurchaseDate)),
      DataCell(Text(searchPurchaseList[index].PurchaseTotal.toString())),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.preview,
              ),
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PreviewPurchase(index, searchPurchaseList)));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
              ),
              color: Colors.green,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditReturnPurchaseScreenNew(
                            index, searchPurchaseList)));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
              ),
              color: Colors.red,
              onPressed: () {
                _showMyDialog(searchPurchaseList[index].Purchaseid);
              },
            ),
          ],
        ),
      ),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < searchPurchaseList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
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
                  PurchaseDelete purchasedelete = new PurchaseDelete();
                  var result =
                      await purchasedelete.getPurchaseDelete(id.toString());
                  print("//////////////////Print result//////$result");
                  print("///delete id///$id");
                  Navigator.of(context).pop();
                  _getPurchase();
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
  void _getPurchase() async {
    setState(() {
      _showCircle = true;
    });
    PurchaseFetch purchasefetch = new PurchaseFetch();
    var purchaseData = await purchasefetch.getReturnPurchaseFetch("1");
    print('$purchaseData');
    var resid = purchaseData["resid"];
    if (resid == 200) {
      int rowcount = purchaseData["rowcount"];
      if (rowcount > 0) {
        var purchasesd = purchaseData["purchase"];
        List<Purchase> tempPurchase = [];
        print(purchasesd.length);
        for (var n in purchasesd) {
          Purchase pro = Purchase(
              int.parse(n["PurchaseId"]),
              n["PurchaseCustomername"],'',
              n["PurchaseDate"],
              n["PurchaseProductName"],
              n["PurchaseProductRate"],
              n["PurchaseProductQty"],
              n["PurchaseProductSubTotal"],
              n["PurchaseSubTotal"],
              n["PurchaseDiscount"],
              n["PurchaseGST"],
              n["PurchaseMiscellaneons"],
              n["PurchaseTotalAmount"],
              n["PurchaseNarration"],
              n["productids"]);
          tempPurchase.add(pro);
        }
        setState(() {
          _showCircle = false;
          this.purchaseList = tempPurchase;
          searchPurchaseList = purchaseList;
        });

        searchController.addListener(() {
          setState(() {
            if (purchaseList != null) {
              String s = searchController.text;
              // searchPurchaseList = purchaseList
              //     .where((element) => element.PurchaseCompanyname.toLowerCase()
              //         .contains(s.toLowerCase()))
              //     .toList();

              searchPurchaseList = purchaseList
                  .where((element) =>
                      element.PurchaseIds.toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.PurchaseCompanyname.toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.PurchaseProductName.toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.PurchaseDate.toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.PurchaseTotal.toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()))
                  .toList();
            }
          });
        });
        print("//////purchaselist/////////$purchaseList.length");
      } else {
        String msg = purchaseData["message"];
        Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black38,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }

      print("//////purchaselist/////////$purchaseList.length");
    } else {
      setState(() {
        _showCircle = false;
      });
      String msg = purchaseData["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void _getSupplier() async {
    SupplierFetch supplierfetch = new SupplierFetch();
    var supplierData = await supplierfetch.getSupplierFetch("1");
    print(supplierData);
    var resid = supplierData["resid"];

    if (resid == 200) {
      var suppliersd = supplierData["supplier"];
      List<Supplier> tempSupplier = [];
      for (var n in suppliersd) {
        Supplier pro = Supplier.WithIdname(
            int.parse(n["SupplierId"]), n["SupplierCustomername"]);
        tempSupplier.add(pro);
      }
      setState(() {
        this.SupplierList = tempSupplier;
      });
      print("//////SalesList/////////$SupplierList.length");

      List<String> tempcompanyNameLists = [];
      tempcompanyNameLists.add('All');
      for (int i = 0; i < SupplierList.length; i++) {
        tempcompanyNameLists.add(SupplierList[i].SupplierComapanyName);
      }
      setState(() {
        this.companyNameList = tempcompanyNameLists;
      });
      print(companyNameList);
    } else {}
  }

  void _getFilterPurchase(String action, String cName, sDate, eDate) async {
    setState(() {
      purchaseList.clear();
    });
    setState(() {
      _showCircle = true;
    });

    String purComName = cName;
    if (purComName == null) {
      purComName = 'All';
    }

    PurchaseFetch purchasefetch = new PurchaseFetch();
    var purchaseData = await purchasefetch.getFilterReturnPurchaseFetch(
        action, purComName, sDate, eDate);
    print('$purchaseData');
    var resid = purchaseData["resid"];
    if (resid == 200) {
      int rowcount = purchaseData["rowcount"];
      if (rowcount > 0) {
        var purchasesd = purchaseData["purchase"];
        List<Purchase> tempPurchase = [];
        print(purchasesd.length);
        for (var n in purchasesd) {
          // Purchase pro = Purchase(
          //     int.parse(n["PurchaseId"]),
          //     n["PurchaseCustomername"],
          //     n["PurchaseDate"],
          //     n["PurchaseProductName"],
          //     n["PurchaseProductRate"],
          //     n["PurchaseProductQty"],
          //     n["PurchaseProductSubTotal"],
          //     n["PurchaseSubTotal"],
          //     n["PurchaseDiscount"],
          //     n["PurchaseGST"],
          //     n["PurchaseMiscellaneons"],
          //     n["PurchaseTotalAmount"],
          //     n["PurchaseNarration"],
          //     n["productids"]);
          // tempPurchase.add(pro);
        }

        setState(() {
          _showCircle = false;
          this.purchaseList = tempPurchase;
          searchPurchaseList = purchaseList;
        });

        searchController.addListener(() {
          setState(() {
            if (purchaseList != null) {
              String s = searchController.text;
              // searchPurchaseList = purchaseList
              //     .where((element) => element.PurchaseCompanyname.toLowerCase()
              //         .contains(s.toLowerCase()))
              //     .toList();

              searchPurchaseList = purchaseList
                  .where((element) =>
                      element.PurchaseIds.toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.PurchaseCompanyname.toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.PurchaseProductName.toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.PurchaseDate.toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.PurchaseTotal.toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()))
                  .toList();
            }
          });
        });
        print("//////purchaselist/////////$purchaseList.length");
      } else {
        String msg = purchaseData["message"];
        Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black38,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }
      setState(() {
        _showCircle = false;
      });
    } else {
      setState(() {
        _showCircle = false;
      });
      String msg = purchaseData["message"];
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
