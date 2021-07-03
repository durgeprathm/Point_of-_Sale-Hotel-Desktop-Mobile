import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/pos_purchase_fetch.dart';
import 'package:retailerp/Adpater/pos_purchse_delete.dart';
import 'package:retailerp/Adpater/pos_supplier_fetch.dart';
import 'package:retailerp/Datatables/Purchase_Reports_Source.dart';
import 'package:retailerp/Pagination_notifier/Manage_Purchase_datanotifier.dart';
import 'package:retailerp/models/Purchase.dart';
import 'package:retailerp/models/supplier.dart';
import 'package:retailerp/pages/Purchse_Report_Print.dart';
import 'package:retailerp/pages/edit_perchase_screen_new.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';

import 'Add_Supliers.dart';
import 'Add_purchase.dart';
import 'Import_purchase.dart';
import 'Manage_Suppliers.dart';
import 'Preview_Purchase.dart';

class PurchaseReport extends StatefulWidget {
  @override
  _PurchaseReportState createState() => _PurchaseReportState();
}

class _PurchaseReportState extends State<PurchaseReport> {
  @override
  // DatabaseHelper databaseHelper = DatabaseHelper();
  List<Purchase> purchaseList = [];
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
  List<Supplier> supplierList = new List();
  String Supplierid;

  TextEditingController searchController = TextEditingController();
  TextEditingController _textSuppliertype = TextEditingController();

  bool _showCircle = false;
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = Text("Purchase Report");

  @override
  void initState() {
    Provider.of<ManagePurchaseDataNotifier>(context, listen: false).clear();
    _getSupplier();
    final DateTime now = DateTime.now();
    final DateTime pre = new DateTime(now.year, now.month - 1, now.day);
    final String toDate = dateFormat.format(now);
    final String formDate = dateFormat.format(pre);
    _toDatetext.text = toDate;
    _fromDatetext.text = formDate;
    _getPurchase('1', '', "", "");
  }

