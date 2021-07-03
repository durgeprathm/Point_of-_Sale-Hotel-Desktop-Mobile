import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_cash_bill_fetch.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/Datatables/View_Cash_Bill_Source.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/POSUIONE/bill_reprint.dart';
import 'package:retailerp/Pagination_notifier/view_cash_bill_datanotifier.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/pages/Manage_Sales.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';

import 'Add_Sales.dart';
import 'Import_sales.dart';
import 'Preview_sales.dart';

class ViewCashBill extends StatefulWidget {
  @override
  _ViewCashBillState createState() => _ViewCashBillState();
}

class _ViewCashBillState extends State<ViewCashBill> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      // content = _buildMobileViewCashBill();
    } else {
      content = _buildTabletViewCashBill();
    }

    return content;
  }

//-------------------------------------------
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
  final dateFormat = DateFormat("yyyy-MM-dd");
  final initialValue = DateTime.now();

  //DatabaseHelper databaseHelper = DatabaseHelper();
  List<EhotelSales> CashBillList = new List();
  List<Sales> CashBillDateWiseList = new List();
  List<EhotelSales> CashBillListSearch = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;

  List<int> ProductID = new List();
  List<String> ProductName = new List();
  List<String> RATE = new List();
  List<String> Quant = new List();
  List<String> ProSubtotal = new List();
  List<String> GSTPER = new List();

  @override
  void initState() {
    Provider.of<ViewCashBillDataNotifier>(context, listen: false).clear();
    _getCashBill("1", "", "");
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletViewCashBill() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.18;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.25;
    final _provider = context.watch<ViewCashBillDataNotifier>();
    final _model = _provider.ViewCashModel;
    final _dtSource =
        ViewCashBillDataTableSource(ViewCashBillData: _model, context: context);
    void handleClick(String value) {
      switch (value) {
        case 'Today\'s Bill':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
          break;
        case 'Debit Bill':
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
            FaIcon(FontAwesomeIcons.moneyBill),
            SizedBox(
              width: 20.0,
            ),
            Text('Cash Bill'),
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
          // CashBillList.length != 0
          //     ? IconButton(
          //   icon: Icon(Icons.print, color: Colors.white),
          //   onPressed: () {
          //     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          //       return TodaysReportPrint(1, CashBillList);
          //     }));
          //   },
          // )
          //     : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Today\'s Bill',
                'Debit Bill',
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
              child: CashBillList.length == 0
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
                                height: 50.0,
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
                                    onShowPicker:
                                        (context, currentValue) async {
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
                                        return DateTimeField.combine(
                                            date, time);
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
                                      final DateFormat formatter =
                                          DateFormat('yyyy-MM-dd');
                                      final String fromValue =
                                          formatter.format(date);
                                      print(
                                          'Selected value Date: ${fromValue}');
                                      savedCount++;
                                    }),
                                    resetIcon: showResetIcon
                                        ? Icon(Icons.delete)
                                        : null,
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
                                    onShowPicker:
                                        (context, currentValue) async {
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
                                        return DateTimeField.combine(
                                            date, time);
                                      } else {
                                        return currentValue;
                                      }
                                    },
                                    autovalidate: _toDatevalidate,
                                    validator: (date) =>
                                        date == null ? 'Invalid date' : null,
                                    onChanged: (date) => setState(() {
                                      final DateFormat formatter =
                                          DateFormat('yyyy-MM-dd');
                                      final String toValue =
                                          formatter.format(date);
                                      print('Selected Date: ${toValue}');
                                    }),
                                    onSaved: (date) => setState(() {
                                      toValue = date;
                                      print(
                                          'Selected value Date: $_toDatetext');
                                      savedCount++;
                                    }),
                                    resetIcon: showResetIcon
                                        ? Icon(Icons.delete)
                                        : null,
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
                                        //_getCashBill("",_fromDatetext.text,_toDatetext.text);
                                        _getCashBill("", fromValue.toString(),
                                            toValue.toString());
                                        print(
                                            "//fromValue//////////////${fromValue.toString()}");
                                        print(
                                            "////toValue////////////${toValue.toString()}");
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
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: DataTable(columns: [
                        //     DataColumn(
                        //         label: Expanded(
                        //       child: Container(
                        //         width: 75,
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
                    )),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(CashBillList[index].menusalesid.toString())),
      DataCell(Text(CashBillList[index].customername)),
      DataCell(Text(CashBillList[index].medate)),
      DataCell(Text(CashBillList[index].totalamount.toString())),
      DataCell(Text(CashBillList[index].discount)),
      DataCell(Text(CashBillList[index].paymodename)),
      DataCell(Text(CashBillList[index].accounttypename)),
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0, left: 12.0),
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
                              PreviewSales(index, CashBillList)));
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
                        CashBillList[index].menuname.split("#").toList();
                    RATE = CashBillList[index].menurate.split("#").toList();
                    Quant = CashBillList[index].menuquntity.split("#").toList();
                    ProSubtotal =
                        CashBillList[index].menusubtotal.split("#").toList();
                    GSTPER = CashBillList[index].menugst.split("#").toList();
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
                              CashBillList[index].Subtotal.toString(),
                              CashBillList[index].discount.toString(),
                              CashBillList[index].totalamount.toString(),
                              CashBillList[index].customername.toString(),
                              CashBillList[index].medate.toString(),
                              CashBillList[index].menusalesid.toString())));
                  ;
                },
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < CashBillList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  List<DataColumn> _colGen(
    ViewCashBillDataNotifier _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text(
            "Bill NO",
            style: tablecolumname,
          ),
          numeric: true,
          tooltip: "Bill NO",
        ),
        DataColumn(
          label: Text(
            'Customer Name',
            style: tablecolumname,
          ),
          tooltip: 'Customer Name',
        ),
        DataColumn(
          label: Text(
            'Date',
            style: tablecolumname,
          ),
          tooltip: 'Date',
        ),
        DataColumn(
          label: Text('Total', style: tablecolumname),
          tooltip: 'Total',
        ),
        DataColumn(
          label: Text('Discount', style: tablecolumname),
          tooltip: 'Discount',
        ),
        DataColumn(
          label: Text('Mode', style: tablecolumname),
          tooltip: 'Mode',
        ),
        DataColumn(
          label: Text('Type', style: tablecolumname),
          tooltip: 'Type',
        ),
        DataColumn(
          label: Text('Action', style: tablecolumname),
          tooltip: 'Action',
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(EhotelSales sale) getField,
    int colIndex,
    bool asc,
    ViewCashBillDataNotifier _provider,
  ) {
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  //-------------------------------------
//from server fetching All Cash Data
  void _getCashBill(
      String allrecords, String firstdate, String lastdate) async {
    CashBillFetch cashbillfetch = new CashBillFetch();
    var cashData =
        await cashbillfetch.getCashBillFetch(allrecords, firstdate, lastdate);
    print(cashData);
    var resid = cashData["resid"];
    var cashbillsd = cashData["viewcashbill"];
    print(cashbillsd.length);
    List<EhotelSales> tempCashBill = [];
    for (var n in cashbillsd) {
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
      tempCashBill.add(pro);
      Provider.of<ViewCashBillDataNotifier>(context, listen: false)
          .addViewBillData(pro);
    }
    setState(() {
      this.CashBillList = tempCashBill;
      this.CashBillListSearch = tempCashBill;
    });
    print("//////CashBillList/////////$CashBillList.length");

    SerachController.addListener(() {
      setState(() {
        if (CashBillListSearch != null) {
          String s = SerachController.text;
          CashBillList = CashBillListSearch.where((element) =>
              element.menusalesid
                  .toString()
                  .toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.customername.toLowerCase().contains(s.toLowerCase()) ||
              element.discount.toLowerCase().contains(s.toLowerCase()) ||
              element.totalamount.toLowerCase().contains(s.toLowerCase()) ||
              element.medate.toLowerCase().contains(s.toLowerCase()) ||
              element.paymodename
                  .toString()
                  .toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.waitername
                  .toString()
                  .toLowerCase()
                  .contains(s.toLowerCase())).toList();
        }
      });
    });
  }
//-------------------------------------
  //-------------------------------------
//from server fetching cash data datewise
//   void _getCashBillDate(String DateFrom, String DateTo ) async {
//     CashBillDateWiseFetch cashbilldatewisefetch = new CashBillDateWiseFetch();
//     var cashDatewiaseData = await cashbilldatewisefetch.getCashBillDateWiseFetch(DateFrom,DateTo);
//     var resid = cashDatewiaseData["resid"];
//     var cashbillDatewisesd = cashDatewiaseData["sales"];
//     //print(cashbillDatewisesd.length);
//     List<Sales> tempCashBillDateWise = [];
//     for (var n in cashbillDatewisesd) {
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
//       tempCashBillDateWise.add(pro);
//     }
//     setState(() {
//       this.CashBillList = tempCashBillDateWise;
//     });
//     print("//////CashBillList/////////$CashBillList.length");
//   }
//-------------------------------------
}
