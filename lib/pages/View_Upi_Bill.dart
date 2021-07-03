import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos-view_upi-bill_fetch.dart';
import 'package:retailerp/Adpater/pos_sales_delete.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/Datatables/View_UPI_Bill_Source.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/POSUIONE/bill_reprint.dart';
import 'package:retailerp/Pagination_notifier/view_upi_bill_Datanotifier.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/pages/Manage_Sales.dart';
import 'package:retailerp/pages/PaymentMode_Todays_UPI_Reports_Print.dart';
import 'package:retailerp/pages/edit_sales_screen_new.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';

import 'Add_Sales.dart';
import 'Edit_Sales.dart';
import 'Import_sales.dart';
import 'Preview_sales.dart';
import 'dashboard.dart';

class UpiCashBill extends StatefulWidget {
  @override
  _UpiCashBillState createState() => _UpiCashBillState();
}

class _UpiCashBillState extends State<UpiCashBill> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileUpiCashBill();
    } else {
      content = _buildTabletUpiCashBill();
    }

    return content;
  }

//-------------------------------------------
  final dateFormat = DateFormat("yyyy-MM-dd");
  final initialValue = DateTime.now();
  final _fromDatetext = TextEditingController();
  final _toDatetext = TextEditingController();
  DateTime fromValue = DateTime.now();
  DateTime toValue = DateTime.now();
  bool _fromDatevalidate = false;
  bool _toDatevalidate = false;
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;
  bool Datetofromenable = false;

  //DatabaseHelper databaseHelper = DatabaseHelper();
  List<EhotelSales> UpiBillList = new List();
  List<EhotelSales> UpiBillListSearch = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;
  String UpiFilter;
  List<String> ProductName = new List();
  List<String> RATE = new List();
  List<String> Quant = new List();
  List<String> ProSubtotal = new List();
  List<String> GSTPER = new List();

  @override
  void initState() {
    Provider.of<ViewUPIBillDataNotifier>(context, listen: false).clear();
    //ShowSalesdetails();
    _getUpiBill();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletUpiCashBill() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.18;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.25;
    final _provider = context.watch<ViewUPIBillDataNotifier>();
    final _model = _provider.ViewUPIModel;
    final _dtSource =
        ViewUPIBillDataTableSource(ViewUPIBillData: _model, context: context);

    void handleClick(String value) {
      switch (value) {
        case 'Today\'s Bill':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
          break;
        case 'Cash Bill':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ImportSales()));
          break;
        case 'Debit Bill':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ImportSales()));
          break;
        case 'Sales Book':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ManageSales()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.ccAmazonPay),
            SizedBox(
              width: 20.0,
            ),
            Text('UPI Bill'),
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
          // UpiBillList.length != 0
          //     ? IconButton(
          //   icon: Icon(Icons.print, color: Colors.white),
          //   onPressed: () {
          //     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          //       return PaymentModeTodaysUPIReportPrint(1, UpiBillList);
          //     }));
          //   },
          // )
          //     : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Today\'s Bill',
                'Cash Bill',
                'Debit Bill',
                'Sales Book',
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
            child: UpiBillList.length == 0
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: tabletWidthSearch,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: TextField(
                                  controller: SerachController,
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
                            ),
                            Container(
                              width: tabletWidth,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: DateTimeField(
                                  format: dateFormat,
                                  controller: _fromDatetext,
                                  onShowPicker: (context, currentValue) async {
                                    final date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                    if (date != null) {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                            currentValue ?? DateTime.now()),
                                      );
                                      return DateTimeField.combine(date, time);
                                    } else {
                                      return currentValue;
                                    }
                                  },
                                  autovalidate: _fromDatevalidate,
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
                                  resetIcon:
                                      showResetIcon ? Icon(Icons.delete) : null,
                                  readOnly: readOnly,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'From Date',
                                    errorText: _fromDatevalidate
                                        ? 'Enter From Date'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: tabletWidth,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: DateTimeField(
                                  format: dateFormat,
                                  controller: _toDatetext,
                                  onShowPicker: (context, currentValue) async {
                                    final date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                    if (date != null) {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                            currentValue ?? DateTime.now()),
                                      );
                                      return DateTimeField.combine(date, time);
                                    } else {
                                      return currentValue;
                                    }
                                  },
                                  autovalidate: _toDatevalidate,
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
                                  resetIcon:
                                      showResetIcon ? Icon(Icons.delete) : null,
                                  readOnly: readOnly,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'To Date',
                                    errorText: _toDatevalidate
                                        ? 'Enter Purchase Date'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Material(
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
                                      // _getUpiBillDateWise(_fromDatetext.text, _toDatetext.text);
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
                                height: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Go",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
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
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 8.0, horizontal: 50.0),
                      //   child: DataTable(columns: [
                      //     DataColumn(
                      //         label: Expanded(
                      //       child: Container(
                      //         width: 70,
                      //         child: Text('Bill No',
                      //             style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold)),
                      //       ),
                      //     )),
                      //     DataColumn(
                      //         label: Expanded(
                      //       child: Container(
                      //         width: 200,
                      //         child: Text('Customer Name',
                      //             style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold)),
                      //       ),
                      //     )),
                      //     DataColumn(
                      //         label: Expanded(
                      //       child: Container(
                      //         child: Text('Date',
                      //             style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold)),
                      //       ),
                      //     )),
                      //     DataColumn(
                      //         label: Expanded(
                      //       child: Container(
                      //         child: Text('Total',
                      //             style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold)),
                      //       ),
                      //     )),
                      //     DataColumn(
                      //         label: Expanded(
                      //           child: Container(
                      //             child: Text('Discount',
                      //                 style: TextStyle(
                      //                     fontSize: 20,
                      //                     fontWeight: FontWeight.bold)),
                      //           ),
                      //         )),
                      //     DataColumn(
                      //         label: Expanded(
                      //       child: Container(
                      //         child: Text('Mode',
                      //             style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold)),
                      //       ),
                      //     )),
                      //     DataColumn(
                      //       label: Expanded(
                      //         child: Container(
                      //           child: Text('Type',
                      //               style: TextStyle(
                      //                   fontSize: 20,
                      //                   fontWeight: FontWeight.bold)),
                      //         ),
                      //       ),
                      //     ),
                      //     DataColumn(
                      //       label: Expanded(
                      //         child: Container(
                      //           width: 50,
                      //           child: Text('Action',
                      //               style: TextStyle(
                      //                   fontSize: 20,
                      //                   fontWeight: FontWeight.bold)),
                      //         ),
                      //       ),
                      //     ),
                      //   ], rows: getDataRowList()),
                      // ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobileUpiCashBill() {
    void handleClick(String value) {
      switch (value) {
        case 'Today\'s Bill':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
          break;
        case 'Cash Bill':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ImportSales()));
          break;
        case 'Debit Bill':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ImportSales()));
          break;
        case 'Sales Book':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ManageSales()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.ccAmazonPay),
            SizedBox(
              width: 20.0,
            ),
            Text('UPI Bill'),
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
          // UpiBillList.length != 0
          //     ? IconButton(
          //   icon: Icon(Icons.print, color: Colors.white),
          //   onPressed: () {
          //     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          //       return PaymentModeTodaysUPIReportPrint(1, EhotelSales);
          //     }));
          //   },
          // )
          //     : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Today\'s Bill',
                'Cash Bill',
                'Debit Bill',
                'Sales Book',
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
            child: UpiBillList.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: UpiBillList.length,
                    itemBuilder: (context, index) {
                      print("//in index////$index");
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Bill No: ${UpiBillList[index].menusalesid.toString()} ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${UpiBillList[index].medate}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Customer Name: ",
                                  style: headHintTextStyle,
                                ),
                                Text("${UpiBillList[index].customername}",
                                    style: tablecolumname),
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
                                    "Rs. ${UpiBillList[index].totalamount.toString()}",
                                    style: tablecolumname),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  // onPressed: () {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) => PreviewSales(
                                  //               index, UpiBillList)));
                                  // },
                                  icon: Icon(
                                    Icons.preview,
                                    color: Colors.blue,
                                  ),
                                ),
                                // IconButton(
                                //   onPressed: () {
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) =>
                                //                 EditSaleScreenNew(
                                //                     index, UpiBillList)));
                                //   },
                                //   icon: Icon(
                                //     Icons.edit,
                                //     color: Colors.green,
                                //   ),
                                // ),
                                IconButton(
                                  onPressed: () {
                                    _showMyDialog(
                                        UpiBillList[index].menusalesid);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
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
    );
  }

