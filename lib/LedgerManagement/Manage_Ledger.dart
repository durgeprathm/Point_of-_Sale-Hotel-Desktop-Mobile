import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/Fetch_Account_Type_Payment.dart';
import 'package:retailerp/LedgerManagement/Add_Ledger.dart';
import 'package:retailerp/LedgerManagement/Adpater/pos_supplier_fetch.dart';
import 'package:retailerp/LedgerManagement/Models/ledgermodel.dart';
import 'package:retailerp/Pagination_notifier/Manage_Supplier_datanotifier.dart';
import 'package:retailerp/models/Accountype.dart';
import 'package:retailerp/pages/Edit_Suppliers.dart';
import 'package:retailerp/pages/Import_purchase.dart';
import 'package:retailerp/pages/Manage_Purchase.dart';
import 'package:retailerp/pages/Preview_Suppliers.dart';
import 'package:retailerp/pages/add_purchase_new.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/Datatables/Manage_Supplier_Source.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';


class ManageSuppliers extends StatefulWidget {
  @override
  _ManageSuppliersState createState() => _ManageSuppliersState();
}

class _ManageSuppliersState extends State<ManageSuppliers> {
  @override
  // DatabaseHelper databaseHelper = DatabaseHelper();
  List<Supplier> SupplierList = new List();
  List<Supplier> SearchSupplierList = new List();
  List<AllAccountType> AllAccounttypeList = new List();
  TextEditingController searchController = TextEditingController();
  TextEditingController _textAccountType = TextEditingController();
  int count;
  bool _showCircle = false;
  String AccountTypeID;

  @override
  void initState() {
    Provider.of<ManageSupplierDataNotifier>(context, listen: false).clear();
    _getSupplier("1","");
    _getAccountType();
  }

  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileManageSuppliers();
    } else {
      content = _buildTabletManageSuppliers();
    }

    return content;
  }

//-------------------------------------------
//---------------Tablet Mode Start-------------//
  Widget _buildTabletManageSuppliers() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.18;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.25;
    final _provider = context.watch<ManageSupplierDataNotifier>();
    final _model = _provider.ManageSupplierModel;
    final _dtSource = ManageSupplierDataTableSource(
        ManageSupplieData: _model,
        context: context
    );
    void handleClick(String value) {
      switch (value) {
        case 'Add Ledger':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSupplierDetails()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.users),
            SizedBox(
              width: 20.0,
            ),
            Text('Manage Ledger'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {

              // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              //   return RetailerHomePage();
              // }));

            },
          ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Add Ledger',
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
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: DataTable(
                //     columns: [
                //       DataColumn(
                //           label: Expanded(
                //         child: Container(
                //           child: Center(
                //             child: Text('Sr No', style: tableColmTextStyle),
                //           ),
                //         ),
                //       )),
                //       DataColumn(
                //           label: Expanded(
                //         child: Container(
                //           child: Center(
                //             child:
                //                 Text('Ledger\nPerson Name', style: tableColmTextStyle),
                //           ),
                //         ),
                //       )),
                //       DataColumn(
                //           label: Expanded(
                //         child: Container(
                //           child: Center(
                //             child:
                //                 Text('Company Name', style: tableColmTextStyle),
                //           ),
                //         ),
                //       )),
                //       DataColumn(
                //           label: Expanded(
                //             child: Container(
                //               child: Center(
                //                 child: Text('GST No.',
                //                     style: tableColmTextStyle),
                //               ),
                //             ),
                //           )),
                //       DataColumn(
                //           label: Expanded(
                //             child: Container(
                //               child: Center(
                //                 child: Text('Ledger\nMobile No',
                //                     style: tableColmTextStyle),
                //               ),
                //             ),
                //           )),
                //       DataColumn(
                //           label: Expanded(
                //             child: Container(
                //               child: Center(
                //                 child: Text('Ledger\nEmail',
                //                     style: tableColmTextStyle),
                //               ),
                //             ),
                //           )),
                //       DataColumn(
                //           label: Expanded(
                //             child: Container(
                //               child: Center(
                //                 child: Text('Supplier\nUPI No',
                //                     style: tableColmTextStyle),
                //               ),
                //             ),
                //           )),
                //       DataColumn(
                //           label: Expanded(
                //         child: Container(
                //           child: Center(
                //             child: Text('Action', style: tableColmTextStyle),
                //           ),
                //         ),
                //       )),
                //
                //       // DataColumn(
                //       //     label: Text('Edit',
                //       //         style: TextStyle(
                //       //             fontSize: 20, fontWeight: FontWeight.bold))),
                //       // DataColumn(
                //       //     label: Text('Delete',
                //       //         style: TextStyle(
                //       //             fontSize: 20, fontWeight: FontWeight.bold))),
                //     ],
                //     rows: getDataRowList(),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobileManageSuppliers() {
    void handleClick(String value) {
      switch (value) {
        case 'Add Purchase':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPurchaseNew()));
          break;
        case 'Manage Purchase':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Managepurchase()));
          break;
        case 'Import Purchase':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImportPurchase()));
          break;
        case 'Add Suppliers':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddSupplierDetails()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.users),
            SizedBox(
              width: 20.0,
            ),
            Text('Suppliers'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              //   return RetailerHomePage();
              // }));
            },
          ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Add Purchase',
                'Manage Purchase',
                'Import Purchase',
                'Add Suppliers',
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
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: SupplierList.length,
                  itemBuilder: (context, index) {
                    print("//in index////$index");
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Supplier No:${SupplierList[index].Supplierid.toString()} ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "${SupplierList[index].SupplierMobile}",
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
                                "Supplier Company Name:",
                                style: headHintTextStyle,
                              ),
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
                            height: 3.0,
                          ),
                          Row(
                            children: [
                              Text(
                                "Supplier Email:",
                                style: headHintTextStyle,
                              ),
                              Text("${SupplierList[index].SupplierEmail}",
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
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             PreviewSuppliers(
                                  //                 index, SupplierList)));
                                },
                                icon: Icon(
                                  Icons.preview,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             EditSupplierDetails(
                                  //                 index, SupplierList)));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _showMyDialog(SupplierList[index].Supplierid);
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
          ),
        ),
      ),
    );
  }

