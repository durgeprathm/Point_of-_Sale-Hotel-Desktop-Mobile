import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/LedgerManagement/Models/ledgermodel.dart';

class PreviewSuppliers extends StatefulWidget {
  PreviewSuppliers(this.indexFetch, this.SuppliersListFetch);
  @override
  final int indexFetch;
  List<Supplier> SuppliersListFetch = new List();
  _PreviewSuppliersState createState() => _PreviewSuppliersState();
}

class _PreviewSuppliersState extends State<PreviewSuppliers> {
  //@override
  int PreviewSupplierno;
  String PreviewSupplierCompanyName;
  String PreviewSupplierCompanyPerson;
  String PreviewSupplierCompanyMobile;
  String PreviewSupplierCompanyEmail;
  String PreviewSupplierCompanyAddress;
  String PreviewSupplierCompanyUdyogid;
  String PreviewSupplierCompanyCIN;
  String PreviewSupplierCompanyGSTType;
  String PreviewSupplierCompanyGSTNumber;
  String PreviewSupplierCompanyFAX;
  String PreviewSupplierCompanyPAN;
  String PreviewSupplierCompanyLicenceType;
  String PreviewSupplierCompanyLicenceNumber;
  String PreviewSupplierCompanyBankName;
  String PreviewSupplierCompanyBankBranch;
  String PreviewSupplierCompanyAccountType;
  String PreviewSupplierCompanyAccountNumber;
  String PreviewSupplierCompanyIFSC;
  String PreviewSupplierCompanyUPINumber;
  var tempSupplierCompanyLicenceType, tempSupplierCompanyLicenceNumber;

  @override
  void initState() {
    PreviewSupplierno = widget.SuppliersListFetch[widget.indexFetch].Supplierid;
    PreviewSupplierCompanyName =
        widget.SuppliersListFetch[widget.indexFetch].SupplierComapanyName;
    PreviewSupplierCompanyPerson =
        widget.SuppliersListFetch[widget.indexFetch].SupplierComapanyPersonName;
    PreviewSupplierCompanyMobile =
        widget.SuppliersListFetch[widget.indexFetch].SupplierMobile;
    PreviewSupplierCompanyEmail =
        widget.SuppliersListFetch[widget.indexFetch].SupplierEmail;
    PreviewSupplierCompanyAddress =
        widget.SuppliersListFetch[widget.indexFetch].SupplierAddress;
    PreviewSupplierCompanyUdyogid =
        widget.SuppliersListFetch[widget.indexFetch].SupplierUdyogAadhar;
    PreviewSupplierCompanyCIN =
        widget.SuppliersListFetch[widget.indexFetch].SupplierCINNumber;
    PreviewSupplierCompanyGSTType =
        widget.SuppliersListFetch[widget.indexFetch].SupplierGSTType;
    PreviewSupplierCompanyGSTNumber =
        widget.SuppliersListFetch[widget.indexFetch].SupplierGSTNumber;
    PreviewSupplierCompanyFAX =
        widget.SuppliersListFetch[widget.indexFetch].SupplierFAXNumber;
    PreviewSupplierCompanyPAN =
        widget.SuppliersListFetch[widget.indexFetch].SupplierPANNumber;
    PreviewSupplierCompanyLicenceType =
        widget.SuppliersListFetch[widget.indexFetch].SupplierLicenseType;
    PreviewSupplierCompanyLicenceNumber =
        widget.SuppliersListFetch[widget.indexFetch].SupplierLicenseName;
    PreviewSupplierCompanyBankName =
        widget.SuppliersListFetch[widget.indexFetch].SupplierBankName;
    PreviewSupplierCompanyBankBranch =
        widget.SuppliersListFetch[widget.indexFetch].SupplierBankBranch;
    PreviewSupplierCompanyAccountType =
        widget.SuppliersListFetch[widget.indexFetch].SupplierAccountType;
    PreviewSupplierCompanyAccountNumber =
        widget.SuppliersListFetch[widget.indexFetch].SupplierAccountNumber;
    PreviewSupplierCompanyIFSC =
        widget.SuppliersListFetch[widget.indexFetch].SupplierIFSCCode;
    PreviewSupplierCompanyUPINumber =
        widget.SuppliersListFetch[widget.indexFetch].SupplierUPINumber;
    print(PreviewSupplierCompanyLicenceType);
    print(PreviewSupplierCompanyLicenceNumber);
    tempSupplierCompanyLicenceType =
        PreviewSupplierCompanyLicenceType.split("#");
    tempSupplierCompanyLicenceNumber =
        PreviewSupplierCompanyLicenceNumber.split("#");
    print(tempSupplierCompanyLicenceType);
    print(tempSupplierCompanyLicenceNumber);
  }

  //-------------------------------------------
  static const int kTabletBreakpoint = 552;
  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobilePreviewSuppliers();
    } else {
      content = _buildTabletPreviewSuppliers();
    }

    return content;
  }

