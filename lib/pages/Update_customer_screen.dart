import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/LocalDbModels/customer_model.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/popup_menu.dart';
import 'package:retailerp/pages/manage_customer.dart';
import 'package:retailerp/providers/data_upload.dart';
import 'package:retailerp/providers/popup_menu_item.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/utils/my_navigator.dart';
import 'package:retailerp/widgets/drop_down_widget.dart';
import 'package:retailerp/widgets/drop_down_widget_type.dart';
import 'package:retailerp/widgets/rowtextfields.dart';
import 'package:sqflite/sqflite.dart';

class UpdateCustomerScreen extends StatefulWidget {
  final int indexId;
  final List<CustomerModel> customerList;

  UpdateCustomerScreen(this.indexId, this.customerList);

  @override
  _UpdateCustomerScreenState createState() =>
      _UpdateCustomerScreenState(this.indexId, this.customerList);
}

class _UpdateCustomerScreenState extends State<UpdateCustomerScreen> {
  final int indexId;
  final List<CustomerModel> customerList;
  bool showspinnerlog = false;

  _UpdateCustomerScreenState(this.indexId, this.customerList);

  DataUpload dataUpload = new DataUpload();
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<String> mCreditType = ['CR', 'DR'];
  String _mCreditValue;

  final _cNameController = TextEditingController();
  final _cMobNoController = TextEditingController();
  final _cEmailController = TextEditingController();
  final _cAddressController = TextEditingController();
  final _cTaxSupController = TextEditingController();
  final _cNameID = 1;
  final _cMobNoID = 2;
  final _cEmailID = 3;
  final _cAddressID = 4;
  final _cTaxSupID = 5;
  bool _cNameValidate = false;
  bool _cMobNoValidate = false;
  bool _cEmailValidate = false;
  bool _cAddressValidate = false;
  bool _cTaxSupValidate = false;
  String _cName = "";
  int _cMobNo;
  String _cEmail = "";
  String _cAddress = "";
  String _cTaxSup = "";
  String _mobileChek = 'Enter a mobile no';
  int rowID;
  DateTime selectedDate = DateTime.now();
  String _selectdate = DateFormat('dd/MM/yyyy').format(new DateTime.now());

  PopupMenu _selectedMenu = customerPopupMenu1[0];

  @override
  void initState() {
    super.initState();
    // getTextData();
    getFromServerTextData();
  }

