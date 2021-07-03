import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_TodaysSales_PaymentMode_fetch.dart';
import 'Todays_Cash_Reports_Print.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/pages/todays_reports.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';


import 'Day_Debit_Reports.dart';
import 'Day_UPI_Reports.dart';
import 'Todays_UPI_Reports_Print.dart';

class DayCashReports extends StatefulWidget {
  @override
  _DayCashReportsState createState() => _DayCashReportsState();
}

class _DayCashReportsState extends State<DayCashReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileDayCashReports();
    } else {
      content = _buildTabletDayCashReports();
    }

    return content;
  }

  bool _showCircle = false;
  Widget appBarTitle = Text("Cash Report");
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );

//-------------------------------------------
  DateTime fromValue = DateTime.now();
  DateTime toValue = DateTime.now();
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;
  final dateFormat = DateFormat("yyyy-MM-dd");
  final initialValue = DateTime.now();

  //DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController SerachController = new TextEditingController();
  int count;

  List<EhotelSales> TodayCashReportsList = new List();
  List<EhotelSales> TodayCashReportsListSearch = new List();
  String _selectdate;

  @override
  void initState() {

    setState(() {
      _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    });
    _getTodaysCashReports();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletDayCashReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.30;
    void handleClick(String value) {
      switch (value) {
        case 'Today\'s Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TodaysReports()));
          break;
        case 'Debit Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TodaysDebitReports()));
          break;
        case 'UPI Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TodayUPIReports()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.moneyBill),
            SizedBox(
              width: 20.0,
            ),
            Text('Today\'s Cash Reports'),
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
          TodayCashReportsList.length != 0
              ? IconButton(
                  icon: Icon(Icons.print, color: Colors.white),
                  onPressed: () {
                    double total = 0.0;
                    for(int i=0;i<TodayCashReportsList.length;i++){
                      total = total +  double.parse(TodayCashReportsList[0].totalamount);
                    }


                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return TodaysCashReportPrint(1, TodayCashReportsList,_selectdate.toString(),total.toString());
                    }));
                  },
                )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Today\'s Reports',
                'Debit Reports',
                'UPI Reports',
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
              child: TodayCashReportsList.length == 0
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
                      ],
                    )),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobileDayCashReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Today\'s Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TodaysReports()));
          break;
        case 'Debit Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TodaysDebitReports()));
          break;
        case 'UPI Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TodayUPIReports()));
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
                      ) ;
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
                        "Cash Report",
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
              TodayCashReportsList.length != 0
                  ? IconButton(
                      icon: Icon(Icons.print, color: Colors.white),
                      onPressed: () {
                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: (_) {
                        //   return TodaysCashReportPrint(1, TodayCashReportsList);
                        // }));
                      },
                    )
                  : Text(''),
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {
                    'Today\'s Reports',
                    'Debit Reports',
                    'UPI Reports',
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
                Divider(),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: TodayCashReportsList.length,
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
                                        "Bill No:- ${TodayCashReportsList[index].menusalesid.toString()} ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${TodayCashReportsList[index].medate}",
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
                                            "${TodayCashReportsList[index].customername}",
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
                                            "Rs.${TodayCashReportsList[index].totalamount.toString()}",
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
                                            "${TodayCashReportsList[index].paymodename.toString()}",
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
      DataCell(Text(TodayCashReportsList[index].menusalesid.toString())),
      DataCell(Text(TodayCashReportsList[index].customername)),
      DataCell(Text(TodayCashReportsList[index].medate)),
      DataCell(Text(TodayCashReportsList[index].discount.toString())),
      DataCell(Text(double.parse(TodayCashReportsList[index].totalamount).toStringAsFixed(2))),
      DataCell(Text(TodayCashReportsList[index].paymodename)),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < TodayCashReportsList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  //-------------------------------------
//from server fetching All Cash Data
  void _getTodaysCashReports() async {
    setState(() {
      _showCircle = true;
    });
    TodaysSalesPaymentModeFetch todaysalespaymentmodefetch = new TodaysSalesPaymentModeFetch();
    var todaysalespaymentmodefetchData = await todaysalespaymentmodefetch.getTodaysSalesPaymentModeFetch("CASH",_selectdate);
    print(todaysalespaymentmodefetchData);
    var resid = await todaysalespaymentmodefetchData["resid"];
    if (resid == 200) {
      var rowcount = todaysalespaymentmodefetchData["rowcount"];

        var todaysalespaymentmodefetchsd =
            todaysalespaymentmodefetchData["todaysallsortbill"];

        List<EhotelSales> temptodaysalespaymentmodefetch = [];
        for (var n in todaysalespaymentmodefetchsd) {
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
          temptodaysalespaymentmodefetch.add(pro);
        }
        setState(() {
          this.TodayCashReportsList = temptodaysalespaymentmodefetch;
          this.TodayCashReportsListSearch = temptodaysalespaymentmodefetch;
        });
        print(
            "//////TodayCashReportsList/////////$TodayCashReportsList.length");

        SerachController.addListener(() {
          setState(() {
            if (TodayCashReportsListSearch != null) {
              String s = SerachController.text;
              TodayCashReportsList = TodayCashReportsListSearch.where(
                  (element) =>
                      element.menusalesid.toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.customername.toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.discount.toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.totalamount.toLowerCase()
                          .contains(s.toLowerCase()) ||
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
        String message = todaysalespaymentmodefetchData["message"];
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: PrimaryColor,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
    }
  }
//-------------------------------------

}
