import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_TodaysSales_PaymentMode_fetch.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_today_bill_fetch.dart';
import 'package:retailerp/Adpater/pos_Fetcing_Todays_Total_Amount.dart';
import 'package:retailerp/Adpater/pos_Fetcing_Todays_cashdebitUPI_Total_Amount.dart';
import 'package:retailerp/Adpater/pos_Paymentmode_todays_debitcredit_fetch.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/pages/add_sales_new.dart';
import 'package:retailerp/pages/todays_reports.dart';

import 'Day_Debit_Reports.dart';
import 'Day_UPI_Reports.dart';
import 'Day_cash_Reports.dart';
import 'Import_sales.dart';
import 'PaymentMode_Today_cash_Reports.dart';
import 'Paymentmode_Today_Debit_Reports.dart';
import 'Paymentmode_Todays_Credit_card_Reports.dart';
import 'Paymentmode_Todays_Debit_card_Reports.dart';
import 'Paymentmode_Todays_UPI_Reports.dart';
import 'Return_Sales_Dashboard.dart';
import 'View_Sales_Dashboard.dart';

class PaymentModeDayWiseReportsDashboard extends StatefulWidget {
  @override
  _PaymentModeDayWiseReportsDashboardState createState() =>
      _PaymentModeDayWiseReportsDashboardState();
}

