import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/Fetch_Account_Type_Payment.dart';
import 'package:retailerp/Datatables/Supplier_Wise_Report_Source.dart';
import 'package:retailerp/LedgerManagement/Adpater/pos_supplier_fetch.dart';
import 'package:retailerp/Pagination_notifier/Supplier_Wise_Report_datanotifier.dart';
import 'package:retailerp/models/Accountype.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';
import 'All_cash_Reports.dart';
import 'Supplier_Reports_Print.dart';
import 'package:retailerp/LedgerManagement/Models/ledgermodel.dart';

class SupplierReports extends StatefulWidget {
  @override
  _SupplierReportsState createState() => _SupplierReportsState();
}

class _SupplierReportsState extends State<SupplierReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileSupplierReports();
    } else {
      content = _buildTableSupplierReports();
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
  Widget appBarTitle = Text("Supplier Reports");
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
  List<Supplier> SupplierList = new List();
  TextEditingController SerachController = new TextEditingController();
  List<Supplier> SearchSupplierList = new List();
  List<AllAccountType> AllAccounttypeList = new List();
  TextEditingController searchController = TextEditingController();
  TextEditingController _textAccountType = TextEditingController();
  int count;
  String AccountTypeID;

  @override
  void initState() {
    Provider.of<SupplierWiseReportDataNotifier>(context, listen: false).clear();
    _getSupplier("1","");
    _getAccountType();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTableSupplierReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.18;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.25;
    final _provider = context.watch<SupplierWiseReportDataNotifier>();
    final _model = _provider.SupplierWiseReportModel;
    final _dtSource = SupplierWiseReportDataTableSource(
        SupplierWiseReportData: _model,
        context: context
    );
    void handleClick(String value) {
      switch (value) {
        case 'Supplier Product Wise Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AllCashReports()));
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
            Text('Supplier Reports'),
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
          SupplierList.length != 0
              ? IconButton(
                  icon: Icon(Icons.print, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return SupplierReportPrint(1, SupplierList);
                    }));
                  },
                )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Supplier Product Wise Reports'}
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
            child: SupplierList.length == 0
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Padding(
                        padding:   const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                                      onPressed: () {

                                      },
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
                                      _getSupplier("1","");
                                    } else {
                                      print("//_getSupplier function call///////////////////${AccountTypeID}");
                                      _getSupplier("",AccountTypeID.toString());
                                    }
                                    print("//AccountTypeID///////////////////${AccountTypeID}");
                                  } else {}
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
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
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: DataTable(columns: [
                      //     DataColumn(
                      //         label: Expanded(
                      //       child: Container(
                      //         width: 50,
                      //         child: Text('Sr No',
                      //             style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold)),
                      //       ),
                      //     )),
                      //     DataColumn(
                      //         label: Expanded(
                      //       child: Container(
                      //         child: Text('Company',
                      //             style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold)),
                      //       ),
                      //     )),
                      //     DataColumn(
                      //         label: Expanded(
                      //       child: Container(
                      //         child: Text('Name',
                      //             style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold)),
                      //       ),
                      //     )),
                      //     DataColumn(
                      //         label: Expanded(
                      //       child: Container(
                      //         child: Text('Mobile',
                      //             style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold)),
                      //       ),
                      //     )),
                      //     DataColumn(
                      //         label: Expanded(
                      //       child: Container(
                      //         child: Text('Email',
                      //             style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold)),
                      //       ),
                      //     )),
                      //     DataColumn(
                      //         label: Expanded(
                      //       child: Container(
                      //         child: Text('Address',
                      //             style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold)),
                      //       ),
                      //     )),
                      //   ], rows: getDataRowList()),
                      // ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobileSupplierReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Supplier Product Wise Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AllCashReports()));
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
              SupplierList.length != 0
                  ? IconButton(
                      icon: Icon(Icons.print, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return SupplierReportPrint(1, SupplierList);
                        }));
                      },
                    )
                  : Text(''),
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Supplier Product Wise Reports'}
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
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: SupplierList.length,
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
                                        "Supplier No:- ${SupplierList[index].Supplierid.toString()} ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${SupplierList[index].SupplierMobile}",
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
                                        Text("Customer Company: ",
                                            style: headHintTextStyle),
                                        Text(
                                            "${SupplierList[index].SupplierComapanyName}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Supplier Company Person Name:",
                                            style: headHintTextStyle),
                                        Text(
                                            "${SupplierList[index].SupplierComapanyPersonName.toString()}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Email:   ",
                                            style: headHintTextStyle),
                                        Text(
                                            "${SupplierList[index].SupplierEmail.toString()}",
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
  List<DataColumn> _colGen(
      SupplierWiseReportDataNotifier _provider,
      ) =>
      <DataColumn>[
        DataColumn(
          label: Text("Sr No"),
          numeric: true,
          tooltip: "Sr No",
        ),
        DataColumn(
          label: Text('Supplier Name'),
          tooltip: 'Supplier Name',
        ),
        DataColumn(
          label: Text('Company Name'),
          tooltip: 'Company Name',
        ),
        DataColumn(
          label: Text('Mobile No'),
          tooltip: 'Mobile No',
        ),
        DataColumn(
          label: Text('Email'),
          tooltip: 'Email',
        ),
        DataColumn(
          label: Text('GST No'),
          tooltip: 'GST No',
        ),
      ];

  void _sort<T>(
      Comparable<T> Function(Supplier sale) getField,
      int colIndex,
      bool asc,
      SupplierWiseReportDataNotifier _provider,
      ) {
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }




  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(SupplierList[index].Supplierid.toString())),
      DataCell(Text(SupplierList[index].SupplierComapanyName)),
      DataCell(Text(SupplierList[index].SupplierComapanyPersonName)),
      DataCell(Text(SupplierList[index].SupplierMobile.toString())),
      DataCell(Text(SupplierList[index].SupplierEmail.toString())),
      DataCell(Text(SupplierList[index].SupplierAddress.toString())),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < SupplierList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  //-------------------------------------