  void _getInputValue(String inputValue, int id) {
    setState(() {
      switch (id) {
        case 1:
          {
            _cName = inputValue;
          }
          break;
        case 2:
          {
            _cMobNo = int.parse(inputValue);
          }
          break;
        case 3:
          {
            _cEmail = inputValue;
          }
          break;
        case 4:
          {
            _cAddress = inputValue;
          }
          break;
        case 5:
          {
            _cTaxSup = inputValue;
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double tabletwidth = MediaQuery.of(context).size.width * (.60);
    var screenOrien = MediaQuery.of(context).orientation;
    double mobwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Customer"),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));

              // Navigator.pop(context);
              // MyNavigator.goToDashboard(context);
            },
          ),
          new PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              size: 28,
              color: Colors.white,
            ),
            itemBuilder: (BuildContext context) {
              return customerPopupMenu1.map((PopupMenu popupMenu) {
                return new PopupMenuItem(
                    value: popupMenu,
                    child: new ListTile(
                      dense: true,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      leading: popupMenu.icon,
                      title: new Text(popupMenu.title),
                    ));
              }).toList();
            },
            onSelected: _selectedPopMenu,
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ModalProgressHUD(
          inAsyncCall: showspinnerlog,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RowTextFields(
                        'Customer Name*',
                        _cNameController,
                        _getInputValue,
                        _cNameID,
                        _cNameValidate,
                        'text',
                        'Enter a Customer Name',
                        .60),
                    RowTextFields(
                        'Mobile No.*',
                        _cMobNoController,
                        _getInputValue,
                        _cMobNoID,
                        _cMobNoValidate,
                        'no',
                        _mobileChek,
                        .60),
                    RowTextFields(
                        'Email*',
                        _cEmailController,
                        _getInputValue,
                        _cEmailID,
                        _cEmailValidate,
                        'text',
                        'Enter a Email',
                        .60),
                    RowTextFields(
                        'Address*',
                        _cAddressController,
                        _getInputValue,
                        _cAddressID,
                        _cAddressValidate,
                        'text',
                        'Enter a Address',
                        .60),
                    DropDownWidgetType.withType('Select Credit Type *',
                        mCreditType, _getDropDownValue, 1, .60, _mCreditValue),
                    // DropDownWidget('Select Credit Type *', mCreditType,
                    //     _getDropDownValue, 1, .60,),
                    RowTextFields(
                        'Tax Supplier*',
                        _cTaxSupController,
                        _getInputValue,
                        _cTaxSupID,
                        _cTaxSupValidate,
                        'text',
                        'Enter a tax supplier',
                        .60),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(vertical: 10),
                    //       child: Container(
                    //         width: screenOrien == Orientation.portrait
                    //             ? mobwidth
                    //             : tabletwidth,
                    //         child: TextField(
                    //           enabled: false,
                    //           enableInteractiveSelection: false,
                    //           decoration: InputDecoration(
                    //             labelText: _selectdate,
                    //             // labelText: DateFormat('dd/MM/yyyy')
                    //             //     .format(new DateTime.now()),
                    //             border: OutlineInputBorder(),
                    //             labelStyle: labelTextStyle,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     FlatButton.icon(
                    //       onPressed: () => _selectAndroidDate(context),
                    //       icon: Icon(
                    //         Icons.calendar_today,
                    //       ),
                    //       label: Text(''),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Material(
                        elevation: 5.0,
                        color: PrimaryColor,
                        borderRadius: BorderRadius.circular(15.0),
                        child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              if (_cNameController.text.isEmpty) {
                                _cNameValidate = true;
                              } else {
                                _cNameValidate = false;
                              }
                              if (_cMobNoController.text.isEmpty) {
                                _cMobNoValidate = true;
                              } else {
                                // if (_cMobNo < 10) {
                                //   _mobileChek = 'Enter valid mobile no';
                                //   _cMobNoValidate = true;
                                // } else {
                                _cMobNoValidate = false;
                                // }
                              }
                              if (_cEmailController.text.isEmpty) {
                                _cEmailValidate = true;
                              } else {
                                _cEmailValidate = false;
                              }
                              if (_cAddressController.text.isEmpty) {
                                _cAddressValidate = true;
                              } else {
                                _cAddressValidate = false;
                              }
                              if (_cTaxSupController.text.isEmpty) {
                                _cTaxSupValidate = true;
                              } else {
                                _cTaxSupValidate = false;
                              }

                              bool errorCheck = (!_cNameValidate &&
                                  !_cMobNoValidate &&
                                  !_cEmailValidate &&
                                  !_cAddressValidate &&
                                  !_cTaxSupValidate &&
                                  _mCreditValue != null);

                              if (errorCheck) {
                                _saveToloc();
                                print('errorCheck Call');
                              } else {
                                Fluttertoast.showToast(
                                  msg:
                                      "Fill all the * Marked fileds Before Proceeding!!!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.black38,
                                  textColor: Color(0xffffffff),
                                  gravity: ToastGravity.BOTTOM,
                                );
                              }
                              // }
                            });
                          },
                          minWidth: 150,
                          height: 25.0,
                          child: Text(
                            'Update',
                            style: btnTextStyle,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveToloc() async {
    setState(() {
      showspinnerlog = true;
    });
    // var result = await databaseHelper.updateCustomer(
    //     CustomerModel(_selectdate, _cName, _cMobNo, _cEmail, _cAddress,
    //         _mCreditValue, _cTaxSup, 0),
    //     indexId);
    //
    // if (result != 0) {
    //   // Success
      // _showAlertDialog('Status', 'Customer data Saved Successfully');
      final prodata = await dataUpload.updateCustomerData(
          rowID.toString(),
          _selectdate,
          _cName,
          _cMobNo.toString(),
          _cEmail,
          _cAddress,
          _mCreditValue,
          _cTaxSup,
          0);

      var resid = prodata["resid"];
      print(resid);
      if (resid == 200) {
        setState(() {
          showspinnerlog = false;
        });
        Navigator.pop(context, true);
      } else {
        setState(() {
          showspinnerlog = false;
        });
        Fluttertoast.showToast(
          msg: "Customer data updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black38,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }

      // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      //   return ManageCustomer();
      // }));
    // } else {
    //   // Failure
    //   _showAlertDialog('Status', 'Problem Saving to Customer data');
    // }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _selectedPopMenu(PopupMenu popupMenu) {
    setState(() {
      _selectedMenu = popupMenu;
      print(_selectedMenu.title);
    });
  }

  _getDropDownValue(String value, int _taxid) {
    setState(() {
      switch (_taxid) {
        case 1:
          _mCreditValue = value;
          break;
      }
      print('_mCredit Value: $_mCreditValue');
    });
  }

  void getTextData() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((value) {
      Future<List<CustomerModel>> proListFuture =
          databaseHelper.getCustomerSingleData(indexId);
      proListFuture.then((productCatList) {
        setState(() {
          productCatList.forEach((element) {
            _cNameController.text = element.custName;
            _cMobNoController.text = element.custMobileNo.toString();
            _cEmailController.text = element.custEmail.toString();
            _cAddressController.text = element.custAddress;
            _cTaxSupController.text = element.taxSupplier;
            _mCreditValue = element.custCreditType;
          });
        });
      });
    });
  }

  void getFromServerTextData() {
    setState(() {
      // _selectdate, _cName,
      // _cMobNo.toString(), _cEmail, _cAddress, _mCreditValue, _cTaxSup,

      rowID = customerList[indexId].custId;
      _cNameController.text = customerList[indexId].custName;
      _cName = customerList[indexId].custName;
      _cMobNoController.text = customerList[indexId].custMobileNo.toString();
      _cMobNo = int.parse(customerList[indexId].custMobileNo);
      _cEmailController.text = customerList[indexId].custEmail.toString();
      _cEmail = customerList[indexId].custEmail.toString();
      _cAddressController.text = customerList[indexId].custAddress;
      _cAddress = customerList[indexId].custAddress;
      _cTaxSupController.text = customerList[indexId].taxSupplier;
      _cTaxSup = customerList[indexId].taxSupplier;
      _mCreditValue = customerList[indexId].custCreditType;
    });
  }

  _selectAndroidDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2018),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _selectdate = DateFormat('dd/MM/yyyy').format(picked);
        print("Date Selected:  $_selectdate");
      });
  }
}