//---------------Mobile Mode End-------------//

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(UpiBillList[index].menusalesid.toString())),
      DataCell(Text(UpiBillList[index].customername)),
      DataCell(Text(UpiBillList[index].medate)),
      DataCell(Text(
          double.parse(UpiBillList[index].totalamount).toStringAsFixed(2))),
      DataCell(Text(UpiBillList[index].discount)),
      DataCell(Text(UpiBillList[index].paymodename)),
      DataCell(Text(UpiBillList[index].accounttypename)),
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0, left: 12.0),
              child: IconButton(
                icon: Icon(
                  Icons.preview,
                ),
                color: Colors.blue,
                onPressed: () {
                  if (UpiBillList != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PreviewSales(index, UpiBillList)));
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0, left: 12.0),
              child: IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.print,
                  size: 25,
                ),
                color: Colors.blueGrey,
                onPressed: () {
                  setState(() {
                    ProductName =
                        UpiBillListSearch[index].menuname.split("#").toList();
                    RATE =
                        UpiBillListSearch[index].menurate.split("#").toList();
                    Quant = UpiBillListSearch[index]
                        .menuquntity
                        .split("#")
                        .toList();
                    ProSubtotal = UpiBillListSearch[index]
                        .menusubtotal
                        .split("#")
                        .toList();
                    GSTPER =
                        UpiBillListSearch[index].menugst.split("#").toList();
                  });

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BillRePrint(
                              ProductName,
                              RATE,
                              Quant,
                              ProSubtotal,
                              GSTPER,
                              UpiBillListSearch[index].Subtotal.toString(),
                              UpiBillListSearch[index].discount.toString(),
                              UpiBillListSearch[index].totalamount.toString(),
                              UpiBillListSearch[index].customername.toString(),
                              UpiBillListSearch[index].medate.toString(),
                              UpiBillListSearch[index]
                                  .menusalesid
                                  .toString())));
                  ;
                },
              ),
            ),

            // IconButton(
            //   icon: Icon(
            //     Icons.edit,
            //   ),
            //   color: Colors.green,
            //   // onPressed: () {
            //   //   Navigator.push(
            //   //       context,
            //   //       MaterialPageRoute(
            //   //           builder: (context) =>
            //   //               EditSaleScreenNew(index, UpiBillList)));
            //   // },
            // ),
            // IconButton(
            //   icon: Icon(
            //     Icons.delete,
            //   ),
            //   color: Colors.red,
            //   onPressed: () {
            //     _showMyDialog(UpiBillList[index].menusalesid);
            //   },
            // ),
          ],
        ),
      ),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < UpiBillList.length; i++) {
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
                  SalesDelete salesdelete = new SalesDelete();
                  var result = await salesdelete.getSalesDelete(id.toString());
                  print("//////////////////Print result//////$result");
                  print("///delete id///$id");
                  Navigator.of(context).pop();
                  _getUpiBill();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  List<DataColumn> _colGen(
    ViewUPIBillDataNotifier _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text("Bill NO",style: tablecolumname),
          numeric: true,
          tooltip: "Bill NO",
        ),
        DataColumn(
          label: Text('Customer Name',style: tablecolumname),
          tooltip: 'Customer Name',
        ),
        DataColumn(
          label: Text('Date',style: tablecolumname),
          tooltip: 'Date',
        ),
        DataColumn(
          label: Text('Total',style: tablecolumname),
          tooltip: 'Total',
        ),
        DataColumn(
          label: Text('Discount',style: tablecolumname),
          tooltip: 'Discount',
        ),
        DataColumn(
          label: Text('Mode',style: tablecolumname),
          tooltip: 'Mode',
        ),
        DataColumn(
          label: Text('Type',style: tablecolumname),
          tooltip: 'Type',
        ),
        DataColumn(
          label: Text('Action',style: tablecolumname),
          tooltip: 'Action',
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(EhotelSales sale) getField,
    int colIndex,
    bool asc,
    ViewUPIBillDataNotifier _provider,
  ) {
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  //-------------------------------------
//from server fetching sales Debit Data
  void _getUpiBill() async {
    UpiBillFetch upibillfetch = new UpiBillFetch();
    var UpiData = await upibillfetch.getUpiBillFetch();
    var resid = UpiData["resid"];
    var upibillsd = UpiData["viewupibill"];
    print(upibillsd.length);
    List<EhotelSales> tempupiBill = [];
    for (var n in upibillsd) {
      EhotelSales pro = EhotelSales(
          int.parse(n["menusalesid"]),
          n["customerid"],
          n["customername"],
          n["mobilenumber"],
          n["medate"],
          n["Subtotal"],
          n["discount"],
          n["totalamount"],
          n["payid"],
          n["transcationid"],
          n["paypaymodeid"],
          n["paymodename"],
          n["Narration"],
          n["menuid"],
          n["menuname"],
          n["menuquntity"],
          n["menurate"],
          n["menugst"],
          n["menusubtotal"],
          n["waiterid"],
          n["waitername"],
          n["accounttypename"]);
      tempupiBill.add(pro);
      Provider.of<ViewUPIBillDataNotifier>(context, listen: false)
          .addSalesBillData(pro);
    }
    setState(() {
      this.UpiBillList = tempupiBill;
      this.UpiBillListSearch = tempupiBill;
    });
    print("//////SalesList/////////$UpiBillList.length");

    SerachController.addListener(() {
      setState(() {
        if (UpiBillListSearch != null) {
          String s = SerachController.text;
          UpiBillList = UpiBillListSearch.where((element) =>
              element.menusalesid
                  .toString()
                  .toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.customername.toLowerCase().contains(s.toLowerCase()) ||
              element.medate.toLowerCase().contains(s.toLowerCase()) ||
              element.totalamount.toLowerCase().contains(s.toLowerCase()) ||
              element.paymodename
                  .toLowerCase()
                  .contains(s.toLowerCase())).toList();
        }
      });
    });
  }
//-------------------------------------
//from server fetching sales Debit Data
//   void _getUpiBillDateWise(String DateFrom,String DateTo) async {
//     UpiBillDatewiseFetch upibilldatewisefetch = new UpiBillDatewiseFetch();
//     var UpiDatadatewise = await upibilldatewisefetch.getUpiBillDateWiseFetch(DateFrom,DateTo);
//     var resid = UpiDatadatewise["resid"];
//     var upibilldatewisesd = UpiDatadatewise["sales"];
//     print(upibilldatewisesd.length);
//     List<Sales> tempupiBillDateWise = [];
//     for (var n in upibilldatewisesd) {
//       Sales pro = Sales(
//           int.parse(n["SalesId"]),
//           n["SalesCustomername"],
//           n["SalesDate"],
//           n["SalesProductName"],
//           n["SalesProductRate"],
//           n["SalesProductQty"],
//           n["SalesProductSubTotal"],
//           n["SalesSubTotal"],
//           n["SalesDiscount"],
//           n["SalesGST"],
//           n["SalesTotalAmount"],
//           n["SalesNarration"],
//           n["SalesPaymentMode"]);
//       tempupiBillDateWise.add(pro);
//     }
//     setState(() {
//       this.UpiBillList = tempupiBillDateWise;
//     });
//     print("//////SalesList/////////$UpiBillList.length");
//   }

}
