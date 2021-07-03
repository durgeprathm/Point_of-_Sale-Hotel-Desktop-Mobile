import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/LedgerManagement/Ledger_DashBoard.dart';
import 'package:retailerp/MobilePages/MobilePOS/POSTableOne/mobile_pos.dart';
import 'package:retailerp/POSUIONE/pos_frontpage.dart';
import 'package:retailerp/pages/add_empolyee.dart';
import 'package:retailerp/pages/conversion.dart';
import 'package:retailerp/pages/customer_menu_list.dart';
import 'package:retailerp/pages/empolyee_dashboard.dart';
import 'package:retailerp/pages/login_page.dart';
import 'package:retailerp/pages/menu_Dashboard.dart';
import 'package:retailerp/pages/overall_summary_dashboard.dart';
import 'package:retailerp/pages/product_management_menu_list.dart';
import 'package:retailerp/pages/purchase_Dashboard.dart';
import 'package:retailerp/pages/report_dashboard.dart';
import 'package:retailerp/pages/setting_dashboard.dart';
import 'package:retailerp/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Sales_Dashboard.dart';
import 'StockTranfer_Dashboard.dart';
import 'Voucher_Generate_Dashboard.dart';

class RetailerHomePage extends StatefulWidget {
  static const String id = 'dashboard_screen';

  @override
  _RetailerHomePageState createState() => _RetailerHomePageState();
}

class _RetailerHomePageState extends State<RetailerHomePage> {
  static const int kTabletBreakpoint = 552;
  bool usertypecheck = false;
  String Username;
  TextEditingController serachcontroller = new TextEditingController();
  bool showtextSearch = false;
  FocusNode myFocusNode;

  Future<void> checkUsertype() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String usertype = prefs.getString("usertype");
    String userpermisson = prefs.getString("permission");
    String name = prefs.getString("name");

