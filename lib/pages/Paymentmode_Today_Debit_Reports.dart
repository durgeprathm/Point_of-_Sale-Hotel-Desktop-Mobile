import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_TodaysSales_PaymentMode_fetch.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/pages/Manage_Sales.dart';
import 'package:retailerp/pages/todays_reports.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';

import 'Add_Sales.dart';
import 'Day_UPI_Reports.dart';
import 'Day_cash_Reports.dart';
import 'Import_sales.dart';
import 'PaymentMode_Today_cash_Reports.dart';
import 'PaymentMode_Todays_Debit_Reports_Print.dart';
import 'Todays_Debit_Reports_Print.dart';
import 'Todays_UPI_Reports_Print.dart';


class PaymentModeTodaysDebitReports extends StatefulWidget {
  @override
  _PaymentModeTodaysDebitReportsState createState() => _PaymentModeTodaysDebitReportsState();
}

class _PaymentModeTodaysDebitReportsState extends State<PaymentModeTodaysDebitReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobilePaymentModeTodaysDebitReports();
    } else {
      content = _buildTabletPaymentModeTodaysDebitReports();
    }

    return content;
  }

  bool _showCircle = false;
  Widget appBarTitle = Text("Debit Report");
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
//-------------------------------------------
  List<Sales> DebitReportsList = new List();
  List<Sales> DebitReportsListSearch = new List();
  TextEditingController SerachController = new TextEditingController();
  final dateFormat = DateFormat("yyyy-MM-dd");
  final initialValue = DateTime.now();
  DateTime fromValue = DateTime.now();
  DateTime toValue = DateTime.now();
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;

  //DatabaseHelper databaseHelper = DatabaseHelper();
  int count;

  String _selectdate;
  @override
  void initState() {
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    _getTodaysDebitReports();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletPaymentModeTodaysDebitReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.30;
    void handleClick(String value) {
      switch (value) {
        case 'Cash Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PaymentModeTodayCashReports()));
          break;
        case 'UPI Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TodayUPIReports()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.creditCard),
            SizedBox(
              width: 20.0,
            ),
            Text('Today\'s Debit Reports'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15.0, horizontal: 20.0),
            child: Container(
              //width: tabletWidth,
                child:Text("Today\'s Date:- $_selectdate",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white))
            ),
          ),
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          DebitReportsList.length != 0
              ? IconButton(
            icon: Icon(Icons.print, color: Colors.white),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) {
                return PaymentModeTodaysDebitReportPrint(1, DebitReportsList);
              }));
            },
          )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Cash Reports',
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
            child: DebitReportsList.length == 0
                ?
            Center(child: CircularProgressIndicator())
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
                            width: 40,
                            child: Text('Sr',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )),
                    DataColumn(
                        label: Expanded(
                          child: Container(
                            width: 150,
                            child: Text('Customer Name',
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
                            child: Text('Type',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )),
                    DataColumn(
                        label: Expanded(
                          child: Container(
                            child: Text('Card Type',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )),
                    DataColumn(
                        label: Expanded(
                          child: Container(
                            child: Text('Name',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )),
                    DataColumn(
                        label: Expanded(
                          child: Container(
                            child: Text('Card Number',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )),
                  ], rows: getDataRowList()),
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
  Widget _buildMobilePaymentModeTodaysDebitReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Cash Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PaymentModeTodayCashReports()));
          break;
        case 'UPI Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TodayUPIReports()));
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
                        "Debit Report",
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
              DebitReportsList.length != 0
                  ? IconButton(
                icon: Icon(Icons.print, color: Colors.white),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) {
                    return PaymentModeTodaysDebitReportPrint(1, DebitReportsList);
                  }));
                },
              )
                  : Text(''),
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {
                    'Cash Reports',
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
                        itemCount: DebitReportsList.length,
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
                                        "Bill No:- ${DebitReportsList[index].Salesid.toString()} ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${DebitReportsList[index].SalesDate}",
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
                                        Text("Customer Name:",
                                            style: headHintTextStyle),
                                        Text(
                                            "${DebitReportsList[index].SalesCustomername}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Total Amount:",
                                            style: headHintTextStyle),
                                        Text(
                                            "Rs.${DebitReportsList[index].SalesTotal.toString()}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Payment Card Type:",
                                            style: headHintTextStyle),
                                        Text(
                                            "${DebitReportsList[index].SalesPaymentCardType.toString()}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Card Type:",
                                            style: headHintTextStyle),
                                        Text(
                                            "${DebitReportsList[index].SalesCardType.toString()}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Name On Card:",
                                            style: headHintTextStyle),
                                        Text(
                                            "${DebitReportsList[index].SalesNameOnCard.toString()}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Card Number:",
                                            style: headHintTextStyle),
                                        Text(
                                            "${DebitReportsList[index].SalesCardName.toString()}",
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
      DataCell(Text(DebitReportsList[index].Salesid.toString())),
      DataCell(Text(DebitReportsList[index].SalesCustomername)),
      DataCell(Text(DebitReportsList[index].SalesTotal)),
      DataCell(Text(DebitReportsList[index].SalesPaymentCardType.toString())),
      DataCell(Text(DebitReportsList[index].SalesCardType)),
      DataCell(Text(DebitReportsList[index].SalesNameOnCard)),
      DataCell(Text(DebitReportsList[index].SalesCardName)),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < DebitReportsList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }



//from server fetching All Debit Data
  void _getTodaysDebitReports() async {
    TodaysSalesPaymentModeFetch todaysalespaymentmodefetch = new TodaysSalesPaymentModeFetch();
    var todaysalespaymentmodefetchData = await todaysalespaymentmodefetch.getTodaysSalesPaymentModeFetch("DEBIT",_selectdate);
    var resid = todaysalespaymentmodefetchData["resid"];

    if (resid == 200) {
      var todaysalespaymentmodefetchsd = todaysalespaymentmodefetchData["sales"];
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
        this.DebitReportsList = temptodaysalespaymentmodefetch;
        this.DebitReportsListSearch = temptodaysalespaymentmodefetch;
      });
      print("//////DebitReportsList/////////$DebitReportsList.length");


      SerachController.addListener(() {
        setState(() {
          if(DebitReportsListSearch != null){
            String s = SerachController.text;
            DebitReportsList = DebitReportsListSearch.where((element) => element.Salesid.toString().toLowerCase().contains(s.toLowerCase()) || element.SalesCustomername.toLowerCase().contains(s.toLowerCase()) ||element.SalesTotal.toLowerCase().contains(s.toLowerCase()) ||element.SalesPaymentCardType.toLowerCase().contains(s.toLowerCase()) ||element.SalesCardType.toString().toLowerCase().contains(s.toLowerCase())||element.SalesNameOnCard.toString().toLowerCase().contains(s.toLowerCase())||element.SalesCardName.toString().toLowerCase().contains(s.toLowerCase())).toList();
          }
        });
      });


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

//-------------------------------------

}
