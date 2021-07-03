import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_view_debit_bill_fetch.dart';
import 'package:retailerp/Adpater/pos_MnageSales_PaymentModeAndDatewise_fetch.dart';
import 'package:retailerp/Adpater/pos_Sales_datewise_fetch.dart';
import 'package:retailerp/Adpater/pos_view_debit_bill_datewise_fetch.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/pages/Manage_Sales.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';

import 'Add_Sales.dart';
import 'All_Debit_Reports_Print.dart';
import 'All_Reports.dart';
import 'All_Reports_Print.dart';
import 'All_Upi_Reports.dart';
import 'All_cash_Reports.dart';
import 'Import_sales.dart';
import 'PaymentMode_All_cash_Reports.dart';
import 'PaymentMode_Todays_Debit_Reports_Print.dart';

class PaymentModeAllDebitReports extends StatefulWidget {
  @override
  _PaymentModeAllDebitReportsState createState() =>
      _PaymentModeAllDebitReportsState();
}

class _PaymentModeAllDebitReportsState
    extends State<PaymentModeAllDebitReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobilePaymentModeAllDebitReports();
    } else {
      content = _buildTabletPaymentModeAllDebitReports();
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
  Widget appBarTitle = Text("Debit Reports");
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );

//-------------------------------------------
//-------------------------------------------
  final initialValue = DateTime.now();
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;

  //DatabaseHelper databaseHelper = DatabaseHelper();
  List<Sales> DebitBillList = new List();
  List<Sales> DebitBillListSearch = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;

  @override
  void initState() {
    //ShowSalesdetails();
    _getDebitBill();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletPaymentModeAllDebitReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.30;
    void handleClick(String value) {
      switch (value) {
        case 'Cash Reports':
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentModeAllCashReports()));
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
            FaIcon(FontAwesomeIcons.creditCard),
            SizedBox(
              width: 20.0,
            ),
            Text('All Debit Reports'),
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
          DebitBillList.length != 0
              ? IconButton(
                  icon: Icon(Icons.print, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return PaymentModeTodaysDebitReportPrint(
                          1, DebitBillList);
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
        child: ModalProgressHUD(
          inAsyncCall: _showCircle,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
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
                                  initialDate: currentValue ?? DateTime.now(),
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
                              errorText:
                                  _fromDatevalidate ? 'Enter From Date' : null,
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
                                  initialDate: currentValue ?? DateTime.now(),
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
                                  _getDebitBillDateWise(
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
                          width: 30,
                          child: Text('Sr\nNo',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Container(
                          width: 100,
                          child: Text('Customer\nName',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Container(
                          child: Text('Date',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Container(
                          child: Text('Total',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Container(
                          child: Text('Payment Card\n Type',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Container(
                          child: Text('Card\nType',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Container(
                          child: Text('Name On\nCard',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Container(
                          child: Text('Card\nNumber',
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
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobilePaymentModeAllDebitReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Cash Reports':
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentModeAllCashReports()));
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
                        "Debit Reports",
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
              DebitBillList.length != 0
                  ? IconButton(
                      icon: Icon(Icons.print, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PaymentModeTodaysDebitReportPrint(
                              1, DebitBillList);
                        }));
                      },
                    )
                  : Text(''),
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Cash Reports', 'UPI Reports'}.map((String choice) {
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
                        itemCount: DebitBillList.length,
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
                                        "Bill No:- ${DebitBillList[index].Salesid.toString()} ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${DebitBillList[index].SalesDate}",
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
                                            "${DebitBillList[index].SalesCustomername}",
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
                                            "Rs.${DebitBillList[index].SalesTotal.toString()}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Payment Card:",
                                            style: headHintTextStyle),
                                        Text(
                                            "${DebitBillList[index].SalesPaymentCardType}",
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
                                            "${DebitBillList[index].SalesCardType}",
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
                                            "${DebitBillList[index].SalesNameOnCard}",
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
                                            "${DebitBillList[index].SalesCardName}",
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
      DataCell(Text(DebitBillList[index].Salesid.toString())),
      DataCell(Text(DebitBillList[index].SalesCustomername)),
      DataCell(Text(DebitBillList[index].SalesDate)),
      DataCell(Text(DebitBillList[index].SalesTotal.toString())),
      DataCell(Text(DebitBillList[index].SalesPaymentCardType.toString())),
      DataCell(Text(DebitBillList[index].SalesCardType.toString())),
      DataCell(Text(DebitBillList[index].SalesNameOnCard)),
      DataCell(Text(DebitBillList[index].SalesCardName)),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < DebitBillList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  //-------------------------------------
//from server fetching sales Debit Bill
  void _getDebitBill() async {
    setState(() {
      _showCircle = true;
    });
    DebitBillFetch debitbillfetch = new DebitBillFetch();
    var debitData = await debitbillfetch.getDebitBillFetch("1");
    var resid = debitData["resid"];

    if (resid == 200) {
      var rowcount = debitData["rowcount"];

      if (rowcount > 0) {
        var debitbillsd = debitData["sales"];
        print(debitbillsd.length);
        List<Sales> tempdebitBill = [];
        for (var n in debitbillsd) {
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
          tempdebitBill.add(pro);
        }
        setState(() {
          this.DebitBillList = tempdebitBill;
          this.DebitBillListSearch = tempdebitBill;
          _showCircle = false;
        });
        print("//////DebitBillList/////////$DebitBillList.length");
        SerachController.addListener(() {
          setState(() {
            if (DebitBillListSearch != null) {
              String s = SerachController.text;
              DebitBillList = DebitBillListSearch.where((element) =>
                  element.Salesid.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesCustomername.toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesDiscount.toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesTotal.toLowerCase().contains(s.toLowerCase()) ||
                  element.SalesPaymentMode.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesDate.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesPaymentCardType.toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesCardType.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesNameOnCard.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesCardName.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase())).toList();
            }
          });
        });
      } else {
        setState(() {
          _showCircle = false;
        });
        String msg = debitData["message"];
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
      String msg = debitData["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

//-------------------------------------
//from server fetching sales Debit  Bill Datewise
  void _getDebitBillDateWise(String DateFrom, String DateTo) async {
    DebitBillDateWiseFetch debitbilldatewisefetch =
        new DebitBillDateWiseFetch();
    var debitData = await debitbilldatewisefetch.getDebitBillDateWiseFetch(
        DateFrom, DateTo);
    var resid = debitData["resid"];
    if (resid == 200) {
      var rowcount = debitData["rowcount"];

      if (rowcount > 0) {
        var debitbillsd = debitData["sales"];
        print(debitbillsd.length);
        List<Sales> tempdebitBill = [];
        for (var n in debitbillsd) {
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
          tempdebitBill.add(pro);
        }
        setState(() {
          this.DebitBillList = tempdebitBill;
          this.DebitBillListSearch = tempdebitBill;
          _showCircle = false;
        });
        print("//////DebitBillList/////////$DebitBillList.length");
        SerachController.addListener(() {
          setState(() {
            if (DebitBillListSearch != null) {
              String s = SerachController.text;
              DebitBillList = DebitBillListSearch.where((element) =>
                  element.Salesid.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesCustomername.toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesDiscount.toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesTotal.toLowerCase().contains(s.toLowerCase()) ||
                  element.SalesPaymentMode.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesDate.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesPaymentCardType.toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesCardType.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesNameOnCard.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesCardName.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase())).toList();
            }
          });
        });
      } else {
        setState(() {
          _showCircle = false;
        });
        String msg = debitData["message"];
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
      String msg = debitData["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

//-------------------------------------

  //from server Fetching with Date
  void _getbothpaymentDate(String Datefrom, String dateto) async {
    ManegeSalesPaymentModeDateWiseFetch managesalespaymentmodedatewisefetch =
        new ManegeSalesPaymentModeDateWiseFetch();
    var debitData = await managesalespaymentmodedatewisefetch
        .getManageSalesPaymentModeDateWiseFetch("DEBIT", Datefrom, dateto);
    var resid = debitData["resid"];

    if (resid == 200) {
      var rowcount = debitData["rowcount"];

      if (rowcount > 0) {
        var debitbillsd = debitData["sales"];
        print(debitbillsd.length);
        List<Sales> tempdebitBill = [];
        for (var n in debitbillsd) {
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
          tempdebitBill.add(pro);
        }
        setState(() {
          this.DebitBillList = tempdebitBill;
          this.DebitBillListSearch = tempdebitBill;
          _showCircle = false;
        });
        print("//////DebitBillList/////////$DebitBillList.length");
        SerachController.addListener(() {
          setState(() {
            if (DebitBillListSearch != null) {
              String s = SerachController.text;
              DebitBillList = DebitBillListSearch.where((element) =>
                  element.Salesid.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesCustomername.toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesDiscount.toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesTotal.toLowerCase().contains(s.toLowerCase()) ||
                  element.SalesPaymentMode.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesDate.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesPaymentCardType.toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesCardType.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesNameOnCard.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SalesCardName.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase())).toList();
            }
          });
        });
      } else {
        setState(() {
          _showCircle = false;
        });
        String msg = debitData["message"];
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
      String msg = debitData["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
