import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_sales_fetch.dart';
import 'package:retailerp/Adpater/Fetch_Account_Type_Payment.dart';
import 'package:retailerp/Adpater/Fetch_All_Payment_Mode.php.dart';
import 'package:retailerp/Adpater/pos_MnageSales_PaymentModeAndDatewise_fetch.dart';
import 'package:retailerp/Adpater/pos_MnageSales_PaymentMode_fetch.dart';
import 'package:retailerp/Adpater/pos_sales_delete.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/Datatables/View_Sales_book_Source.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/Pagination_notifier/view_salesbook_bill_datanotifier.dart';
import 'package:retailerp/editPOSUI/table_pos_frontpage_edit.dart';
import 'package:retailerp/models/Accountype.dart';
import 'package:retailerp/models/PaymentMode.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';
import 'Add_Sales.dart';
import 'Import_sales.dart';
import 'Preview_sales.dart';

class ManageSales extends StatefulWidget {
  @override
  _ManageSalesState createState() => _ManageSalesState();
}

class _ManageSalesState extends State<ManageSales> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
     // content = _buildMobileManageSales();
    } else {
      content = _buildTabletManageSales();
    }

    return content;
  }

//-------------------------------------------

  //DatabaseHelper databaseHelper = DatabaseHelper();
  String PaymentMode;
  final dateFormat = DateFormat("yyyy-MM-dd");
  final initialValue = DateTime.now();
  final _fromDatetext = TextEditingController();
  final _toDatetext = TextEditingController();
  DateTime fromValue = DateTime.now();
  DateTime toValue = DateTime.now();
  bool _fromDatevalidate = false;
  bool _toDatevalidate = false;
  int changedCount = 0;
  int savedCount = 0;
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;
  bool Datetofromenable = false;
  String AccountTypeID;
  List<EhotelSales> SalesList = new List();
  List<AllPaymentModeType> AllPaymentmodeList = new List();
  List<AllAccountType> AllAccounttypeList = new List();
  List<EhotelSales> searchSalesList = [];

  int count;
  TextEditingController searchController = TextEditingController();
  TextEditingController _textPaymentmode = TextEditingController();
  TextEditingController _textAccountType = TextEditingController();

  bool _showCircle = false;
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = Text("Manage Sales");


  @override
  void initState() {
    Provider.of<ViewSalesBookDataNotifier>(context, listen: false).clear();
    _getPaymentMode();
    _getAccountType();
    final DateTime now = DateTime.now();
    final DateTime pre = new DateTime(now.year, now.month - 1, now.day);
    final String toDate = dateFormat.format(now);
    final String formDate = dateFormat.format(pre);
    _toDatetext.text = toDate;
    _fromDatetext.text = formDate;
    _getSales('0', '1', "","","","");
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletManageSales() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.18;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.25;
    final _provider = context.watch<ViewSalesBookDataNotifier>();
    final _model = _provider.ViewSalesBookModel;
    final _dtSource = ViewSalesBookDataTableSource(
        ViewSalesBookData: _model,
        context: context
    );
    void handleClick(String value) {
      switch (value) {
        case 'Add Sales':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
          break;
        case 'Import Sales':
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
            FaIcon(FontAwesomeIcons.shoppingBag),
            SizedBox(
              width: 20.0,
            ),
            Text('Sales Book'),
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
                'Add Sales',
                'Import Sales',
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
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 40,
                      width: tabletWidth,
                      child: TextField(
                        controller: searchController,
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
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: tabletWidth,
                      child: DropdownSearch<AllAccountType>(
                        searchBoxController: _textAccountType,
                        isFilteredOnline: true,
                        showClearButton: true,
                        showSearchBox: true,
                        items: AllAccounttypeList,
                        onSaved: (AllAccountType value) {
                          _textAccountType.text =
                              value.AccountTypeName.toString();
                        },

                        label: "Account Type",
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) {
                          if (value != null) {
                            AccountTypeID =
                                value.AccountTypeID.toString();
                            if (AccountTypeID == "0") {
                              _getSales('0', '1', "","","","");
                            } else {
                              print("//_getSales function call///////////////////${AccountTypeID}");
                              _getSales('0',"", AccountTypeID,"","","");
                            }
                            print("//AccountTypeID///////////////////${AccountTypeID}");
                          } else {}
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: tabletWidth,
                      child: DropdownSearch<AllPaymentModeType>(
                        searchBoxController: _textPaymentmode,
                        isFilteredOnline: true,
                        showClearButton: true,
                        showSearchBox: true,
                        items: AllPaymentmodeList,
                        onSaved: (AllPaymentModeType value) {
                          _textPaymentmode.text =
                              value.PaymentModeName.toString();
                        },

                        label: "Payment Mode",
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) {
                          if (value != null) {
                            PaymentMode =
                                value.PaymentModeId.toString();
                            if (PaymentMode == "0") {
                              _getSales('0', '1', "","","","");
                            } else {
                              print("//_getSalesPaymentMode function call///////////////////${PaymentMode}");
                              _getSales('0',"", "",PaymentMode,"","");
                            }
                            print("//PaymentMode///////////////////${PaymentMode}");
                          } else {}
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: tabletWidth,
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
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: tabletWidth,
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
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
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
                                _getSales('0',"", "","",_fromDatetext.text,_toDatetext.text);
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
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "Go",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Container(
              //       child: Center(
              //         child: DataTable(columns: [
              //           DataColumn(
              //               label: Expanded(
              //             child: Container(
              //               width: 70,
              //               child: Center(
              //                 child: Text('Bill No',
              //                     style: TextStyle(
              //                         fontSize: 20,
              //                         fontWeight: FontWeight.bold)),
              //               ),
              //             ),
              //           )),
              //           DataColumn(
              //               label: Expanded(
              //             child: Container(
              //               child: Center(
              //                 child: Text('Date',
              //                     style: TextStyle(
              //                         fontSize: 20,
              //                         fontWeight: FontWeight.bold)),
              //               ),
              //             ),
              //           )),
              //           DataColumn(
              //               label: Expanded(
              //             child: Container(
              //               child: Center(
              //                 child: Text('Customer Name',
              //                     style: TextStyle(
              //                         fontSize: 20,
              //                         fontWeight: FontWeight.bold)),
              //               ),
              //             ),
              //           )),
              //           DataColumn(
              //               label: Expanded(
              //                 child: Container(
              //                   child: Center(
              //                     child: Text('Total',
              //                         style: TextStyle(
              //                             fontSize: 20,
              //                             fontWeight: FontWeight.bold)),
              //                   ),
              //                 ),
              //               )),
              //           DataColumn(
              //               label: Expanded(
              //                 child: Container(
              //                   child: Center(
              //                     child: Text('Discount',
              //                         style: TextStyle(
              //                             fontSize: 20,
              //                             fontWeight: FontWeight.bold)),
              //                   ),
              //                 ),
              //               )),
              //           DataColumn(
              //               label: Expanded(
              //                 child: Container(
              //                   child: Center(
              //                     child: Text('Pay Mode',
              //                         style: TextStyle(
              //                             fontSize: 20,
              //                             fontWeight: FontWeight.bold)),
              //                   ),
              //                 ),
              //               )),
              //           DataColumn(
              //               label: Expanded(
              //                 child: Container(
              //                   child: Center(
              //                     child: Text('Type',
              //                         style: TextStyle(
              //                             fontSize: 20,
              //                             fontWeight: FontWeight.bold)),
              //                   ),
              //                 ),
              //               )),
              //           DataColumn(
              //             label: Expanded(
              //               child: Container(
              //                 child: Center(
              //                   child: Text('Action',
              //                       style: TextStyle(
              //                           fontSize: 20,
              //                           fontWeight: FontWeight.bold)),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ], rows: getDataRowList()),
              //       ),
              //     ),
              //   ),
              // ),
              CustomPaginatedTable(
                dataColumns: _colGen(_provider),
                // header: const Text("Sales Day Wise Report"),
                onRowChanged: (index) => _provider.rowsPerPage = index,
                rowsPerPage: _provider.rowsPerPage,
                source: _dtSource,
                showActions: true,
                sortColumnIndex: _provider.sortColumnIndex,
                sortColumnAsc: _provider.sortAscending,
              ),
            ],
          ),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//


  DataRow getRow(int index) {
    int srNo = index + 1;
    return DataRow(cells: [
      DataCell(Center(child: Text(searchSalesList[index].menusalesid.toString()))),
      DataCell(Center(child: Text(searchSalesList[index].medate))),
      DataCell(Center(child: Text(searchSalesList[index].customername))),
      DataCell(Center(child: Text(searchSalesList[index].totalamount.toString()))),
      DataCell(Center(child: Text(searchSalesList[index].discount.toString()))),
      DataCell(Center(child: Text(searchSalesList[index].paymodename.toString()))),
      DataCell(Center(child: Text(searchSalesList[index].accounttypename.toString()))),
      DataCell(
        Center(
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.preview,
                ),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PreviewSales(index, searchSalesList)));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.edit,
                ),
                color: Colors.green,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TablePosEdit(index,searchSalesList)));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                color: Colors.red,
                onPressed: () {
                  _showMyDialog(searchSalesList[index].menusalesid);
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < searchSalesList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  Future<void> _showMyDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              "Want To Delete!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Delete'),
                onPressed: () {
                  SalesDelete salesdelete = new SalesDelete();
                  salesdelete.getSalesDelete(id.toString());
                  print("///delete id///$id");
                  Navigator.of(context).pop();
                  _getSales('0', '1', '', '',"","");
                  // _getSales();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  List<DataColumn> _colGen(
      ViewSalesBookDataNotifier _provider,
      ) =>
      <DataColumn>[
        DataColumn(
          label: Text("Bill NO",style: tablecolumname),
          numeric: true,
          tooltip: "Bill NO",
        ),
        DataColumn(
          label: Text('Date',style: tablecolumname),
          tooltip: 'Date',
        ),
        DataColumn(
          label: Text('Customer Name',style: tablecolumname),
          tooltip: 'Customer Name',
        ),
        DataColumn(
          label: Text('Total',style: tablecolumname),
          tooltip: 'Total',
        ),
        DataColumn(
          label: Text('Discount',style: tablecolumname),
          tooltip: 'Discount',
        ),
        DataColumn(
          label: Text('Mode',style: tablecolumname),
          tooltip: 'Mode',
        ),
        DataColumn(
          label: Text('Type',style: tablecolumname),
          tooltip: 'Type',
        ),
        DataColumn(
          label: Text('Action' ,style: tablecolumname),
          tooltip: 'Action',
        ),
      ];

  void _sort<T>(
      Comparable<T> Function(EhotelSales sale) getField,
      int colIndex,
      bool asc,
      ViewSalesBookDataNotifier _provider,
      ) {
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  //-------------------------------------
//from server
  void _getSales(action,allrecords,accounttype, paymentId, fromDate, toDate) async {
    setState(() {
      _showCircle = true;
    });
    SalesFetch salesfetch = new SalesFetch();
    var salesData = await salesfetch.getmanagesalesFetch(
        action,allrecords,accounttype, paymentId, fromDate, toDate);
    var resid = salesData["resid"];

    if (resid == 200) {
      var rowcount = salesData["rowcount"];

      if (rowcount > 0) {
        setState(() {
          SalesList .clear();
          searchSalesList.clear();
        });
        var salessd = salesData["allcashbill"];
        print(salessd.length);
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
            n["paymodeid"],
            n["paymodename"],
            n["Narration"],
            n["menuid"],
            n["menuname"],
            n["menuquntity"],
            n["menurate"],
            n["menugst"],
            n["menusubtotal"],n["waiterid"],n["waitername"],n["accounttypename"]);
          tempSales.add(pro);
          Provider.of<ViewSalesBookDataNotifier>(context, listen: false)
              .addSalesBillData(pro);
        }
        setState(() {
          this.SalesList = tempSales;
          searchSalesList = tempSales;
          _showCircle = false;
        });
        searchController.addListener(() {
          setState(() {
            if (SalesList != null) {
              String s = searchController.text;
                searchSalesList = SalesList
                  .where((element) =>
                      element.menusalesid
                          .toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.customername
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.medate.toLowerCase().contains(s.toLowerCase()) ||
                      element.discount
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.totalamount
                          .toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()))
                  .toList();
            }
          });
        });
      } else {
        setState(() {
          _showCircle = false;
        });
        String message = salesData["message"];
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black38,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      setState(() {
        _showCircle = false;
      });
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
//from server Fetching Payment Mode  Type Data
  void _getPaymentMode() async {
    FetchPaymentMode fetchpaymentmode = new FetchPaymentMode();
    var fetchpaymentmodeData =
    await fetchpaymentmode.getFetchPaymentMode();
    var resid = fetchpaymentmodeData["resid"];
    var fetchpaymentmodesd = fetchpaymentmodeData["Paymodenamelist"];
    print(fetchpaymentmodesd.length);
    List<AllPaymentModeType> tempfetchpaymentmode = [];
    AllPaymentModeType allpro = AllPaymentModeType(
      "0",
      "All",
    );
    tempfetchpaymentmode.add(allpro);
    for (var n in fetchpaymentmodesd) {
      AllPaymentModeType pro = AllPaymentModeType(
        n["paymentmodeid"],
        n["paymodename"],
      );
      tempfetchpaymentmode.add(pro);
    }
    setState(() {
      this.AllPaymentmodeList = tempfetchpaymentmode;
      print("//////AllPaymentmodeList/////////${AllPaymentmodeList.length}");
    });
  }


  //from server Fetching Payment Mode  Type Data
  void _getAccountType() async {
    FetchAccountTypePayment fetchaccounttypePayment = new FetchAccountTypePayment();
    var fetchaccounttypePaymentData =
    await fetchaccounttypePayment.getFetchAccountTypePayment("0");
    var resid = fetchaccounttypePaymentData["resid"];
    var fetchaccounttypePaymentsd = fetchaccounttypePaymentData["AccountTypelist"];
    print(fetchaccounttypePaymentsd.length);
    List<AllAccountType> tempfetchaccounttypePayment = [];
    AllAccountType allpro = AllAccountType(
      "0",
      "All",
    );
    tempfetchaccounttypePayment.add(allpro);
    for (var n in fetchaccounttypePaymentsd) {
      AllAccountType pro = AllAccountType(
        n["accounttypeids"],
        n["accounttypename"],
      );
      tempfetchaccounttypePayment.add(pro);
    }
    setState(() {
      this.AllAccounttypeList = tempfetchaccounttypePayment;
      print("//////AllAccounttypeList/////////${AllAccounttypeList.length}");
    });
  }

//from server Fetching Payment Mode  Data by paymode id
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
            n["paymodeid"],
            n["paymodename"],
            n["Narration"],
            n["menuid"],
            n["menuname"],
            n["menuquntity"],
            n["menurate"],
            n["menugst"],
            n["menusubtotal"],n["waiterid"],n["waitername"],n["accounttypename"]);
        tempmanagesalespaymentmodefetchDatasd.add(pro);
      }
      setState(() {
        this.SalesList = tempmanagesalespaymentmodefetchDatasd;
        print("//////SalesList/////////${SalesList.length}");
      });
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
  void _getbothpaymentDate(
      String paymentmode, String Datefrom, String dateto) async {
    ManegeSalesPaymentModeDateWiseFetch managesalespaymentmodedatewisefetch =
        new ManegeSalesPaymentModeDateWiseFetch();
    var managesalespaymentmodedatewisefetchData =
        await managesalespaymentmodedatewisefetch
            .getManageSalesPaymentModeDateWiseFetch(
                paymentmode, Datefrom, dateto);
    var resid = managesalespaymentmodedatewisefetchData["resid"];

    if (resid == 200) {
      var managesalespaymentmodedatewisefetchsd =
          managesalespaymentmodedatewisefetchData["sales"];
      print(managesalespaymentmodedatewisefetchsd.length);
      List<EhotelSales> tempmanagesalespaymentmodedatewisefetch = [];
      for (var n in managesalespaymentmodedatewisefetchsd) {
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
        tempmanagesalespaymentmodedatewisefetch.add(pro);
      }
      setState(() {
        this.SalesList = tempmanagesalespaymentmodedatewisefetch;
        searchSalesList = SalesList;
      });
      // searchController.addListener(() {
      //   setState(() {
      //     if (SalesList != null) {
      //       String s = searchController.text;
      //       searchSalesList = SalesList.where((element) =>
      //           element.Salesid.toString()
      //               .toLowerCase()
      //               .contains(s.toLowerCase()) ||
      //           element.SalesCustomername.toLowerCase()
      //               .contains(s.toLowerCase()) ||
      //           element.SalesDate.toLowerCase().contains(s.toLowerCase()) ||
      //           element.SalesProductName.toLowerCase()
      //               .contains(s.toLowerCase()) ||
      //           element.SalesProductRate.toString()
      //               .toLowerCase()
      //               .contains(s.toLowerCase())).toList();
      //     }
      //   });
      // });
      print("//////SalesList/////////$SalesList.length");
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

  void _getDataByDate(String Datefrom, String dateto) async {
    setState(() {
      _showCircle = true;
    });
    ManegeSalesPaymentModeDateWiseFetch managesalespaymentmodedatewisefetch =
        new ManegeSalesPaymentModeDateWiseFetch();
    var managesalesdatewisefetchData = await managesalespaymentmodedatewisefetch
        .getManageSalesDateWiseFetch(Datefrom, dateto);
    var resid = managesalesdatewisefetchData["resid"];

    if (resid == 200) {
      var rowCount = managesalesdatewisefetchData["rowcount"];
      if (rowCount > 0) {
        var managesalespaymentmodedatewisefetchsd =
            managesalesdatewisefetchData["sales"];
        print(managesalespaymentmodedatewisefetchsd.length);
        List<EhotelSales> tempmanagesalesdatewisefetch = [];
        for (var n in managesalespaymentmodedatewisefetchsd) {
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
          tempmanagesalesdatewisefetch.add(pro);
        }
        setState(() {
          this.SalesList = tempmanagesalesdatewisefetch;
          searchSalesList = SalesList;
          _showCircle = false;
        });
        // searchController.addListener(() {
        //   setState(() {
        //     if (SalesList != null) {
        //       String s = searchController.text;
        //       searchSalesList = SalesList.where((element) =>
        //           element.Salesid.toString()
        //               .toLowerCase()
        //               .contains(s.toLowerCase()) ||
        //           element.SalesCustomername.toLowerCase()
        //               .contains(s.toLowerCase()) ||
        //           element.SalesDate.toLowerCase().contains(s.toLowerCase()) ||
        //           element.SalesProductName.toLowerCase()
        //               .contains(s.toLowerCase()) ||
        //           element.SalesProductRate.toString()
        //               .toLowerCase()
        //               .contains(s.toLowerCase())).toList();
        //     }
        //   });
        // });
        print("//////SalesList/////////$SalesList.length");
      } else {
        setState(() {
          _showCircle = false;
        });
        String message = managesalesdatewisefetchData["message"];
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black38,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      setState(() {
        _showCircle = false;
      });
      String message = managesalesdatewisefetchData["message"];
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
