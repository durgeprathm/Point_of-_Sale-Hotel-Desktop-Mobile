import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/LedgerManagement/Adpater/POS_Supplier_Insert.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/supplier.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/supplier_cart_item.dart';

import 'Add_purchase.dart';
import 'Import_purchase.dart';
import 'Manage_Purchase.dart';
import 'Manage_Suppliers.dart';
import 'Mobile_BankSupplierDetalis.dart';
import 'dashboard.dart';

class AddSupplierDetails extends StatefulWidget {
  @override
  _AddSupplierDetailsState createState() => _AddSupplierDetailsState();
}

class _AddSupplierDetailsState extends State<AddSupplierDetails> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  @override
//------------------------
  static const int kTabletBreakpoint = 552;
  bool supListVisibility = false;

  @override
  void initState() {
    // Provider.of<SupplierProvider>(context, listen: false).clear();
  }

  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileAddSupplier();
    } else {
      content = _buildTabletAddSupplier();
    }

    return content;
  }

  //------------------------
  int rowpro = 1;
  int tempIndex = 0;
  bool visibilityTagGST = false;
  SupplierInsert supplierinsert = new SupplierInsert();

  final _SupplierCompanyNametext = TextEditingController();
  final _SupplierCompanyPersontext = TextEditingController();
  final _SupplierCompanyMobiletext = TextEditingController();
  final _SupplierCompanyEmailtext = TextEditingController();
  final _SupplierCompanyAddresstext = TextEditingController();
  final _SupplierCompanyUdyogidtext = TextEditingController();
  final _SupplierCompanyCINtext = TextEditingController();
  final _SupplierCompanyGSTtext = TextEditingController();
  final _SupplierCompanyGSTNumbertext = TextEditingController();
  final _SupplierCompanyFAXtext = TextEditingController();
  final _SupplierCompanyPANtext = TextEditingController();

  // final _SupplierCompanyLicenceTypetext=TextEditingController();
  // final _SupplierCompanyLicenceNumbertext=TextEditingController();
  final _SupplierCompanyBankNametext = TextEditingController();
  final _SupplierCompanyBankBranchtext = TextEditingController();
  final _SupplierCompanyAccountTypetext = TextEditingController();
  final _SupplierCompanyAccountNumbertext = TextEditingController();
  final _SupplierCompanyAccountIFSCtext = TextEditingController();
  final _SupplierCompanyUPINumbertext = TextEditingController();

  bool _SupplierCompanyNamevalidate = false;
  bool _SupplierCompanyPersonvalidate = false;
  bool _SupplierCompanyMobilevalidate = false;
  bool _SupplierCompanyEmailvalidate = false;
  bool _SupplierCompanyAddressvalidate = false;
  bool _SupplierCompanyUdyogidvalidate = false;
  bool _SupplierCompanyCINvalidate = false;
  bool _SupplierCompanyGSTvalidate = false;
  bool _SupplierCompanyFAXvalidate = false;
  bool _SupplierCompanyPANvalidate = false;
  bool _SupplierCompanyLicenceTypevalidate = false;
  bool _SupplierCompanyLicenceNumbervalidate = false;
  bool _SupplierCompanyBankNamevalidate = false;
  bool _SupplierCompanyBankBranchvalidate = false;
  bool _SupplierCompanyAccountTypevalidate = false;
  bool _SupplierCompanyAccountNumbervalidate = false;
  bool _SupplierCompanyAccountIFSCvalidate = false;
  bool _SupplierCompanyUPINumbervalidate = false;

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
  bool _showProgressBar = false;
  List<String> LocalCompanyLicenceType = new List();
  List<String> LocalCompanyLicenceNumber = new List();

  final _supplierCompLiNoTypeText = TextEditingController();
  final _supplierCompLiNoText = TextEditingController();

  List<TextEditingController> _SupplierCompanyLicenceTypetext = new List();
  List<TextEditingController> _SupplierCompanyLicenceNumbertext = new List();

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletAddSupplier() {
    void handleClick(String value) {
      switch (value) {
        case 'Add Purchase':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPurchase()));
          break;
        case 'Manage Purchase':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Managepurchase()));
          break;
        case 'Import Purchase':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImportPurchase()));
          break;
        case 'Manage Suppliers':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ManageSuppliers()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text('Add Supplier'),
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
                'Manage Suppliers',
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
      body: ModalProgressHUD(
        inAsyncCall: _showProgressBar,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  shape: Border.all(color: PrimaryColor, width: 2),
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
                                  controller: _SupplierCompanyNametext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    SupplierCompanyName = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Supplier Company Name',
                                    errorText: _SupplierCompanyNamevalidate
                                        ? ' Enter Supplier Company Name'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: _SupplierCompanyPersontext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    SupplierCompanyPerson = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Supplier Person Name',
                                    errorText: _SupplierCompanyPersonvalidate
                                        ? ' Enter Supplier Person Name'
                                        : null,
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
                                  controller: _SupplierCompanyMobiletext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    SupplierCompanyMobile = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Supplier Company Mobile Number',
                                    errorText: _SupplierCompanyMobilevalidate
                                        ? ' Enter Supplier Company Mobile Number'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: _SupplierCompanyEmailtext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    SupplierCompanyEmail = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Supplier Company E-Mail',
                                    errorText: _SupplierCompanyEmailvalidate
                                        ? 'Enter Supplier Company E-Mail'
                                        : null,
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
                                  controller: _SupplierCompanyAddresstext,
                                  obscureText: false,
                                  maxLines: 3,
                                  onChanged: (value) {
                                    SupplierCompanyAddress = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Supplier Company Address',
                                    errorText: _SupplierCompanyAddressvalidate
                                        ? 'Enter Supplier Company Address'
                                        : null,
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
                                  controller: _SupplierCompanyUdyogidtext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    SupplierCompanyUdyogid = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Supplier Company Udyog Aadhaar',
                                    errorText: _SupplierCompanyUdyogidvalidate
                                        ? 'Enter Supplier Company Udyog Aadhaar'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: _SupplierCompanyCINtext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    SupplierCompanyCIN = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Supplier CIN Number',
                                    errorText: _SupplierCompanyCINvalidate
                                        ? 'Enter Supplier Company CIN Number'
                                        : null,
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
                                // child: TextField(
                                //   obscureText: false,
                                //   decoration: InputDecoration(
                                //     border: OutlineInputBorder(),
                                //     labelText: 'Supplier Company GSTIN',
                                //   ),
                                // ),
                                child: DropdownSearch(
                                  items: [
                                    "Unknown",
                                    "Composition",
                                    "Consumers",
                                    "Regular",
                                    "Unregister"
                                  ],
                                  label: "Supplier Company GSTIN",
                                  onChanged: (value) {
                                    SupplierCompanyGSTType = value;
                                    if (value == "Composition" ||
                                        value == "Consumers" ||
                                        value == "Regular") {
                                      _showMyDialogGST();
                                    } else {
                                      SupplierCompanyGSTNumber = value;
                                    }
                                  },
                                  validator: (String item) {
                                    if (item == null)
                                      return "Required field";
                                    else if (item == "Brazil")
                                      return "Invalid item";
                                    else
                                      return null;
                                  },
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
                                  controller: _SupplierCompanyFAXtext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    SupplierCompanyFAX = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Supplier Company Fax Number',
                                    errorText: _SupplierCompanyFAXvalidate
                                        ? 'Enter Supplier Company Fax Number'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  obscureText: false,
                                  controller: _SupplierCompanyPANtext,
                                  onChanged: (value) {
                                    SupplierCompanyPAN = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Supplier Company Pan Number',
                                    errorText: _SupplierCompanyPANvalidate
                                        ? 'Enter Supplier Company Pan Number'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Material(
                          shape: Border.all(color: PrimaryColor, width: 2),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              // height: 150.0,
                              child: ListView.builder(
                                  itemCount: rowpro,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    _SupplierCompanyLicenceTypetext.add(
                                        new TextEditingController());
                                    _SupplierCompanyLicenceNumbertext.add(
                                        new TextEditingController());
                                    return Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: TextField(
                                                obscureText: false,
                                                controller:
                                                    _SupplierCompanyLicenceTypetext[
                                                        index],
                                                onChanged: (value) {
                                                  SupplierCompanyLicenceType =
                                                      value;
                                                },
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText:
                                                      'Supplier Company license Type Name',
                                                  errorText:
                                                      _SupplierCompanyLicenceTypevalidate
                                                          ? 'Enter Supplier Company license Type Name'
                                                          : null,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: TextField(
                                                controller:
                                                    _SupplierCompanyLicenceNumbertext[
                                                        index],
                                                obscureText: false,
                                                onChanged: (value) {
                                                  SupplierCompanyLicenceNumber =
                                                      value;
                                                },
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText:
                                                      'Supplier Company licence Number',
                                                  errorText:
                                                      _SupplierCompanyLicenceNumbervalidate
                                                          ? 'Enter Supplier Company licence Number'
                                                          : null,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: IconButton(
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.save,
                                                    color: Colors.green,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (SupplierCompanyLicenceType ==
                                                              null ||
                                                          SupplierCompanyLicenceNumber ==
                                                              null) {
                                                        _SupplierCompanyLicenceTypetext[
                                                                    index]
                                                                .text
                                                                .isEmpty
                                                            ? _SupplierCompanyLicenceTypevalidate =
                                                                true
                                                            : _SupplierCompanyLicenceTypevalidate =
                                                                false;
                                                        _SupplierCompanyLicenceNumbertext[
                                                                    index]
                                                                .text
                                                                .isEmpty
                                                            ? _SupplierCompanyLicenceNumbervalidate =
                                                                true
                                                            : _SupplierCompanyLicenceNumbervalidate =
                                                                false;
                                                      } else {
                                                        LocalCompanyLicenceType.add(
                                                            SupplierCompanyLicenceType);
                                                        LocalCompanyLicenceNumber
                                                            .add(
                                                                SupplierCompanyLicenceNumber);
                                                        print(
                                                            LocalCompanyLicenceType);
                                                        print(
                                                            LocalCompanyLicenceNumber);
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: IconButton(
                                                  icon: FaIcon(
                                                    FontAwesomeIcons
                                                        .minusCircle,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (rowpro != 1) {
                                                        rowpro--;
                                                        LocalCompanyLicenceType
                                                            .removeAt(index);
                                                        LocalCompanyLicenceNumber
                                                            .removeAt(index);
                                                        print(
                                                            LocalCompanyLicenceType);
                                                        print(
                                                            LocalCompanyLicenceNumber);
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          elevation: 5.0,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.plusCircle,
                                  color: PrimaryColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (SupplierCompanyLicenceType == null ||
                                        SupplierCompanyLicenceNumber == null) {
                                      _SupplierCompanyLicenceTypetext[tempIndex]
                                              .text
                                              .isEmpty
                                          ? _SupplierCompanyLicenceTypevalidate =
                                              true
                                          : _SupplierCompanyLicenceTypevalidate =
                                              false;
                                      _SupplierCompanyLicenceNumbertext[
                                                  tempIndex]
                                              .text
                                              .isEmpty
                                          ? _SupplierCompanyLicenceNumbervalidate =
                                              true
                                          : _SupplierCompanyLicenceNumbervalidate =
                                              false;
                                    } else {
                                      tempIndex++;
                                      rowpro++;
                                      print(tempIndex);
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
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
                  shape: Border.all(color: PrimaryColor, width: 2),
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
                                  controller: _SupplierCompanyBankNametext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    SupplierCompanyBankName = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Supplier Bank Name',
                                    errorText: _SupplierCompanyBankNamevalidate
                                        ? 'Enter Supplier Bank Name'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: _SupplierCompanyBankBranchtext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    SupplierCompanyBankBranch = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Supplier Bank Branch Name',
                                    errorText:
                                        _SupplierCompanyBankBranchvalidate
                                            ? 'Enter Supplier Bank Branch Name'
                                            : null,
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
                                // child: TextField(
                                //   obscureText: false,
                                //   decoration: InputDecoration(
                                //     border: OutlineInputBorder(),
                                //     labelText: 'Supplier Account Type',
                                //   ),
                                // ),
                                child: DropdownSearch(
                                  items: ["Current", "Saving"],
                                  label: "Supplier Company Account Type",
                                  onChanged: (value) {
                                    SupplierCompanyAccountType = value;
                                  },
                                  validator: (String item) {
                                    if (item == null)
                                      return "Required field";
                                    else if (item == "Brazil")
                                      return "Invalid item";
                                    else
                                      return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: _SupplierCompanyAccountNumbertext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    SupplierCompanyAccountNumber = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Supplier Account Number',
                                    errorText:
                                        _SupplierCompanyAccountNumbervalidate
                                            ? 'Enter Supplier Account Number'
                                            : null,
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
                                  controller: _SupplierCompanyAccountIFSCtext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    SupplierCompanyIFSC = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Supplier Bank IFSC Code',
                                    errorText:
                                        _SupplierCompanyAccountIFSCvalidate
                                            ? 'Enter Supplier Bank IFSC Code'
                                            : null,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: _SupplierCompanyUPINumbertext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    SupplierCompanyUPINumber = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Supplier UPI Number',
                                    errorText: _SupplierCompanyUPINumbervalidate
                                        ? 'Enter Supplier UPI Number'
                                        : null,
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
                children: <Widget>[
                  InkWell(
                    child: Container(
                      width: ScreenUtil.getInstance().setWidth(330),
                      height: ScreenUtil.getInstance().setHeight(200),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          PrimaryColor,
                          PrimaryColor,
                        ]),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            uploadData();
                          },
                          child: Center(
                            child: Text("ADD SUPPLIER",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 18,
                                    letterSpacing: 1.0)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(60),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //---------------Tablet Mode End-------------//
  //---------------Mobile Mode Start-------------//
  Widget _buildMobileAddSupplier() {
    void handleClick(String value) {
      switch (value) {
        case 'Add Purchase':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPurchase()));
          break;
        case 'Manage Purchase':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Managepurchase()));
          break;
        case 'Import Purchase':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImportPurchase()));
          break;
        case 'Manage Suppliers':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ManageSuppliers()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text('Add Supplier'),
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
                'Manage Suppliers',
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
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Consumer<SupplierProvider>(builder: (context, cart, child) {
                return Column(children: [
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
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: TextField(
                      controller: _SupplierCompanyNametext,
                      obscureText: false,
                      onChanged: (value) {
                        SupplierCompanyName = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Supplier Company Name',
                        errorText: _SupplierCompanyNamevalidate
                            ? ' Enter Supplier Company Name'
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: TextField(
                      controller: _SupplierCompanyPersontext,
                      obscureText: false,
                      onChanged: (value) {
                        SupplierCompanyPerson = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Supplier Person Name',
                        errorText: _SupplierCompanyPersonvalidate
                            ? ' Enter Supplier Person Name'
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: TextField(
                      controller: _SupplierCompanyMobiletext,
                      obscureText: false,
                      onChanged: (value) {
                        SupplierCompanyMobile = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Supplier Company Mobile Number',
                        errorText: _SupplierCompanyMobilevalidate
                            ? ' Enter Supplier Company Mobile Number'
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: TextField(
                      controller: _SupplierCompanyEmailtext,
                      obscureText: false,
                      onChanged: (value) {
                        SupplierCompanyEmail = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Supplier Company E-Mail',
                        errorText: _SupplierCompanyEmailvalidate
                            ? 'Enter Supplier Company E-Mail'
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: TextField(
                      controller: _SupplierCompanyAddresstext,
                      obscureText: false,
                      maxLines: 3,
                      onChanged: (value) {
                        SupplierCompanyAddress = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Supplier Company Address',
                        errorText: _SupplierCompanyAddressvalidate
                            ? 'Enter Supplier Company Address'
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: TextField(
                      controller: _SupplierCompanyUdyogidtext,
                      obscureText: false,
                      onChanged: (value) {
                        SupplierCompanyUdyogid = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Supplier Company Udyog Aadhaar',
                        errorText: _SupplierCompanyUdyogidvalidate
                            ? 'Enter Supplier Company Udyog Aadhaar'
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: TextField(
                      controller: _SupplierCompanyCINtext,
                      obscureText: false,
                      onChanged: (value) {
                        SupplierCompanyCIN = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Supplier CIN Number',
                        errorText: _SupplierCompanyCINvalidate
                            ? 'Enter Supplier Company CIN Number'
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    // child: TextField(
                    //   obscureText: false,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     labelText: 'Supplier Company GSTIN',
                    //   ),
                    // ),
                    child: DropdownSearch(
                      items: [
                        "Unknown",
                        "Composition",
                        "Consumers",
                        "Regular",
                        "Unregister"
                      ],
                      label: "Supplier Company GSTIN",
                      onChanged: (value) {
                        SupplierCompanyGSTType = value;
                        if (value == "Composition" ||
                            value == "Consumers" ||
                            value == "Regular") {
                          _showMyDialogGST();
                        } else {
                          SupplierCompanyGSTNumber = value;
                        }
                      },
                      validator: (String item) {
                        if (item == null)
                          return "Required field";
                        else if (item == "Brazil")
                          return "Invalid item";
                        else
                          return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: TextField(
                      controller: _SupplierCompanyFAXtext,
                      obscureText: false,
                      onChanged: (value) {
                        SupplierCompanyFAX = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Supplier Company Fax Number',
                        errorText: _SupplierCompanyFAXvalidate
                            ? 'Enter Supplier Company Fax Number'
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: TextField(
                      obscureText: false,
                      controller: _SupplierCompanyPANtext,
                      onChanged: (value) {
                        SupplierCompanyPAN = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Supplier Company Pan Number',
                        errorText: _SupplierCompanyPANvalidate
                            ? 'Enter Supplier Company Pan Number'
                            : null,
                      ),
                    ),
                  ),
                  //-------------------------------------------------------
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: TextField(
                      controller: _supplierCompLiNoTypeText,
                      obscureText: false,
                      onChanged: (value) {
                        SupplierCompanyLicenceType = (value);
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Supplier Company license Type Name',
                        errorText: _SupplierCompanyLicenceTypevalidate
                            ? 'Enter Supplier Company license Type Name'
                            : null,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _supplierCompLiNoText,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            SupplierCompanyLicenceNumber = value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Supplier Company licence Number',
                            errorText: _SupplierCompanyLicenceNumbervalidate
                                ? 'Enter Supplier Company licence Number'
                                : null,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.plusCircle,
                          color: PrimaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_supplierCompLiNoTypeText.text.isEmpty) {
                              _SupplierCompanyLicenceTypevalidate = true;
                            } else {
                              _SupplierCompanyLicenceTypevalidate = false;
                            }
                            if (_supplierCompLiNoText.text.isEmpty) {
                              _SupplierCompanyLicenceNumbervalidate = true;
                            } else {
                              _SupplierCompanyLicenceNumbervalidate = false;
                            }

                            bool errorCheck =
                                (!_SupplierCompanyLicenceTypevalidate &&
                                    !_SupplierCompanyLicenceNumbervalidate);

                            if (errorCheck) {
                              final suppliers = Supplier.cust(
                                  SupplierCompanyLicenceType,
                                  SupplierCompanyLicenceNumber);
                              Provider.of<SupplierProvider>(context,
                                      listen: false)
                                  .addSupplierLicence(suppliers);
                              SupplierCompanyLicenceType = '';
                              SupplierCompanyLicenceNumber = '';
                              _supplierCompLiNoTypeText.text = '';
                              _supplierCompLiNoText.text = '';
                              supListVisibility = true;
                              print("/////${cart.itemCount}");
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Visibility(
                    visible: supListVisibility,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 300,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: cart.itemCount,
                                itemBuilder: (context, int index) {
                                  // final cartItem = cart.pSupplier[index];
                                  // return SupplierCartItem(cartItem);
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              PrimaryColor,
                              PrimaryColor,
                            ]),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                //   if (SupplierCompanyName == null ||
                                //       SupplierCompanyPerson == null ||
                                //       SupplierCompanyMobile == null ||
                                //       SupplierCompanyEmail == null ||
                                //       SupplierCompanyAddress == null ||
                                //       SupplierCompanyUdyogid == null ||
                                //       SupplierCompanyCIN == null ||
                                //       SupplierCompanyFAX == null ||
                                //       SupplierCompanyPAN == null ||
                                //       SupplierCompanyLicenceNumber == null ||
                                //       SupplierCompanyLicenceType == null ||
                                //       SupplierCompanyBankName == null ||
                                //       SupplierCompanyBankBranch == null ||
                                //       SupplierCompanyAccountNumber == null ||
                                //       SupplierCompanyIFSC == null ||
                                //       SupplierCompanyUPINumber == null) {
                                //     _SupplierCompanyNametext.text.isEmpty
                                //         ? _SupplierCompanyNamevalidate = true
                                //         : _SupplierCompanyNamevalidate = false;
                                //     _SupplierCompanyPersontext.text.isEmpty
                                //         ? _SupplierCompanyPersonvalidate = true
                                //         : _SupplierCompanyPersonvalidate =
                                //             false;
                                //     _SupplierCompanyMobiletext.text.isEmpty
                                //         ? _SupplierCompanyMobilevalidate = true
                                //         : _SupplierCompanyMobilevalidate =
                                //             false;
                                //     _SupplierCompanyEmailtext.text.isEmpty
                                //         ? _SupplierCompanyEmailvalidate = true
                                //         : _SupplierCompanyEmailvalidate = false;
                                //     _SupplierCompanyAddresstext.text.isEmpty
                                //         ? _SupplierCompanyAddressvalidate = true
                                //         : _SupplierCompanyAddressvalidate =
                                //             false;
                                //     _SupplierCompanyUdyogidtext.text.isEmpty
                                //         ? _SupplierCompanyUdyogidvalidate = true
                                //         : _SupplierCompanyUdyogidvalidate =
                                //             false;
                                //     _SupplierCompanyCINtext.text.isEmpty
                                //         ? _SupplierCompanyCINvalidate = true
                                //         : _SupplierCompanyCINvalidate = false;
                                //     _SupplierCompanyGSTtext.text.isEmpty
                                //         ? _SupplierCompanyGSTvalidate = true
                                //         : _SupplierCompanyGSTvalidate = false;
                                //     _SupplierCompanyFAXtext.text.isEmpty
                                //         ? _SupplierCompanyFAXvalidate = true
                                //         : _SupplierCompanyFAXvalidate = false;
                                //     _SupplierCompanyPANtext.text.isEmpty
                                //         ? _SupplierCompanyPANvalidate = true
                                //         : _SupplierCompanyPANvalidate = false;
                                //     // _SupplierCompanyLicenceTypetext.text.isEmpty ? _SupplierCompanyLicenceTypevalidate = true : _SupplierCompanyLicenceTypevalidate = false;
                                //     // _SupplierCompanyLicenceNumbertext.text.isEmpty ? _SupplierCompanyLicenceNumbervalidate = true : _SupplierCompanyLicenceNumbervalidate = false;
                                //     _SupplierCompanyBankNametext.text.isEmpty
                                //         ? _SupplierCompanyBankNamevalidate =
                                //             true
                                //         : _SupplierCompanyBankNamevalidate =
                                //             false;
                                //     _SupplierCompanyBankBranchtext.text.isEmpty
                                //         ? _SupplierCompanyBankBranchvalidate =
                                //             true
                                //         : _SupplierCompanyBankBranchvalidate =
                                //             false;
                                //     _SupplierCompanyAccountNumbertext
                                //             .text.isEmpty
                                //         ? _SupplierCompanyAccountNumbervalidate =
                                //             true
                                //         : _SupplierCompanyAccountNumbervalidate =
                                //             false;
                                //     _SupplierCompanyAccountIFSCtext.text.isEmpty
                                //         ? _SupplierCompanyAccountIFSCvalidate =
                                //             true
                                //         : _SupplierCompanyAccountIFSCvalidate =
                                //             false;
                                //     _SupplierCompanyUPINumbertext.text.isEmpty
                                //         ? _SupplierCompanyUPINumbervalidate =
                                //             true
                                //         : _SupplierCompanyUPINumbervalidate =
                                //             false;
                                //   } else {
                                //     if (cart.itemCount != 0) {
                                //       List<String> licenceType = new List();
                                //       List<String> licenceNumber = new List();
                                //       List<Supplier> pTempRecipeList =
                                //           cart.pSupplier;
                                //
                                //       pTempRecipeList.forEach((element) {
                                //         licenceType
                                //             .add(element.SupplierLicenseType);
                                //         licenceNumber
                                //             .add(element.SupplierLicenseName);
                                //       });
                                //       String JoinedCompanyLicenceType =
                                //           licenceType.join("#");
                                //       print(JoinedCompanyLicenceType);
                                //       String JoinedCompanyLicenceNumber =
                                //           licenceNumber.join("#");
                                //       print(JoinedCompanyLicenceNumber);
                                //       print(SupplierCompanyName);
                                //       print(SupplierCompanyPerson);
                                //       print(SupplierCompanyMobile);
                                //       print(SupplierCompanyEmail);
                                //       print(SupplierCompanyAddress);
                                //       print(SupplierCompanyUdyogid);
                                //       print(SupplierCompanyCIN);
                                //       print(SupplierCompanyGSTType);
                                //       print(SupplierCompanyGSTNumber);
                                //       print(SupplierCompanyFAX);
                                //       print(SupplierCompanyPAN);
                                //       print(JoinedCompanyLicenceType);
                                //       print(JoinedCompanyLicenceNumber);
                                //       print(SupplierCompanyBankName);
                                //       print(SupplierCompanyBankBranch);
                                //       print(SupplierCompanyAccountType);
                                //       print(SupplierCompanyAccountNumber);
                                //       print(SupplierCompanyIFSC);
                                //       print(SupplierCompanyUPINumber);
                                //       var res = new Supplier.copyWith(
                                //           SupplierCompanyName,
                                //           SupplierCompanyPerson,
                                //           SupplierCompanyMobile,
                                //           SupplierCompanyEmail,
                                //           SupplierCompanyAddress,
                                //           SupplierCompanyUdyogid,
                                //           SupplierCompanyCIN,
                                //           SupplierCompanyGSTType,
                                //           SupplierCompanyGSTNumber,
                                //           SupplierCompanyFAX,
                                //           SupplierCompanyPAN,
                                //           JoinedCompanyLicenceType,
                                //           JoinedCompanyLicenceNumber,
                                //           SupplierCompanyBankName,
                                //           SupplierCompanyBankBranch,
                                //           SupplierCompanyAccountType,
                                //           SupplierCompanyAccountNumber,
                                //           SupplierCompanyIFSC,
                                //           SupplierCompanyUPINumber);
                                //       //insert data in server
                                //       var result =
                                //           supplierinsert.getpossupplierinsert(
                                //               SupplierCompanyName,
                                //               SupplierCompanyPerson,
                                //               SupplierCompanyMobile,
                                //               SupplierCompanyEmail,
                                //               SupplierCompanyAddress,
                                //               SupplierCompanyUdyogid,
                                //               SupplierCompanyCIN,
                                //               SupplierCompanyGSTType,
                                //               SupplierCompanyGSTNumber,
                                //               SupplierCompanyFAX,
                                //               SupplierCompanyPAN,
                                //               JoinedCompanyLicenceType,
                                //               JoinedCompanyLicenceNumber,
                                //               SupplierCompanyBankName,
                                //               SupplierCompanyBankBranch,
                                //               SupplierCompanyAccountType,
                                //               SupplierCompanyAccountNumber,
                                //               SupplierCompanyIFSC,
                                //               SupplierCompanyUPINumber);
                                //       if (res == null && result == null) {
                                //         _showMyDialog('Filed !', Colors.red);
                                //       } else {
                                //         _showMyDialog('Data Save Successfully!',
                                //             Colors.green);
                                //         print("//////in purchase////////$res");
                                //       }
                                //     } else {
                                //       Fluttertoast.showToast(
                                //         msg: "Add license type and number",
                                //         toastLength: Toast.LENGTH_SHORT,
                                //         backgroundColor: PrimaryColor,
                                //         textColor: Color(0xffffffff),
                                //         gravity: ToastGravity.BOTTOM,
                                //       );
                                //     }
                                //   }
                                // });
                              },
                              child: Center(
                                child: Text("ADD SUPPLIER",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(60),
                  ),
                  // Container(
                  //   height: 300.0,
                  //   child: ListView.builder(
                  //       itemCount: rowpro,
                  //       shrinkWrap: true,
                  //       scrollDirection: Axis.vertical,
                  //       itemBuilder: (context, index) {
                  //         _SupplierCompanyLicenceTypetext.add(
                  //             new TextEditingController());
                  //         _SupplierCompanyLicenceNumbertext.add(
                  //             new TextEditingController());
                  //         return Padding(
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 20.0, vertical: 10.0),
                  //           child: Material(
                  //             //shape: Border.all(color: Colors.blueGrey, width: 5),
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Column(
                  //                 children: [
                  //                   Container(
                  //                     child: Row(
                  //                       mainAxisAlignment: MainAxisAlignment.center,
                  //                       children: [
                  //                         Padding(
                  //                           padding: const EdgeInsets.all(8.0),
                  //                           child: Text(
                  //                             "Add Licence   ${index + 1} ",
                  //                             style: TextStyle(
                  //                               fontWeight: FontWeight.bold,
                  //                               fontSize: 20.0,
                  //                               color: Colors.white,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         SizedBox(
                  //                           width: 30.0,
                  //                         ),
                  //                         Padding(
                  //                           padding: const EdgeInsets.all(8.0),
                  //                           child: IconButton(
                  //                             onPressed: () {
                  //                               setState(() {
                  //                                 if (rowpro != 1) {
                  //                                   rowpro--;
                  //                                   LocalCompanyLicenceType
                  //                                       .removeAt(index);
                  //                                   LocalCompanyLicenceNumber
                  //                                       .removeAt(index);
                  //                                   print(LocalCompanyLicenceType);
                  //                                   print(
                  //                                       LocalCompanyLicenceNumber);
                  //                                 }
                  //                               });
                  //                             },
                  //                             icon: FaIcon(
                  //                               FontAwesomeIcons.trash,
                  //                               color: Colors.white,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         Padding(
                  //                           padding: const EdgeInsets.all(8.0),
                  //                           child: IconButton(
                  //                             onPressed: () {
                  //                               // setState(() {
                  //                               //   rowpro++;
                  //                               // });
                  //                               setState(() {
                  //                                 if (SupplierCompanyLicenceType ==
                  //                                     null ||
                  //                                     SupplierCompanyLicenceNumber ==
                  //                                         null) {
                  //                                   _SupplierCompanyLicenceTypetext[
                  //                                   index]
                  //                                       .text
                  //                                       .isEmpty
                  //                                       ? _SupplierCompanyLicenceTypevalidate =
                  //                                   true
                  //                                       : _SupplierCompanyLicenceTypevalidate =
                  //                                   false;
                  //                                   _SupplierCompanyLicenceNumbertext[
                  //                                   index]
                  //                                       .text
                  //                                       .isEmpty
                  //                                       ? _SupplierCompanyLicenceNumbervalidate =
                  //                                   true
                  //                                       : _SupplierCompanyLicenceNumbervalidate =
                  //                                   false;
                  //                                 } else {
                  //                                   rowpro++;
                  //                                   LocalCompanyLicenceType.add(
                  //                                       SupplierCompanyLicenceType);
                  //                                   LocalCompanyLicenceNumber.add(
                  //                                       SupplierCompanyLicenceNumber);
                  //                                   print(LocalCompanyLicenceType);
                  //                                   print(
                  //                                       LocalCompanyLicenceNumber);
                  //                                 }
                  //                               });
                  //                             },
                  //                             icon: FaIcon(
                  //                               FontAwesomeIcons.plus,
                  //                               color: Colors.white,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     color: Colors.blue,
                  //                   ),
                  //                   Padding(
                  //                     padding: const EdgeInsets.all(8.0),
                  //                     child: TextField(
                  //                       obscureText: false,
                  //                       controller:
                  //                       _SupplierCompanyLicenceTypetext[index],
                  //                       onChanged: (value) {
                  //                         SupplierCompanyLicenceType = value;
                  //                       },
                  //                       decoration: InputDecoration(
                  //                         border: OutlineInputBorder(),
                  //                         labelText:
                  //                         'Supplier Company license Type Name',
                  //                         errorText: _SupplierCompanyLicenceTypevalidate
                  //                             ? 'Enter Supplier Company license Type Name'
                  //                             : null,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Padding(
                  //                     padding: const EdgeInsets.all(8.0),
                  //                     child: TextField(
                  //                       controller:
                  //                       _SupplierCompanyLicenceNumbertext[
                  //                       index],
                  //                       obscureText: false,
                  //                       onChanged: (value) {
                  //                         SupplierCompanyLicenceNumber = value;
                  //                       },
                  //                       decoration: InputDecoration(
                  //                         border: OutlineInputBorder(),
                  //                         labelText:
                  //                         'Supplier Company licence Number',
                  //                         errorText:
                  //                         _SupplierCompanyLicenceNumbervalidate
                  //                             ? 'Enter Supplier Company licence Number'
                  //                             : null,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             elevation: 10.0,
                  //           ),
                  //         );
                  //       }),
                  // ),

                  //----------------------------
                  // Padding(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  //   child: Material(
                  //     color: PRODUCTRATEBG,
                  //     borderRadius: BorderRadius.circular(10.0),
                  //     child: MaterialButton(
                  //       onPressed: () {
                  //         //setState(() async {
                  //         if (SupplierCompanyName == null ||
                  //             SupplierCompanyPerson == null ||
                  //             SupplierCompanyMobile == null ||
                  //             SupplierCompanyEmail == null ||
                  //             SupplierCompanyAddress == null ||
                  //             SupplierCompanyUdyogid == null ||
                  //             SupplierCompanyCIN == null ||
                  //             SupplierCompanyFAX == null ||
                  //             SupplierCompanyPAN == null ||
                  //             SupplierCompanyLicenceNumber == null ||
                  //             SupplierCompanyLicenceType == null) {
                  //           _SupplierCompanyNametext.text.isEmpty
                  //               ? _SupplierCompanyNamevalidate = true
                  //               : _SupplierCompanyNamevalidate = false;
                  //           _SupplierCompanyPersontext.text.isEmpty
                  //               ? _SupplierCompanyPersonvalidate = true
                  //               : _SupplierCompanyPersonvalidate = false;
                  //           _SupplierCompanyMobiletext.text.isEmpty
                  //               ? _SupplierCompanyMobilevalidate = true
                  //               : _SupplierCompanyMobilevalidate = false;
                  //           _SupplierCompanyEmailtext.text.isEmpty
                  //               ? _SupplierCompanyEmailvalidate = true
                  //               : _SupplierCompanyEmailvalidate = false;
                  //           _SupplierCompanyAddresstext.text.isEmpty
                  //               ? _SupplierCompanyAddressvalidate = true
                  //               : _SupplierCompanyAddressvalidate = false;
                  //           _SupplierCompanyUdyogidtext.text.isEmpty
                  //               ? _SupplierCompanyUdyogidvalidate = true
                  //               : _SupplierCompanyUdyogidvalidate = false;
                  //           _SupplierCompanyCINtext.text.isEmpty
                  //               ? _SupplierCompanyCINvalidate = true
                  //               : _SupplierCompanyCINvalidate = false;
                  //           _SupplierCompanyGSTtext.text.isEmpty
                  //               ? _SupplierCompanyGSTvalidate = true
                  //               : _SupplierCompanyGSTvalidate = false;
                  //           _SupplierCompanyFAXtext.text.isEmpty
                  //               ? _SupplierCompanyFAXvalidate = true
                  //               : _SupplierCompanyFAXvalidate = false;
                  //           _SupplierCompanyPANtext.text.isEmpty
                  //               ? _SupplierCompanyPANvalidate = true
                  //               : _SupplierCompanyPANvalidate = false;
                  //         } else {
                  //           String JoinedCompanyLicenceType =
                  //               LocalCompanyLicenceType.join("#");
                  //           print(JoinedCompanyLicenceType);
                  //           String JoinedCompanyLicenceNumber =
                  //               LocalCompanyLicenceNumber.join("#");
                  //           print(JoinedCompanyLicenceNumber);
                  //           print(SupplierCompanyName);
                  //           print(SupplierCompanyPerson);
                  //           print(SupplierCompanyMobile);
                  //           print(SupplierCompanyEmail);
                  //           print(SupplierCompanyAddress);
                  //           print(SupplierCompanyUdyogid);
                  //           print(SupplierCompanyCIN);
                  //           print(SupplierCompanyGSTType);
                  //           print(SupplierCompanyGSTNumber);
                  //           print(SupplierCompanyFAX);
                  //           print(SupplierCompanyPAN);
                  //           print(JoinedCompanyLicenceType);
                  //           print(JoinedCompanyLicenceNumber);
                  //           // print(SupplierCompanyBankName);
                  //           // print(SupplierCompanyBankBranch);
                  //           // print(SupplierCompanyAccountType);
                  //           // print(SupplierCompanyAccountNumber);
                  //           // print(SupplierCompanyIFSC);
                  //           // print(SupplierCompanyUPINumber);
                  //           Supplier supplier = new Supplier.copyWith(
                  //               SupplierCompanyName,
                  //               SupplierCompanyPerson,
                  //               SupplierCompanyMobile,
                  //               SupplierCompanyEmail,
                  //               SupplierCompanyAddress,
                  //               SupplierCompanyUdyogid,
                  //               SupplierCompanyCIN,
                  //               SupplierCompanyGSTType,
                  //               SupplierCompanyGSTNumber,
                  //               SupplierCompanyFAX,
                  //               SupplierCompanyPAN,
                  //               JoinedCompanyLicenceType,
                  //               JoinedCompanyLicenceNumber,
                  //               null,
                  //               null,
                  //               null,
                  //               null,
                  //               null,
                  //               null);
                  //           Navigator.of(context).push(
                  //             MaterialPageRoute(builder: (_) {
                  //               return BankSupplierDetalis(supplier);
                  //             }),
                  //           );
                  //         }
                  //         // });
                  //       },
                  //       minWidth: 100.0,
                  //       height: 35.0,
                  //       child: Text(
                  //         'Add Bank Details',
                  //         style: TextStyle(color: Colors.white, fontSize: 20.0),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ]);
              }),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showUploadDialog(String msg, Color col) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              msg,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: col,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (col == Colors.green) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => super.widget));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //---------------Mobile Mode End-------------//
  Future<void> _showMyDialog(String msg, Color col) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              msg,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: col,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  ///////////////-------------------GST NUMBER--------------------------//
  Future<void> _showMyDialogGST() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text('ADD GST NUMBER'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    controller: _SupplierCompanyGSTNumbertext,
                    autofocus: true,
                    decoration: InputDecoration(labelText: "GST Number"),
                    onChanged: (value) {
                      SupplierCompanyGSTNumber = value;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Add'),
                onPressed: () {
                  Navigator.of(context).pop();
                  print(SupplierCompanyGSTNumber);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  uploadData() async {
    setState(() {
      _showProgressBar = true;
    });
    String JoinedCompanyLicenceType = LocalCompanyLicenceType.join("#");
    print(JoinedCompanyLicenceType);
    String JoinedCompanyLicenceNumber = LocalCompanyLicenceNumber.join("#");
    print(JoinedCompanyLicenceNumber);
    print(SupplierCompanyName);
    print(SupplierCompanyPerson);
    print(SupplierCompanyMobile);
    print(SupplierCompanyEmail);
    print(SupplierCompanyAddress);
    print(SupplierCompanyUdyogid);
    print(SupplierCompanyCIN);
    print(SupplierCompanyGSTType);
    print(SupplierCompanyGSTNumber);
    print(SupplierCompanyFAX);
    print(SupplierCompanyPAN);
    print(JoinedCompanyLicenceType);
    print(JoinedCompanyLicenceNumber);
    print(SupplierCompanyBankName);
    print(SupplierCompanyBankBranch);
    print(SupplierCompanyAccountType);
    print(SupplierCompanyAccountNumber);
    print(SupplierCompanyIFSC);
    print(SupplierCompanyUPINumber);
    var res = new Supplier.copyWith(
        SupplierCompanyName,
        SupplierCompanyPerson,
        SupplierCompanyMobile,
        SupplierCompanyEmail,
        SupplierCompanyAddress,
        SupplierCompanyUdyogid,
        SupplierCompanyCIN,
        SupplierCompanyGSTType,
        SupplierCompanyGSTNumber,
        SupplierCompanyFAX,
        SupplierCompanyPAN,
        JoinedCompanyLicenceType,
        JoinedCompanyLicenceNumber,
        SupplierCompanyBankName,
        SupplierCompanyBankBranch,
        SupplierCompanyAccountType,
        SupplierCompanyAccountNumber,
        SupplierCompanyIFSC,
        SupplierCompanyUPINumber);

    //   if (SupplierCompanyName == null ||
    //       SupplierCompanyPerson == null ||
    //       SupplierCompanyMobile == null ||
    //       SupplierCompanyEmail == null ||
    //       SupplierCompanyAddress == null ||
    //       SupplierCompanyUdyogid == null ||
    //       SupplierCompanyCIN == null ||
    //       SupplierCompanyFAX == null ||
    //       SupplierCompanyPAN == null ||
    //       SupplierCompanyLicenceNumber == null ||
    //       SupplierCompanyLicenceType == null ||
    //       SupplierCompanyBankName == null ||
    //       SupplierCompanyBankBranch == null ||
    //       SupplierCompanyAccountNumber == null ||
    //       SupplierCompanyIFSC == null ||
    //       SupplierCompanyUPINumber == null) {
    //     _SupplierCompanyNametext.text.isEmpty
    //         ? _SupplierCompanyNamevalidate = true
    //         : _SupplierCompanyNamevalidate = false;
    //     _SupplierCompanyPersontext.text.isEmpty
    //         ? _SupplierCompanyPersonvalidate = true
    //         : _SupplierCompanyPersonvalidate = false;
    //     _SupplierCompanyMobiletext.text.isEmpty
    //         ? _SupplierCompanyMobilevalidate = true
    //         : _SupplierCompanyMobilevalidate = false;
    //     _SupplierCompanyEmailtext.text.isEmpty
    //         ? _SupplierCompanyEmailvalidate = true
    //         : _SupplierCompanyEmailvalidate = false;
    //     _SupplierCompanyAddresstext.text.isEmpty
    //         ? _SupplierCompanyAddressvalidate = true
    //         : _SupplierCompanyAddressvalidate = false;
    //     _SupplierCompanyUdyogidtext.text.isEmpty
    //         ? _SupplierCompanyUdyogidvalidate = true
    //         : _SupplierCompanyUdyogidvalidate = false;
    //     _SupplierCompanyCINtext.text.isEmpty
    //         ? _SupplierCompanyCINvalidate = true
    //         : _SupplierCompanyCINvalidate = false;
    //     _SupplierCompanyGSTtext.text.isEmpty
    //         ? _SupplierCompanyGSTvalidate = true
    //         : _SupplierCompanyGSTvalidate = false;
    //     _SupplierCompanyFAXtext.text.isEmpty
    //         ? _SupplierCompanyFAXvalidate = true
    //         : _SupplierCompanyFAXvalidate = false;
    //     _SupplierCompanyPANtext.text.isEmpty
    //         ? _SupplierCompanyPANvalidate = true
    //         : _SupplierCompanyPANvalidate = false;
    //     // _SupplierCompanyLicenceTypetext.text.isEmpty ? _SupplierCompanyLicenceTypevalidate = true : _SupplierCompanyLicenceTypevalidate = false;
    //     // _SupplierCompanyLicenceNumbertext.text.isEmpty ? _SupplierCompanyLicenceNumbervalidate = true : _SupplierCompanyLicenceNumbervalidate = false;
    //     _SupplierCompanyBankNametext.text.isEmpty
    //         ? _SupplierCompanyBankNamevalidate = true
    //         : _SupplierCompanyBankNamevalidate = false;
    //     _SupplierCompanyBankBranchtext.text.isEmpty
    //         ? _SupplierCompanyBankBranchvalidate = true
    //         : _SupplierCompanyBankBranchvalidate = false;
    //     _SupplierCompanyAccountNumbertext.text.isEmpty
    //         ? _SupplierCompanyAccountNumbervalidate = true
    //         : _SupplierCompanyAccountNumbervalidate =
    //             false;
    //     _SupplierCompanyAccountIFSCtext.text.isEmpty
    //         ? _SupplierCompanyAccountIFSCvalidate = true
    //         : _SupplierCompanyAccountIFSCvalidate = false;
    //     _SupplierCompanyUPINumbertext.text.isEmpty
    //         ? _SupplierCompanyUPINumbervalidate = true
    //         : _SupplierCompanyUPINumbervalidate = false;
    //   } else {

    //     //insert data in server
    var result = await supplierinsert.getpossupplierinsert(
        SupplierCompanyName!=null?SupplierCompanyName:'',
        SupplierCompanyPerson!=null?SupplierCompanyPerson:'',
        SupplierCompanyMobile!=null?SupplierCompanyMobile:'',
        SupplierCompanyEmail!=null?SupplierCompanyEmail:'',
        SupplierCompanyAddress!=null?SupplierCompanyAddress:'',
        SupplierCompanyUdyogid!=null?SupplierCompanyUdyogid:'',
        SupplierCompanyCIN!=null?SupplierCompanyCIN:'',
        SupplierCompanyGSTType!=null?SupplierCompanyGSTType:'',
        SupplierCompanyGSTNumber!=null?SupplierCompanyGSTNumber:'',
        SupplierCompanyFAX!=null?SupplierCompanyFAX:'',
        SupplierCompanyPAN!=null?SupplierCompanyPAN:'',
        JoinedCompanyLicenceType!=null?JoinedCompanyLicenceType:'',
        JoinedCompanyLicenceNumber!=null?JoinedCompanyLicenceNumber:'',
        SupplierCompanyBankName!=null?SupplierCompanyBankName:'',
        SupplierCompanyBankBranch!=null?SupplierCompanyBankBranch:'',
        SupplierCompanyAccountType!=null?SupplierCompanyAccountType:'',
        SupplierCompanyAccountNumber!=null?SupplierCompanyAccountNumber:'',
        SupplierCompanyIFSC!=null?SupplierCompanyIFSC:'',
        SupplierCompanyUPINumber!=null?SupplierCompanyUPINumber:'',
        '5');
    if (result != null) {
      int resid = result["resid"];
      String mes = result["message"];

      if (resid == 200) {
        setState(() {
          _showProgressBar = false;
        });

        _showUploadDialog(mes.toString(), Colors.green);
        // _showMyDialog(
        //     'Data Save Successfully!', Colors.green);
        print("//////in purchase////////$res");
      } else {
        setState(() {
          _showProgressBar = false;
        });
        _showUploadDialog(mes.toString(), Colors.red);
      }
    } else {
      setState(() {
        _showProgressBar = false;
      });
      _showMyDialog('Filed !', Colors.red);
    }
    //   }
  }
}