//from server
  void _getSupplier(String allrecords,String accounttype) async {
    setState(() {
      _showCircle = true;
    });
    SupplierFetch supplierfetch = new SupplierFetch();
    var supplierData = await supplierfetch.getSupplierFetch(allrecords,accounttype);
    print(supplierData);
    var resid = supplierData["resid"];
    if (resid == 200) {
      var rowcount = supplierData["rowcount"];
      if (rowcount > 0) {
        var suppliersd = supplierData["supplier"];
        List<Supplier> tempSupplier = [];
        for (var n in suppliersd) {
          Supplier pro = Supplier(
              int.parse(n["SupplierId"]),
              n["SupplierCustomername"],
              n["SupplierComapanyPersonName"],
              n["SupplierMobileNumber"],
              n["SupplierEmail"],
              n["SupplierAddress"],
              n["SupplierUdyogAadhar"],
              n["SupplierCINNumber"],
              n["SupplierGSTType"],
              n["SupplierGSTNumber"],
              n["SupplierFAXNumber"],
              n["SupplierPANNumber"],
              n["SupplierLicenseType"],
              n["SupplierLicenseName"],
              n["SupplierBankName"],
              n["SupplierBankBranch"],
              n["SupplierAccountType"],
              n["SupplierAccountNumber"],
              n["SupplierIFSCCode"],
              n["SupplierUPINumber"]);
          tempSupplier.add(pro);
          Provider.of<SupplierWiseReportDataNotifier>(context, listen: false)
              .addSupplierWiseData(pro);
        }
        setState(() {
          this.SupplierList = tempSupplier;
          this.SearchSupplierList = tempSupplier;
          _showCircle = false;
        });
        print("//////SalesList/////////$SupplierList.length");

        searchController.addListener(() {
          setState(() {
            if (SupplierList != null) {
              String s = searchController.text;
              SupplierList = SearchSupplierList.where((element) =>
              element.SupplierComapanyName.toString()
                  .toLowerCase()
                  .contains(s.toLowerCase()) ||
                  element.SupplierComapanyPersonName.toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SupplierComapanyName.toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SupplierGSTNumber.toLowerCase().contains(s.toLowerCase()) ||
                  element.SupplierMobile.toLowerCase()
                      .contains(s.toLowerCase())||
                  element.SupplierEmail.toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.SupplierUPINumber.toString()
                      .toLowerCase()
                      .contains(s.toLowerCase())).toList();
            }
          });
        });

      } else {
        setState(() {
          _showCircle = false;
        });
        String msg = supplierData["message"];
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
      String msg = supplierData["message"];
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

  //from server Fetching Payment Mode  Type Data
  void _getAccountType() async {
    FetchAccountTypePayment fetchaccounttypePayment = new FetchAccountTypePayment();
    var fetchaccounttypePaymentData =
    await fetchaccounttypePayment.getFetchAccountTypePayment("1");
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
      print("//////AllAccounttypeList/////////${AllAccounttypeList}");
    });
  }


}
