import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/LedgerManagement/Models/ledgermodel.dart';
import 'package:retailerp/helpers/database_helper.dart';



class EditSupplierDetails extends StatefulWidget {
  EditSupplierDetails(this.indexFetch, this.SupplierListFetch);
  @override
  final int indexFetch;
  List<Supplier> SupplierListFetch = new List();
  _EditSupplierDetailsState createState() => _EditSupplierDetailsState();
}

class _EditSupplierDetailsState extends State<EditSupplierDetails> {
  DatabaseHelper databaseHelper =new DatabaseHelper();
  @override
  int rowpro = 1;
  int tempIndex=0;
  bool visibilityTagGST = false;
  bool enable = true;

  void initState() {
    setState(() {
      EditSupplierNo=widget.SupplierListFetch[widget.indexFetch].Supplierid;
      SupplierCompanyNameAppBar=widget.SupplierListFetch[widget.indexFetch].SupplierComapanyName;
      this._EditSupplierCompanyNametext.text =
          widget.SupplierListFetch[widget.indexFetch].SupplierComapanyName;
      this._EditSupplierCompanyPersontext.text =
          widget.SupplierListFetch[widget.indexFetch].SupplierComapanyPersonName;
      this._EditSupplierCompanyMobiletext.text = widget
          .SupplierListFetch[widget.indexFetch].SupplierMobile;
      this._EditSupplierCompanyEmailtext.text = widget
          .SupplierListFetch[widget.indexFetch].SupplierEmail;
      this._EditSupplierCompanyAddresstext.text =
          widget.SupplierListFetch[widget.indexFetch].SupplierAddress;
      this._EditSupplierCompanyUdyogidtext.text = widget
          .SupplierListFetch[widget.indexFetch].SupplierUdyogAadhar;
      this._EditSupplierCompanyCINtext.text =
          widget.SupplierListFetch[widget.indexFetch].SupplierCINNumber;
      this._EditSupplierCompanyGSTtext.text =
          widget.SupplierListFetch[widget.indexFetch].SupplierGSTType;
      this._EditSupplierCompanyFAXtext.text =
          widget.SupplierListFetch[widget.indexFetch].SupplierFAXNumber;
      this._EditSupplierCompanyPANtext.text =
          widget.SupplierListFetch[widget.indexFetch].SupplierPANNumber;
      this._EditSupplierCompanyBankNametext.text = widget
          .SupplierListFetch[widget.indexFetch].SupplierBankName;
      this._EditSupplierCompanyBankBranchtext.text = widget
          .SupplierListFetch[widget.indexFetch].SupplierBankBranch;
      this._EditSupplierCompanyGSTtext.text =
          widget.SupplierListFetch[widget.indexFetch].SupplierGSTType;
      this._EditSupplierCompanyAccountTypetext.text =
          widget.SupplierListFetch[widget.indexFetch].SupplierAccountType;
      this._EditSupplierCompanyAccountNumbertext.text = widget
          .SupplierListFetch[widget.indexFetch].SupplierAccountNumber;
      this._EditSupplierCompanyAccountIFSCtext.text =
          widget.SupplierListFetch[widget.indexFetch].SupplierIFSCCode;
      this._EditSupplierCompanyUPINumbertext.text =
          widget.SupplierListFetch[widget.indexFetch].SupplierUPINumber;
      EditlicenceType =
          widget.SupplierListFetch[widget.indexFetch].SupplierLicenseType;
      EditlicenceNumber =
          widget.SupplierListFetch[widget.indexFetch].SupplierLicenseName;
      print(EditlicenceType);
      print(EditlicenceNumber);
      TemplicenceType = EditlicenceType.split("#");
      TemplicenceNumber = EditlicenceNumber.split("#");
      print(TemplicenceType);
      print(TemplicenceNumber);
    });
  }








TextEditingController _EditSupplierCompanyNametext=TextEditingController();
TextEditingController _EditSupplierCompanyPersontext=TextEditingController();
TextEditingController _EditSupplierCompanyMobiletext=TextEditingController();
TextEditingController _EditSupplierCompanyEmailtext=TextEditingController();
TextEditingController _EditSupplierCompanyAddresstext=TextEditingController();
TextEditingController _EditSupplierCompanyUdyogidtext=TextEditingController();
TextEditingController _EditSupplierCompanyCINtext=TextEditingController();
TextEditingController _EditSupplierCompanyGSTtext=TextEditingController();
TextEditingController _EditSupplierCompanyFAXtext=TextEditingController();
TextEditingController _EditSupplierCompanyPANtext=TextEditingController();
// TextEditingController _SupplierCompanyLicenceTypetext=TextEditingController();
// TextEditingController _SupplierCompanyLicenceNumbertext=TextEditingController();
TextEditingController _EditSupplierCompanyBankNametext=TextEditingController();
TextEditingController _EditSupplierCompanyBankBranchtext=TextEditingController();
TextEditingController _EditSupplierCompanyAccountTypetext=TextEditingController();
TextEditingController _EditSupplierCompanyAccountNumbertext=TextEditingController();
TextEditingController _EditSupplierCompanyAccountIFSCtext=TextEditingController();
TextEditingController _EditSupplierCompanyUPINumbertext=TextEditingController();