class _PaymentModeDayWiseReportsDashboardState
    extends State<PaymentModeDayWiseReportsDashboard> {
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  List<Sales> TodayReportsList = new List();
  List<Sales> TodayCashReportsList = new List();
  List<Sales> TodayDebitReportsList = new List();
  List<Sales> TodayUPIReportsList = new List();
  List<Sales> TodayAmountReportsList = new List();
  List<Sales> TodayCashAmountReportsList = new List();
  List<Sales> TodayDebitAmountReportsList = new List();
  List<Sales> TodayUpiAmountReportsList = new List();
  List<Sales> TodayDebitCardList = new List();
  List<Sales> TodayCreditCardList = new List();
  List<double> TotalAmount = new List();
  List<double> CashTotalAmount = new List();
  List<double> DebitTotalAmount = new List();
  List<double> UpiTotalAmount = new List();
  String _selectdate;
  double TodaysTotalAmount;
  @override
  void initState() {
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    _getTodaysCashReports();
    _getTodaysDebitReports();
    _getTodaysUPIReports();
    _getTodaysSalesAmount();
    _getTodaysCashSalesAmount();
    _getTodaysDebitSalesAmount();
    _getTodaysUPISalesAmount();
    _getTodaysDebitCards();
    _getTodaysCreditCards();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobilePaymentModeDayWiseReportsDashboard();
    } else {
      content = _buildTabletPaymentModeDayWiseReportsDashboard();
    }

    return content;
  }

  //-------------------------------------------
  //---------------Tablet Mode Start-------------//
  Widget _buildTabletPaymentModeDayWiseReportsDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.moneyBill),
            SizedBox(
              width: 10.0,
            ),
            Text('Day Wise Payment Mode Reports'),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return PaymentModeTodayCashReports();
                          }));
                        },
                        child: Material(
                          color: SETTINGSBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '${TodayCashReportsList.length}',
                                  style: TextStyle(
                                    fontSize: 40.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Cash Reports',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          elevation: 10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return PaymentModeTodaysDebitReports();
                          }));
                        },
                        child: Material(
                          color: CUSTOMERBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '${TodayDebitReportsList.length}',
                                  style: TextStyle(
                                    fontSize: 40.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Debit Reports',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          elevation: 10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return PaymentModeTodayUPIReports();
                          }));
                        },
                        child: Material(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '${TodayUPIReportsList.length}',
                                  style: TextStyle(
                                    fontSize: 40.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'UPI Reports',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          elevation: 10.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50.0,
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Total Sales:- ${getIntSubtotal(TotalAmount).toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Total Cash:-${getIntSubtotal(CashTotalAmount).toStringAsFixed(2)},',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Total Debit:-${getIntSubtotal(DebitTotalAmount).toStringAsFixed(2)},',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Total UPI:-${getIntSubtotal(UpiTotalAmount).toStringAsFixed(2)},',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        elevation: 10.0,
                      ),
                    ),
                    SizedBox(
                      width: 50.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return PaymentModeTodayDebitCardsReports();
                          }));
                        },
                        child: Material(
                          elevation: 5.0,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.blueGrey,
                              child: Text(
                                "${TodayDebitCardList.length}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              "Debit Card",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return PaymentModeTodayCreditCardsReports();
                          }));
                        },
                        child: Material(
                          elevation: 5.0,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.blueGrey,
                              child: Text(
                                "${TodayCreditCardList.length}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              "Credit Card",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
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
  Widget _buildMobilePaymentModeDayWiseReportsDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.calendarDay),
            SizedBox(
              width: 10.0,
            ),
            Text('Day Wise Payment Reports'),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return PaymentModeTodayCashReports();
                          }));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: PURCHASEBG,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  '${TodayCashReportsList.length}',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Cash Reports',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          elevation: 10.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return PaymentModeTodaysDebitReports();
                          }));
                        },
                        child: Material(
                          color: PRODUCTBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  '${TodayDebitReportsList.length}',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Debit Reports',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          elevation: 10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return PaymentModeTodayUPIReports();
                          }));
                        },
                        child: Material(
                          color: CUSTOMERBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  '${TodayUPIReportsList.length}',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'UPI Reports',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          elevation: 10.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Total Sales:- ${getIntSubtotal(TotalAmount).toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Total Cash:-${getIntSubtotal(CashTotalAmount).toStringAsFixed(2)},',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Total Debit:-${getIntSubtotal(DebitTotalAmount).toStringAsFixed(2)},',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Total UPI:-${getIntSubtotal(UpiTotalAmount).toStringAsFixed(2)},',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        elevation: 10.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return PaymentModeTodayDebitCardsReports();
                          }));
                        },
                        child: Material(
                          color:Colors.amberAccent,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "${TodayDebitCardList.length}",
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Debit Cards',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          elevation: 10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return PaymentModeTodayCreditCardsReports();
                          }));
                        },
                        child: Material(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "${TodayCreditCardList.length}",
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Credit Cards',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          elevation: 10.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
//---------------Mobile Mode End-------------//

//from server fetching Todays sales data
  void _getTodaysReports(String TodaysDate) async {
    TodayBillFetch todaybillfetch = new TodayBillFetch();
    print("My Date //////////// $TodaysDate");
    var TodaybillData = await todaybillfetch.getTodayBillFetch(TodaysDate);
    var resid = TodaybillData["resid"];
    print("My res//// $resid");
    var todaybillsd = TodaybillData["sales"];
    print(todaybillsd.length);
    List<Sales> temptodayReports = [];
    for (var n in todaybillsd) {
      Sales pro = Sales(
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
          n["SalesPaymentMode"]);
      temptodayReports.add(pro);
    }
    setState(() {
      this.TodayReportsList = temptodayReports;
    });
    print("//////TodayBillList/////////$TodayReportsList.length");
  }

  //from server fetching Todays Cash sales data
  void _getTodaysCashReports() async {
    TodaysSalesPaymentModeFetch todaysalespaymentmodefetch =
        new TodaysSalesPaymentModeFetch();
    var todaysalespaymentmodefetchData = await todaysalespaymentmodefetch
        .getTodaysSalesPaymentModeFetch("CASH", _selectdate);
    var resid = todaysalespaymentmodefetchData["resid"];

    if (resid == 200) {
      var todaysalespaymentmodefetchsd =
          todaysalespaymentmodefetchData["sales"];
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
      });
      print("//////SalesList/////////$TodayCashReportsList.length");
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

  //from server fetching Todays Debit sales data
  void _getTodaysDebitReports() async {
    TodaysSalesPaymentModeFetch todaysalespaymentmodefetch =
        new TodaysSalesPaymentModeFetch();
    var todaysalespaymentmodefetchData = await todaysalespaymentmodefetch
        .getTodaysSalesPaymentModeFetch("DEBIT", _selectdate);
    var resid = todaysalespaymentmodefetchData["resid"];

    if (resid == 200) {
      var todaysalespaymentmodefetchsd =
          todaysalespaymentmodefetchData["sales"];
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
        this.TodayDebitReportsList = temptodaysalespaymentmodefetch;
      });
      print("//////SalesList/////////$TodayDebitReportsList.length");
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

  //from server fetching Todays UPI sales data
  void _getTodaysUPIReports() async {
    TodaysSalesPaymentModeFetch todaysalespaymentmodefetch =
        new TodaysSalesPaymentModeFetch();
    var todaysalespaymentmodefetchData = await todaysalespaymentmodefetch
        .getTodaysSalesPaymentModeFetch("UPI", _selectdate);
    var resid = todaysalespaymentmodefetchData["resid"];

    if (resid == 200) {
      var todaysalespaymentmodefetchsd =
          todaysalespaymentmodefetchData["sales"];
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
        this.TodayUPIReportsList = temptodaysalespaymentmodefetch;
      });
      print("//////SalesList/////////$TodayUPIReportsList.length");
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

  //from server fetching Todays Total sales  Amount data
  void _getTodaysSalesAmount() async {
    TodaysTotalAmountFetch todaystotalamountfetch =
        new TodaysTotalAmountFetch();
    var todaystotalamountfetchData =
        await todaystotalamountfetch.getTodaysTotalAmountFetch(_selectdate);
    var resid = todaystotalamountfetchData["resid"];

    if (resid == 200) {
      var todaystotalamountfetchsd = todaystotalamountfetchData["sales"];
      print(todaystotalamountfetchsd.length);
      List<Sales> temptodaysalespaymentmodefetch = [];
      for (var n in todaystotalamountfetchsd) {
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
        this.TodayAmountReportsList = temptodaysalespaymentmodefetch;
      });
      print("//////SalesList/////////$TodayAmountReportsList.length");

      List<double> tempTotalAmount = [];
      for (int i = 0; i < TodayAmountReportsList.length; i++) {
        tempTotalAmount.add(double.parse(TodayAmountReportsList[i].SalesTotal));
      }

      setState(() {
        TotalAmount = tempTotalAmount;
      });
      print("edoamvrojcptiupmv,i   $tempTotalAmount");
    } else {
      String message = todaystotalamountfetchData["message"];
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  //from server fetching Todays Total  cash sales  Amount data
  void _getTodaysCashSalesAmount() async {
    TodaysCashDebitUpiTotalAmountFetch todayscashdebitupitotalamountfetch =
        new TodaysCashDebitUpiTotalAmountFetch();
    var todayscashdebitupitotalamountfetchData =
        await todayscashdebitupitotalamountfetch
            .getTodaysCashDebitUpiTotalAmountFetch(_selectdate, "CASH");
    var resid = todayscashdebitupitotalamountfetchData["resid"];

    if (resid == 200) {
      var todayscashdebitupitotalamountfetchsd =
          todayscashdebitupitotalamountfetchData["sales"];
      print(todayscashdebitupitotalamountfetchsd.length);
      List<Sales> temptodayscashdebitupitotalamountfetch = [];
      for (var n in todayscashdebitupitotalamountfetchsd) {
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
        temptodayscashdebitupitotalamountfetch.add(pro);
      }
      setState(() {
        this.TodayCashAmountReportsList =
            temptodayscashdebitupitotalamountfetch;
      });
      print("//////SalesList/////////$TodayCashAmountReportsList.length");

      List<double> tempCashTotalAmount = [];
      for (int i = 0; i < TodayCashAmountReportsList.length; i++) {
        tempCashTotalAmount
            .add(double.parse(TodayCashAmountReportsList[i].SalesTotal));
      }

      setState(() {
        CashTotalAmount = tempCashTotalAmount;
      });
    } else {
      String message = todayscashdebitupitotalamountfetchData["message"];
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  //from server fetching Todays Total  Debit sales  Amount data
  void _getTodaysDebitSalesAmount() async {
    TodaysCashDebitUpiTotalAmountFetch todayscashdebitupitotalamountfetch =
        new TodaysCashDebitUpiTotalAmountFetch();
    var todayscashdebitupitotalamountfetchData =
        await todayscashdebitupitotalamountfetch
            .getTodaysCashDebitUpiTotalAmountFetch(_selectdate, "DEBIT");
    var resid = todayscashdebitupitotalamountfetchData["resid"];

    if (resid == 200) {
      var todayscashdebitupitotalamountfetchsd =
          todayscashdebitupitotalamountfetchData["sales"];
      print(todayscashdebitupitotalamountfetchsd.length);
      List<Sales> temptodayscashdebitupitotalamountfetch = [];
      for (var n in todayscashdebitupitotalamountfetchsd) {
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
        temptodayscashdebitupitotalamountfetch.add(pro);
      }
      setState(() {
        this.TodayDebitAmountReportsList =
            temptodayscashdebitupitotalamountfetch;
      });
      print("//////SalesList/////////$TodayDebitAmountReportsList.length");

      List<double> tempDebitTotalAmount = [];
      for (int i = 0; i < TodayDebitAmountReportsList.length; i++) {
        tempDebitTotalAmount
            .add(double.parse(TodayDebitAmountReportsList[i].SalesTotal));
      }

      setState(() {
        DebitTotalAmount = tempDebitTotalAmount;
      });
    } else {
      String message = todayscashdebitupitotalamountfetchData["message"];
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  //from server fetching Todays Total  Upi sales  Amount data
  void _getTodaysUPISalesAmount() async {
    TodaysCashDebitUpiTotalAmountFetch todayscashdebitupitotalamountfetch =
        new TodaysCashDebitUpiTotalAmountFetch();
    var todayscashdebitupitotalamountfetchData =
        await todayscashdebitupitotalamountfetch
            .getTodaysCashDebitUpiTotalAmountFetch(_selectdate, "UPI");
    var resid = todayscashdebitupitotalamountfetchData["resid"];

    if (resid == 200) {
      var todayscashdebitupitotalamountfetchsd =
          todayscashdebitupitotalamountfetchData["sales"];
      print(todayscashdebitupitotalamountfetchsd.length);
      List<Sales> temptodayscashdebitupitotalamountfetch = [];
      for (var n in todayscashdebitupitotalamountfetchsd) {
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
        temptodayscashdebitupitotalamountfetch.add(pro);
      }
      setState(() {
        this.TodayUpiAmountReportsList = temptodayscashdebitupitotalamountfetch;
      });
      print("//////SalesList/////////$TodayUpiAmountReportsList.length");

      List<double> tempUpiTotalAmount = [];
      for (int i = 0; i < TodayUpiAmountReportsList.length; i++) {
        tempUpiTotalAmount
            .add(double.parse(TodayUpiAmountReportsList[i].SalesTotal));
      }

      setState(() {
        UpiTotalAmount = tempUpiTotalAmount;
      });
    } else {
      String message = todayscashdebitupitotalamountfetchData["message"];
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }



  //from server fetching Todays Debit Cards sales data
  void _getTodaysDebitCards() async {
    TodaysDebitPaymentModeFetch todaysdebitpaymentmodefetch =
    new TodaysDebitPaymentModeFetch();
    var todaydebitpaymentmodefetchData = await todaysdebitpaymentmodefetch
        .getTodaysDebitPaymentModeFetch("Debit Card", _selectdate);
    var resid = todaydebitpaymentmodefetchData["resid"];

    if (resid == 200) {
      var todayDebitpaymentmodefetchsd =
      todaydebitpaymentmodefetchData["sales"];
      print(todayDebitpaymentmodefetchsd.length);
      List<Sales> temptodaydebitpaymentmodefetch = [];
      for (var n in todayDebitpaymentmodefetchsd) {
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
        temptodaydebitpaymentmodefetch.add(pro);
      }
      setState(() {
        this.TodayDebitCardList = temptodaydebitpaymentmodefetch;
      });
      print("//////TodayDebitCardList/////////$TodayDebitCardList.length");
    } else {
      String message = todaydebitpaymentmodefetchData["message"];
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }




  //from server fetching Todays Credit Cards sales data
  void _getTodaysCreditCards() async {
    TodaysDebitPaymentModeFetch todaysdebitpaymentmodefetch =
    new TodaysDebitPaymentModeFetch();
    var todaydebitpaymentmodefetchData = await todaysdebitpaymentmodefetch
        .getTodaysDebitPaymentModeFetch("Credit Card", _selectdate);
    var resid = todaydebitpaymentmodefetchData["resid"];

    if (resid == 200) {
      var todayDebitpaymentmodefetchsd =
      todaydebitpaymentmodefetchData["sales"];
      print(todayDebitpaymentmodefetchsd.length);
      List<Sales> temptodaydebitpaymentmodefetch = [];
      for (var n in todayDebitpaymentmodefetchsd) {
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
        temptodaydebitpaymentmodefetch.add(pro);
      }
      setState(() {
        this.TodayCreditCardList = temptodaydebitpaymentmodefetch;
      });
      print("//////TodayCreditCardList/////////$TodayCreditCardList.length");
    } else {
      String message = todaydebitpaymentmodefetchData["message"];
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }



//function for adding list Sum
  double getIntSubtotal(List<double> intamountList) {
    double Totaltemp = 0;
    for (int k = 0; k < intamountList.length; k++) {
      Totaltemp += intamountList[k];
    }
    return Totaltemp;
  }
}
