import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_TodaysSales_PaymentMode_fetch.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_today_bill_fetch.dart';
import 'package:retailerp/Adpater/Fetch_All_Payment_Mode.php.dart';
import 'package:retailerp/Adpater/pos_sales_delete.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/Datatables/View_Todays_Bill_Source.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/POSUIONE/bill_reprint.dart';
import 'package:retailerp/Pagination_notifier/view_Todays_bill_datanotifier.dart';
import 'package:retailerp/models/PaymentMode.dart';
import 'package:retailerp/pages/Manage_Sales.dart';
import 'package:retailerp/pages/dashboard.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';

import 'Add_Sales.dart';
import 'Import_sales.dart';
import 'Preview_sales.dart';

class TodayBill extends StatefulWidget {
  @override
  _TodayBillState createState() => _TodayBillState();
}

class _TodayBillState extends State<TodayBill> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileTodayBill();
    } else {
      content = _buildTabletTodayBill();
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
  bool nodata = false;
  bool showspinner = false;
  bool sorting = false;
  String _selectdate;
  String PaymentMode;
  int sortingcount;
  //DatabaseHelper databaseHelper = DatabaseHelper();
  List<EhotelSales> TodayBillList = new List();
  List<EhotelSales> TodaysBillListSearch = new List();
  List<AllPaymentModeType> AllPaymentmodeList = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;

  List<String> ProductName = new List();
  List<String> RATE = new List();
  List<String> Quant = new List();
  List<String> ProSubtotal = new List();
  List<String> GSTPER = new List();
  TextEditingController _textPaymentmode = TextEditingController();

  @override
  void initState() {
    Provider.of<ViewTodayBillDataNotifier>(context, listen: false).clear();
    _getPaymentMode();
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    _getTodaysBill(_selectdate);
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletTodayBill() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.18;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.25;
    final _provider = context.watch<ViewTodayBillDataNotifier>();
    final _model = _provider.ViewTodayModel;
    final _dtSource = ViewTodaysBillDataTableSource(
        ViewTodaysBillData: _model, context: context);
    void handleClick(String value) {
      switch (value) {
        case 'Cash Bill':
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
            FaIcon(FontAwesomeIcons.calendar),
            SizedBox(
              width: 20.0,
            ),
            Text('Today\'s Bill'),
          ],
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Container(
                //width: tabletWidth,
                child: Text("Today\'s Date:- $_selectdate",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
          ),
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RetailerHomePage()));
            },
          ),
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
        child: SingleChildScrollView(
          child: Center(
              child: showspinner
                  ? Center(child: CircularProgressIndicator())
                  : nodata
                      ? Column(
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
                                      child: DropdownSearch<AllPaymentModeType>(
                                        searchBoxController: _textPaymentmode,
                                        isFilteredOnline: true,
                                        showClearButton: true,
                                        showSearchBox: true,
                                        items: AllPaymentmodeList,
                                        label: "Payment Mode",
                                        autoValidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        onSaved: (AllPaymentModeType value) {
                                          _textPaymentmode.text =
                                              value.PaymentModeName.toString();
                                        },
                                        onChanged: (value) {
                                          PaymentMode =
                                              value.PaymentModeId.toString();
                                          if (PaymentMode == "0" ||
                                              PaymentMode == null) {
                                            _getTodaysBill(_selectdate);
                                          } else {
                                            _getSalesPaymentMode(
                                                PaymentMode, _selectdate);
                                          }
                                          print(
                                              "//PaymentMode///////////////////${PaymentMode}");
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: DataTable(
                            //       columns: [
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
                            //         child: Text('Discount',
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
                            //       child: Container(
                            //         child: Text('Mode',
                            //             style: TextStyle(
                            //                 fontSize: 20,
                            //                 fontWeight: FontWeight.bold)),
                            //       ),
                            //     )),
                            //     DataColumn(
                            //         label: Expanded(
                            //       child: Container(
                            //         child: Text('Type',
                            //             style: TextStyle(
                            //                 fontSize: 20,
                            //                 fontWeight: FontWeight.bold)),
                            //       ),
                            //     )),
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
                        )
                      : Center(
                          child: Text('Data Not Available For Today',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        )),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobileTodayBill() {
    void handleClick(String value) {
      switch (value) {
        case 'Cash Bill':
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
            FaIcon(FontAwesomeIcons.calendar),
            SizedBox(
              width: 20.0,
            ),
            Text('Today\'s Bill'),
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
          // TodayBillList.length != 0
          //     ? IconButton(
          //   icon: Icon(Icons.print, color: Colors.white),
          //   onPressed: () {
          //     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          //       return TodaysReportPrint(1, TodayBillList);
          //     }));
          //   },
          // )
          //     : Text(''),
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
        child: SingleChildScrollView(
          child: Center(
            child: TodayBillList.length == 0
                ?
                // ? Padding(
                //     padding: const EdgeInsets.all(40.0),
                //     child: Material(
                //       shape: Border.all(color: Colors.blueGrey, width: 5),
                //       child: Padding(
                //         padding: const EdgeInsets.all(40.0),
                //         child: Text(
                //           "No Record Found !",
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 30.0,
                //               color: Colors.red),
                //         ),
                //       ),
                //     ),
                //   )
                Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: TodayBillList.length,
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
                                    "Bill No: ${TodayBillList[index].menusalesid.toString()} ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${TodayBillList[index].medate}",
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
                                Text("${TodayBillList[index].customername}",
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
                                    "Rs. ${TodayBillList[index].totalamount.toString()}",
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
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PreviewSales(
                                                index, TodayBillList)));
                                  },
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
                                //                     index, TodayBillList)
                                //         ));
                                //   },
                                //   icon: Icon(
                                //     Icons.edit,
                                //     color: Colors.green,
                                //   ),
                                // ),
                                IconButton(
                                  onPressed: () {
                                    _showMyDialog(
                                        TodayBillList[index].menusalesid);
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
      DataCell(Text(TodayBillList[index].menusalesid.toString())),
      DataCell(Text(TodayBillList[index].customername)),
      DataCell(Text(TodayBillList[index].discount)),
      DataCell(Text(TodayBillList[index].totalamount.toString())),
      DataCell(Text(TodayBillList[index].paymodename)),
      DataCell(Text(TodayBillList[index].accounttypename)),
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
                              PreviewSales(index, TodayBillList)));
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
                    ProductName = TodaysBillListSearch[index]
                        .menuname
                        .split("#")
                        .toList();
                    RATE = TodaysBillListSearch[index]
                        .menurate
                        .split("#")
                        .toList();
                    Quant = TodaysBillListSearch[index]
                        .menuquntity
                        .split("#")
                        .toList();
                    ProSubtotal = TodaysBillListSearch[index]
                        .menusubtotal
                        .split("#")
                        .toList();
                    GSTPER =
                        TodaysBillListSearch[index].menugst.split("#").toList();
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
                              TodaysBillListSearch[index].Subtotal.toString(),
                              TodaysBillListSearch[index].discount.toString(),
                              TodaysBillListSearch[index]
                                  .totalamount
                                  .toString(),
                              TodaysBillListSearch[index]
                                  .customername
                                  .toString(),
                              TodaysBillListSearch[index].medate.toString(),
                              TodayBillList[index].menusalesid.toString())));
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

    for (int i = 0; i < TodayBillList.length; i++) {
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
                  _getTodaysBill(_selectdate);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  List<DataColumn> _colGen(
    ViewTodayBillDataNotifier _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text("Bill NO",style: tablecolumname),
          numeric: true,
          tooltip: "Bill NO",
          onSort: (colIndex, asc) {
            _sort<num>((user) => int.parse(user.paypaymodeid), colIndex, asc,
                _provider);
          },
        ),
        DataColumn(
          label: Text('Customer Name',style: tablecolumname),
          tooltip: 'Customer Name',
          onSort: (colIndex, asc) {
            _sort<String>(
                (user) => user.customername, colIndex, asc, _provider);
          },
        ),
        DataColumn(
          label: Text('Date',style: tablecolumname),
          tooltip: 'Date',
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
          tooltip: 'Waiter',
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
    ViewTodayBillDataNotifier _provider,
  ) {
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  //-------------------------------------
//from server fetching sales data
  void _getTodaysBill(String TodaysDate) async {
    setState(() {
      showspinner = true;
    });
    TodayBillFetch todaybillfetch = new TodayBillFetch();
    var TodaybillData = await todaybillfetch.getTodayBillFetch(TodaysDate);
    print(TodaybillData);
    if (TodaybillData != null) {
      var resid = TodaybillData["resid"];
      if (resid == 200) {
        var rowcount = TodaybillData["rowcount"];
        print("rowcount///////////////${rowcount}");
        if (rowcount >= 1) {
          nodata = true;
          print("rowcount///////////////true");
          var todaybillsd = TodaybillData["todaysbilllist"];
          print(todaybillsd.length);
          List<EhotelSales> temptodayBill = [];
          for (var n in todaybillsd) {
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
            temptodayBill.add(pro);
            Provider.of<ViewTodayBillDataNotifier>(context, listen: false)
                .addSalesBillData(pro);
          }
          setState(() {
            this.TodayBillList = temptodayBill;
            this.TodaysBillListSearch = temptodayBill;
          });
          SerachController.addListener(() {
            setState(() {
              if (TodaysBillListSearch != null) {
                String s = SerachController.text;
                TodayBillList = TodaysBillListSearch.where((element) =>
                    element.menusalesid
                        .toString()
                        .toLowerCase()
                        .contains(s.toLowerCase()) ||
                    element.mobilenumber
                        .toLowerCase()
                        .contains(s.toLowerCase()) ||
                    element.totalamount
                        .toLowerCase()
                        .contains(s.toLowerCase()) ||
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
          setState(() {
            showspinner = false;
          });
        } else {
          print("rowcount///////////////false");
          setState(() {
            showspinner = false;
            nodata = false;
          });
        }
      }
    }
  }

//from server Fetching Payment Mode  Type Data
  void _getPaymentMode() async {
    FetchPaymentMode fetchpaymentmode = new FetchPaymentMode();
    var fetchpaymentmodeData = await fetchpaymentmode.getFetchPaymentMode();
    var resid = fetchpaymentmodeData["resid"];
    var fetchpaymentmodesd = fetchpaymentmodeData["Paymodenamelist"];
    print(fetchpaymentmodesd.length);
    List<AllPaymentModeType> tempfetchpaymentmode = [];
    AllPaymentModeType allpro = AllPaymentModeType(
      "0",
      "All",
    );
    tempfetchpaymentmode.add(allpro);
    for (var n in fetchpaymentmodesd) {
      AllPaymentModeType pro = AllPaymentModeType(
        n["paymentmodeid"],
        n["paymodename"],
      );
      tempfetchpaymentmode.add(pro);
    }
    setState(() {
      this.AllPaymentmodeList = tempfetchpaymentmode;
      print("//////AllPaymentmodeList/////////${AllPaymentmodeList.length}");
    });
  }

//from server Fetching Payment Mode Data
  void _getSalesPaymentMode(String PaymentMode, String todaysDate) async {
    TodaysSalesPaymentModeFetch todaysalespaymentmodefetch =
        new TodaysSalesPaymentModeFetch();
    var todaysalespaymentmodefetchData = await todaysalespaymentmodefetch
        .getTodaysSalesPaymentModeFetch(PaymentMode, todaysDate);
    var resid = todaysalespaymentmodefetchData["resid"];
    var rowcount = todaysalespaymentmodefetchData["rowcount"];
    if (resid == 200) {
      var todaysalespaymentmodefetchsd =
          todaysalespaymentmodefetchData["todayallsortbill"];
      print(todaysalespaymentmodefetchsd.length);
      List<EhotelSales> temptodaysalespaymentmodefetch = [];
      for (var n in todaysalespaymentmodefetchsd) {
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
        temptodaysalespaymentmodefetch.add(pro);
      }
      setState(() {
        this.TodayBillList = temptodaysalespaymentmodefetch;
        print("//////SalesList/////////$TodayBillList.length");
      });
    } else {
      String message = todaysalespaymentmodefetchData["message"];
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
