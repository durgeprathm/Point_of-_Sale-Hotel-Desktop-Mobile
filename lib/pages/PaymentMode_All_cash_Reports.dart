import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_cash_bill_fetch.dart';
import 'package:retailerp/Adpater/pos_MnageSales_PaymentModeAndDatewise_fetch.dart';
import 'package:retailerp/Adpater/pos_Sales_datewise_fetch.dart';
import 'package:retailerp/Adpater/pos_cash_bill_datewise_fetch.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';

import 'All_Cash_Reports_Print.dart';
import 'All_Debit_Reports.dart';
import 'All_Reports.dart';
import 'All_Reports_Print.dart';
import 'All_Upi_Reports.dart';
import 'PaymentMode_All_Debit_Reports.dart';

class PaymentModeAllCashReports extends StatefulWidget {
  @override
  _PaymentModeAllCashReportsState createState() => _PaymentModeAllCashReportsState();
}

class _PaymentModeAllCashReportsState extends State<PaymentModeAllCashReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobilePaymentModeAllCashReports();
    } else {
      content = _buildTabletPaymentModeAllCashReports();
    }

    return content;
  }

  //=--------mobile--------------
  bool _showCircle = false;
  final _fromDatetext = TextEditingController();
  final _toDatetext = TextEditingController();
  DateTime fromValue = DateTime.now();
  DateTime toValue = DateTime.now();
  final dateFormat = DateFormat("yyyy-MM-dd");
  bool _fromDatevalidate = false;
  bool _toDatevalidate = false;
  Widget appBarTitle = Text("Cash Reports");
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
//-------------------------------------------

