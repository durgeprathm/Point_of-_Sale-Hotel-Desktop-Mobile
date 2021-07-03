import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/pages/stocktransfer_Monthly_reports.dart';
import 'package:retailerp/pages/stocktransfer_Todays_reports.dart';



class StockTransferReportDashboard extends StatefulWidget {
  @override
  _StockTransferReportDashboardState createState() => _StockTransferReportDashboardState();
}

class _StockTransferReportDashboardState extends State<StockTransferReportDashboard> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;
  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery
        .of(context)
        .size
        .shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileStockTransferReportDashboard();
    } else {
      content = _buildTabletStockTransferReportDashboard();
    }

    return content;
  }
  //-------------------------------------------
  //---------------Tablet Mode Start-------------//
  Widget _buildTabletStockTransferReportDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.shoppingBag),
            SizedBox(
              width: 10.0,
            ),
            Text('Stock Transfer Reports'),
          ],
        ),
        // backgroundColor:APPBARRBG,
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
                            return StockTransferTodayReports();
                          }));
                        },
                        child: Material(
                          color: POSBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.shoppingCart,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Today\'s Stock Transfer Report',
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
                      width: 25.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return StockTransferMonthlyReports();
                          }));
                        },
                        child: Material(
                          color: SALESBG,
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
                                  'Over All Stock Transfer Report',
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
                      width: 25.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return StockTransferMonthlyReports();
                          }));
                        },
                        child: Visibility(
                          visible: false,
                          child: Material(
                            color: SALESBG,
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
                                    'Over All Stock Transfer Report',
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
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child:GestureDetector(
                //         onTap: () {
                //           Navigator.of(context)
                //               .push(MaterialPageRoute(builder: (_) {
                //             return ReturnPurchaseDashbaord();
                //           }));
                //         },
                //
                //         child: Material(
                //           color: Colors.blueGrey ,
                //           borderRadius: BorderRadius.circular(10.0),
                //           child:Column(
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.all(10.0),
                //                 child: FaIcon(FontAwesomeIcons.undoAlt,
                //                   color:Colors.white,
                //                   size: 50.0,
                //                 ),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.all(10.0),
                //                 child: Text('Purchse Return',
                //                   style: TextStyle(
                //                     fontSize: 30.0,
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 25.0,
                //     ),
                //     Expanded(
                //       child: GestureDetector(
                //         onTap: () {
                //           Navigator.of(context)
                //               .push(MaterialPageRoute(builder: (_) {
                //             return AddSupplierDetails();
                //           }));
                //         },
                //         child: Material(
                //           color: SETTINGSBG,
                //           borderRadius: BorderRadius.circular(10.0),
                //           child: Column(
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.all(10.0),
                //                 child: FaIcon(
                //                   FontAwesomeIcons.user,
                //                   color: Colors.white,
                //                   size: 50.0,
                //                 ),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.all(10.0),
                //                 child: Text(
                //                   'Add Supplier',
                //                   style: TextStyle(
                //                     fontSize: 30.0,
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.bold,
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
                //       width: 25.0,
                //     ),
                //     Expanded(
                //       child: GestureDetector(
                //         onTap: () {
                //           Navigator.of(context)
                //               .push(MaterialPageRoute(builder: (_) {
                //             return ManageSuppliers();
                //           }));
                //         },
                //         child: Material(
                //           color: PRODUCTRATEBG,
                //           borderRadius: BorderRadius.circular(10.0),
                //           child: Column(
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.all(10.0),
                //                 child: FaIcon(
                //                   FontAwesomeIcons.print,
                //                   color: Colors.white,
                //                   size: 50.0,
                //                 ),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.all(10.0),
                //                 child: Text(
                //                   'Manage Supplier',
                //                   style: TextStyle(
                //                     fontSize: 30.0,
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //           elevation: 10.0,
                //         ),
                //       ),
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
  Widget _buildMobileStockTransferReportDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.shoppingBag),
            SizedBox(
              width: 10.0,
            ),
            Text('Stock Transfer Reports'),
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
                            return StockTransferTodayReports();
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
                                  'Today\'s Stock Transfer Report',
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
                            return StockTransferMonthlyReports();
                          }));
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
                                  'Over All Stock Transfer Report',
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
                // Row(
                //   children: [
                //     Expanded(
                //       child: GestureDetector(
                //         onTap: () {
                //           Navigator.of(context)
                //               .push(MaterialPageRoute(builder: (_) {
                //             return ImportPurchase();
                //           }));
                //         },
                //
                //         child: Material(
                //           color: MENUBG,
                //           borderRadius: BorderRadius.circular(10.0),
                //           child: Column(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(10.0),
                //                 child: FaIcon(
                //                   FontAwesomeIcons.fileImport,
                //                   color: Colors.white,
                //                   size: 35.0,
                //                 ),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.all(10.0),
                //                 child: Text(
                //                   'Import Purchase',
                //                   style: TextStyle(
                //                       fontSize: 20.0,
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
                //       width: 25.0,
                //     ),
                //     Expanded(
                //       child: InkWell(
                //         onTap: () {
                //           Navigator.of(context)
                //               .push(MaterialPageRoute(builder: (_) {
                //             return ReturnPurchaseDashbaord();
                //           }));
                //         },
                //         child: Material(
                //           color: Colors.blueGrey,
                //           borderRadius: BorderRadius.circular(10.0),
                //           child: Column(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(10.0),
                //                 child: FaIcon(
                //                   FontAwesomeIcons.undoAlt,
                //                   color: Colors.white,
                //                   size: 35.0,
                //                 ),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.all(10.0),
                //                 child: Text(
                //                   'Purchse Return',
                //                   style: TextStyle(
                //                       fontSize: 20.0,
                //                       color: Colors.white,
                //                       fontWeight: FontWeight.bold),
                //                 ),
                //               )
                //             ],
                //           ),
                //           elevation: 10.0,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 15.0,
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: InkWell(
                //         onTap: () {
                //           Navigator.of(context)
                //               .push(MaterialPageRoute(builder: (_) {
                //             return AddSupplierDetails();
                //           }));
                //         },
                //         child: Material(
                //           color: SETTINGSBG,
                //           borderRadius: BorderRadius.circular(10.0),
                //           child: Column(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(10.0),
                //                 child: FaIcon(
                //                   FontAwesomeIcons.user,
                //                   color: Colors.white,
                //                   size: 35.0,
                //                 ),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.all(10.0),
                //                 child: Text(
                //                   'Add Supplier',
                //                   style: TextStyle(
                //                       fontSize: 20.0,
                //                       color: Colors.white,
                //                       fontWeight: FontWeight.bold),
                //                 ),
                //               )
                //             ],
                //           ),
                //           elevation: 10.0,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 25.0,
                //     ),
                //     Expanded(
                //       child: InkWell(
                //         onTap: () {
                //          Navigator.of(context)
                //              .push(MaterialPageRoute(builder: (_) {
                //            return ManageSuppliers();
                //          }));
                //         },
                //         child: Material(
                //           borderRadius: BorderRadius.circular(10.0),
                //           color: PRODUCTRATEBG,
                //           child: Column(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(10.0),
                //                 child: FaIcon(
                //                   FontAwesomeIcons.print,
                //                   size: 35.0,
                //                   color: Colors.white,
                //                 ),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.all(10.0),
                //                 child: Text(
                //                   'Manage Supplier',
                //                   style: TextStyle(
                //                       fontSize: 20.0,
                //                       color: Colors.white,
                //                       fontWeight: FontWeight.bold),
                //                 ),
                //               )
                //             ],
                //           ),
                //           elevation: 10.0,
                //         ),
                //       ),
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

}
