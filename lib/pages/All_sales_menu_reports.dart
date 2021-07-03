import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_Allsales_menu_fetch.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_todayssales_menu_fetch.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/Datatables/Monthly_Wise_Menu_Report_Source.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/EhotelModel/Ehotelmenu.dart';
import 'package:retailerp/Pagination_notifier/Monthly_Wise_Menu_Reports_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/view_upi_bill_Datanotifier.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/pages/edit_sales_screen_new.dart';
import 'package:retailerp/pages/todays_menu_report_print.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';

import 'Add_Sales.dart';
import 'Import_sales.dart';
import 'Preview_sales.dart';
import 'Todays_Reports_Print.dart';

class AllMenuReports extends StatefulWidget {
  @override
  _AllMenuReportsState createState() => _AllMenuReportsState();
}

class _AllMenuReportsState extends State<AllMenuReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;
  bool _showCircle = false;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileAllMenuReports();
    } else {
      content = _buildTabletAllMenuReports();
    }

    return content;
  }

//-------------------------------------------
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  final format = DateFormat("yyyy-MM-dd");
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;
  String _selectdate;
  String PaymentMode;

  //DatabaseHelper databaseHelper = DatabaseHelper();
  List<Ehotelmenu> AllMenuList = new List();
  List<Ehotelmenu> AllMenuListSearch = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;

  @override
  void initState() {
    Provider.of<MonthlyWiseMenuReportsDataNotifier>(context, listen: false)
        .clear();
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    _getTodaysmenu();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletAllMenuReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.18;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.25;
    final _provider = context.watch<MonthlyWiseMenuReportsDataNotifier>();
    final _model = _provider.MonthlyWiseMenuReportsModel;
    final _dtSource = MonthlyWiseMenuReportDataTableSource(
        MonthlyWiseMenuReportData: _model, context: context);

    void handleClick(String value) {
      switch (value) {
        case 'Cash Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
          break;
        case 'Debit Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ImportSales()));
          break;
        case 'UPI Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ImportSales()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.calendar),
            SizedBox(
              width: 20.0,
            ),
            Text('Monthly Menu Sales  Reports'),
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
          AllMenuList.length != 0
              ? IconButton(
                  icon: Icon(Icons.print, color: Colors.white),
                  onPressed: () {
                    double total = 0.0;
                    for (int i = 0; i < AllMenuList.length; i++) {
                      total = double.parse(AllMenuList[i].Menu_total_amount);
                    }
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return TodaysMenuReportPrint(1, AllMenuList,
                          _selectdate.toString(), total.toString());
                    }));
                  },
                )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Cash Reports',
                'Debit Reports',
                'UPI Reports',
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
            child: AllMenuList.length == 0
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Row(
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
                          // Container(
                          //   width: tabletWidth,
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(
                          //         vertical: 10.0, horizontal: 20.0),
                          //     child: DropdownSearch(
                          //       isFilteredOnline: true,
                          //       showClearButton: true,
                          //       showSearchBox: true,
                          //       items: [
                          //         "All",
                          //         "CASH",
                          //         "DEBIT",
                          //         "UPI",
                          //       ],
                          //       label: "Payment Mode",
                          //       autoValidateMode:
                          //           AutovalidateMode.onUserInteraction,
                          //       onChanged: (value) {
                          //         PaymentMode = value;
                          //         if (PaymentMode == "All" ||
                          //             PaymentMode == null) {
                          //           _getTodaysBill(_selectdate);
                          //         } else {
                          //           // _getSalesPaymentMode(
                          //           //     PaymentMode, _selectdate);
                          //         }
                          //
                          //         print(PaymentMode);
                          //       },
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: DataTable(columns: [
                      //     DataColumn(
                      //         label: Expanded(
                      //       child: Container(
                      //         width: 70,
                      //         child: Text('Sr No',
                      //             style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold)),
                      //       ),
                      //     )),
                      //     DataColumn(
                      //         label: Expanded(
                      //       child: Container(
                      //         width: 200,
                      //         child: Text('Menu Name',
                      //             style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold)),
                      //       ),
                      //     )),
                      //     DataColumn(
                      //         label: Expanded(
                      //       child: Container(
                      //         child: Text('Category',
                      //             style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold)),
                      //       ),
                      //     )),
                      //     DataColumn(
                      //         label: Expanded(
                      //       child: Container(
                      //         child: Text('Quntity',
                      //             style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold)),
                      //       ),
                      //     )),
                      //     DataColumn(
                      //         label: Expanded(
                      //       child: Container(
                      //         child: Text('Rate',
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
                      //   ], rows: getDataRowList()),
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
  Widget _buildMobileAllMenuReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Cash Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
          break;
        case 'Debit Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ImportSales()));
          break;
        case 'UPI Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ImportSales()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.calendar),
            SizedBox(
              width: 20.0,
            ),
            Text('Today\'s Reports'),
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
          AllMenuList.length != 0
              ? IconButton(
                  icon: Icon(Icons.print, color: Colors.white),
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    //   return TodaysMenuReportPrint(1, AllMenuList);
                    // }));
                  },
                )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Cash Bill',
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
        child: ModalProgressHUD(
          inAsyncCall: _showCircle,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: AllMenuList.length,
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
                                    "Menu No: ${AllMenuList[index].menu_id.toString()} ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${AllMenuList[index].Menu_date}",
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
                                  "Menu Name: ",
                                  style: headHintTextStyle,
                                ),
                                Text("${AllMenuList[index].Menu_Name}",
                                    style: tablecolumname),
                              ],
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Menu Category: ",
                                  style: headHintTextStyle,
                                ),
                                Text("${AllMenuList[index].Menu_Cat_Name}",
                                    style: tablecolumname),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Text("Quntity:      ",
                                    style: headHintTextStyle),
                                Text(
                                    "Rs. ${AllMenuList[index].Menu_Qty_Sum.toString()}",
                                    style: tablecolumname),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Text("Rate:      ", style: headHintTextStyle),
                                Text(
                                    "Rs. ${AllMenuList[index].Menu_Rate.toString()}",
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
                                    "Rs. ${AllMenuList[index].Menu_total_amount.toString()}",
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
                                  //               index, TodayBillList)));
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
                                  //                   index, TodayBillList)));
                                  // },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // _showMyDialog(TodayBillList[index].Salesid);
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
            ],
          ),
        ),
      ),
    );
  }

