import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/pages/purchase_report_dashboard.dart';
import 'package:retailerp/pages/stocktransfer_report_dashboard.dart';
import 'package:retailerp/utils/const.dart';

import 'Menu_Wise_Reports_Dashboard.dart';
import 'Sales_Reports_Dashboard.dart';
import 'Stock_Wise_Reports_Dashboard.dart';
import 'Supplier_Reports_Dashboard.dart';
import 'consumption_report_dashboard.dart';

class ReportDashBoard extends StatefulWidget {
  @override
  _ReportDashBoardState createState() => _ReportDashBoardState();
}

class _ReportDashBoardState extends State<ReportDashBoard> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;


  Future<bool> _onBackPressed() async {
    return true;
  }


  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < kTabletBreakpoint) {
      content =_buildMobileReportDashBoard();
    } else {
      content = _buildTabletReportDashBoard();
    }

    return content;
  }

  //-------------------------------------------
  //---------------Tablet Mode Start-------------//
  Widget _buildTabletReportDashBoard() {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Report'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
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
                              return SalesReportsDashbaord();
                            }));
                          },
                          child: Material(
                            color:  Color(0xffE57373),
                            borderRadius: BorderRadius.circular(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.print,
                                    color: Colors.white,
                                    size: 50.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Sales Reports',
                                    style: dashboadrTextStyle,
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
                              return PurchaseReportDashboard();
                            }));

                          },
                          child: Material(
                            color: Color(0xff81C784),
                            borderRadius: BorderRadius.circular(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.print,
                                    color: Colors.white,
                                    size: 50.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Purchase Reports',
                                    style: dashboadrTextStyle,
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
                              return MenuWiseReportsDashboard();
                            }));
                          },
                          child: Material(
                            color: Color(0xff4DD0E1),
                            borderRadius: BorderRadius.circular(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.print,
                                    color: Colors.white,
                                    size: 50.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Menu Wise Report',
                                    style: dashboadrTextStyle,
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
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return SupplierReportsDashbaord();
                            }));
                          },
                          child: Material(
                            color: primary,
                            borderRadius: BorderRadius.circular(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.print,
                                    color: Colors.white,
                                    size: 50.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Leg Wise Report',
                                    style: dashboadrTextStyle,
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
                              return StockWiseReportsDashboard();
                            }));
                          },
                          child: Material(
                            color: EMPBG,
                            borderRadius: BorderRadius.circular(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.print,
                                    color: Colors.white,
                                    size: 50.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Stock Wise Report',
                                    style: dashboadrTextStyle,
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
                          },
                          child: Visibility(
                            visible: false,
                            child: Material(
                              color: SETTINGSBG,
                              borderRadius: BorderRadius.circular(10.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.print,
                                      color: Colors.white,
                                      size: 50.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'Consumption Report',
                                      style: dashboadrTextStyle,
                                    ),
                                  )
                                ],
                              ),
                              elevation: 10.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
//                  SizedBox(
//                    height: 30.0,
//                  ),
//                  Row(
//                    children: [
//
//                      SizedBox(
//                        width: 25.0,
//                      ),
//                      Expanded(
//                        child: GestureDetector(
//                          onTap: () {
//                            // Navigator.of(context)
//                            //     .push(MaterialPageRoute(builder: (_) {
//                            //   return PaymentModeWiseReportsDashbaord();
//                            // }));
//                          },
//                          child: Material(
//                            color: PRODUCTBG,
//                            borderRadius: BorderRadius.circular(10.0),
//                            child: Column(
//                              children: [
//                                Padding(
//                                  padding: const EdgeInsets.all(10.0),
//                                  child: FaIcon(
//                                    FontAwesomeIcons.print,
//                                    color: Colors.white,
//                                    size: 50.0,
//                                  ),
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.all(10.0),
//                                  child: Text(
//                                    'Payment Mode Report',
//                                    style: dashboadrTextStyle,
//                                  ),
//                                )
//                              ],
//                            ),
//                            elevation: 10.0,
//                          ),
//                        ),
//                      ),
//                      SizedBox(
//                        width: 25.0,
//                      ),
//                      Expanded(
//                        child: GestureDetector(
//                          onTap: () {
//                            // Navigator.of(context)
//                            //     .push(MaterialPageRoute(builder: (_) {
//                            //   return PaymentModeWiseReportsDashbaord();
//                            // }));
//                          },
//                          child: Visibility(
//                            visible: false,
//                            child: Material(
//                              color: Colors.black38,
//                              borderRadius: BorderRadius.circular(10.0),
//                              child: Column(
//                                children: [
//                                  Padding(
//                                    padding: const EdgeInsets.all(10.0),
//                                    child: FaIcon(
//                                      FontAwesomeIcons.print,
//                                      color: Colors.white,
//                                      size: 50.0,
//                                    ),
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.all(10.0),
//                                    child: Text(
//                                      'Payment Mode Report',
//                                      style: dashboadrTextStyle,
//                                    ),
//                                  )
//                                ],
//                              ),
//                              elevation: 10.0,
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
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
  Widget _buildMobileReportDashBoard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.shoppingBag),
            SizedBox(
              width: 10.0,
            ),
            Text('Reports'),
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
                            return PurchaseReportDashboard();
                          }));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: POSBG,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(FontAwesomeIcons.shoppingCart,
                                    size: 35.0, color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Purchase Reports',
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
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (_) {
                          //   return SalesReportsDashbaord();
                          // }));
                        },
                        child: Material(
                          color: SALESBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.print,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Sales Reports',
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
                  height: 25.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return MenuWiseReportsDashboard();
                          }));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: CUSTOMERBG,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(FontAwesomeIcons.productHunt,
                                    size: 35.0, color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Menu Wise Report',
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
                            return StockWiseReportsDashboard();
                          }));
                        },
                        child: Material(
                          color: PRODUCTCATBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.stackExchange,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Stock Wise Report',
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
                  height: 25.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (_) {
                          //   return PaymentModeWiseReportsDashbaord();
                          // }));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: REPROTGENBG,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(FontAwesomeIcons.moneyBill,
                                    size: 35.0, color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Payment Mode Wise Report',
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
                            return SupplierReportsDashbaord();
                          }));
                        },
                        child: Material(
                          color: PRODUCTRATEBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.print,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Supplier Wise Reports',
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

}
