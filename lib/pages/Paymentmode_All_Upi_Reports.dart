import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos-view_upi-bill_fetch.dart';
import 'package:retailerp/Adpater/pos_MnageSales_PaymentModeAndDatewise_fetch.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';

import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/pages/PaymentMode_Todays_UPI_Reports_Print.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';



import 'PaymentMode_All_Debit_Reports.dart';
import 'PaymentMode_All_cash_Reports.dart';



class PaymentModeAllUpiReports extends StatefulWidget {
  @override
  _PaymentModeAllUpiReportsState createState() => _PaymentModeAllUpiReportsState();
}

class _PaymentModeAllUpiReportsState extends State<PaymentModeAllUpiReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobilePaymentModeAllUpiReports();
    } else {
      content = _buildTabletPaymentModeAllUpiReports();
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
  Widget appBarTitle = Text("UPI Reports");
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
  bool Datetofromenable = false;
  String PaymentMode;

  //DatabaseHelper databaseHelper = DatabaseHelper();
  List<EhotelSales> UpiBillList = new List();
  List<EhotelSales> UpiBillListSearch = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;
  String UpiFilter;


  @override
  void initState() {
    _getUpiBill();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletPaymentModeAllUpiReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.30;
    void handleClick(String value) {
      switch (value) {
        case 'Cash Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PaymentModeAllCashReports()));
          break;
        case 'Debit Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PaymentModeAllDebitReports()));
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
            Text('UPI Reports'),
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
          // UpiBillList.length != 0
          //     ? IconButton(
          //   icon: Icon(Icons.print, color: Colors.white),
          //   onPressed: () {
          //     Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (_) {
          //       return PaymentModeTodaysUPIReportPrint(1, UpiBillList);
          //     }));
          //   },
          // )
          //     : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
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
            child: UpiBillList.length == 0
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
                                validator: (date) => date == null ? 'Invalid date' : null,
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
                                  errorText: _fromDatevalidate ? 'Enter From Date' : null,
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
                                validator: (date) => date == null ? 'Invalid date' : null,
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
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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

                                    int dateDiff = toValue.difference(fromValue).inDays;
                                    print('Date: $dateDiff');
                                    if (dateDiff >= 0) {
                                      if(_fromDatetext==null || _toDatetext==null)
                                        {
                                          _getUpiBill();
                                        }else
                                          {
                                            //_getUpiBillDateWise(_fromDatetext.text, _toDatetext.text);
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
  Widget _buildMobilePaymentModeAllUpiReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Cash Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PaymentModeAllCashReports()));
          break;
        case 'Debit Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PaymentModeAllDebitReports()));
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
                        "UPI Reports",
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
              // UpiBillList.length != 0
              //     ? IconButton(
              //   icon: Icon(Icons.print, color: Colors.white),
              //   onPressed: () {
              //     Navigator.of(context)
              //         .push(MaterialPageRoute(builder: (_) {
              //       return PaymentModeTodaysUPIReportPrint(1, UpiBillList);
              //     }));
              //   },
              // )
              //     : Text(''),
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {
                    'Cash Reports',
                    'Debit Reports',}
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

                                if(_fromDatetext==null || _toDatetext==null)
                                {
                                  _getUpiBill();
                                }else
                                {
                                 // _getUpiBillDateWise(_fromDatetext.text, _toDatetext.text);
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
                        itemCount: UpiBillList.length,
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
                                        "Bill No:- ${UpiBillList[index].menusalesid.toString()} ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${UpiBillList[index].medate}",
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
                                            "${UpiBillList[index].customername}",
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
                                            "Rs.${UpiBillList[index].totalamount.toString()}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Payment Mode:",
                                            style: headHintTextStyle),
                                        Text(
                                            "${UpiBillList[index].paymodename.toString()}",
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
      DataCell(Text(UpiBillList[index].menusalesid.toString())),
      DataCell(Text(UpiBillList[index].customername)),
      DataCell(Text(UpiBillList[index].medate)),
      DataCell(Text(UpiBillList[index].discount.toString())),
      DataCell(Text(UpiBillList[index].totalamount.toString())),
      DataCell(Text(UpiBillList[index].paymodename)),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < UpiBillList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }


  //-------------------------------------
//from server fetching sales UPI Data
  void _getUpiBill() async {
    UpiBillFetch upibillfetch = new UpiBillFetch();
    var UpiData = await upibillfetch.getUpiBillFetch();
    var resid = UpiData["resid"];
    var upibillsd = UpiData["sales"];
    print(upibillsd.length);
    List<EhotelSales> tempupiBill = [];
    for (var n in upibillsd) {
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
      tempupiBill.add(pro);
    }
    setState(() {
      this.UpiBillList = tempupiBill;
      this.UpiBillListSearch = tempupiBill;
    });
    print("//////SalesList/////////$UpiBillList.length");

    SerachController.addListener(() {
      setState(() {
        if(UpiBillListSearch != null){
          String s = SerachController.text;
          UpiBillList = UpiBillListSearch.where((element) => element.menusalesid.toString().toLowerCase().contains(s.toLowerCase())
              || element.customername.toLowerCase().contains(s.toLowerCase())
              ||element.discount.toLowerCase().contains(s.toLowerCase())
              ||element.totalamount.toLowerCase().contains(s.toLowerCase())
              ||element.paymodename.toString().toLowerCase().contains(s.toLowerCase())
              ||element.medate.toString().toLowerCase().contains(s.toLowerCase())).toList();
        }
      });
    });
  }
//-------------------------------------
//from server fetching sales Debit Data
//   void _getUpiBillDateWise(String DateFrom,String DateTo) async {
//     UpiBillDatewiseFetch upibilldatewisefetch = new UpiBillDatewiseFetch();
//     var UpiDatadatewise = await upibilldatewisefetch.getUpiBillDateWiseFetch(DateFrom,DateTo);
//     var resid = UpiDatadatewise["resid"];
//     var upibilldatewisesd = UpiDatadatewise["sales"];
//     print(upibilldatewisesd.length);
//     List<Sales> tempupiBillDateWise = [];
//     for (var n in upibilldatewisesd) {
//       Sales pro = Sales.ManageList(
//           int.parse(n["SalesId"]),
//           n["SalesCustomername"],
//           n["SalesDate"],
//           n["SalesProductName"],
//           n["SalesProductRate"],
//           n["SalesProductQty"],
//           n["SalesProductSubTotal"],
//           n["SalesSubTotal"],
//           n["SalesDiscount"],
//           n["SalesGST"],
//           n["SalesTotalAmount"],
//           n["SalesNarration"],
//           n["SalesPaymentMode"],
//           n["SalesProductIDs"],
//           n["SalesPaymentCardType"],
//           n["SalesCardType"],
//           n["SalesNameonCard"],
//           n["SalesCardNumber"],
//           n["SalesBankName"],
//           n["SalesUPITransationNumber"]);
//       tempupiBillDateWise.add(pro);
//     }
//     setState(() {
//       this.UpiBillList = tempupiBillDateWise;
//     });
//     print("//////SalesList/////////$UpiBillList.length");
//   }
//-------------------------------------




//from server Fetching with Date
//   void _getbothpaymentDate(String Datefrom, String dateto) async {
//     ManegeSalesPaymentModeDateWiseFetch managesalespaymentmodedatewisefetch =
//     new ManegeSalesPaymentModeDateWiseFetch();
//     var managesalespaymentmodedatewisefetchData =
//     await managesalespaymentmodedatewisefetch
//         .getManageSalesPaymentModeDateWiseFetch(
//         "UPI", Datefrom, dateto);
//     var resid = managesalespaymentmodedatewisefetchData["resid"];
//
//     if (resid == 200) {
//       var managesalespaymentmodedatewisefetchsd =
//       managesalespaymentmodedatewisefetchData["sales"];
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
//         this.UpiBillList = tempmanagesalespaymentmodedatewisefetch;
//       });
//       print("//////UpiBillList/////////$UpiBillList.length");
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

}