  bool _SupplierCompanyNamevalidate=false;
  bool _SupplierCompanyPersonvalidate=false;
  bool _SupplierCompanyMobilevalidate=false;
  bool _SupplierCompanyEmailvalidate=false;
  bool _SupplierCompanyAddressvalidate=false;
  bool _SupplierCompanyUdyogidvalidate=false;
  bool _SupplierCompanyCINvalidate=false;
  bool _SupplierCompanyGSTvalidate=false;
  bool _SupplierCompanyFAXvalidate=false;
  bool _SupplierCompanyPANvalidate=false;
  bool _SupplierCompanyLicenceTypevalidate=false;
  bool _SupplierCompanyLicenceNumbervalidate=false;
  bool _SupplierCompanyBankNamevalidate=false;
  bool _SupplierCompanyBankBranchvalidate=false;
  bool _SupplierCompanyAccountTypevalidate=false;
  bool _SupplierCompanyAccountNumbervalidate=false;
  bool _SupplierCompanyAccountIFSCvalidate=false;
  bool _SupplierCompanyUPINumbervalidate=false;


  int EditSupplierNo;
  String SupplierCompanyNameAppBar;
  String SupplierCompanyName;
  String SupplierCompanyPerson;
  String SupplierCompanyMobile;
  String SupplierCompanyEmail;
  String SupplierCompanyAddress;
  String SupplierCompanyUdyogid;
  String SupplierCompanyCIN;
  String SupplierCompanyGSTType;
  String SupplierCompanyGSTNumber;
  String SupplierCompanyFAX;
  String SupplierCompanyPAN;
  String SupplierCompanyLicenceType;
  String SupplierCompanyLicenceNumber;
  String SupplierCompanyBankName;
  String SupplierCompanyBankBranch;
  String SupplierCompanyAccountType;
  String SupplierCompanyAccountNumber;
  String SupplierCompanyIFSC;
  String SupplierCompanyUPINumber;
  String EditlicenceType;
  String EditlicenceNumber;
  var TemplicenceType,TemplicenceNumber;

  List<String> LocalCompanyLicenceType = new List();
  List<String> LocalCompanyLicenceNumber = new List();

