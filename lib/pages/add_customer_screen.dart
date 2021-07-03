import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/LocalDbModels/customer_model.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/popup_menu.dart';
import 'package:retailerp/providers/data_upload.dart';
import 'package:retailerp/providers/popup_menu_item.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/utils/my_navigator.dart';
import 'package:retailerp/widgets/drop_down_widget.dart';
import 'package:retailerp/widgets/rowtextfields.dart';

class AddCustomerScreen extends StatefulWidget {
  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
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

  DateTime selectedDate = DateTime.now();
  String _selectdate = DateFormat('dd/MM/yyyy').format(new DateTime.now());
  DataUpload dataUpload = new DataUpload();
  PopupMenu _selectedMenu = customerPopupMenu1[0];
  bool showspinnerlog = false;

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
        title: Text("Add Customer"),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // Navigator.pop(context);
              // MyNavigator.goToDashboard(context);
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
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
                    SizedBox(
                      height: 5,
                    ),
                    DropDownWidget('Select Credit Type *', mCreditType,
                        _getDropDownValue, 1, .60),
                    SizedBox(
                      height: 5,
                    ),
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
                                _cMobNoValidate = false;
                                // if (_cMobNo < 10) {
                                //   _mobileChek = 'Enter valid mobile no';
                                //   _cMobNoValidate = true;
                                // } else {
                                //   _cMobNoValidate = false;
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

                              print(_selectdate);
                              print(_cName);
                              print(_cMobNo);
                              print(_cEmail);
                              print(_cAddress);
                              print(_mCreditValue);
                              print(_cTaxSup);
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
                            'Save',
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
    var result = await databaseHelper.insertCustomerData(CustomerModel(
        _selectdate,
        _cName,
        _cMobNo.toString(),
        _cEmail,
        _cAddress,
        _mCreditValue,
        _cTaxSup,
        0));

    if (result != 0) {
      // Success
      // _showAlertDialog('Status', 'Product Saved Successfully');

      final prodata = await dataUpload.uploadCustomerData(_selectdate, _cName,
          _cMobNo.toString(), _cEmail, _cAddress, _mCreditValue, _cTaxSup, 0);

      var resid = prodata["resid"];
      print(resid);
      if (resid == 200) {
        setState(() {
          showspinnerlog = false;
          setState(() {
            _cNameController.text = '';
            _cMobNoController.text = '';
            _cEmailController.text = '';
            _cAddressController.text = '';
            _cTaxSupController.text = '';
          });
        });
      } else {
        setState(() {
          showspinnerlog = false;
        });
        Fluttertoast.showToast(
          msg: "Please check * marks fields",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black38,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving to add product category');
    }
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
