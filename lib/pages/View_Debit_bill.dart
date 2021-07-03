import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_view_debit_bill_fetch.dart';
import 'package:retailerp/Adpater/pos_sales_delete.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/Datatables/View_Debit_Bill_Source.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/POSUIONE/bill_reprint.dart';
import 'package:retailerp/Pagination_notifier/view_debit_bill_datanotifier.dart';
import 'package:retailerp/pages/Manage_Sales.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';

import 'Add_Sales.dart';
import 'Import_sales.dart';
import 'Preview_sales.dart';


class DebitCashBill extends StatefulWidget {
  @override
  _DebitCashBillState createState() => _DebitCashBillState();
}

class _DebitCashBillState extends State<DebitCashBill> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileDebitCashBill();
    } else {
      content = _buildTabletDebitCashBill();
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

  //DatabaseHelper databaseHelper = DatabaseHelper();
  List<EhotelSales> DebitBillList = new List();
  List<EhotelSales> DebitBillListSearch = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;

  List<String> ProductName = new List();
  List<String> RATE = new List();
  List<String> Quant = new List();
  List<String> ProSubtotal = new List();
  List<String> GSTPER = new List();


  @override
  void initState() {
    Provider.of<ViewDebitBillDataNotifier>(context, listen: false).clear();
    //ShowSalesdetails();
    _getDebitBill();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletDebitCashBill() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.18;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.25;
    final _provider = context.watch<ViewDebitBillDataNotifier>();
    final _model = _provider.ViewDebitModel;
    final _dtSource = ViewDebitBillDataTableSource(
        ViewDebitBillData: _model,
        context: context
    );
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
        case 'UPI Bill':
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
            FaIcon(FontAwesomeIcons.creditCard),
            SizedBox(
              width: 20.0,
            ),
            Text('Debit Bill'),
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
          // DebitBillList.length != 0
          //     ? IconButton(
          //   icon: Icon(Icons.print, color: Colors.white),
          //   onPressed: () {
          //     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          //       return PaymentModeTodaysDebitReportPrint(1, DebitBillList);
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
                'UPI Bill',
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
            child: DebitBillList.length == 0
                ?
                Center(child: CircularProgressIndicator())
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
                                        initialDate: currentValue ?? DateTime.now(),
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
                                  validator: (date) => date == null ? 'Invalid date' : null,
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
                                    errorText: _fromDatevalidate ? 'Enter From Date' : null,
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
                                        initialDate: currentValue ?? DateTime.now(),
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
                                  validator: (date) => date == null ? 'Invalid date' : null,
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

                                    int dateDiff = toValue.difference(fromValue).inDays;
                                    print('Date: $dateDiff');
                                    if (dateDiff >= 0) {
                                      //_getDebitBillDateWise(_fromDatetext.text, _toDatetext.text);
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
                      //   padding: const EdgeInsets.all(8.0),
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
  Widget _buildMobileDebitCashBill() {
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
        case 'UPI Bill':
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
            FaIcon(FontAwesomeIcons.creditCard),
            SizedBox(
              width: 20.0,
            ),
            Text('Debit Bill'),
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
          // DebitBillList.length != 0
          //     ? IconButton(
          //   icon: Icon(Icons.print, color: Colors.white),
          //   onPressed: () {
          //     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          //       return PaymentModeTodaysDebitReportPrint(1, DebitBillList);
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
                'UPI Bill',
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
            child: DebitBillList.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: DebitBillList.length,
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
                                    "Bill No: ${DebitBillList[index].menusalesid.toString()} ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${DebitBillList[index].medate}",
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
                                Text(
                                    "${DebitBillList[index].customername}",
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
                                    "Rs. ${DebitBillList[index].totalamount.toString()}",
                                     style: tablecolumname),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  // onPressed: () {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) => PreviewSales(
                                  //               index, DebitBillList)));
                                  // },
                                  icon: Icon(
                                    Icons.preview,
                                    color: Colors.blue,
                                  ),
                                ),
                                IconButton(
                                  // onPressed: () {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               EditSaleScreenNew(
                                  //                   index, DebitBillList)));
                                  // },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _showMyDialog(DebitBillList[index].menusalesid);
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
      DataCell(Text(DebitBillList[index].menusalesid.toString())),
      DataCell(Text(DebitBillList[index].customername)),
      DataCell(Text(DebitBillList[index].medate)),
      DataCell(Text(DebitBillList[index].totalamount.toString())),
      DataCell(Text(DebitBillList[index].discount)),
      DataCell(Text(DebitBillList[index].paymodename)),
      DataCell(Text(DebitBillList[index].accounttypename)),
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0,left: 12.0),
              child: IconButton(
                icon: Icon(
                  Icons.preview,
                  size: 25,
                ),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PreviewSales(index, DebitBillList)));;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0,left: 12.0),
              child: IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.print,
                  size: 25,
                ),
                color: Colors.blueGrey,
                onPressed: () {

                  setState(() {
                    ProductName =  DebitBillList[index].menuname.split("#").toList();
                    RATE = DebitBillList[index].menurate.split("#").toList();
                    Quant = DebitBillList[index].menuquntity.split("#").toList();
                    ProSubtotal = DebitBillList[index].menusubtotal.split("#").toList();
                    GSTPER = DebitBillList[index].menugst.split("#").toList();
                  });

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BillRePrint(ProductName,RATE,Quant,ProSubtotal,GSTPER,DebitBillList[index].Subtotal.toString(),DebitBillList[index].discount.toString(),DebitBillList[index].totalamount.toString(),DebitBillList[index].customername.toString(),DebitBillList[index].medate.toString(),DebitBillList[index].menusalesid.toString())));;
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
            //   //               EditSaleScreenNew(index, DebitBillList)));
            //   // },
            // ),
            // IconButton(
            //   icon: Icon(
            //     Icons.delete,
            //   ),
            //   color: Colors.red,
            //   onPressed: () {
            //     _showMyDialog(DebitBillList[index].menusalesid);
            //   },
            // ),
          ],
        ),
      ),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < DebitBillList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }


  List<DataColumn> _colGen(
      ViewDebitBillDataNotifier _provider,
      ) =>
      <DataColumn>[
        DataColumn(
          label: Text("Bill NO",style: tablecolumname),
          numeric: true,
          tooltip:"Bill NO",
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
      ViewDebitBillDataNotifier _provider,
      ) {
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
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
                  _getDebitBill();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //-------------------------------------
//from server fetching sales Debit Bill
  void _getDebitBill() async {
    DebitBillFetch debitbillfetch = new DebitBillFetch();
    var debitData = await debitbillfetch.getDebitBillFetch("1");
    var resid = debitData["resid"];
    var debitbillsd = debitData["Debitcashbill"];
    print(debitbillsd.length);
    List<EhotelSales> tempdebitBill = [];
    for (var n in debitbillsd) {
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
        n["menusubtotal"],n["waiterid"],n["waitername"],
          n["accounttypename"]);
      tempdebitBill.add(pro);
      Provider.of<ViewDebitBillDataNotifier>(context, listen: false)
          .addSalesBillData(pro);
    }
    setState(() {
      this.DebitBillList = tempdebitBill;
      this.DebitBillListSearch = tempdebitBill;
    });
    print("//////SalesList/////////$DebitBillList.length");

    SerachController.addListener(() {
      setState(() {
        if (DebitBillListSearch != null) {
          String s = SerachController.text;
          DebitBillList = DebitBillListSearch.where((element) =>
          element.menusalesid.toString()
              .toLowerCase()
              .contains(s.toLowerCase()) ||
              element.customername.toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.discount.toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.totalamount.toLowerCase().contains(s.toLowerCase()) ||
              element.medate.toLowerCase().contains(s.toLowerCase()) ||
              element.paymodename.toString()
                  .toLowerCase()
                  .contains(s.toLowerCase())).toList();
        }
      });
    });
  }
//-------------------------------------
//from server fetching sales Debit  Bill Datewise
//   void _getDebitBillDateWise(String DateFrom,String DateTo) async {
//     DebitBillDateWiseFetch debitbilldatewisefetch = new DebitBillDateWiseFetch();
//     var debitdatewiseData = await debitbilldatewisefetch.getDebitBillDateWiseFetch(DateFrom,DateTo);
//     var resid = debitdatewiseData["resid"];
//     var debitbilldatewisesd = debitdatewiseData["sales"];
//     print(debitbilldatewisesd.length);
//     List<Sales> tempdebitBillDateWise = [];
//     for (var n in debitbilldatewisesd) {
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
//       tempdebitBillDateWise.add(pro);
//     }
//     setState(() {
//       this.DebitBillList = tempdebitBillDateWise;
//     });
//     print("//////SalesList/////////$DebitBillList.length");
//   }
//-------------------------------------

}