    setState(() {
      Username = name;
    });
    if (usertype == "0") {
      setState(() {
        usertypecheck = false;
      });
    } else if (usertype == "1") {
      setState(() {
        usertypecheck = true;
      });
    }
  }

  @override
  void initState() {
    checkUsertype();
    myFocusNode = FocusNode();
  }

  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    myFocusNode = FocusNode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileDashboard();
    } else {
      content = _buildTabletDashboard();
    }

    return content;
  }

  Widget _buildTabletDashboard() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss  EEE d MMM').format(now);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Arun Telgirni",
            style: appBarTitleTextStyle,
          ),
          backgroundColor: Color(0xff01579B),
          actions: [
            Center(
                child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Text(
                "$Username | ",
                style: appBarTitleTextStyle,
              ),
            )),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Text(
                "${formattedDate.toString()} | ",
                style: appBarTitleTextStyle,
              ),
            )),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.powerOff,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: false,
                    child: Container(
                      child: TextField(
                        controller: serachcontroller,
                        autofocus: true,
                        focusNode: myFocusNode,
                        onChanged: (String value) {
                          setState(() {
                            showtextSearch = true;
                          });
                        },
                        style: TextStyle(
                          color: Colors.blueGrey,
                        ),
                        onSubmitted: (value) {
                          if(value == "PO" || value == "1"){
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return POSFrontPage();
                            }));
                          }
                          if(value == "RE"|| value == "2"){
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return ReportDashBoard();
                            }));
                          }
                          if(value == "EP"|| value == "3"){
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return EmpDashboard();
                            }));
                          }
                          if(value == "LE"|| value == "4"){
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return LegdgerDashbaord();
                            }));
                          }
                          if(value == "PM"|| value == "5"){
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return ProductManagementMenuList();
                            }));
                          }
                          if(value == "ME"|| value == "6"){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                              return MenuDashboard();
                            }));
                          }
                          if(value == "SL"|| value == "7"){
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return SalesDashboard(usertypecheck);
                            }));
                          }
                          if(value == "PR"|| value == "8"){

                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return PurchaseDashboard();
                            }));

                          }

                          if(value == "ST"|| value == "9"){
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return StockTransferDashboard();
                            }));
                          }

                          if(value == "DI"|| value == "10"){


                          }
                          if(value == "Sg"|| value == "11"){
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return SettingDashboard();
                            }));
                          }

                          setState(() {
                            showtextSearch = false;
                          });
                          serachcontroller.text = "";
                          myFocusNode.requestFocus();

                        },
                        decoration: InputDecoration(
                            hintText: "Type shortcuts here...",
                         ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return POSFrontPage();
                            }));
                          },
                          child: Material(
                            color: Color(0xffE57373),
                            borderRadius: BorderRadius.circular(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: FaIcon(FontAwesomeIcons.calculator,
                                      size: 50.0, color: Colors.white),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "POS",
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
                              return OverallSummaryDashBoard();
                            }));
                          },
                          child: Visibility(
                            visible: true,
                            child: Material(
                              color: Color(0xffE57373),
                              borderRadius: BorderRadius.circular(10.0),
                              child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: FaIcon(FontAwesomeIcons.poll,
                                          size: 50.0, color: Colors.white),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        "Sales Dashboard",
                                        style: dashboadrTextStyle,
                                      ),
                                    )
                                  ]
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
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return ReportDashBoard();
                            }));
                          },
                          child: Material(
                            color: Color(0xff81C784),
                            borderRadius: BorderRadius.circular(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.book,
                                      size: 50.0, color: Colors.white),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Report Gen.",
                                    style: dashboadrTextStyle,
                                  ),
                                )
                              ],
                            ),
                            elevation: 10.0,
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child: InkWell(
                      //     onTap: () {
                      //       Navigator.of(context)
                      //           .push(MaterialPageRoute(builder: (_) {
                      //         return EmpDashboard();
                      //       }));
                      //     },
                      //     child: Material(
                      //       color: Color(0xff4DD0E1),
                      //       borderRadius: BorderRadius.circular(10.0),
                      //       child: Column(
                      //         children: [
                      //           Padding(
                      //             padding: EdgeInsets.all(10.0),
                      //             child: FaIcon(
                      //               FontAwesomeIcons.personBooth,
                      //               color: Colors.white,
                      //               size: 50.0,
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: EdgeInsets.all(10.0),
                      //             child: Text(
                      //               "Employee",
                      //               style: dashboadrTextStyle,
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //       elevation: 10.0,
                      //     ),
                      //   ),
                      // ),
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
                              return LegdgerDashbaord();
                            }));
                          },
                          child: Material(
                            color: primary,
                            borderRadius: BorderRadius.circular(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.work,
                                    size: 50.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Ledger",
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
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return ProductManagementMenuList();
                            }));
                          },
                          child: Material(
                            color: Color(0xff9575CD),
                            borderRadius: BorderRadius.circular(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.folder,
                                    size: 50.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Product Management",
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
                              return StockTransferDashboard();
                            }));
                          },
                          child: Material(
                            color: Color(0xffe57373),
                            borderRadius: BorderRadius.circular(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: FaIcon(FontAwesomeIcons.calculator,
                                      size: 50.0, color: Colors.white),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Stock Transfer",
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
                              return SalesDashboard(usertypecheck);
                            }));
                          },
                          child: Material(
                            color: Color(0xffF06292),
                            borderRadius: BorderRadius.circular(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.store,
                                    color: Colors.white,
                                    size: 50.0,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Sales",
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
                              return PurchaseDashboard();
                            }));
                          },
                          child: Material(
                            color: Color(0xffBA68C8),
                            borderRadius: BorderRadius.circular(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.shoppingBag,
                                    color: Colors.white,
                                    size: 50.0,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Purchase",
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
                            // Navigator.of(context)
                            //     .push(MaterialPageRoute(builder: (_) {
                            //   return SettingDashboard();
                            // }));
                          },
                          child: Material(
                            color: SETTINGSBG,
                            borderRadius: BorderRadius.circular(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.delete,
                                      size: 50.0, color: dashtextcolor),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Dispose Items",
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
                              return SettingDashboard();
                            }));
                          },
                          child: Visibility(
                            visible: usertypecheck,
                            child: Material(
                              color: MENUCATBG,
                              borderRadius: BorderRadius.circular(10.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(Icons.settings,
                                        size: 50.0, color: dashtextcolor),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      "Settings",
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
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return OverallSummaryDashBoard();
                            }));
                          },
                          child: Visibility(
                            visible: false,
                            child: Material(
                              color: Color(0xffE57373),
                              borderRadius: BorderRadius.circular(10.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: FaIcon(FontAwesomeIcons.poll,
                                        size: 50.0, color: Colors.white),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      "Sales Dashboard",
                                      style: dashboadrTextStyle,
                                    ),
                                  )
                                ]
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
                              return ConversionPage();
                            }));
                          },
                          child: Visibility(
                            visible: false,
                            child: Material(
                              color: Color(0xffE57373),
                              borderRadius: BorderRadius.circular(10.0),
                              child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: FaIcon(FontAwesomeIcons.arrowsAlt,
                                          size: 50.0, color: Colors.white),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        "Conversion",
                                        style: dashboadrTextStyle,
                                      ),
                                    )
                                  ]
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
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildMobileDashboard() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "QI System",
          style: appBarTitleTextStyle,
        ),
        backgroundColor: Color(0xff01579B),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff01579B),
