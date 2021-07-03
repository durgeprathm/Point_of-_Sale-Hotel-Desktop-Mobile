
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_TodaysSales_PaymentMode_fetch.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/pages/todays_reports.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';

import 'Add_Sales.dart';
import 'Day_Debit_Reports.dart';
import 'Day_UPI_Reports.dart';
import 'Import_sales.dart';
import 'Todays_UPI_Reports_Print.dart';

class PaymentModeTodayCashReports extends StatefulWidget {
  @override
  _PaymentModeTodayCashReportsState createState() => _PaymentModeTodayCashReportsState();
}

class _PaymentModeTodayCashReportsState extends State<PaymentModeTodayCashReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobilePaymentModeTodayCashReports();
    } else {
      content = _buildTabletPaymentModeTodayCashReports();
    }

    return content;
  }
  bool _showCircle = false;
  Widget appBarTitle = Text("Cash Report");
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
//-------------------------------------------
  DateTime fromValue = DateTime.now();
  DateTime toValue = DateTime.now();
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;
  final dateFormat = DateFormat("yyyy-MM-dd");
  final initialValue = DateTime.now();

  //DatabaseHelper databaseHelper = DatabaseHelper();
  List<Sales> CashBillDateWiseList = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;

  List<Sales> TodayCashReportsList = new List();
  List<Sales> TodayCashReportsListSearch = new List();
 String _selectdate;
  @override
  void initState() {
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    _getTodaysCashReports();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletPaymentModeTodayCashReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.30;
    void handleClick(String value) {
      switch (value) {
        case 'Debit Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TodaysDebitReports()));
          break;
        case 'UPI Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TodayUPIReports()));
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
            Text('Today\'s Cash Reports'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15.0, horizontal: 20.0),
            child: Container(
              //width: tabletWidth,
                child:Text("Today\'s Date:- $_selectdate",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white))
            ),
          ),
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          // TodayCashReportsList.length != 0
          //     ? IconButton(
          //   icon: Icon(Icons.print, color: Colors.white),
          //   onPressed: () {
          //     Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (_) {
          //       return TodaysUPIReportPrint(1, TodayCashReportsList);
          //     }));
          //   },
          // )
          //     : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
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
              child: TodayCashReportsList.length == 0
                  ?
              Center(child: CircularProgressIndicator())
                  : Column(children: [
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable(columns: [
                    DataColumn(
                        label: Expanded(
                          child: Container(
                            width: 50,
                            child: Text('Sr No',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )),
                    DataColumn(
                        label: Expanded(
                          child: Container(
                            width: 200,
                            child: Text('Customer Name',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )),
                    DataColumn(
                        label: Expanded(
                          child: Container(
                            child: Text('Date',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )),
                    DataColumn(
                        label: Expanded(
                          child: Container(
                            child: Text('Discount',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )),
                    DataColumn(
                        label: Expanded(
                          child: Container(
                            child: Text('Total',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )),
                    DataColumn(
                        label: Expanded(
                          child: Container(
                            child: Text('Mode',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )),
                  ], rows: getDataRowList()),
                ),
              ],
              )
          ),
        ),
      ),
    );

  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobilePaymentModeTodayCashReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Debit Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TodaysDebitReports()));
          break;
        case 'UPI Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TodayUPIReports()));
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
                        controller: SerachController,
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
                        "Cash Report",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      );
                      SerachController.clear();
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
              // TodayCashReportsList.length != 0
              //     ? IconButton(
              //   icon: Icon(Icons.print, color: Colors.white),
              //   onPressed: () {
              //     Navigator.of(context)
              //         .push(MaterialPageRoute(builder: (_) {
              //       return TodaysUPIReportPrint(1, TodayCashReportsList);
              //     }));
              //   },
              // )
              //     : Text(''),
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {
                    'Today\'s Reports',
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
        ],
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _showCircle,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Divider(),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: TodayCashReportsList.length,
                        itemBuilder: (context, index) {
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
                                        "Bill No:- ${TodayCashReportsList[index].Salesid.toString()} ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${TodayCashReportsList[index].SalesDate}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14.0,
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
                                        Text("Customer Name:",
                                            style: headHintTextStyle),
                                        Text(
                                            "${TodayCashReportsList[index].SalesCustomername}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Total Amount:",
                                            style: headHintTextStyle),
                                        Text(
                                            "Rs.${TodayCashReportsList[index].SalesTotal.toString()}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Payment Mode:",
                                            style: headHintTextStyle),
                                        Text(
                                            "${TodayCashReportsList[index].SalesPaymentMode.toString()}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
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
      ),
    );
  }

//---------------Mobile Mode End-------------//

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(TodayCashReportsList[index].Salesid.toString())),
      DataCell(Text(TodayCashReportsList[index].SalesCustomername)),
      DataCell(Text(TodayCashReportsList[index].SalesDate)),
      DataCell(Text(TodayCashReportsList[index].SalesDiscount.toString())),
      DataCell(Text(TodayCashReportsList[index].SalesTotal.toString())),
      DataCell(Text(TodayCashReportsList[index].SalesPaymentMode)),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < TodayCashReportsList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }



  //-------------------------------------
//from server fetching All Cash Data
  void _getTodaysCashReports() async {
    TodaysSalesPaymentModeFetch todaysalespaymentmodefetch = new TodaysSalesPaymentModeFetch();
    var todaysalespaymentmodefetchData = await todaysalespaymentmodefetch.getTodaysSalesPaymentModeFetch("CASH",_selectdate);
    var resid = todaysalespaymentmodefetchData["resid"];

    if (resid == 200) {
      var todaysalespaymentmodefetchsd = todaysalespaymentmodefetchData["sales"];
      print(todaysalespaymentmodefetchsd.length);
      List<Sales> temptodaysalespaymentmodefetch = [];
      for (var n in todaysalespaymentmodefetchsd) {
        Sales pro = Sales.ManageList(
            int.parse(n["SalesId"]),
            n["SalesCustomername"],
            n["SalesDate"],
            n["SalesProductName"],
            n["SalesProductRate"],
            n["SalesProductQty"],
            n["SalesProductSubTotal"],
            n["SalesSubTotal"],
            n["SalesDiscount"],
            n["SalesGST"],
            n["SalesTotalAmount"],
            n["SalesNarration"],
            n["SalesPaymentMode"],
            n["SalesProductIDs"],
            n["SalesPaymentCardType"],
            n["SalesCardType"],
            n["SalesNameonCard"],
            n["SalesCardNumber"],
            n["SalesBankName"],
            n["SalesUPITransationNumber"]);
        temptodaysalespaymentmodefetch.add(pro);
      }
      setState(() {
        this.TodayCashReportsList = temptodaysalespaymentmodefetch;
        this.TodayCashReportsListSearch = temptodaysalespaymentmodefetch;
      });
      print("//////TodayCashReportsList/////////$TodayCashReportsList.length");




      SerachController.addListener(() {
        setState(() {
          if(TodayCashReportsListSearch != null){
            String s = SerachController.text;
            TodayCashReportsList = TodayCashReportsListSearch.where((element) => element.Salesid.toString().toLowerCase().contains(s.toLowerCase()) || element.SalesCustomername.toLowerCase().contains(s.toLowerCase()) ||element.SalesDiscount.toLowerCase().contains(s.toLowerCase()) ||element.SalesTotal.toLowerCase().contains(s.toLowerCase()) ||element.SalesPaymentMode.toString().toLowerCase().contains(s.toLowerCase())).toList();
          }
        });
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
//-------------------------------------

}
