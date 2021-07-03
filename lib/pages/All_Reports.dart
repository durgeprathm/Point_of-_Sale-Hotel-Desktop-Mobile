import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_month_wise_bill_fetch.dart';
import 'package:retailerp/Adpater/pos_MnageSales_PaymentMode_fetch.dart';
import 'package:retailerp/Adpater/pos_Sales_datewise_fetch.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';

import 'All_Debit_Reports.dart';
import 'All_Reports_Print.dart';
import 'All_Upi_Reports.dart';
import 'All_cash_Reports.dart';

class AllReports extends StatefulWidget {
  @override
  _AllReportsState createState() => _AllReportsState();
}

class _AllReportsState extends State<AllReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileAllReports();
    } else {
      content = _buildTabletAllReports();
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
  Widget appBarTitle = Text("All Reports");
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
//-------------------------------------------
//-------------------------------------------

  //DatabaseHelper databaseHelper = DatabaseHelper();
  String PaymentMode;
  final initialValue = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;
  bool Datetofromenable = false;
  List<EhotelSales> SalesList = [];
  List<EhotelSales> SalesListSearch = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;

  @override
  void initState() {
    _getSales();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletAllReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.30;
    void handleClick(String value) {
      switch (value) {
        case 'Cash Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AllCashReports()));
          break;
        case 'Debit Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AllDebitReports()));
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
            FaIcon(FontAwesomeIcons.book),
            SizedBox(
              width: 20.0,
            ),
            Text('All Reports'),
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
          SalesList.length != 0
              ? IconButton(
                  icon: Icon(Icons.print, color: Colors.white),
                  onPressed: () {
                    double total = 0.0;
                    for(int i=0;i<SalesList.length;i++){
                      total = total + double.parse(SalesList[i].totalamount);
                    }
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return AllReportPrint(1, SalesList,total);
                    }));
                  },
                )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Cash Reports', 'Debit Reports', 'UPI Reports'}
                  .map((String choice) {
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
            child: SalesList.length == 0
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
                                  _getSales();
                                } else {
                                  _getSalesPaymentMode(PaymentMode);
                                }

                                print(PaymentMode);
                              },
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
                                  _getDatewise(_fromDatetext.text.toString(),_toDatetext.text.toString());
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
                                      if (PaymentMode == "All" ||
                                          PaymentMode == null) {
                                        // _getDatewise(
                                        //     _fromDatetext.text, _toDatetext.text);
                                      } else {
                                        // _getbothpaymentDate(PaymentMode,
                                        //     _fromDatetext.text, _toDatetext.text);
                                      }
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
                  ),
          ),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobileAllReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Cash Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AllCashReports()));
          break;
        case 'Debit Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AllDebitReports()));
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
                        "All Reports",
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
              SalesList.length != 0
                  ? IconButton(
                      icon: Icon(Icons.print, color: Colors.white),
                      onPressed: () {


                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: (_) {
                        //   return AllReportPrint(1, SalesList);
                        // }));
                      },
                    )
                  : Text(''),
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Cash Reports', 'Debit Reports', 'UPI Reports'}
                      .map((String choice) {
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
                Container(
                  height: 40,
                  child: DropdownSearch(
                    items: [
                      "All",
                      "CASH",
                      "DEBIT",
                      "UPI",
                    ],
                    showClearButton: true,
                    showSearchBox: true,
                    label: 'Payment Mode',
                    hint: "Payment Mode",
                    // selectedItem: 'All',
                    searchBoxDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                      labelText: "Payment Mode",
                    ),
                    onChanged: (String value) {
                      PaymentMode = value;
                      if (PaymentMode == "All" || PaymentMode == null) {
                        _getSales();
                      } else {
                        //_getSalesPaymentMode(PaymentMode);
                      }
                      print(PaymentMode);
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
                                if (PaymentMode == "All" ||
                                    PaymentMode == null) {
                                  // _getDatewise(
                                  //     _fromDatetext.text, _toDatetext.text);
                                } else {
                                  // _getbothpaymentDate(PaymentMode,
                                  //     _fromDatetext.text, _toDatetext.text);
                                }
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
                        itemCount: SalesList.length,
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
                                        "Bill No:- ${SalesList[index].menusalesid.toString()} ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${SalesList[index].medate}",
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
                                            "${SalesList[index].customername}",
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
                                            "Rs.${double.parse(SalesList[index].totalamount).toStringAsFixed(2)}",
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
                                            "${SalesList[index].paymodename.toString()}",
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
      DataCell(Text(SalesList[index].menusalesid.toString())),
      DataCell(Text(SalesList[index].customername)),
      DataCell(Text(SalesList[index].medate)),
      DataCell(Text(SalesList[index].discount.toString())),
      DataCell(Text(double.parse(SalesList[index].totalamount).toStringAsFixed(2))),
      DataCell(Text(SalesList[index].paymodename.toString())),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < SalesList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  //-------------------------------------
//from server
  void _getSales() async {
    SalesFetchAllDetails salesfetch = new SalesFetchAllDetails();
    var salesData = await salesfetch.getSalesFetch("0");
    var resid = salesData["resid"];

    if (resid == 200) {
      var salessd = salesData["allbilllist"];
      //print(salessd.length);
      List<EhotelSales> tempSales = [];
      for (var n in salessd) {
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
        tempSales.add(pro);
      }
      setState(() {
        this.SalesList = tempSales;
        this.SalesListSearch = tempSales;
      });
      print("//////SalesList/////////$SalesList.length");

      SerachController.addListener(() {
        setState(() {
          if (SalesListSearch != null) {
            String s = SerachController.text;
            SalesList = SalesListSearch.where((element) =>
                element.menusalesid.toString()
                    .toLowerCase()
                    .contains(s.toLowerCase()) ||
                element.customername.toLowerCase()
                    .contains(s.toLowerCase()) ||
                element.discount.toLowerCase().contains(s.toLowerCase()) ||
                element.totalamount.toLowerCase().contains(s.toLowerCase()) ||
                element.paymodename.toString()
                    .toLowerCase()
                    .contains(s.toLowerCase()) ||
                element.medate.toString()
                    .toLowerCase()
                    .contains(s.toLowerCase())).toList();
          }
        });
      });
    } else {
      String message = salesData["message"];
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
//from server Fetching Payment Mode Data
  void _getSalesPaymentMode(String PaymentMode) async {
    ManegeSalesPaymentModeFetch managesalespaymentmodefetch =
        new ManegeSalesPaymentModeFetch();
    var managesalespaymentmodefetchData = await managesalespaymentmodefetch
        .getManageSalesPaymentModeFetch(PaymentMode);
    var resid = managesalespaymentmodefetchData["resid"];

    if (resid == 200) {
      var managesalespaymentmodefetchDatasd =
          managesalespaymentmodefetchData["sales"];
      print(managesalespaymentmodefetchDatasd.length);
      List<EhotelSales> tempmanagesalespaymentmodefetchDatasd = [];
      for (var n in managesalespaymentmodefetchDatasd) {
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
        tempmanagesalespaymentmodefetchDatasd.add(pro);
      }
      setState(() {
        this.SalesList = tempmanagesalespaymentmodefetchDatasd;
      });
      print("//////SalesList/////////$SalesList.length");
    } else {
      String message = managesalespaymentmodefetchData["message"];
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

//from server Fetching with paymentmode  And Date
//   void _getbothpaymentDate(
//       String paymentmode, String Datefrom, String dateto) async {
//     ManegeSalesPaymentModeDateWiseFetch managesalespaymentmodedatewisefetch =
//         new ManegeSalesPaymentModeDateWiseFetch();
//     var managesalespaymentmodedatewisefetchData =
//         await managesalespaymentmodedatewisefetch
//             .getManageSalesPaymentModeDateWiseFetch(
//                 paymentmode, Datefrom, dateto);
//     var resid = managesalespaymentmodedatewisefetchData["resid"];
//
//     if (resid == 200) {
//       var managesalespaymentmodedatewisefetchsd =
//           managesalespaymentmodedatewisefetchData["sales"];
//       print(managesalespaymentmodedatewisefetchsd.length);
//       List<Sales> tempmanagesalespaymentmodedatewisefetch = [];
//       for (var n in managesalespaymentmodedatewisefetchsd) {
//         Sales pro = Sales.ManageList(
//             int.parse(n["SalesId"]),
//             n["SalesCustomername"],
//             n["SalesDate"],
//             n["SalesProductName"],
//             n["SalesProductRate"],
//             n["SalesProductQty"],
//             n["SalesProductSubTotal"],
//             n["SalesSubTotal"],
//             n["SalesDiscount"],
//             n["SalesGST"],
//             n["SalesTotalAmount"],
//             n["SalesNarration"],
//             n["SalesPaymentMode"],
//             n["SalesProductIDs"],
//             n["SalesPaymentCardType"],
//             n["SalesCardType"],
//             n["SalesNameonCard"],
//             n["SalesCardNumber"],
//             n["SalesBankName"],
//             n["SalesUPITransationNumber"]);
//         tempmanagesalespaymentmodedatewisefetch.add(pro);
//       }
//       setState(() {
//         this.SalesList = tempmanagesalespaymentmodedatewisefetch;
//       });
//       print("//////SalesList/////////$SalesList.length");
//     } else {
//       String message = managesalespaymentmodedatewisefetchData["message"];
//       Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_SHORT,
//         backgroundColor: Colors.black38,
//         textColor: Color(0xffffffff),
//         gravity: ToastGravity.BOTTOM,
//       );
//     }
//   }

 // from server Fetching with Date
  void _getDatewise(String Datefrom, String dateto) async {
    SalesDateWiseFetch salesdatewisefetch = new SalesDateWiseFetch();
    var salesdatewisefetchData =
        await salesdatewisefetch.getSalesDateWiseFetchFetch(Datefrom, dateto);
    var resid = salesdatewisefetchData["resid"];

    if (resid == 200) {
      var salesdatewisefetchfetchsd = salesdatewisefetchData["sales"];
      print(salesdatewisefetchfetchsd.length);
      List<EhotelSales> tempsalesdatewisefetchfetch = [];
      for (var n in salesdatewisefetchfetchsd) {
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
        tempsalesdatewisefetchfetch.add(pro);
      }
      setState(() {
        this.SalesList = tempsalesdatewisefetchfetch;
      });
      print("//////SalesList/////////$SalesList.length");
    } else {
      String message = salesdatewisefetchData["message"];
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
