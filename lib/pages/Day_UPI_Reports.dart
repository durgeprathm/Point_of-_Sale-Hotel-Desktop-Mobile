import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_todays_Upi_bill-fetch.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/pages/todays_reports.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';

import 'Day_Debit_Reports.dart';
import 'Day_cash_Reports.dart';
import 'Todays_Cash_Reports_Print.dart';
import 'Todays_UPI_Reports_Print.dart';

class TodayUPIReports extends StatefulWidget {
  @override
  _TodayUPIReportsState createState() => _TodayUPIReportsState();
}

class _TodayUPIReportsState extends State<TodayUPIReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileTodayUPIReports();
    } else {
      content = _buildTabletTodayUPIReports();
    }

    return content;
  }

  bool _showCircle = false;
  Widget appBarTitle = Text("UPI Report");
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );

//-------------------------------------------
  List<EhotelSales> TodaysUPIReports = new List();
  List<EhotelSales> TodaysUPIReportsSearch = new List();
  TextEditingController SerachController = new TextEditingController();
  final dateFormat = DateFormat("yyyy-MM-dd");
  final initialValue = DateTime.now();
  final _fromDatetext = TextEditingController();
  final _toDatetext = TextEditingController();
  DateTime fromValue = DateTime.now();
  DateTime toValue = DateTime.now();
  bool _fromDatevalidate = false;
  bool _toDatevalidate = false;
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;
  bool Datetofromenable = false;

  int count;
  String UpiFilter;

  String _selectdate;

  @override
  void initState() {
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    _getTodaysUPIReports();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletTodayUPIReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.30;
    void handleClick(String value) {
      switch (value) {
        case 'Today\'s Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TodaysReports()));
          break;
        case 'Cash Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DayCashReports()));
          break;
        case 'Debit Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TodaysDebitReports()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.ccAmazonPay),
            SizedBox(
              width: 20.0,
            ),
            Text('Today\'s UPI Reports'),
          ],
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Container(
                //width: tabletWidth,
                child: Text("Today\'s Date:- $_selectdate",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
          ),
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          TodaysUPIReports.length != 0
              ? IconButton(
                  icon: Icon(Icons.print, color: Colors.white),
                  onPressed: () {
                    double total = 0.0;
                    for(int i=0;i<TodaysUPIReports.length;i++){
                      total = total + double.parse(TodaysUPIReports[i].totalamount);
                    }

                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return TodaysUPIReportPrint(1, TodaysUPIReports,_selectdate.toString(),total.toString());
                    }));
                  },
                )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Today\'s Reports',
                'Cash Reports',
                'Debit Reports',
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
            child: TodaysUPIReports.length == 0
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 50.0),
                          child: DataTable(columns: [
                            DataColumn(
                                label: Expanded(
                              child: Container(
                                width: 70,
                                child: Text('Bill No',
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
  Widget _buildMobileTodayUPIReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Today\'s Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TodaysReports()));
          break;
        case 'Cash Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DayCashReports()));
          break;
        case 'Debit Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TodaysDebitReports()));
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
                        "UPI Report",
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
              TodaysUPIReports.length != 0
                  ? IconButton(
                      icon: Icon(Icons.print, color: Colors.white),
                      onPressed: () {

                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: (_) {
                        //   return TodaysUPIReportPrint(1, TodaysUPIReports);
                        // }));


                      },
                    )
                  : Text(''),
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {
                    'Today\'s Reports',
                    'Cash Reports',
                    'Debit Reports',
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
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: TodaysUPIReports.length,
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
                                        "Bill No:- ${TodaysUPIReports[index].menusalesid.toString()} ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${TodaysUPIReports[index].medate}",
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
                                        Text("Customer Name: ",
                                            style: headHintTextStyle),
                                        Text(
                                            "${TodaysUPIReports[index].customername}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Total Amount:      ",
                                            style: headHintTextStyle),
                                        Text(
                                            "Rs.${TodaysUPIReports[index].totalamount.toString()}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Payment Mode:   ",
                                            style: headHintTextStyle),
                                        Text(
                                            "${TodaysUPIReports[index].paymodename.toString()}",
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
      DataCell(Text(TodaysUPIReports[index].menusalesid.toString())),
      DataCell(Text(TodaysUPIReports[index].customername)),
      DataCell(Text(TodaysUPIReports[index].medate)),
      DataCell(Text(TodaysUPIReports[index].discount.toString())),
      DataCell(Text(TodaysUPIReports[index].totalamount.toString())),
      DataCell(Text(TodaysUPIReports[index].paymodename)),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < TodaysUPIReports.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  //-------------------------------------
//from server fetching All Cash Data
  void _getTodaysUPIReports() async {
    setState(() {
      _showCircle = true;
    });
    TodayupiBillFetch todayupibill = new TodayupiBillFetch();
    var todayupibillfetchData = await todayupibill.getTodayupiBillFetch(_selectdate);
    var resid = todayupibillfetchData["resid"];

    if (resid == 200) {
      var rowcount = todayupibillfetchData["rowcount"];
      if (rowcount > 0) {
        var todayupibillfetchsd = todayupibillfetchData["todayupibill"];
        print(todayupibillfetchsd.length);
        List<EhotelSales> temptodayupibillfetch = [];
        for (var n in todayupibillfetchsd) {
          EhotelSales pro = EhotelSales(
            int.parse(n["menusalesid"]),
            n["customerid"],
            n["customername"],
            n["mobilenumber"],
            n["medate"],
            n["Subtotal"],
            n["discount"],
            n["totalamount"],
            n["payid"],
            n["transcationid"],
            n["paypaymodeid"],
            n["paymodename"],
            n["Narration"],
            n["menuid"],
            n["menuname"],
            n["menuquntity"],
            n["menurate"],
            n["menugst"],
            n["menusubtotal"],n["waiterid"],n["waitername"],
              n["accounttypename"]);
          temptodayupibillfetch.add(pro);
        }
        setState(() {
          this.TodaysUPIReports = temptodayupibillfetch;
          this.TodaysUPIReportsSearch = temptodayupibillfetch;
        });
        print("//////SalesList/////////$TodaysUPIReports.length");

        SerachController.addListener(() {
          setState(() {
            if (TodaysUPIReportsSearch != null) {
              String s = SerachController.text;
              TodaysUPIReports = TodaysUPIReportsSearch.where((element) =>
                  element.menusalesid.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.customername.toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.discount.toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.totalamount.toLowerCase().contains(s.toLowerCase()) ||
                  element.paymodename.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase())).toList();
            }
          });
        });
        setState(() {
          _showCircle = false;
        });
      } else {
        setState(() {
          _showCircle = false;
        });

        String message = todayupibillfetchData["message"];
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: PrimaryColor,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      setState(() {
        _showCircle = false;
      });
      String message = todayupibillfetchData["message"];
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