//                image: DecorationImage(
//                    image: AssetImage("Images/snsbluelogo.png"),
//                    fit: BoxFit.contain),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.menu,
                color: Color(0xff00838F),
                size: 40.0,
              ),
              title: Text(
                'Menu',
                style: dashboadrNavTextStyle,
              ),
              onTap: () {
//                Navigator.pop(context);
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) =>
//                            AllVideoPage(widget.USERNAME, widget.StudId)));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.library_books,
                color: Color(0xff3949AB),
                size: 40.0,
              ),
              title: Text(
                'Menu Category',
                style: dashboadrNavTextStyle,
              ),
              onTap: () {
////                Navigator.pop(context);
////                Navigator.push(
////                    context,
////                    MaterialPageRoute(
////                        builder: (context) => NotePage(
////                            username: widget.USERNAME,
////                            studentid: widget.StudId)));
              },
            ),
            ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.indigo,
                  size: 40.0,
                ),
                title: Text(
                  'Settings',
                  style: dashboadrNavTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return SettingDashboard();
                    }),
                  );
                }),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Color(0xff4CAF50),
                size: 40.0,
              ),
              title: Text(
                'Logout',
                style: dashboadrNavTextStyle,
              ),
              onTap: () async {},
            ),
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
                            return MobilePOS();
                          }));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xffE57373),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(FontAwesomeIcons.calculator,
                                    size: 35.0, color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "POS",
                                  style: dashboardMobTextStyle,
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
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return SalesDashboard(usertypecheck);
                            }),
                          );
                        },
                        child: Material(
                          color: Color(0xffF06292),
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.store,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Sales",
                                  style: dashboardMobTextStyle,
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
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return PurchaseDashboard();
                            }),
                          );
                        },
                        child: Material(
                          color: Color(0xffBA68C8),
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
                                  "Purchase",
                                  style: dashboardMobTextStyle,
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
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return ProductManagementMenuList();
                          }));
                        },
                        child: Material(
                          color: Color(0xff9575CD),
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.folder,
                                  size: 35.0,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Product",
                                  style: dashboardMobTextStyle,
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
                      child: InkWell(
                        onTap: () {},
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xff7986CB),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.productHunt,
                                  size: 35.0,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Employee",
                                  style: dashboardMobTextStyle,
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
                      child: InkWell(
                        onTap: () {
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (_) {
                          //   return ProductRateMenuList();
                          // }));

                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return CustomerMenuList();
                          }));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xff4FC3F7),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(FontAwesomeIcons.rupeeSign,
                                    size: 35.0, color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Customer",
                                  style: dashboardMobTextStyle,
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
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return StockTransferDashboard();
                          }));
                        },
                        child: Material(
                          color: Color(0xff9575CD),
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.calculate,
                                  size: 35.0,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Stock Transfer",
                                  style: dashboardMobTextStyle,
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
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return ProductManagementMenuList();
                          }));
                        },
                        child: Material(
                          color: Color(0xff9575CD),
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.delete,
                                  size: 35.0,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Dispose Items",
                                  style: dashboardMobTextStyle,
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
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return MenuDashboard();
                            }),
                          );
                        },
                        child: Material(
                          color: Color(0xffBA68C8),
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.receipt,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Menu",
                                  style: dashboardMobTextStyle,
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
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return ReportDashBoard();
                            }),
                          );
                        },
                        child: Material(
                          color: Color(0xffBA68C8),
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.book,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Report Gen.",
                                  style: dashboardMobTextStyle,
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
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return VoucherGenerateDashbaord();
                            }),
                          );
                        },
                        child: Material(
                          color: Color(0xffBA68C8),
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.creditCard,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Voucher",
                                  style: dashboardMobTextStyle,
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
}