//---------------Mobile Mode End-------------//


  List<DataColumn> _colGen(
      ManageSupplierDataNotifier _provider,
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
        DataColumn(
          label: Text('Action'),
          tooltip: 'Action',
        ),
      ];

  void _sort<T>(
      Comparable<T> Function(Supplier sale) getField,
      int colIndex,
      bool asc,
      ManageSupplierDataNotifier _provider,
      ) {
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }






  DataRow getRow(int index) {
    var serNo = index + 1;
    return DataRow(cells: [
      DataCell(Center(child: Text(serNo.toString()))),
      DataCell(
          Center(child: Text(SupplierList[index].SupplierComapanyPersonName))),
      DataCell(Center(child: Text(SupplierList[index].SupplierComapanyName))),
      DataCell(Center(child: Text(SupplierList[index].SupplierGSTNumber))),
      DataCell(Center(child: Text(SupplierList[index].SupplierMobile))),
      DataCell(Center(child: Text(SupplierList[index].SupplierEmail))),
      DataCell(Center(child: Text(SupplierList[index].SupplierUPINumber))),
      DataCell(
        Row(
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
                            PreviewSuppliers(index, SupplierList)));
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
                            EditSupplierDetails(index, SupplierList)));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
              ),
              color: Colors.red,
              onPressed: () {
                _showMyDialog(SupplierList[index].Supplierid);
              },
            ),
          ],
        ),
      ),
    ]);
  }
  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < SupplierList.length; i++) {
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
              "Do You Want To Delete!",
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
                onPressed: () async {
                  // SupplierDelete supplierdelete = new SupplierDelete();
                  // var result =
                  //     await supplierdelete.getSupplierDelete(id.toString());
                  // print("//////////////////Print result//////$result");
                  // print("///delete id///$id");
                  // Navigator.of(context).pop();
                  // _getSupplier();
                },
              ),
            ],
          ),
        );
      },
    );
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
          Provider.of<ManageSupplierDataNotifier>(context, listen: false)
              .addManageSupplierData(pro);
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
