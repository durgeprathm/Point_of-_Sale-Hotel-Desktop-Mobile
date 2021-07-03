import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_todays_bill_count_fetch.dart';
import 'package:retailerp/Adpater/pos_Fetcing_Todays_cashdebitUPI_Total_Amount.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/pages/todays_reports.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';

import 'Day_Debit_Reports.dart';
import 'Day_UPI_Reports.dart';
import 'Day_cash_Reports.dart';



class DayWiseSalesReportsDashboard extends StatefulWidget {
  @override
  _DayWiseSalesReportsDashboardState createState() =>
      _DayWiseSalesReportsDashboardState();
}

class _DayWiseSalesReportsDashboardState
    extends State<DayWiseSalesReportsDashboard> {
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;
  List<AllbillCountDetails> AllBillCountList;
  List<Sales> TodayAmountReportsList ;
  List<Sales> TodayCashAmountReportsList;
  List<Sales> TodayDebitAmountReportsList ;
  List<Sales> TodayUpiAmountReportsList;
  List<double> TotalAmount ;
  List<double> CashTotalAmount ;
  List<double> DebitTotalAmount ;
  List<double> UpiTotalAmount ;
  String _selectdate;
  double TodaysTotalAmount;
  bool showSpinner = false;
  TodaysCashDebitUpiTotalAmountFetch todayscashdebitupitotalamountfetch =
  new TodaysCashDebitUpiTotalAmountFetch();
  TodayCountBillFetch todaycountbill = new TodayCountBillFetch();


  @override
  void initState() {
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    _getAllbillcountList(_selectdate);
    _getTodaysCashSalesAmount();
    _getTodaysDebitSalesAmount();
    _getTodaysUPISalesAmount();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileDayWiseSalesReportsDashboard();
    } else {
      content = _buildTabletDayWiseSalesReportsDashboard();
    }

    return content;
  }

  //-------------------------------------------
  //---------------Tablet Mode Start-------------//
  Widget _buildTabletDayWiseSalesReportsDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.calendarDay),
            SizedBox(
              width: 10.0,
            ),
            Text('Day Wise Sales Reports'),
          ],
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
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
                              return TodaysReports();
                            }));
                          },
                          child: Material(
                            color: PURCHASEBG,
                            borderRadius: BorderRadius.circular(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    AllBillCountList.length == 0 ? "0" :
                                    '${AllBillCountList[0].todaysAll}',
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
                                    'Today\'s Reports',
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
                              return DayCashReports();
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
                                    AllBillCountList.length == 0 ? "0" :
                                    '${AllBillCountList[0].todayscash}',
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
                              return TodaysDebitReports();
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
                                    AllBillCountList.length == 0 ? "0" :
                                    '${AllBillCountList[0].todaysdebit}',
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
                              return TodayUPIReports();
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
                                    AllBillCountList.length == 0 ? "0" :
                                    '${AllBillCountList[0].todaysupi}',
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
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 80.0,
                  //     ),
                  //     Expanded(
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           Navigator.of(context)
                  //               .push(MaterialPageRoute(builder: (_) {
                  //             return DayCashReports();
                  //           }));
                  //         },
                  //         child: Material(
                  //           color: PRODUCTBG,
                  //           borderRadius: BorderRadius.circular(10.0),
                  //           child: Column(
                  //             children: [
                  //               Padding(
                  //                 padding: const EdgeInsets.all(10.0),
                  //                 child: Text(
                  //                   'Total Sales:- ${getIntSubtotal(TotalAmount).toStringAsFixed(3)}',
                  //                   style: TextStyle(
                  //                     fontSize: 40.0,
                  //                     color: Colors.white,
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //                 ),
                  //               ),
                  //               Padding(
                  //                 padding: const EdgeInsets.all(10.0),
                  //                 child: Text(
                  //                   'Total Cash:-${getIntSubtotal(CashTotalAmount).toStringAsFixed(3)}',
                  //                   style: TextStyle(
                  //                     fontSize: 30.0,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               ),
                  //               Padding(
                  //                 padding: const EdgeInsets.all(10.0),
                  //                 child: Text(
                  //                   'Total Debit:-${getIntSubtotal(DebitTotalAmount).toStringAsFixed(3)}',
                  //                   style: TextStyle(
                  //                     fontSize: 30.0,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               ),
                  //               Padding(
                  //                 padding: const EdgeInsets.all(10.0),
                  //                 child: Text(
                  //                   'Total UPI:-${getIntSubtotal(UpiTotalAmount).toStringAsFixed(3)}',
                  //                   style: TextStyle(
                  //                     fontSize: 30.0,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //           elevation: 10.0,
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 80.0,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //---------------Tablet Mode End-------------//
  //---------------Mobile Mode Start-------------//
  Widget _buildMobileDayWiseSalesReportsDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.calendarDay),
            SizedBox(
              width: 10.0,
            ),
            Text('Day Wise Sales Reports'),
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
                            return TodaysReports();
                          }));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: PURCHASEBG,
                          child: Column(
                            children: [
                              Text(
                                AllBillCountList == null ? "0" :
                                '${AllBillCountList[0].todaysAll}',
                                style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Today\'s Reports',
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
                            return DayCashReports();
                          }));
                        },
                        child: Material(
                          color: PRODUCTBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Text(
                                AllBillCountList == null ? "0" :
                                '${AllBillCountList[0].todayscash}',
                                style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Cash Reports',
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
                            return TodaysDebitReports();
                          }));
                        },
                        child: Material(
                          color: CUSTOMERBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Text(
                                AllBillCountList == null ? "0" :
                                '${AllBillCountList[0].todaysdebit}',
                                style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Debit Reports',
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
                    SizedBox(
                      width: 25.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return TodayUPIReports();
                          }));
                        },
                        child: Material(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Text(
                                AllBillCountList == null ? "0" :
                                '${AllBillCountList[0].todaysupi}',
                                style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'UPI Reports',
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
                  height: 35.0,
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: GestureDetector(
                //         onTap: () {
                //           Navigator.of(context)
                //               .push(MaterialPageRoute(builder: (_) {
                //             return ImportSales();
                //           }));
                //         },
                //         child: Material(
                //           color: PRODUCTBG,
                //           borderRadius: BorderRadius.circular(10.0),
                //           child: Column(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(10.0),
                //                 child: Text(
                //                   'Total Sales:- ${getIntSubtotal(TotalAmount).toStringAsFixed(3)}',
                //                   style: TextStyle(
                //                       fontSize: 30.0,
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.white),
                //                 ),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.all(10.0),
                //                 child: Text(
                //                   'Total Cash:-${getIntSubtotal(CashTotalAmount).toStringAsFixed(3)}',
                //                   style: TextStyle(
                //                       fontSize: 30.0,
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.white),
                //                 ),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.all(10.0),
                //                 child: Text(
                //                   'Total Debit:-${getIntSubtotal(DebitTotalAmount).toStringAsFixed(3)}',
                //                   style: TextStyle(
                //                       fontSize: 30.0,
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.white),
                //                 ),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.all(10.0),
                //                 child: Text(
                //                   'Total UPI:-${getIntSubtotal(UpiTotalAmount).toStringAsFixed(3)}',
                //                   style: TextStyle(
                //                       fontSize: 30.0,
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.white),
                //                 ),
                //               )
                //             ],
                //           ),
                //           elevation: 10.0,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 15.0,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
