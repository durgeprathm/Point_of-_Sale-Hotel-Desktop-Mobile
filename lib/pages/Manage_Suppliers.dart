import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/pos_supplier_delete.dart';
import 'package:retailerp/Adpater/pos_supplier_fetch.dart';
import 'package:retailerp/LedgerManagement/Add_Ledger.dart';
import 'package:retailerp/LedgerManagement/Models/ledgermodel.dart';
import 'package:retailerp/Pagination_notifier/Manage_Supplier_datanotifier.dart';
import 'package:retailerp/pages/Add_Sales.dart';
import 'package:retailerp/pages/Edit_Suppliers.dart';
import 'package:retailerp/pages/Import_purchase.dart';
import 'package:retailerp/pages/Manage_Purchase.dart';
import 'package:retailerp/pages/Preview_Suppliers.dart';
import 'package:retailerp/pages/dashboard.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';
import 'package:retailerp/Datatables/Manage_Supplier_Source.dart';



class ManageSuppliers extends StatefulWidget {
  @override
  _ManageSuppliersState createState() => _ManageSuppliersState();
}

class _ManageSuppliersState extends State<ManageSuppliers> {
  @override
  // DatabaseHelper databaseHelper = DatabaseHelper();
  List<Supplier> SupplierList = new List();
  int count;
  bool _showCircle = false;

  @override
  void initState() {
    Provider.of<ManageSupplierDataNotifier>(context, listen: false).clear();
    //ShowSupplierdetails();
    _getSupplier();
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
        case 'Add Purchase':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
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
            Text('Manage Suppliers'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return RetailerHomePage();
              }));
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomPaginatedTable(
                dataColumns: _colGen(_provider),
                // header: const Text("Sales Day Wise Report"),
                onRowChanged: (index) => _provider.rowsPerPage = index,
                rowsPerPage: _provider.rowsPerPage,
                source: _dtSource,
                showActions: true,
                sortColumnIndex: _provider.sortColumnIndex,
                sortColumnAsc: _provider.sortAscending,
              ),
              // DataTable(
              //   columns: [
              //     DataColumn(
              //         label: Expanded(
              //           child: Container(
              //             child: Center(
              //               child: Text('Sr No', style: tableColmTextStyle),
              //             ),
              //           ),
              //         )),
              //     DataColumn(
              //         label: Expanded(
              //           child: Container(
              //             child: Center(
              //               child:
              //               Text('Supplier Name', style: tableColmTextStyle),
              //             ),
              //           ),
              //         )),
              //     DataColumn(
              //         label: Expanded(
              //           child: Container(
              //             child: Center(
              //               child:
              //               Text('Company Name', style: tableColmTextStyle),
              //             ),
              //           ),
              //         )),
              //     DataColumn(
              //         label: Expanded(
              //           child: Container(
              //             child: Center(
              //               child: Text('GST No.',
              //                   style: tableColmTextStyle),
              //             ),
              //           ),
              //         )),
              //     DataColumn(
              //         label: Expanded(
              //           child: Container(
              //             child: Center(
              //               child: Text('Mob No.',
              //                   style: tableColmTextStyle),
              //             ),
              //           ),
              //         )),
              //     DataColumn(
              //         label: Expanded(
              //           child: Container(
              //             child: Center(
              //               child: Text('Action', style: tableColmTextStyle),
              //             ),
              //           ),
              //         )),
              //   ],
              //   rows: getDataRowList(),
              // ),
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
              context, MaterialPageRoute(builder: (context) => AddSales()));
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
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return RetailerHomePage();
              }));
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PreviewSuppliers(
                                                  index, SupplierList)));
                                },
                                icon: Icon(
                                  Icons.preview,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditSupplierDetails(
                                                  index, SupplierList)));
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
                  SupplierDelete supplierdelete = new SupplierDelete();
                  var result =
                      await supplierdelete.getSupplierDelete(id.toString());
                  print("//////////////////Print result//////$result");
                  print("///delete id///$id");
                  Navigator.of(context).pop();
                  _getSupplier();
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
  void _getSupplier() async {
    setState(() {
      _showCircle = true;
    });
    SupplierFetch supplierfetch = new SupplierFetch();
    var supplierData = await supplierfetch.getSupplierFetch("1");
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
          _showCircle = false;
        });
        print("//////SalesList/////////$SupplierList.length");
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

}