  //-------------------------------------------
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

//-------------------------------------------
//---------------Tablet Mode Start-------------//
  Widget _buildTabletManagepurchase() {
    var tabletWidth =MediaQuery.of(context).size.width * 0.18;
    var tabletWidthSearch =MediaQuery.of(context).size.width * 0.25;
    final _provider = context.watch<ManagePurchaseDataNotifier>();
    final _model = _provider.ManagePurchaseModel;
    final _dtSource = PurchaseReportsDataTableSource(
      PurchaseReportsData: _model,
    );
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
            Text('Purchase Report'),
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
          purchaseList.length != 0
              ? IconButton(
            icon: Icon(Icons.print, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return PurchseReportPrint(1, purchaseList);
              }));
            },
          )
              : Text(''),
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
        child: SingleChildScrollView(
          child: Center(
            child: purchaseList.length == 0
                ? Center(child: CircularProgressIndicator())
                :  Column(
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
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 40,
                        width: tabletWidth,
                        child: DropdownSearch<Supplier>(
                          searchBoxController: _textSuppliertype,
                          isFilteredOnline: true,
                          showClearButton: true,
                          showSearchBox: true,
                          items: supplierList,
                          onSaved: (Supplier value) {
                            _textSuppliertype.text = value.Supplierid.toString();
                          },
                          label: "Supplier Name",
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            if (value != null) {
                              Supplierid = value.Supplierid.toString();
                              if (Supplierid == "0") {
                                _getPurchase('1', '', "", "");
                              } else {
                                print(
                                    "//_getSales function call///////////////////${Supplierid}");
                                _getPurchase("", Supplierid.toString(), "", "");
                              }
                              print(
                                  "//Supplierid///////////////////${Supplierid}");
                            } else {}
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
                            if (_fromDatetext == null ||
                                _toDatetext == null ||
                                fromValue == null ||
                                toValue == null) {
                              _getPurchase('1', '', "", "");
                            }
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
                        height: 40,
                        width: tabletWidth,
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
                          autofocus: false,
                          validator: (date) =>
                          date == null ? 'Invalid date' : null,
                          onChanged: (date) => setState(() {
                            toValue = date;
                            print('Selected Date: ${toValue}');
                            if (_fromDatetext == null ||
                                _toDatetext == null ||
                                fromValue == null ||
                                toValue == null) {
                              _getPurchase('1', '', "", "");
                            }
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

                                int dateDiff =
                                    toValue.difference(fromValue).inDays;
                                print('Date: $dateDiff');
                                if (dateDiff >= 0) {
                                  setState(() {
                                    _showCircle = true;
                                  });
                                  _getPurchase('2', '', _fromDatetext.text,
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
                    ],
                  ),
                ),
                // Expanded(
                //   child: SingleChildScrollView(
                //     child: Container(
                //       child: Center(
                //           child: DataTable(columns: [
                //             DataColumn(
                //                 label: Expanded(
                //                   child: Container(
                //                     child: Center(
                //                       child: Text('Sr No', style: tableColmTextStyle),
                //                     ),
                //                   ),
                //                 )),
                //             DataColumn(
                //                 label: Expanded(
                //                   child: Container(
                //                     child: Center(
                //                       child: Text('Date', style: tableColmTextStyle),
                //                     ),
                //                   ),
                //                 )),
                //             DataColumn(
                //                 label: Expanded(
                //                   child: Container(
                //                     child: Center(
                //                       child: Text('Supplier Name',
                //                           style: tableColmTextStyle),
                //                     ),
                //                   ),
                //                 )),
                //             DataColumn(
                //                 label: Expanded(
                //                   child: Container(
                //                     child: Center(
                //                       child:
                //                       Text('Invoice No', style: tableColmTextStyle),
                //                     ),
                //                   ),
                //                 )),
                //             DataColumn(
                //                 label: Expanded(
                //                   child: Container(
                //                     child: Center(
                //                       child: Text('Miscellaneous Amount',
                //                           style: tableColmTextStyle),
                //                     ),
                //                   ),
                //                 )),
                //             DataColumn(
                //                 label: Expanded(
                //                   child: Container(
                //                     child: Center(
                //                       child: Text('Discount', style: tableColmTextStyle),
                //                     ),
                //                   ),
                //                 )),
                //             DataColumn(
                //                 label: Expanded(
                //                   child: Container(
                //                     child: Center(
                //                       child:
                //                       Text('Total Amount', style: tableColmTextStyle),
                //                     ),
                //                   ),
                //                 )),
                //           ], rows: getDataRowList())),
                //     ),
                //   ),
                // ),
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
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobileManagepurchase() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.18;
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
                        "Manage Purchase",
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
                            if (_fromDatetext == null ||
                                _toDatetext == null ||
                                fromValue == null ||
                                toValue == null) {
                              _getPurchase('1', '', "", "");
                            }
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
                            if (_fromDatetext == null ||
                                _toDatetext == null ||
                                fromValue == null ||
                                toValue == null) {
                              _getPurchase('1', '', "", "");
                            }
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
                                _getPurchase('1', '', _fromDatetext.text,
                                    _toDatetext.text);
                                print(
                                    "_fromDatetext///////////////${_fromDatetext.text}");
                                print(
                                    "_toDatetext/////////////////${_toDatetext.text}");
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
                  child: GestureDetector(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: searchPurchaseList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 8),
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
                                                        EditPurchaseScreenNew(
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
              ),
            ],
          ),
        ),
      ),
    );
  }



  List<DataColumn> _colGen(
      ManagePurchaseDataNotifier _provider,
      ) =>
      <DataColumn>[
        DataColumn(
          label: Text("Sr No"),
          numeric: true,
          tooltip: "Sr No",
        ),
        DataColumn(
          label: Text('Date'),
          tooltip: 'Date',
        ),
        DataColumn(
          label: Text('Supplier Name'),
          tooltip: 'Supplier Name',
        ),
        DataColumn(
          label: Text('Invoice No'),
          tooltip: 'Invoice No',
        ),
        DataColumn(
          label: Text('Miscellaneous'),
          tooltip: 'Miscellaneous',
        ),
        DataColumn(
          label: Text('Discount'),
          tooltip: 'Discount',
        ),
        DataColumn(
          label: Text('Total'),
          tooltip: 'Total',
        ),
      ];

  void _sort<T>(
      Comparable<T> Function(Purchase sale) getField,
      int colIndex,
      bool asc,
      ManagePurchaseDataNotifier _provider,
      ) {
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }







  DataRow getRow(int index) {
    var serNo = index + 1;

    return DataRow(cells: [
      DataCell(Center(child: Text(serNo.toString()))),
      DataCell(Center(child: Text(searchPurchaseList[index].PurchaseDate))),
      DataCell(Center(child: Text(searchPurchaseList[index].PurchaseCompanyname))),
      DataCell(Center(child: Text(searchPurchaseList[index].Purchaseinvoice))),
      DataCell(Center(child: Text(searchPurchaseList[index].PurchaseMiscellaneons.toString()))),
      DataCell(Center(child: Text(searchPurchaseList[index].PurchaseDiscount.toString()))),
      DataCell(Center(child: Text(searchPurchaseList[index].PurchaseTotal.toString()))),
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
                  _getPurchase('0', '', '', '');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _getSupplier() async {
    SupplierFetch supplierfetch = new SupplierFetch();
    var supplierData = await supplierfetch.getSupplierFetch("1");
    print(supplierData);
    var resid = supplierData["resid"];
    if (resid == 200) {
      var rowcount = supplierData["rowcount"];
      print("//////rowcount/////////$rowcount");
      if (rowcount > 0) {
        var suppliersd = supplierData["supplier"];
        List<Supplier> tempSupplier = [];
        Supplier allpro = Supplier.WithIdname(
          0,
          "All",
        );
        tempSupplier.add(allpro);
        for (var n in suppliersd) {
          Supplier pro = Supplier.WithIdname(
            int.parse(n["SupplierId"]),
            n["SupplierCustomername"],
          );
          tempSupplier.add(pro);
        }
        setState(() {
          this.supplierList = tempSupplier;
        });
        print("//////supplierList/////////${supplierList.length}");
      } else {}
    } else {}
  }

  //-------------------------------------
//from server
  void _getPurchase(Forall, suplierId, fromDate, toDate) async {
    setState(() {
      _showCircle = true;
    });
    PurchaseFetch purchasefetch = new PurchaseFetch();
    var purchaseData = await purchasefetch.getDatewisePurchaseReportFetch(
        Forall, suplierId, fromDate, toDate);
    print('$purchaseData');
    var resid = purchaseData["resid"];
    if (resid == 200) {
      var rowcount = purchaseData["rowcount"];
      if (rowcount > 0) {
        var purchasesd = purchaseData["purchasereport"];
        List<Purchase> tempPurchase = [];
        print(purchasesd.length);
        for (int i = 0; i < purchasesd.length; i++) {
          Purchase pro = Purchase.withSupplier(
            i + 1,
            int.parse(purchasesd[i]["Purchaseid"]),
            purchasesd[i]["SupplierCustomername"],
            purchasesd[i]["purchaseinvoice"],
            purchasesd[i]["PurchaseDate"],
            purchasesd[i]["purchseproductid"],
            purchasesd[i]["purchseproductname"],
            purchasesd[i]["purchseproductrate"],
            purchasesd[i]["purchseproductquntity"],
            purchasesd[i]["purchseproductsubtotal"],
            purchasesd[i]["PurchaseSubTotal"],
            purchasesd[i]["PurchaseDiscount"],
            purchasesd[i]["purchseproductgst"],
            purchasesd[i]["PurchaseMiscellaneons"],
            purchasesd[i]["PurchaseTotal_Amount"],
            purchasesd[i]["PurchaseNarration"],
            purchasesd[i]["purchasesupplierid"],
            purchasesd[i]["SupplierCustomername"],
            purchasesd[i]["SupplierComapanyPersonName"],
            purchasesd[i]["SupplierMobileNumber"],
            purchasesd[i]["SupplierEmail"],
            purchasesd[i]["SupplierAddress"],
            purchasesd[i]["SupplierGSTNumber"],
          );
          tempPurchase.add(pro);
          Provider.of<ManagePurchaseDataNotifier>(context, listen: false)
              .addManagePurchaseData(pro);
        }

        setState(() {
          purchaseList = tempPurchase;
          searchPurchaseList = purchaseList;
          _showCircle = false;
        });
        print("//////purchaselist/////////$purchaseList.length");

        searchController.addListener(() {
          setState(() {
            if (purchaseList != null) {
              String s = searchController.text;
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

  _reload(value) {
    _getPurchase('0', '', '', '');
  }
//-------------------------------------
}
