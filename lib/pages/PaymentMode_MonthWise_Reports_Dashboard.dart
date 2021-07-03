import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos-view_upi-bill_fetch.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_cash_bill_fetch.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_sales_fetch.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_view_debit_bill_fetch.dart';
import 'package:retailerp/Adpater/pos_Paymentmode_All_debitcredit_fetch.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/models/Sales.dart';

import 'PaymentMode_All_Debit_Reports.dart';
import 'PaymentMode_All_cash_Reports.dart';
import 'Paymentmode_All_Credit_card_Reports.dart';
import 'Paymentmode_All_Debit_card_Reports.dart';
import 'Paymentmode_All_Upi_Reports.dart';


class PaymentModeMonthWiseReportsDashboard extends StatefulWidget {
  @override
  _PaymentModeMonthWiseReportsDashboardState createState() =>
      _PaymentModeMonthWiseReportsDashboardState();
}

class _PaymentModeMonthWiseReportsDashboardState
    extends State<PaymentModeMonthWiseReportsDashboard> {
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
  List<Sales> AllDebitCardList = new List();
  List<Sales> AllCreditCardList = new List();
  List<double> TotalAmount = new List();
  List<double> CashTotalAmount = new List();
  List<double> DebitTotalAmount = new List();
  List<double> UpiTotalAmount = new List();
  String _selectdate;
  double TodaysTotalAmount;
  @override
  void initState() {
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    _getAllReports();
    _getCashReports("1","","");
    _getDebitReports();
    _getUPIReports();
    _getDebitCards();
    _getCreditCards();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobilePaymentModeMonthWiseReportsDashboard();
    } else {
      content = _buildTabletPaymentModeMonthWiseReportsDashboard();
    }

    return content;
  }

  //-------------------------------------------
  //---------------Tablet Mode Start-------------//
  Widget _buildTabletPaymentModeMonthWiseReportsDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.moneyBill),
            SizedBox(
              width: 10.0,
            ),
            Text('Month Wise Payment Reports'),
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
                            return PaymentModeAllCashReports();
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
                            return PaymentModeAllDebitReports();
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
                            return PaymentModeAllUpiReports();
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
                            return PaymentModeAllDebitCardsReports();
                          }));
                        },
                        child: Material(
                          elevation: 5.0,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.blueGrey,
                              child: Text(
                                "${AllDebitCardList.length}",
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
                            return PaymentModeAllCreditCardsReports();
                          }));
                        },
                        child: Material(
                          elevation: 5.0,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.blueGrey,
                              child: Text(
                                "${AllCreditCardList.length}",
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
  Widget _buildMobilePaymentModeMonthWiseReportsDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.shoppingBag),
            SizedBox(
              width: 10.0,
            ),
            Text('Month Wise Payment Reports'),
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
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return PaymentModeAllCashReports();
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
                    SizedBox(
                      width: 25.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return PaymentModeAllDebitReports();
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
                            return PaymentModeAllUpiReports();
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return PaymentModeAllDebitCardsReports();
                          }));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color:Colors.pink,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  '${AllDebitCardList.length}',
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
                    SizedBox(
                      width: 25.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return PaymentModeAllCreditCardsReports();
                          }));
                        },
                        child: Material(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  '${AllCreditCardList.length}',
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
  void _getAllReports() async {
    SalesFetch todaybillfetch = new SalesFetch();
    var TodaybillData = await todaybillfetch.getSalesFetch("1");
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
  void _getCashReports(String allrecords,String firstdate,String lastdate) async {
    CashBillFetch todaysalespaymentmodefetch = new CashBillFetch();
    var todaysalespaymentmodefetchData =
        await todaysalespaymentmodefetch.getCashBillFetch(allrecords,firstdate,lastdate);
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
  void _getDebitReports() async {
    DebitBillFetch todaysalespaymentmodefetch = new DebitBillFetch();
    var todaysalespaymentmodefetchData =
        await todaysalespaymentmodefetch.getDebitBillFetch("1");
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
  void _getUPIReports() async {
    UpiBillFetch todaysalespaymentmodefetch = new UpiBillFetch();
    var todaysalespaymentmodefetchData =
        await todaysalespaymentmodefetch.getUpiBillFetch();
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

  //from server fetching All Debit Cards sales data
  void _getDebitCards() async {
    AllDebitCreditPaymentModeFetch alldebitpaymentmodefetch =
    new AllDebitCreditPaymentModeFetch();
    var AllpaymentmodefetchData = await alldebitpaymentmodefetch
        .getAllDebitCreditPaymentModeFetch("Debit Card");
    var resid = AllpaymentmodefetchData["resid"];

    if (resid == 200) {
      var Allpaymentmodefetchsd =
      AllpaymentmodefetchData["sales"];
      print(Allpaymentmodefetchsd.length);
      List<Sales> tempalldebitpaymentmodefetch = [];
      for (var n in Allpaymentmodefetchsd) {
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
        tempalldebitpaymentmodefetch.add(pro);
      }
      setState(() {
        this.AllDebitCardList = tempalldebitpaymentmodefetch;
      });
      print("//////AllDebitCardList/////////$AllDebitCardList.length");
    } else {
      String message = AllpaymentmodefetchData["message"];
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }


  //from server fetching All Credit Cards sales data
  void _getCreditCards() async {
    AllDebitCreditPaymentModeFetch alldebitpaymentmodefetch =
    new AllDebitCreditPaymentModeFetch();
    var allCreditpaymentmodefetchData = await alldebitpaymentmodefetch
        .getAllDebitCreditPaymentModeFetch("Credit Card");
    var resid = allCreditpaymentmodefetchData["resid"];

    if (resid == 200) {
      var allCreditpaymentmodefetchsd =
      allCreditpaymentmodefetchData["sales"];
      print(allCreditpaymentmodefetchsd.length);
      List<Sales> tempalldebitpaymentmodefetch = [];
      for (var n in allCreditpaymentmodefetchsd) {
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
        tempalldebitpaymentmodefetch.add(pro);
      }
      setState(() {
        this.AllCreditCardList = tempalldebitpaymentmodefetch;
      });
      print("//////AllCreditCardList/////////$AllCreditCardList.length");
    } else {
      String message = allCreditpaymentmodefetchData["message"];
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