//---------------Mobile Mode End-------------//

  List<DataColumn> _colGen(
    MonthlyWiseMenuReportsDataNotifier _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text("Sr No", style: tablecolumname),
          numeric: true,
          tooltip: "Sr No",
        ),
        DataColumn(
          label: Text('Menu Name', style: tablecolumname),
          tooltip: 'Menu Name',
        ),
        DataColumn(
          label: Text('Category', style: tablecolumname),
          tooltip: 'Category',
        ),
        DataColumn(
          label: Text('Quntity', style: tablecolumname),
          tooltip: 'Quntity',
        ),
        DataColumn(
          label: Text('Rate', style: tablecolumname),
          tooltip: 'Rate',
        ),
        DataColumn(
          label: Text('Total', style: tablecolumname),
          tooltip: 'Total',
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(Ehotelmenu sale) getField,
    int colIndex,
    bool asc,
    MonthlyWiseMenuReportsDataNotifier _provider,
  ) {
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(AllMenuList[index].menu_id.toString())),
      DataCell(Text(AllMenuList[index].Menu_Name)),
      DataCell(Text(AllMenuList[index].Menu_Cat_Name)),
      DataCell(Text(AllMenuList[index].Menu_Qty_Sum)),
      DataCell(Text(AllMenuList[index].Menu_Rate)),
      DataCell(Text(double.parse(AllMenuList[index].Menu_total_amount)
          .toStringAsFixed(2))),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < AllMenuList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  //-------------------------------------