  List<TextEditingController> _SupplierCompanyLicenceTypetext = new List();
  List<TextEditingController> _SupplierCompanyLicenceNumbertext = new List();

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text('Update information :- $SupplierCompanyNameAppBar'),
          ],
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                shape: Border.all(color: Colors.blueGrey, width: 5),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Material(
                          color: Colors.blueGrey,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Supplier Company Information',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _EditSupplierCompanyNametext,
                                readOnly: true,
                                enableInteractiveSelection: true,
                                obscureText: false,
                                onChanged: (value) {
                                  SupplierCompanyName=value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Supplier Company Name',
                                  errorText: _SupplierCompanyNamevalidate ? ' Enter Supplier Company Name' : null,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _EditSupplierCompanyPersontext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                obscureText: false,
                                onChanged: (value) {
                                  SupplierCompanyPerson=value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Supplier Person Name',
                                  errorText: _SupplierCompanyPersonvalidate ? ' Enter Supplier Person Name' : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _EditSupplierCompanyMobiletext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                obscureText: false,
                                onChanged: (value) {
                                  SupplierCompanyMobile=value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Supplier Company Mobile Number',
                                  errorText: _SupplierCompanyMobilevalidate ? ' Enter Supplier Company Mobile Number' : null,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _EditSupplierCompanyEmailtext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                obscureText: false,
                                onChanged: (value) {
                                  SupplierCompanyEmail=value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Supplier Company E-Mail',
                                  errorText: _SupplierCompanyEmailvalidate ? 'Enter Supplier Company E-Mail' : null,
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _EditSupplierCompanyAddresstext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                obscureText: false,
                                maxLines: 3,
                                onChanged: (value) {
                                  SupplierCompanyAddress=value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Supplier Company Address',
                                  errorText: _SupplierCompanyAddressvalidate ? 'Enter Supplier Company Address' : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _EditSupplierCompanyUdyogidtext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                obscureText: false,
                                onChanged: (value) {
                                  SupplierCompanyUdyogid=value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Supplier Company Udyog Aadhaar',
                                  errorText: _SupplierCompanyUdyogidvalidate ? 'Enter Supplier Company Udyog Aadhaar' : null,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _EditSupplierCompanyCINtext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                obscureText: false,
                                onChanged: (value) {
                                  SupplierCompanyCIN=value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Supplier CIN Number',
                                  errorText: _SupplierCompanyCINvalidate ? 'Enter Supplier Company CIN Number' : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _EditSupplierCompanyGSTtext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                obscureText: false,
                                onChanged: (value) {
                                  SupplierCompanyGSTType=value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Supplier GST Type',
                                  errorText: _SupplierCompanyGSTvalidate ? 'Enter Supplier GST Type' : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _EditSupplierCompanyFAXtext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                obscureText: false,
                                onChanged: (value) {
                                  SupplierCompanyFAX=value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Supplier Company Fax Number',
                                  errorText: _SupplierCompanyFAXvalidate ? 'Enter Supplier Company Fax Number' : null,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                obscureText: false,
                                controller: _EditSupplierCompanyPANtext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                onChanged: (value) {
                                  SupplierCompanyPAN=value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Supplier Company Pan Number',
                                  errorText: _SupplierCompanyPANvalidate ? 'Enter Supplier Company Pan Number' : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Material(
                        shape: Border.all(color:Colors.blueGrey, width: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            // height: 150.0,
                            child: DataTable(
                              columns: [
                                DataColumn(
                                    label: Expanded(
                                      child: Container(
                                        width: 300.0,
                                        child: Text('Company license Type Name',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    )),
                                DataColumn(
                                    label: Expanded(
                                      child: Container(
                                        width: 300.0,
                                        child: Text('Company licence Number',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    )),
                              ],
                              rows: getDataRowList(),
                            ),
                          ),
                        ),
                        elevation: 5.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),

// Supplier Account Details
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                shape: Border.all(color: Colors.blueGrey, width: 5),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Material(
                          color: Colors.blueGrey,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Supplier Bank Account Information',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller:  _EditSupplierCompanyBankNametext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                obscureText: false,
                                onChanged: (value) {
                                  SupplierCompanyBankName=value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Supplier Bank Name',
                                  errorText: _SupplierCompanyBankNamevalidate ? 'Enter Supplier Bank Name' : null,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _EditSupplierCompanyBankBranchtext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                obscureText: false,
                                onChanged: (value) {
                                  SupplierCompanyBankBranch=value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Supplier Bank Branch Name',
                                  errorText: _SupplierCompanyBankBranchvalidate ? 'Enter Supplier Bank Branch Name' : null,
                                  // errorText: _BankBranchvalidate ? 'Enter Bank Branch Name' : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _EditSupplierCompanyAccountTypetext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                obscureText: false,
                                onChanged: (value) {
                                  SupplierCompanyUPINumber=value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Supplier Account Type',
                                  errorText: _SupplierCompanyAccountTypevalidate ? 'Enter Supplier Account Type' : null,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _EditSupplierCompanyAccountNumbertext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                obscureText: false,
                                onChanged: (value) {
                                  SupplierCompanyAccountNumber=value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Supplier Account Number',
                                  errorText: _SupplierCompanyAccountNumbervalidate ? 'Enter Supplier Account Number' : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _EditSupplierCompanyAccountIFSCtext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                obscureText: false,
                                onChanged: (value) {
                                  SupplierCompanyIFSC=value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Supplier Bank IFSC Code',
                                  errorText: _SupplierCompanyAccountIFSCvalidate ? 'Enter Supplier Bank IFSC Code' : null,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _EditSupplierCompanyUPINumbertext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                obscureText: false,
                                onChanged: (value) {
                                  SupplierCompanyUPINumber=value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Supplier UPI Number',
                                  errorText: _SupplierCompanyUPINumbervalidate ? 'Enter Supplier UPI Number' : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FlatButton(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12),
                        ),
                        textColor: Colors.white,
                        onPressed: () {
                          _showMyDialog();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "EDIT",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FlatButton(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12),
                        ),
                        textColor: Colors.white,
                        onPressed: () {
                          // Respond to button press
                          setState(() async {
                            if(SupplierCompanyName == null ||SupplierCompanyPerson == null ||SupplierCompanyMobile == null ||SupplierCompanyEmail == null ||SupplierCompanyAddress == null ||SupplierCompanyUdyogid == null ||SupplierCompanyCIN == null ||SupplierCompanyFAX == null ||SupplierCompanyPAN == null ||SupplierCompanyLicenceNumber == null ||SupplierCompanyLicenceType == null ||SupplierCompanyBankName == null ||SupplierCompanyBankBranch == null ||SupplierCompanyAccountNumber == null ||SupplierCompanyIFSC == null ||SupplierCompanyUPINumber == null)
                            {
                              _EditSupplierCompanyNametext.text.isEmpty ? _SupplierCompanyNamevalidate = true : _SupplierCompanyNamevalidate = false;
                              _EditSupplierCompanyPersontext.text.isEmpty ? _SupplierCompanyPersonvalidate = true : _SupplierCompanyPersonvalidate = false;
                              _EditSupplierCompanyMobiletext.text.isEmpty ? _SupplierCompanyMobilevalidate = true : _SupplierCompanyMobilevalidate = false;
                              _EditSupplierCompanyEmailtext.text.isEmpty ? _SupplierCompanyEmailvalidate = true : _SupplierCompanyEmailvalidate = false;
                              _EditSupplierCompanyAddresstext.text.isEmpty ? _SupplierCompanyAddressvalidate = true : _SupplierCompanyAddressvalidate = false;
                              _EditSupplierCompanyUdyogidtext.text.isEmpty ? _SupplierCompanyUdyogidvalidate = true : _SupplierCompanyUdyogidvalidate = false;
                              _EditSupplierCompanyCINtext.text.isEmpty ? _SupplierCompanyCINvalidate = true : _SupplierCompanyCINvalidate = false;
                              _EditSupplierCompanyGSTtext.text.isEmpty ? _SupplierCompanyGSTvalidate = true : _SupplierCompanyGSTvalidate = false;
                              _EditSupplierCompanyFAXtext.text.isEmpty ? _SupplierCompanyFAXvalidate = true : _SupplierCompanyFAXvalidate = false;
                              _EditSupplierCompanyPANtext.text.isEmpty ? _SupplierCompanyPANvalidate = true : _SupplierCompanyPANvalidate = false;
                              // _SupplierCompanyLicenceTypetext.text.isEmpty ? _SupplierCompanyLicenceTypevalidate = true : _SupplierCompanyLicenceTypevalidate = false;
                              // _SupplierCompanyLicenceNumbertext.text.isEmpty ? _SupplierCompanyLicenceNumbervalidate = true : _SupplierCompanyLicenceNumbervalidate = false;
                              _EditSupplierCompanyBankNametext.text.isEmpty ? _SupplierCompanyBankNamevalidate = true : _SupplierCompanyBankNamevalidate = false;
                              _EditSupplierCompanyBankBranchtext.text.isEmpty ? _SupplierCompanyBankBranchvalidate = true : _SupplierCompanyBankBranchvalidate = false;
                              _EditSupplierCompanyAccountNumbertext.text.isEmpty ? _SupplierCompanyAccountNumbervalidate = true : _SupplierCompanyAccountNumbervalidate = false;
                              _EditSupplierCompanyAccountIFSCtext.text.isEmpty ? _SupplierCompanyAccountIFSCvalidate = true : _SupplierCompanyAccountIFSCvalidate = false;
                              _EditSupplierCompanyUPINumbertext.text.isEmpty ? _SupplierCompanyUPINumbervalidate = true : _SupplierCompanyUPINumbervalidate = false;

                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "UPDATE",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
          ],
        ),
      ),
    );
  }





  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child:  AlertDialog(
            title: Text("Want to Edit Information!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                ],
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
                  child: Text('Edit'),
                  onPressed: () async {
                    setState(() {
                      enable = false;
                      Navigator.of(context).pop();
                    });
                  }
              ),
            ],
          ),
        );
      },
    );
  }

  DataRow getRow(int index)  {
    _SupplierCompanyLicenceTypetext.add(new TextEditingController());
    _SupplierCompanyLicenceNumbertext.add(new TextEditingController());
    _SupplierCompanyLicenceTypetext[index].text = TemplicenceType[index];
    _SupplierCompanyLicenceNumbertext[index].text = TemplicenceNumber[index];
    return DataRow(cells: [
      DataCell(Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          controller: _SupplierCompanyLicenceTypetext[index],
          readOnly: enable,
          enableInteractiveSelection: enable,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Product Name',
          ),
        ),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          controller: _SupplierCompanyLicenceNumbertext[index],
          readOnly: enable,
          enableInteractiveSelection: enable,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Product Rate',
          ),
        ),
      )),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < TemplicenceNumber.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }






}