//---------------Mobile Mode End-------------//


  //from server fetching Todays Total  cash sales  Amount data
  void _getTodaysCashSalesAmount() async {

    setState(() {
      showSpinner = true;
    });


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

    setState(() {
      showSpinner = false;
    });

  }

  //from server fetching Todays Total  Debit sales  Amount data
  void _getTodaysDebitSalesAmount() async {

    setState(() {
      showSpinner = true;
    });

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
    setState(() {
      showSpinner = false;
    });
  }

  //from server fetching Todays Total  Upi sales  Amount data
  void _getTodaysUPISalesAmount() async {

    setState(() {
      showSpinner = true;
    });

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

    setState(() {
      showSpinner = false;
    });

  }

//function for adding list Sum
  double getIntSubtotal(List<double> intamountList) {
    double Totaltemp = 0;
    for (int k = 0; k < intamountList.length; k++) {
      Totaltemp += intamountList[k];
    }
    return Totaltemp;
  }


  _getAllbillcountList(String TodaysDate) async {

    setState(() {
      showSpinner = true;
    });
    var response = await todaycountbill.getTodayCountBillFetch(TodaysDate);
    var Countbillsd = response["Billcount"];
    List<AllbillCountDetails> tempCountList = [];

    for (var n in Countbillsd) {
      AllbillCountDetails allbillcount = AllbillCountDetails(
          n["todayallbillcount"],
          n["todayCashbillcount"],
          n["todaydebitbillcount"],
          n["todayupibillcount"]);
      tempCountList.add(allbillcount);
    }

    setState(() {
      AllBillCountList = tempCountList;
    });

    setState(() {
      showSpinner = false;
    });
  }
}


class AllbillCountDetails {
  final int todaysAll;
  final int todayscash;
  final int todaysdebit;
  final int todaysupi;


  AllbillCountDetails(this.todaysAll, this.todayscash, this.todaysdebit,
      this.todaysupi);
}