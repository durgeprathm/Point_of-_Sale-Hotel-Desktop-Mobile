import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/pages/add_sales_new.dart';
import 'package:retailerp/utils/const.dart';


import 'Import_sales.dart';
import 'Return_Sales_Dashboard.dart';
import 'Take _Return_Sales.dart';
import 'View_Sales_Dashboard.dart';

class SalesDashboard extends StatefulWidget {
  bool usertypecheck;
  SalesDashboard(this.usertypecheck);
  @override
  _SalesDashboardState createState() => _SalesDashboardState();
}

class _SalesDashboardState extends State<SalesDashboard> {
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;
  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileSalesDashboard();
    } else {
      content = _buildTabletSalesDashboard();
    }

    return content;
  }

  //-------------------------------------------
  //---------------Tablet Mode Start-------------//
  Widget _buildTabletSalesDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.store),
            SizedBox(
              width: 10.0,
            ),
            Text('Sales',style: appBarTitleTextStyle,),
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
                            return AddSalesNew();
                          }));
                        },
                        child: Material(
                          color: PURCHASEBG,
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
                                  'Generate Bill',
                                  style: dashboadrTextStyle
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
                            return ViewSalesDashboard(widget.usertypecheck);
                          }));
                        },
                        child: Material(
                          color: PRODUCTBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.shoppingBag,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'View Bill',
                                  style: dashboadrTextStyle
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
                            return ImportSales();
                          }));
                        },
                        child: Material(
                          color: CUSTOMERBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.fileImport,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Import Sales',
                                  style: dashboadrTextStyle
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
                     child:GestureDetector(
                       onTap: () {
                         Navigator.of(context)
                             .push(MaterialPageRoute(builder: (_) {
                           return ReturnSalesDashbaord();
                         }));
                       },
                       child: Material(
                         color: Colors.pinkAccent ,
                         borderRadius: BorderRadius.circular(10.0),
                         child:Column(
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: FaIcon(FontAwesomeIcons.undoAlt,
                                 color:Colors.white,
                                 size: 50.0,
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Text('Sales Return',
                                 style: dashboadrTextStyle
                               ),
                             )
                           ],
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
                         Navigator.of(context)
                             .push(MaterialPageRoute(builder: (_) {
                           return ViewSalesDashboard(widget.usertypecheck);
                         }));
                       },
                       child: Visibility(
                         visible: false,
                         child: Material(
                           color: PRODUCTBG,
                           borderRadius: BorderRadius.circular(10.0),
                           child: Column(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: FaIcon(
                                   FontAwesomeIcons.shoppingBag,
                                   color: Colors.white,
                                   size: 50.0,
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: Text(
                                     'View Bill',
                                     style: dashboadrTextStyle
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
                         Navigator.of(context)
                             .push(MaterialPageRoute(builder: (_) {
                           return ViewSalesDashboard(widget.usertypecheck);
                         }));
                       },
                       child: Visibility(
                         visible: false,
                         child: Material(
                           color: PRODUCTBG,
                           borderRadius: BorderRadius.circular(10.0),
                           child: Column(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: FaIcon(
                                   FontAwesomeIcons.shoppingBag,
                                   color: Colors.white,
                                   size: 50.0,
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: Text(
                                     'View Bill',
                                     style: dashboadrTextStyle
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  //---------------Tablet Mode End-------------//
  //---------------Mobile Mode Start-------------//
  Widget _buildMobileSalesDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.shoppingBag),
            SizedBox(
              width: 10.0,
            ),
            Text('Sales',style: dashboadrTextStyle,),
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
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (_) {
                          //   return AddSales();
                          // }));
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return AddSalesNew();
                          }));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: PURCHASEBG,
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
                                  'Generate Bill',
                                  style: dashboadrTextStyle
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
                            return ViewSalesDashboard(widget.usertypecheck);
                          }));
                        },
                        child: Material(
                          color: PRODUCTBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.shoppingBag,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'View Sales',
                                  style: dashboadrTextStyle
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
                            return ImportSales();
                          }));
                        },
                        child: Material(
                          color: CUSTOMERBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.fileImport,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Import Sales',
                                  style: dashboadrTextStyle
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
                            return ReturnSalesDashbaord();
                          }));
                        },
                        child: Material(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.undoAlt,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Sales Return',
                                  style: dashboadrTextStyle
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
              ],
            ),
          ),
        ),
      ),
    );
  }
  //---------------Mobile Mode End-------------//

}
