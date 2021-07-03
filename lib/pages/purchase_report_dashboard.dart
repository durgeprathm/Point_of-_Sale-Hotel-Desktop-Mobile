import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/pages/add_purchase_new.dart';
import 'package:retailerp/pages/purchase_productwise_report.dart';
import 'package:retailerp/pages/purchase_report.dart';
import 'package:retailerp/utils/const.dart';

import 'Add_Supliers.dart';
import 'Add_purchase.dart';
import 'Import_purchase.dart';
import 'Manage_Purchase.dart';
import 'Manage_Suppliers.dart';
import 'Puchase_Return_Dashboard.dart';

class PurchaseReportDashboard extends StatefulWidget {
  @override
  _PurchaseReportDashboardState createState() => _PurchaseReportDashboardState();
}

class _PurchaseReportDashboardState extends State<PurchaseReportDashboard> {
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
      content = _buildMobilePurchaseReportDashboard();
    } else {
      content = _buildTabletPurchaseReportDashboard();
    }

    return content;
  }
  //-------------------------------------------
  //---------------Tablet Mode Start-------------//
  Widget _buildTabletPurchaseReportDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.shoppingBag),
            SizedBox(
              width: 10.0,
            ),
            Text('Purchase Report'),
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
                            return PurchaseReport();
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
                                  'Over All Report',
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
                            return ProductwisePurchaseReport();
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
                                    'ProductWise Report',
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
                                    'ProductWise Report',
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
  Widget _buildMobilePurchaseReportDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.shoppingBag),
            SizedBox(
              width: 10.0,
            ),
            Text('Purchase Report'),
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
                            return PurchaseReport();
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
                                  'Over All Report',
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
                            return ProductwisePurchaseReport();
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
                                  'ProductWise Report',
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
