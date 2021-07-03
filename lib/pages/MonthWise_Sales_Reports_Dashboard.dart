import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_month_wise_bill_fetch.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_todays_bill_count_fetch.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/models/Sales.dart';


import 'All_Debit_Reports.dart';
import 'All_Reports.dart';
import 'All_Upi_Reports.dart';
import 'All_cash_Reports.dart';


class MonthWiseSalesReportsDashboard extends StatefulWidget {
  @override
  _MonthWiseSalesReportsDashboardState createState() =>
      _MonthWiseSalesReportsDashboardState();
}

class _MonthWiseSalesReportsDashboardState
    extends State<MonthWiseSalesReportsDashboard> {
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  List<AllbillCountDetails> AllBillCountList = new List();
  List<Sales> TodayCashReportsList = new List();
  List<Sales> TodayDebitReportsList = new List();
  List<Sales> TodayUPIReportsList = new List();
  List<Sales> TodayAmountReportsList = new List();
  List<Sales> TodayCashAmountReportsList = new List();
  List<Sales> TodayDebitAmountReportsList = new List();
  List<Sales> TodayUpiAmountReportsList = new List();
  List<double> TotalAmount = new List();
  List<double> CashTotalAmount = new List();
  List<double> DebitTotalAmount = new List();
  List<double> UpiTotalAmount = new List();
  String _selectdate;
  double TodaysTotalAmount;
  @override
  void initState() {
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    _getAllbillcountList();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileMonthWiseSalesReportsDashboard();
    } else {
      content = _buildTabletMonthWiseSalesReportsDashboard();
    }

    return content;
  }

  //-------------------------------------------
  //---------------Tablet Mode Start-------------//
  Widget _buildTabletMonthWiseSalesReportsDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.calendar),
            SizedBox(
              width: 10.0,
            ),
            Text('Month Wise Sales Reports'),
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
                            return AllReports();
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
                                  '${AllBillCountList[0].Allbill}',
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
                                  'All Reports',
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
                            return AllCashReports();
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
                                  '${AllBillCountList[0].Allbillcash}',
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
                            return AllDebitReports();
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
                                  '${AllBillCountList[0].Allbilldebit}',
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
                            return AllUpiReports();
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
                                  '${AllBillCountList[0].Allbillupi}',
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
    );
  }

  //---------------Tablet Mode End-------------//
  //---------------Mobile Mode Start-------------//
  Widget _buildMobileMonthWiseSalesReportsDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.calendar),
            SizedBox(
              width: 10.0,
            ),
            Text('Month Wise Sales Reports'),
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
                            return AllReports();
                          }));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: PURCHASEBG,
                          child: Column(
                            children: [
                              Text(
                                '${AllBillCountList[0].Allbill}',
                                style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'All Reports',
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
                            return AllCashReports();
                          }));
                        },
                        child: Material(
                          color: PRODUCTBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Text(
                                '${AllBillCountList[0].Allbillcash}',
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
                            return AllDebitReports();
                          }));
                        },
                        child: Material(
                          color: CUSTOMERBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Text(
                                '${AllBillCountList[0].Allbilldebit}',
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
                            return AllUpiReports();
                          }));
                        },
                        child: Material(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Text(
                                '${AllBillCountList[0].Allbillupi}',
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

//from server fetching  sales data
  _getAllbillcountList() async {
    SalesFetchAllDetails allcountbill = new SalesFetchAllDetails();
    var response = await allcountbill.getSalesFetch("4");
    var Countbillsd = response["Billcount"];
    List<AllbillCountDetails> tempCountList = [];

    for (var n in Countbillsd) {
      AllbillCountDetails allbillcount = AllbillCountDetails(
          n["allbillcount"],
          n["allCashbillcount"],
          n["alldebitbillcount"],
          n["allupibillcount"]);
      tempCountList.add(allbillcount);
    }

    setState(() {
      AllBillCountList = tempCountList;
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
}


class AllbillCountDetails {
  final int Allbill;
  final int Allbillcash;
  final int Allbilldebit;
  final int Allbillupi;


  AllbillCountDetails(this.Allbill, this.Allbillcash, this.Allbilldebit,
      this.Allbillupi);
}