//from server fetching sales data
  void _getTodaysmenu() async {
    setState(() {
      _showCircle = true;
    });
    AllMenuFetch allmenusales = new AllMenuFetch();
    var allmenusalesdata = await allmenusales.getAllMenuFetch();
    var resid = allmenusalesdata["resid"];

    if (resid == 200) {
      var rowcount = allmenusalesdata["rowcount"];
      if (rowcount > 0) {
        var AllMenuFetchsd = allmenusalesdata["todaysmenulist"];
        List<Ehotelmenu> temptodaymenulist = [];
        for (var n in AllMenuFetchsd) {
          Ehotelmenu pro = Ehotelmenu(
              n["sedate"] != null ? n["sedate"] : "",
              n["menuid"] != null ? n["menuid"] : "",
              n["Menuname"] != null ? n["Menuname"] : "",
              n["MenuCategoryid"] != null ? n["MenuCategoryid"] : "",
              n["MenuQuntitySum"] != null ? n["MenuQuntitySum"] : "",
              n["Menurate"] != null ? n["Menurate"] : "",
              n["Menutotalamount"] != null
                  ? n["Menutotalamount"].toString()
                  : "",
              n["Menucategory"] != null ? n["Menucategory"] : "");
          temptodaymenulist.add(pro);
          Provider.of<MonthlyWiseMenuReportsDataNotifier>(context,
                  listen: false)
              .addMonthlyWiseSalesBillData(pro);
        }

        setState(() {
          this.AllMenuList = temptodaymenulist;
          this.AllMenuListSearch = temptodaymenulist;
        });

        setState(() {
          _showCircle = false;
        });
        print("//////AllMenuList/////////$AllMenuList.length");
      } else {
        setState(() {
          _showCircle = false;
        });
        String msg = allmenusalesdata["message"];
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
      String msg = allmenusalesdata["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }

    SerachController.addListener(() {
      setState(() {
        if (AllMenuListSearch != null) {
          String s = SerachController.text;
          AllMenuList = AllMenuListSearch.where((element) =>
              element.menu_id
                  .toString()
                  .toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.Menu_Name.toLowerCase().contains(s.toLowerCase()) ||
              element.Menu_Cat_Name.toLowerCase().contains(s.toLowerCase()) ||
              element.Menu_Qty_Sum.toLowerCase().contains(s.toLowerCase()) ||
              element.Menu_Rate.toLowerCase().contains(s.toLowerCase()) ||
              element.Menu_total_amount.toString()
                  .toLowerCase()
                  .contains(s.toLowerCase())).toList();
        }
      });
    });
  }

//-------------------------------------
//from server Fetching Payment Mode Data
//   void _getSalesPaymentMode(String PaymentMode, String todaysDate) async {
//     TodaysSalesPaymentModeFetch todaysalespaymentmodefetch =
//         new TodaysSalesPaymentModeFetch();
//     var todaysalespaymentmodefetchData = await todaysalespaymentmodefetch
//         .getTodaysSalesPaymentModeFetch(PaymentMode, todaysDate);
//     var resid = todaysalespaymentmodefetchData["resid"];
//
//     if (resid == 200) {
//       var todaysalespaymentmodefetchsd =
//           todaysalespaymentmodefetchData["sales"];
//       print(todaysalespaymentmodefetchsd.length);
//       List<Sales> temptodaysalespaymentmodefetch = [];
//       for (var n in todaysalespaymentmodefetchsd) {
//         Sales pro = Sales.ManageList(
//             int.parse(n["SalesId"]),
//             n["SalesCustomername"],
//             n["SalesDate"],
//             n["SalesProductName"],
//             n["SalesProductRate"],
//             n["SalesProductQty"],
//             n["SalesProductSubTotal"],
//             n["SalesSubTotal"],
//             n["SalesDiscount"],
//             n["SalesGST"],
//             n["SalesTotalAmount"],
//             n["SalesNarration"],
//             n["SalesPaymentMode"],
//             n["SalesProductIDs"],
//             n["SalesPaymentCardType"],
//             n["SalesCardType"],
//             n["SalesNameonCard"],
//             n["SalesCardNumber"],
//             n["SalesBankName"],
//             n["SalesUPITransationNumber"]);
//         temptodaysalespaymentmodefetch.add(pro);
//       }
//       setState(() {
//         this.TodayBillList = temptodaysalespaymentmodefetch;
//       });
//       print("//////SalesList/////////$TodayBillList.length");
//     } else {
//       String message = todaysalespaymentmodefetchData["message"];
//       Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_SHORT,
//         backgroundColor: Colors.black38,
//         textColor: Color(0xffffffff),
//         gravity: ToastGravity.BOTTOM,
//       );
//     }
//   }
}
