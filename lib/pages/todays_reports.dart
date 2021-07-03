import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_TodaysSales_PaymentMode_fetch.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_today_bill_fetch.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'Add_Sales.dart';
import 'Import_sales.dart';
import 'Todays_Reports_Print.dart';


class TodaysReports extends StatefulWidget {
  @override
  _TodaysReportsState createState() => _TodaysReportsState();
}

class _TodaysReportsState extends State<TodaysReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;
  bool _showCircle = false;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileTodaysReports();
    } else {
      content = _buildTabletTodaysReports();
    }

    return content;
  }

//-------------------------------------------
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  final format = DateFormat("yyyy-MM-dd");
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;
  String _selectdate;
  String PaymentMode;

  //DatabaseHelper databaseHelper = DatabaseHelper();
  List<EhotelSales> TodayBillList = new List();
  List<EhotelSales> TodaysReportsListSearch = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;
  TodaysSalesPaymentModeFetch todaysalespaymentmodefetch = new TodaysSalesPaymentModeFetch();

  @override
  void initState() {
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    _getTodaysBill(_selectdate);
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletTodaysReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.30;
    void handleClick(String value) {
      switch (value) {
        case 'Cash Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
          break;
        case 'Debit Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ImportSales()));
          break;
        case 'UPI Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ImportSales()));
          break;
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.calendar),
            SizedBox(
              width: 20.0,
            ),
            Text('Today\'s Reports'),
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
          TodayBillList.length != 0
              ? IconButton(
                  icon: Icon(Icons.print, color: Colors.white),
                  onPressed: () {
                    double total = 0.0;
                    for(int i =0;i<TodayBillList.length;i++){
                      total = total + double.parse(TodayBillList[i].totalamount);
                    }
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return TodaysReportPrint(1,_selectdate.toString() ,TodayBillList,total);
                    }));
                  },
                )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Cash Reports',
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
            child: TodayBillList.length == 0
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
                          Container(
                            width: tabletWidth,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: DropdownSearch(
                                isFilteredOnline: true,
                                showClearButton: true,
                                showSearchBox: true,
                                items: [
                                  "All",
                                  "CASH",
                                  "DEBIT",
                                  "UPI",
                                ],
                                label: "Payment Mode",
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                  PaymentMode = value;
                                  if (PaymentMode == "All" ||
                                      PaymentMode == null) {
                                    _getTodaysBill(_selectdate);
                                  } else {
                                    _getSalesPaymentMode(
                                        PaymentMode, _selectdate);
                                  }

                                  print(PaymentMode);
                                },
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
                              child: Text('Discount',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Container(
                              child: Text('Total (₹)',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )),
                          DataColumn(
                              label: Expanded(
                                child: Container(
                                  child: Text('Details',
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold)),
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
  Widget _buildMobileTodaysReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Cash Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
          break;
        case 'Debit Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ImportSales()));
          break;
        case 'UPI Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ImportSales()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.calendar),
            SizedBox(
              width: 20.0,
            ),
            Text('Today\'s Reports'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Cash Bill',
                'Debit Bill',
                'UPI Bill',
                'Sales Book',
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
        child: ModalProgressHUD(
          inAsyncCall: _showCircle,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: TodayBillList.length,
                    itemBuilder: (context, index) {
                      print("//in index////$index");
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Bill No: ${TodayBillList[index].menusalesid.toString()} ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${TodayBillList[index].medate}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Customer Name: ",
                                  style: headHintTextStyle,
                                ),
                                Text(
                                    "${TodayBillList[index].customername}",
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
                                    "Rs. ${TodayBillList[index].totalamount.toString()}",
                                    style: headsubTextStyle),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  // onPressed: () {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) => PreviewSales(
                                  //               index, TodayBillList)));
                                  // },
                                  icon: Icon(
                                    Icons.preview,
                                    color: Colors.blue,
                                  ),
                                ),
                                IconButton(
                                  // onPressed: () {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               EditSaleScreenNew(
                                  //                   index, TodayBillList)));
                                  // },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                   // _showMyDialog(TodayBillList[index].Salesid);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

//---------------Mobile Mode End-------------//

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(TodayBillList[index].menusalesid.toString())),
      DataCell(Text(TodayBillList[index].customername)),
      DataCell(Text(TodayBillList[index].discount)),
      DataCell(Text(double.parse(TodayBillList[index].totalamount).toStringAsFixed(2))),
      DataCell(
        Center(
          child: IconButton(
            icon: Icon(
              Icons.preview,
            ),
            color: Colors.blue,
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             PreviewSales(index, searchSalesList)));
            },
          ),

        )
      ),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < TodayBillList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }


  //-------------------------------------
//from server fetching sales data
  void _getTodaysBill(String TodaysDate) async {
    setState(() {
      _showCircle = true;
    });
    TodayBillFetch todaybillfetch = new TodayBillFetch();
    var TodaybillData = await todaybillfetch.getTodayBillFetch(TodaysDate);
    var resid = TodaybillData["resid"];
    print("My res//// $resid");

    if (resid == 200) {
      var rowcount = TodaybillData["rowcount"];
      if (rowcount > 0) {
        var todaybillsd = TodaybillData["todaysbilllist"];
        print(todaybillsd.length);
        List<EhotelSales> temptodayBill = [];
        for (var n in todaybillsd) {
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
          temptodayBill.add(pro);
        }

        setState(() {
          this.TodayBillList = temptodayBill;
          this.TodaysReportsListSearch = temptodayBill;
        });

        setState(() {
          _showCircle = false;
        });
        print("//////TodayBillList/////////$TodayBillList.length");
      } else {
        setState(() {
          _showCircle = false;
        });
        String msg = TodaybillData["message"];
        Fluttertoast.showToast(
          msg: msg,
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
      String msg = TodaybillData["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }

    SerachController.addListener(() {
      setState(() {
        if (TodaysReportsListSearch != null) {
          String s = SerachController.text;
          TodayBillList = TodaysReportsListSearch.where((element) =>
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
  }

//-------------------------------------
// from server Fetching Payment Mode Data
  void _getSalesPaymentMode(String PaymentMode, String todaysDate) async {

    var todaysalespaymentmodefetchData = await todaysalespaymentmodefetch.getTodaysSalesPaymentModeFetch(PaymentMode, todaysDate);
    print(PaymentMode);
    print(todaysDate);

    int resid = todaysalespaymentmodefetchData["resid"];
    int rowcount = todaysalespaymentmodefetchData["rowcount"];
    print('${rowcount}');
    if (resid == 200) {
      var todaysalespaymentmodefetchsd =
      todaysalespaymentmodefetchData["sales"];
      List<EhotelSales> temptodaysalespaymentmodefetch = [];
      print('${todaysalespaymentmodefetchsd}');
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
        this.TodayBillList = temptodaysalespaymentmodefetch;
      });
      print("//////SalesList/////////$TodayBillList.length");
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
}
