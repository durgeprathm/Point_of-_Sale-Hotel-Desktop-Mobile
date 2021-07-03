import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/LedgerManagement/Adpater/POS_Supplier_Insert.dart';
import 'package:retailerp/LedgerManagement/Adpater/fetch_account_type.dart';
import 'package:retailerp/LedgerManagement/Models/Accounttype.dart';
import 'package:retailerp/LedgerManagement/Models/ledgermodel.dart';
import 'package:retailerp/LedgerManagement/supplier_item_widget.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/pages/Import_purchase.dart';
import 'package:retailerp/pages/Manage_Purchase.dart';
import 'package:retailerp/pages/Manage_Suppliers.dart';
import 'package:retailerp/pages/add_purchase_new.dart';
import 'package:retailerp/pages/dashboard.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/widgets/supplier_cart_item.dart';

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
    Provider.of<SupplierProvider>(context, listen: false).clear();
    _getAccountType();
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
  List<AccountType> AccountTypeList = new List();
  int rowpro = 1;
  int tempIndex = 0;
  bool visibilityTagGST = false;
  SupplierInsert supplierinsert = new SupplierInsert();
  bool visGSTnotext = false;

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
  String SupplierAccountType;

  final _supplierCompLiNoTypeText = TextEditingController();
  final _supplierCompLiNoText = TextEditingController();

  final _SupplierCompanyLicenceTypetext = TextEditingController();
  final _SupplierCompanyLicenceNumbertext = TextEditingController();

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletAddSupplier() {
    void handleClick(String value) {
      switch (value) {
        case 'Manage Ledger':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ManageSuppliers()));
          break;
      }
    }

    double tabletwidth = MediaQuery.of(context).size.width * (.90);
    double tabletHeight = MediaQuery.of(context).size.height * (.35);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text('Add Ledger'),
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
                'Manage Ledger',
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
      body: SingleChildScrollView(
        child: Consumer<SupplierProvider>(builder: (context, cart, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  shape: Border.all(color: PrimaryColor, width: 2),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Ledger Company Information',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.black,
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
                                    labelText: 'Ledger Company Name',
                                    errorText: _SupplierCompanyNamevalidate
                                        ? ' Enter Ledger Company Name'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: DropdownSearch<AccountType>(
                                  isFilteredOnline: true,
                                  showClearButton: true,
                                  showSearchBox: true,
                                  items: AccountTypeList,
                                  label: "Ledger Account Type",
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (AccountType u) => u == null
                                      ? "Product field is required "
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      SupplierAccountType =
                                          value.AccountTypeID.toString();
                                    });

                                    var sss = value.AccountTypeName.toString();
                                    print(SupplierAccountType);
                                    print(sss);
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
                                  controller: _SupplierCompanyPersontext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    setState(() {
                                      SupplierCompanyPerson = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Ledger Person Name',
                                    // errorText: _SupplierCompanyPersonvalidate
                                    //     ? ' Enter Ledger Person Name'
                                    //     : null,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: _SupplierCompanyMobiletext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == null) {
                                        SupplierCompanyMobile = "";
                                      } else {
                                        SupplierCompanyMobile = value;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Ledger Company Mobile Number',
                                    // errorText: _SupplierCompanyMobilevalidate
                                    //     ? ' Enter Ledger Company Mobile Number'
                                    //     : null,
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
                                    setState(() {
                                      if (value == null) {
                                        SupplierCompanyAddress = "";
                                      } else {
                                        SupplierCompanyAddress = value;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Supplier Company Address',
                                    // errorText: _SupplierCompanyAddressvalidate
                                    //     ? 'Enter Supplier Company Address'
                                    //     : null,
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
                                  controller: _SupplierCompanyEmailtext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == null) {
                                        SupplierCompanyEmail = "";
                                      } else {
                                        SupplierCompanyEmail = value;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Ledger Company E-Mail',
                                    // errorText: _SupplierCompanyEmailvalidate
                                    //     ? 'Enter Ledger Company E-Mail'
                                    //     : null,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: _SupplierCompanyUdyogidtext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == null) {
                                        SupplierCompanyUdyogid = "";
                                      } else {
                                        SupplierCompanyUdyogid = value;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Ledger Company Udyog Aadhaar',
                                    // errorText: _SupplierCompanyUdyogidvalidate
                                    //     ? 'Enter Ledger Company Udyog Aadhaar'
                                    //     : null,
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
                                  controller: _SupplierCompanyCINtext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == null) {
                                        SupplierCompanyCIN = "";
                                      } else {
                                        SupplierCompanyCIN = value;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Ledger CIN Number',
                                    // errorText: _SupplierCompanyCINvalidate
                                    //     ? 'Enter Ledger Company CIN Number'
                                    //     : null,
                                  ),
                                ),
                              ),
                            ),
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
                                  label: "Ledger Company GSTIN",
                                  onChanged: (value) {
                                    if (value == null) {
                                      setState(() {
                                        SupplierCompanyGSTType = "";
                                      });
                                    } else {
                                      setState(() {
                                        SupplierCompanyGSTType = value;
                                      });
                                    }

                                    if (value == "Composition" ||
                                        value == "Consumers" ||
                                        value == "Regular") {
                                      setState(() {
                                        visGSTnotext = true;
                                      });
                                    } else {
                                      SupplierCompanyGSTType = value;
                                      setState(() {
                                        visGSTnotext = false;
                                      });
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
                            Visibility(
                              visible: visGSTnotext,
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextField(
                                    controller: _SupplierCompanyGSTNumbertext,
                                    obscureText: false,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == null) {
                                          SupplierCompanyGSTNumber = "";
                                        } else {
                                          SupplierCompanyGSTNumber = value;
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Ledger GST Number',
                                      // errorText: _SupplierCompanyCINvalidate
                                      //     ? 'Enter Ledger GST Number'
                                      //     : null,
                                    ),
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
                                  controller: _SupplierCompanyFAXtext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == null) {
                                        SupplierCompanyFAX = "";
                                      } else {
                                        SupplierCompanyFAX = value;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Ledger Company Fax Number',
                                    // errorText: _SupplierCompanyFAXvalidate
                                    //     ? 'Enter Ledger Company Fax Number'
                                    //     : null,
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
                                    setState(() {
                                      if (value == null) {
                                        SupplierCompanyPAN = "";
                                      } else {
                                        SupplierCompanyPAN = value;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Ledger Company Pan Number',
                                    // errorText: _SupplierCompanyPANvalidate
                                    //     ? 'Enter Ledger Company Pan Number'
                                    //     : null,
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
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _SupplierCompanyLicenceTypetext,
                                  obscureText: false,
                                  onChanged: (value) async {
                                    setState(() {
                                      if (value == null) {
                                        SupplierCompanyLicenceType = "";
                                      } else {
                                        SupplierCompanyLicenceType = value;
                                      }
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText:
                                        'Ledger Company license Type Name',
                                    errorText: _SupplierCompanyLicenceTypevalidate
                                        ? 'Enter Ledger Company license Type Name'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _SupplierCompanyLicenceNumbertext,
                                  obscureText: false,
                                  onChanged: (value) async {
                                    setState(() {
                                      if (value == null) {
                                        SupplierCompanyLicenceNumber = "";
                                      } else {
                                        SupplierCompanyLicenceNumber = value;
                                      }
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Ledger Company licence Number',
                                    errorText: _SupplierCompanyLicenceNumbervalidate
                                        ? 'Enter Ledger Company license Type Name'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.plusCircle,
                                      // color: PrimaryColor,
                                      size: 20.0,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        // print('Add Btn Call');
                                        // print('ProductName: $pProName');

                                        if (_SupplierCompanyLicenceTypetext
                                            .text.isEmpty) {
                                          _SupplierCompanyLicenceTypevalidate =
                                              true;
                                        } else if (_SupplierCompanyLicenceNumbertext
                                                .text ==
                                            0) {
                                          _SupplierCompanyLicenceNumbervalidate =
                                              true;
                                        } else {
                                          _SupplierCompanyLicenceNumbervalidate =
                                              false;
                                        }

                                        bool errorCheck =
                                            (!SupplierCompanyLicenceType
                                                    .isEmpty &&
                                                !_SupplierCompanyLicenceNumbervalidate);

                                        print(
                                            'Company Licence Type Name: $SupplierCompanyLicenceType');
                                        print(
                                            'Ledger Company Licence Number: $SupplierCompanyLicenceNumber');

                                        if (errorCheck) {
                                          print(
                                              'Company Licence Type Name: $SupplierCompanyLicenceType');
                                          print(
                                              'Ledger Company Licence Number: $SupplierCompanyLicenceNumber');

                                          final supplierLicense = Supplier.cust(
                                            SupplierCompanyLicenceType,
                                            SupplierCompanyLicenceNumber
                                                .toString(),
                                          );
                                          Provider.of<SupplierProvider>(context,
                                                  listen: false)
                                              .addSupplierLicence(
                                                  supplierLicense);
                                          print("cart ${cart.itemCount}");

                                          // LocalCompanyLicenceType.add(SupplierCompanyLicenceType);
                                          // LocalCompanyLicenceNumber.add(SupplierCompanyLicenceNumber);

                                          _SupplierCompanyLicenceTypetext.text =
                                              '';
                                          _SupplierCompanyLicenceNumbertext
                                              .text = '';
                                          SupplierCompanyLicenceType = '';

                                          // print("/////${cart.itemCount}");
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: "Check Product data!!!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            backgroundColor: PrimaryColor,
                                            textColor: Color(0xffffffff),
                                            gravity: ToastGravity.BOTTOM,
                                          );
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Visibility(
                          visible: cart.itemCount == 0 ? false : true,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: tabletwidth,
                              height: tabletHeight,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: cart.itemCount,
                                  itemBuilder: (context, int index) {
                                    final cartItem = cart.pSupplier[index];
                                    return SupplierItemWidget(
                                        cartItem, index);
                                  }),
                            ),
                          ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Ledger Bank Account Information',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.black,
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
                                    setState(() {
                                      if (value == null) {
                                        SupplierCompanyBankName = "";
                                      } else {
                                        SupplierCompanyBankName = value;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Ledger Bank Name',
                                    // errorText: _SupplierCompanyBankNamevalidate
                                    //     ? 'Enter Ledger Bank Name'
                                    //     : null,
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
                                    setState(() {
                                      if (value == null) {
                                        SupplierCompanyBankBranch = "";
                                      } else {
                                        SupplierCompanyBankBranch = value;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Ledger Bank Branch Name',
                                    errorText:
                                        _SupplierCompanyBankBranchvalidate
                                            ? 'Enter Ledger Bank Branch Name'
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
                                  label: "Ledger Company Account Type",
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == null) {
                                        SupplierCompanyAccountType = "";
                                      } else {
                                        SupplierCompanyAccountType = value;
                                      }
                                    });
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
                                    setState(() {
                                      if (value == null) {
                                        SupplierCompanyAccountNumber = "";
                                      } else {
                                        SupplierCompanyAccountNumber = value;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Ledger Account Number',
                                    //errorText:
                                    // _SupplierCompanyAccountNumbervalidate
                                    //     ? 'Enter Ledger Account Number'
                                    //     : null,
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
                                    setState(() {
                                      if (value == null) {
                                        SupplierCompanyIFSC = "";
                                      } else {
                                        SupplierCompanyIFSC = value;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Ledger Bank IFSC Code',
                                    // errorText: _SupplierCompanyAccountIFSCvalidate
                                    //     ? 'Enter Ledger Bank IFSC Code'
                                    //     : null,
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
                                    setState(() {
                                      if (value == null) {
                                        SupplierCompanyUPINumber = "";
                                      } else {
                                        SupplierCompanyUPINumber = value;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Ledger UPI Number',
                                    // errorText: _SupplierCompanyUPINumbervalidate
                                    //     ? 'Enter Ledger UPI Number'
                                    //     : null,
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
                          if (SupplierCompanyName == null) {
                            _SupplierCompanyNametext.text.isEmpty
                                ? _SupplierCompanyNamevalidate = true
                                : _SupplierCompanyNamevalidate = false;
                            // _SupplierCompanyPersontext.text.isEmpty
                            //     ? _SupplierCompanyPersonvalidate = true
                            //     : _SupplierCompanyPersonvalidate = false;
                            // _SupplierCompanyMobiletext.text.isEmpty
                            //     ? _SupplierCompanyMobilevalidate = true
                            //     : _SupplierCompanyMobilevalidate = false;
                            // _SupplierCompanyEmailtext.text.isEmpty
                            //     ? _SupplierCompanyEmailvalidate = true
                            //     : _SupplierCompanyEmailvalidate = false;
                            // _SupplierCompanyAddresstext.text.isEmpty
                            //     ? _SupplierCompanyAddressvalidate = true
                            //     : _SupplierCompanyAddressvalidate = false;
                            // _SupplierCompanyUdyogidtext.text.isEmpty
                            //     ? _SupplierCompanyUdyogidvalidate = true
                            //     : _SupplierCompanyUdyogidvalidate = false;
                            // _SupplierCompanyCINtext.text.isEmpty
                            //     ? _SupplierCompanyCINvalidate = true
                            //     : _SupplierCompanyCINvalidate = false;
                            // _SupplierCompanyGSTtext.text.isEmpty
                            //     ? _SupplierCompanyGSTvalidate = true
                            //     : _SupplierCompanyGSTvalidate = false;
                            // _SupplierCompanyFAXtext.text.isEmpty
                            //     ? _SupplierCompanyFAXvalidate = true
                            //     : _SupplierCompanyFAXvalidate = false;
                            // _SupplierCompanyPANtext.text.isEmpty
                            //     ? _SupplierCompanyPANvalidate = true
                            //     : _SupplierCompanyPANvalidate = false;
                            // _SupplierCompanyLicenceTypetext.text.isEmpty ? _SupplierCompanyLicenceTypevalidate = true : _SupplierCompanyLicenceTypevalidate = false;
                            //  _SupplierCompanyLicenceNumbertext.text.isEmpty ? _SupplierCompanyLicenceNumbervalidate = true : _SupplierCompanyLicenceNumbervalidate = false;
                            // _SupplierCompanyBankNametext.text.isEmpty
                            //     ? _SupplierCompanyBankNamevalidate = true
                            //     : _SupplierCompanyBankNamevalidate = false;
                            // _SupplierCompanyBankBranchtext.text.isEmpty
                            //     ? _SupplierCompanyBankBranchvalidate = true
                            //     : _SupplierCompanyBankBranchvalidate = false;
                            // _SupplierCompanyAccountNumbertext.text.isEmpty
                            //     ? _SupplierCompanyAccountNumbervalidate = true
                            //     : _SupplierCompanyAccountNumbervalidate =
                            //         false;
                            // _SupplierCompanyAccountIFSCtext.text.isEmpty
                            //     ? _SupplierCompanyAccountIFSCvalidate = true
                            //     : _SupplierCompanyAccountIFSCvalidate = false;
                            // _SupplierCompanyUPINumbertext.text.isEmpty
                            //     ? _SupplierCompanyUPINumbervalidate = true
                            //     : _SupplierCompanyUPINumbervalidate = false;
                          } else {
                            List<String> LicenceType = new List();
                            List<String> LicenceNumber = new List();

                            List<Supplier> pTempRecipeList = [];
                            pTempRecipeList = cart.pSupplier;

                            pTempRecipeList.forEach((element) {
                              LicenceType.add(
                                  element.SupplierLicenseType.toString());
                              LicenceNumber.add(element.SupplierLicenseName);
                            });

                            String JoinedCompanyLicenceType =
                                LicenceType.join("#");
                            print(JoinedCompanyLicenceType);
                            String JoinedCompanyLicenceNumber =
                                LicenceNumber.join("#");
                            if (SupplierCompanyName == null) {
                              SupplierCompanyName = "";
                            }
                            if (SupplierCompanyPerson == null) {
                              SupplierCompanyPerson = "";
                            }
                            if (SupplierCompanyMobile == null) {
                              SupplierCompanyMobile = "";
                            }
                            if (SupplierCompanyEmail == null) {
                              SupplierCompanyEmail = "";
                            }
                            if (SupplierCompanyAddress == null) {
                              SupplierCompanyAddress = "";
                            }
                            if (SupplierCompanyUdyogid == null) {
                              SupplierCompanyUdyogid = "";
                            }
                            if (SupplierCompanyCIN == null) {
                              SupplierCompanyCIN = "";
                            }
                            if (SupplierCompanyGSTType == null) {
                              SupplierCompanyGSTType = "";
                            }
                            if (SupplierCompanyGSTNumber == null) {
                              SupplierCompanyGSTNumber = "";
                            }
                            if (SupplierCompanyFAX == null) {
                              SupplierCompanyFAX = "";
                            }
                            if (SupplierCompanyPAN == null) {
                              SupplierCompanyPAN = "";
                            }
                            if (JoinedCompanyLicenceType == null) {
                              JoinedCompanyLicenceType = "";
                            }
                            if (JoinedCompanyLicenceNumber == null) {
                              JoinedCompanyLicenceNumber = "";
                            }
                            if (SupplierCompanyBankName == null) {
                              SupplierCompanyBankName = "";
                            }
                            if (SupplierCompanyBankBranch == null) {
                              SupplierCompanyBankBranch = "";
                            }
                            if (SupplierCompanyAccountType == null) {
                              SupplierCompanyAccountType = "";
                            }
                            if (SupplierCompanyAccountNumber == null) {
                              SupplierCompanyAccountNumber = "";
                            }
                            if (SupplierCompanyIFSC == null) {
                              SupplierCompanyIFSC = "";
                            }
                            if (SupplierCompanyUPINumber == null) {
                              SupplierCompanyUPINumber = "";
                            }
                            if (SupplierAccountType == null) {
                              SupplierAccountType = "";
                            }
                            if (SupplierAccountType == null) {
                              SupplierAccountType = "";
                            }

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
                            print(SupplierAccountType);
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

                            var result =
                                await supplierinsert.getpossupplierinsert(
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
                                    SupplierCompanyUPINumber,SupplierAccountType);
                            var resid = result["resid"];
                            if (resid != 200) {
                              _showMyDialog('Filed !', Colors.red);
                            } else {
                              _showMyDialog(
                                  'Data Save Successfully!', Colors.green);
                            }
                          }
                        },
                        child: Center(
                          child: Text("ADD Ledger",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-Bold",
                                  fontSize: 18,
                                  letterSpacing: 1.0)),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(60),
              ),
            ],
          );
        }),
      ),
    );
  }

  //---------------Tablet Mode End-------------//
  //---------------Mobile Mode Start-------------//
  Widget _buildMobileAddSupplier() {
    void handleClick(String value) {
      switch (value) {
        case 'Add Purchase':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPurchaseNew()));
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
                                  final cartItem = cart.pSupplier[index];
                                  return SupplierCartItem(cartItem);
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
                                setState(() {
                                  if (SupplierCompanyName == null ||
                                      SupplierCompanyPerson == null ||
                                      SupplierCompanyMobile == null ||
                                      SupplierCompanyEmail == null ||
                                      SupplierCompanyAddress == null ||
                                      SupplierCompanyUdyogid == null ||
                                      SupplierCompanyCIN == null ||
                                      SupplierCompanyFAX == null ||
                                      SupplierCompanyPAN == null ||
                                      SupplierCompanyLicenceNumber == null ||
                                      SupplierCompanyLicenceType == null ||
                                      SupplierCompanyBankName == null ||
                                      SupplierCompanyBankBranch == null ||
                                      SupplierCompanyAccountNumber == null ||
                                      SupplierCompanyIFSC == null ||
                                      SupplierCompanyUPINumber == null) {
                                    _SupplierCompanyNametext.text.isEmpty
                                        ? _SupplierCompanyNamevalidate = true
                                        : _SupplierCompanyNamevalidate = false;
                                    _SupplierCompanyPersontext.text.isEmpty
                                        ? _SupplierCompanyPersonvalidate = true
                                        : _SupplierCompanyPersonvalidate =
                                            false;
                                    _SupplierCompanyMobiletext.text.isEmpty
                                        ? _SupplierCompanyMobilevalidate = true
                                        : _SupplierCompanyMobilevalidate =
                                            false;
                                    _SupplierCompanyEmailtext.text.isEmpty
                                        ? _SupplierCompanyEmailvalidate = true
                                        : _SupplierCompanyEmailvalidate = false;
                                    _SupplierCompanyAddresstext.text.isEmpty
                                        ? _SupplierCompanyAddressvalidate = true
                                        : _SupplierCompanyAddressvalidate =
                                            false;
                                    _SupplierCompanyUdyogidtext.text.isEmpty
                                        ? _SupplierCompanyUdyogidvalidate = true
                                        : _SupplierCompanyUdyogidvalidate =
                                            false;
                                    _SupplierCompanyCINtext.text.isEmpty
                                        ? _SupplierCompanyCINvalidate = true
                                        : _SupplierCompanyCINvalidate = false;
                                    _SupplierCompanyGSTtext.text.isEmpty
                                        ? _SupplierCompanyGSTvalidate = true
                                        : _SupplierCompanyGSTvalidate = false;
                                    _SupplierCompanyFAXtext.text.isEmpty
                                        ? _SupplierCompanyFAXvalidate = true
                                        : _SupplierCompanyFAXvalidate = false;
                                    _SupplierCompanyPANtext.text.isEmpty
                                        ? _SupplierCompanyPANvalidate = true
                                        : _SupplierCompanyPANvalidate = false;
                                    // _SupplierCompanyLicenceTypetext.text.isEmpty ? _SupplierCompanyLicenceTypevalidate = true : _SupplierCompanyLicenceTypevalidate = false;
                                    // _SupplierCompanyLicenceNumbertext.text.isEmpty ? _SupplierCompanyLicenceNumbervalidate = true : _SupplierCompanyLicenceNumbervalidate = false;
                                    _SupplierCompanyBankNametext.text.isEmpty
                                        ? _SupplierCompanyBankNamevalidate =
                                            true
                                        : _SupplierCompanyBankNamevalidate =
                                            false;
                                    _SupplierCompanyBankBranchtext.text.isEmpty
                                        ? _SupplierCompanyBankBranchvalidate =
                                            true
                                        : _SupplierCompanyBankBranchvalidate =
                                            false;
                                    _SupplierCompanyAccountNumbertext
                                            .text.isEmpty
                                        ? _SupplierCompanyAccountNumbervalidate =
                                            true
                                        : _SupplierCompanyAccountNumbervalidate =
                                            false;
                                    _SupplierCompanyAccountIFSCtext.text.isEmpty
                                        ? _SupplierCompanyAccountIFSCvalidate =
                                            true
                                        : _SupplierCompanyAccountIFSCvalidate =
                                            false;
                                    _SupplierCompanyUPINumbertext.text.isEmpty
                                        ? _SupplierCompanyUPINumbervalidate =
                                            true
                                        : _SupplierCompanyUPINumbervalidate =
                                            false;
                                  } else {
                                    if (cart.itemCount != 0) {
                                      List<String> licenceType = new List();
                                      List<String> licenceNumber = new List();
                                      List<Supplier> pTempRecipeList =
                                          cart.pSupplier;

                                      pTempRecipeList.forEach((element) {
                                        licenceType
                                            .add(element.SupplierLicenseType);
                                        licenceNumber
                                            .add(element.SupplierLicenseName);
                                      });
                                      String JoinedCompanyLicenceType =
                                          licenceType.join("#");
                                      print(JoinedCompanyLicenceType);
                                      String JoinedCompanyLicenceNumber =
                                          licenceNumber.join("#");
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
                                      //insert data in server
                                      var result =
                                          supplierinsert.getpossupplierinsert(
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
                                              SupplierCompanyUPINumber,SupplierCompanyAccountType);
                                      if (res == null && result == null) {
                                        _showMyDialog('Filed !', Colors.red);
                                      } else {
                                        _showMyDialog('Data Save Successfully!',
                                            Colors.green);
                                        print("//////in purchase////////$res");
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Add license type and number",
                                        toastLength: Toast.LENGTH_SHORT,
                                        backgroundColor: PrimaryColor,
                                        textColor: Color(0xffffffff),
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                    }
                                  }
                                });
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

  void _getAccountType() async {
    AccountTypeFetch accounttypefetch = new AccountTypeFetch();
    var accounttypefetchData = await accounttypefetch.getAccountTypeFetch("0");
    var resid = accounttypefetchData["resid"];
    if (resid == 200) {
      var rowcount = accounttypefetchData["rowcount"];
      if (rowcount > 0) {
        var accounttypefetchsd = accounttypefetchData["AccountTypelist"];
        print(accounttypefetchsd.length);
        List<AccountType> tempAccountTypeList = [];
        for (var n in accounttypefetchsd) {
          AccountType pro = AccountType(
            int.parse(n["accounttypeids"]),
            n["accounttypename"],
          );
          tempAccountTypeList.add(pro);
          setState(() {
            this.AccountTypeList = tempAccountTypeList;
          });
          print("//////AccountTypeList/////////$AccountTypeList.length");
        }
      } else {
        String msg = accounttypefetchData["message"];
        // Fluttertoast.showToast(
        //   msg: msg,
        //   toastLength: Toast.LENGTH_SHORT,
        //   backgroundColor: Colors.black38,
        //   textColor: Color(0xffffffff),
        //   gravity: ToastGravity.BOTTOM,
        // );
      }

      // List<String> tempCustomerNames = [];
      // for (int i = 0; i < CustomerList.length; i++) {
      //   tempCustomerNames.add(CustomerList[i].custName);
      // }
      // setState(() {
      //   this.customerName = tempCustomerNames;
      // });
      // print(customerName);
    } else {
      String msg = accounttypefetchData["message"];
      // Fluttertoast.showToast(
      //   msg: msg,
      //   toastLength: Toast.LENGTH_SHORT,
      //   backgroundColor: Colors.black38,
      //   textColor: Color(0xffffffff),
      //   gravity: ToastGravity.BOTTOM,
      // );
    }
  }
}