//-------------------------------------------
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;
  final initialValue = DateTime.now();

  //DatabaseHelper databaseHelper = DatabaseHelper();
  List<Sales> CashBillList = new List();
  List<Sales> CashBillListSearch = new List();
  List<Sales> CashBillDateWiseList = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;

  @override
  void initState() {
    //ShowSalesdetails();
    _getCashBill("1","","");
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletPaymentModeAllCashReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.30;
    void handleClick(String value) {
      switch (value) {
        case 'Debit Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PaymentModeAllDebitReports()));
          break;
        case 'UPI Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AllUpiReports()));
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
            Text('All Cash Reports'),
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
          // CashBillList.length != 0
          //     ? IconButton(
          //         icon: Icon(Icons.print, color: Colors.white),
          //         onPressed: () {
          //           Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          //             return AllCashReportPrint(1, CashBillList);
          //           }));
          //         },
          //       )
          //     : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'All Reports',
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
              child: CashBillList.length == 0
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
                            Container(
                              width: tabletWidth,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: DateTimeField(
                                  format: dateFormat,
                                  controller: _fromDatetext,
                                  onShowPicker: (context, currentValue) async {
                                    final date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                    if (date != null) {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                            currentValue ?? DateTime.now()),
                                      );
                                      return DateTimeField.combine(date, time);
                                    } else {
                                      return currentValue;
                                    }
                                  },
                                  autovalidate: _fromDatevalidate,
                                  validator: (date) =>
                                      date == null ? 'Invalid date' : null,
                                  onChanged: (date) => setState(() {
                                    fromValue = date;
                                    print('Selected Date: ${date}');
                                  }),
                                  onSaved: (date) => setState(() {
                                    fromValue = date;
                                    print('Selected value Date: $fromValue');
                                    savedCount++;
                                  }),
                                  resetIcon:
                                      showResetIcon ? Icon(Icons.delete) : null,
                                  readOnly: readOnly,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'From Date',
                                    errorText: _fromDatevalidate
                                        ? 'Enter From Date'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: tabletWidth,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: DateTimeField(
                                  format: dateFormat,
                                  controller: _toDatetext,
                                  onShowPicker: (context, currentValue) async {
                                    final date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                    if (date != null) {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                            currentValue ?? DateTime.now()),
                                      );
                                      return DateTimeField.combine(date, time);
                                    } else {
                                      return currentValue;
                                    }
                                  },
                                  autovalidate: _toDatevalidate,
                                  validator: (date) =>
                                      date == null ? 'Invalid date' : null,
                                  onChanged: (date) => setState(() {
                                    toValue = date;
                                    print('Selected Date: ${toValue}');
                                  }),
                                  onSaved: (date) => setState(() {
                                    toValue = date;
                                    print('Selected value Date: $_toDatetext');
                                    savedCount++;
                                  }),
                                  resetIcon:
                                      showResetIcon ? Icon(Icons.delete) : null,
                                  readOnly: readOnly,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'To Date',
                                    errorText: _toDatevalidate
                                        ? 'Enter Purchase Date'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Material(
                                elevation: 5.0,
                                color: PrimaryColor,
                                borderRadius: BorderRadius.circular(10.0),
                                child: MaterialButton(
                                  onPressed: () async {
                                    setState(() {
                                      _fromDatetext.text.isEmpty
                                          ? _fromDatevalidate = true
                                          : _fromDatevalidate = false;
                                      _toDatetext.text.isEmpty
                                          ? _toDatevalidate = true
                                          : _toDatevalidate = false;

                                      int dateDiff =
                                          toValue.difference(fromValue).inDays;
                                      print('Date: $dateDiff');
                                      if (dateDiff >= 0) {
                                        _getCashBillDate(_fromDatetext.text,
                                            _toDatetext.text);
                                      } else {
                                        Fluttertoast.showToast(
                                          msg:
                                              "Select from date must be less than to date!!!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          backgroundColor: Colors.black38,
                                          textColor: Color(0xffffffff),
                                          gravity: ToastGravity.BOTTOM,
                                        );
                                      }
                                    });
                                    CircularProgressIndicator();
                                    // _toDatetext.clear();
                                  },
                                  minWidth: 75,
                                  height: 5.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Go",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
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
                                width: 50,
                                child: Text('Sr No',
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
  Widget _buildMobilePaymentModeAllCashReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Debit Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PaymentModeAllDebitReports()));
          break;
        case 'UPI Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AllUpiReports()));
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
                        "Cash Reports",
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
              // CashBillList.length != 0
              //     ? IconButton(
              //         icon: Icon(Icons.print, color: Colors.white),
              //         onPressed: () {
              //           Navigator.of(context)
              //               .push(MaterialPageRoute(builder: (_) {
              //             return AllReportPrint(1, CashBillList);
              //           }));
              //         },
              //       )
              //     : Text(''),
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {
                    'All Reports',
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
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        child: DateTimeField(
                          controller: _fromDatetext,
                          format: dateFormat,
                          keyboardType: TextInputType.number,
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                          autovalidate: autoValidate,
                          validator: (date) =>
                              date == null ? 'Invalid date' : null,
                          onChanged: (date) => setState(() {
                            fromValue = date;
                            print('Selected Date: ${date}');
                          }),
                          onSaved: (date) => setState(() {
                            fromValue = date;
                            print('Selected value Date: $fromValue');
                            savedCount++;
                          }),
                          resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                          readOnly: readOnly,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'From Date',
                            errorText:
                                _fromDatevalidate ? 'Enter From Date' : null,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        child: DateTimeField(
                          controller: _toDatetext,
                          format: dateFormat,
                          keyboardType: TextInputType.number,
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                          autovalidate: autoValidate,
                          validator: (date) =>
                              date == null ? 'Invalid date' : null,
                          onChanged: (date) => setState(() {
                            toValue = date;
                            print('Selected Date: ${toValue}');
                          }),
                          onSaved: (date) => setState(() {
                            toValue = date;
                            print('Selected value Date: $_toDatetext');
                            savedCount++;
                          }),
                          resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                          readOnly: readOnly,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'To Date',
                            errorText:
                                _toDatevalidate ? 'Enter Purchase Date' : null,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 60,
                      height: 30,
                      child: Material(
                        elevation: 5.0,
                        color: PrimaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                        child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _fromDatetext.text.isEmpty
                                  ? _fromDatevalidate = true
                                  : _fromDatevalidate = false;
                              _toDatetext.text.isEmpty
                                  ? _toDatevalidate = true
                                  : _toDatevalidate = false;

                              int dateDiff =
                                  toValue.difference(fromValue).inDays;
                              print('Date: $dateDiff');
                              if (dateDiff >= 0) {
                                _getbothpaymentDate(
                                    _fromDatetext.text, _toDatetext.text);
                              } else {
                                Fluttertoast.showToast(
                                  msg:
                                      "Select from date must be less than to date!!!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.black38,
                                  textColor: Color(0xffffffff),
                                  gravity: ToastGravity.BOTTOM,
                                );
                              }
                            });
                          },
                          minWidth: 60,
                          height: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              "Go",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: CashBillList.length,
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
                                        "Bill No:- ${CashBillList[index].Salesid.toString()} ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${CashBillList[index].SalesDate}",
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
                                            "${CashBillList[index].SalesCustomername}",
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
                                            "Rs.${CashBillList[index].SalesTotal.toString()}",
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
                                            "${CashBillList[index].SalesPaymentMode.toString()}",
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
      DataCell(Text(CashBillList[index].Salesid.toString())),
      DataCell(Text(CashBillList[index].SalesCustomername)),
      DataCell(Text(CashBillList[index].SalesDate)),
      DataCell(Text(CashBillList[index].SalesDiscount.toString())),
      DataCell(Text(CashBillList[index].SalesTotal.toString())),
      DataCell(Text(CashBillList[index].SalesPaymentMode)),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < CashBillList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  //-------------------------------------
//from server fetching All Cash Data
  void _getCashBill(String allrecords,String firstdate,String lastdate) async {
    CashBillFetch cashbillfetch = new CashBillFetch();
    var cashData = await cashbillfetch.getCashBillFetch(allrecords,firstdate,lastdate);
    var resid = cashData["resid"];
    var cashbillsd = cashData["sales"];
    print(cashbillsd.length);
    List<Sales> tempCashBill = [];
    for (var n in cashbillsd) {
      Sales pro = Sales(
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
          n["SalesPaymentMode"]);
      tempCashBill.add(pro);
    }
    setState(() {
      this.CashBillList = tempCashBill;
      this.CashBillListSearch = tempCashBill;
    });
    print("//////CashBillList/////////$CashBillList.length");

    SerachController.addListener(() {
      setState(() {
        if (CashBillListSearch != null) {
          String s = SerachController.text;
          CashBillList = CashBillListSearch.where((element) =>
              element.Salesid.toString()
                  .toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.SalesCustomername.toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.SalesDiscount.toLowerCase().contains(s.toLowerCase()) ||
              element.SalesTotal.toLowerCase().contains(s.toLowerCase()) ||
              element.SalesPaymentMode.toString()
                  .toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.SalesDate.toString()
                  .toLowerCase()
                  .contains(s.toLowerCase())).toList();
        }
      });
    });
  }

//-------------------------------------
  //-------------------------------------
//from server fetching cash data datewise
  void _getCashBillDate(String DateFrom, String DateTo) async {
    DateWiseFetch cashbilldatewisefetch = new DateWiseFetch();
    var cashDatewiaseData =
        await cashbilldatewisefetch.getCashBillDateWiseFetch(DateFrom, DateTo,"CASH");
    var resid = cashDatewiaseData["resid"];
    var cashbillDatewisesd = cashDatewiaseData["sales"];
    //print(cashbillDatewisesd.length);
    List<Sales> tempCashBillDateWise = [];
    for (var n in cashbillDatewisesd) {
      Sales pro = Sales(
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
          n["SalesPaymentMode"]);
      tempCashBillDateWise.add(pro);
    }
    setState(() {
      this.CashBillList = tempCashBillDateWise;
    });
    print("//////CashBillList/////////$CashBillList.length");
  }
//-------------------------------------


  //from server Fetching with Date
  void _getbothpaymentDate(String Datefrom, String dateto) async {
    ManegeSalesPaymentModeDateWiseFetch managesalespaymentmodedatewisefetch =
    new ManegeSalesPaymentModeDateWiseFetch();
    var managesalespaymentmodedatewisefetchData =
    await managesalespaymentmodedatewisefetch
        .getManageSalesPaymentModeDateWiseFetch(
        "CASH", Datefrom, dateto);
    var resid = managesalespaymentmodedatewisefetchData["resid"];

    if (resid == 200) {
      var managesalespaymentmodedatewisefetchsd =
      managesalespaymentmodedatewisefetchData["sales"];
      print(managesalespaymentmodedatewisefetchsd.length);
      List<Sales> tempmanagesalespaymentmodedatewisefetch = [];
      for (var n in managesalespaymentmodedatewisefetchsd) {
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
        tempmanagesalespaymentmodedatewisefetch.add(pro);
      }
      setState(() {
        this.CashBillList = tempmanagesalespaymentmodedatewisefetch;
      });
      print("//////CashBillList/////////$CashBillList.length");
    } else {
      String message = managesalespaymentmodedatewisefetchData["message"];
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