//-------------------------------------------
//---------------Tablet Mode Start-------------//
  Widget _buildTabletPreviewSuppliers() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text('Supplier No:-  $PreviewSupplierno'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          shape: Border.all(color: Colors.blueGrey, width: 5),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: 500.0,
                color: Colors.blueGrey,
                child: Center(
                  child: Text(
                    "Company Information",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(children: [
                Text(
                  "Company Name:-$PreviewSupplierCompanyName",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  width: 400.0,
                ),
                Text(
                  "Person Name:-$PreviewSupplierCompanyPerson",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(children: [
                Text(
                  "Mobile Number:-$PreviewSupplierCompanyMobile",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  width: 400.0,
                ),
                Text(
                  "Email:-$PreviewSupplierCompanyEmail",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(children: [
                Text(
                  "Company Address:-$PreviewSupplierCompanyAddress",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                  ),
                ),
              ]),
            ),
            Divider(
              color: Colors.blueGrey,
              thickness: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(children: [
                Text(
                  "Udyog-Id:-$PreviewSupplierCompanyUdyogid",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  width: 400.0,
                ),
                Text(
                  "CIN Number:-$PreviewSupplierCompanyCIN",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(children: [
                Text(
                  "GST Number:-$PreviewSupplierCompanyGSTType",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(children: [
                Text(
                  "Fax Number:-$PreviewSupplierCompanyFAX",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  width: 400.0,
                ),
                Text(
                  "PAN Number:-$PreviewSupplierCompanyPAN",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                  ),
                ),
              ]),
            ),
            Divider(
              color: Colors.blueGrey,
              thickness: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: DataTable(
                columns: [
                  DataColumn(
                      label: Expanded(
                    child: Container(
                      child: Text('Licence Type',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Container(
                      width: 200,
                      child: Text('Licence Number',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  )),
                ],
                rows: getDataRowList(),
              ),
            ),
            Divider(
              color: Colors.blueGrey,
              thickness: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: 500.0,
                color: Colors.blueGrey,
                child: Center(
                  child: Text(
                    "Bank Account Details",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Bank Name:-$PreviewSupplierCompanyBankName",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Bank Branch:-$PreviewSupplierCompanyBankBranch",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    "Account Type:-$PreviewSupplierCompanyAccountType",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    width: 400.0,
                  ),
                  Text(
                    "Account Number:-$PreviewSupplierCompanyAccountNumber",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    "IFSC Code:-$PreviewSupplierCompanyIFSC",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    width: 400.0,
                  ),
                  Text(
                    "UPI Number:-$PreviewSupplierCompanyUPINumber",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobilePreviewSuppliers() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text('Supplier No:-  $PreviewSupplierno'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          shape: Border.all(color: Colors.blueGrey, width: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: 500.0,
                color: Colors.blueGrey,
                child: Center(
                  child: Text(
                    "Company Information",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Company Name:-$PreviewSupplierCompanyName",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),
            // SizedBox(
            //   width: 400.0,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Person Name:-$PreviewSupplierCompanyPerson",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Mobile Number:-$PreviewSupplierCompanyMobile",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),
            // SizedBox(
            //   width: 400.0,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Email:-$PreviewSupplierCompanyEmail",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Company Address:-$PreviewSupplierCompanyAddress",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),

            Divider(
              color: Colors.blueGrey,
              thickness: 5,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Udyog-Id:-$PreviewSupplierCompanyUdyogid",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),
            // SizedBox(
            //   width: 400.0,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "CIN Number:-$PreviewSupplierCompanyCIN",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "GST Number:-$PreviewSupplierCompanyGSTType",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "GST Number:-$PreviewSupplierCompanyGSTNumber",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Fax Number:-$PreviewSupplierCompanyFAX",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),
            // SizedBox(
            //   width: 400.0,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "PAN Number:-$PreviewSupplierCompanyPAN",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),

            Divider(
              color: Colors.blueGrey,
              thickness: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: DataTable(
                columns: [
                  DataColumn(
                      label: Expanded(
                    child: Container(
                      child: Text('Licence Type',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Container(
                      width: 200,
                      child: Text('Licence Number',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  )),
                ],
                rows: getDataRowList(),
              ),
            ),
            Divider(
              color: Colors.blueGrey,
              thickness: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: 500.0,
                color: Colors.blueGrey,
                child: Center(
                  child: Text(
                    "Bank Account Details",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Bank Name:-$PreviewSupplierCompanyBankName",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Bank Branch:-$PreviewSupplierCompanyBankBranch",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Account Type:-$PreviewSupplierCompanyAccountType",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),
            // SizedBox(
            //   width: 400.0,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Account Number:-$PreviewSupplierCompanyAccountNumber",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "IFSC Code:-$PreviewSupplierCompanyIFSC",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),
            // SizedBox(
            //   width: 400.0,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "UPI Number:-$PreviewSupplierCompanyUPINumber",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
//---------------Mobile Mode End-------------//

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(tempSupplierCompanyLicenceType[index])),
      DataCell(Text(tempSupplierCompanyLicenceNumber[index])),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < tempSupplierCompanyLicenceNumber.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }
}
