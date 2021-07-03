import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/Adpater/pos_purchase_fetch.dart';
import 'package:retailerp/Adpater/pos_purchse_delete.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/models/Purchase.dart';
import 'package:retailerp/pages/product_wise_purchase_report_print.dart';
import 'package:retailerp/pages/purchase_report_print.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';

import 'Add_Supliers.dart';
import 'Add_purchase.dart';
import 'Import_purchase.dart';
import 'Manage_Suppliers.dart';

class ProductwisePurchaseReport extends StatefulWidget {
  @override
  _ProductwisePurchaseReportState createState() =>
      _ProductwisePurchaseReportState();
}

class _ProductwisePurchaseReportState extends State<ProductwisePurchaseReport> {
  @override
  // DatabaseHelper databaseHelper = DatabaseHelper();
  List<Purchase> purchaseList = new List();
  List<ProductModel> productList = new List();
  List<Purchase> _searchPurchaseList = [];
  int count;
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
  String proName;
  String proId;
  bool _showCircle = false;

  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = Text("Purchase Report");
  final TextEditingController _searchQuery = new TextEditingController();

  @override
  void initState() {
    final DateTime now = DateTime.now();
    final DateTime pre = new DateTime(now.year, now.month - 1, now.day);
    final String toDate = dateFormat.format(now);
    final String formDate = dateFormat.format(pre);
    _toDatetext.text = toDate;
    _fromDatetext.text = formDate;
    _getPurchase('1', '',"","");
    _getProducts();
  }

  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobilePurchaseReport();
    } else {
      content = _buildTabletProductwisePurchaseReport();
    }

    return content;
  }

//-------------------------------------------
//---------------Tablet Mode Start-------------//
  Widget _buildTabletProductwisePurchaseReport() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;
    void handleClick(String value) {
      switch (value) {
        case 'Add Purchase':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPurchase()));
          break;
        case 'Import Sales':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImportPurchase()));
          break;
        case 'Add Supplier':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddSupplierDetails()));
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
            FaIcon(FontAwesomeIcons.shoppingBag),
            SizedBox(
              width: 20.0,
            ),
            Text('ProductWise Purchase Report'),
          ],
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(Navigator.defaultRouteName));
                },
              ),
              purchaseList.length != 0
                  ? IconButton(
                      icon: Icon(Icons.print, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return ProductWisePurchaseReportPrint(
                              1, purchaseList);
                        }));
                      },
                    )
                  : Text(''),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _showCircle,
          child: SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          width: tabletWidth,
                          child: DropdownSearch<ProductModel>(
                            items: productList,
                            showClearButton: true,
                            showSearchBox: true,
                            label: 'Product *',
                            hint: "Select a Product",
                            onChanged: (value) {
                              if (value != null) {
                                proId = value.proId.toString();
                                proName = value.proName;
                                if (_fromDatetext.text.isEmpty ||
                                    _toDatetext.text.isEmpty) {
                                  print('date Empty 1');
                                  _getPurchase('2', value.proId.toString(),
                                      _fromDatetext.text, _toDatetext.text);
                                } else {
                                  print('date Empty 3');
                                  _getPurchase('3', value.proId.toString(),
                                      _fromDatetext.text, _toDatetext.text);
                                }
                              } else {
                                proId = null;
                                proName = null;
                                if (_fromDatetext.text.isEmpty ||
                                    _toDatetext.text.isEmpty) {
                                  print('date Value Empty 0');
                                  _getPurchase('0', '', '', '');
                                } else {
                                  print('date Value Empty 2');
                                  _getPurchase('1', '', _fromDatetext.text,
                                      _toDatetext.text);
                                }
                              }
                              
                            },
                          ),
                        ),
                      ),
                      // Container(
                      //   width: tabletWidth,
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         vertical: 10.0, horizontal: 20.0),
                      //     child: DateTimeField(
                      //       controller: _fromDatetext,
                      //       format: dateFormat,
                      //       keyboardType: TextInputType.number,
                      //       onShowPicker: (context, currentValue) {
                      //         return showDatePicker(
                      //             context: context,
                      //             firstDate: DateTime(1900),
                      //             initialDate: currentValue ?? DateTime.now(),
                      //             lastDate: DateTime(2100));
                      //       },
                      //       autovalidate: autoValidate,
                      //       validator: (date) =>
                      //           date == null ? 'Invalid date' : null,
                      //       onChanged: (date) => setState(() {
                      //         fromValue = date;
                      //         print('Selected Date: ${date}');
                      //       }),
                      //       onSaved: (date) => setState(() {
                      //         fromValue = date;
                      //         print('Selected value Date: $fromValue');
                      //         savedCount++;
                      //       }),
                      //       resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                      //       readOnly: readOnly,
                      //       decoration: InputDecoration(
                      //         border: OutlineInputBorder(),
                      //         labelText: 'From Date',
                      //         errorText:
                      //             _fromDatevalidate ? 'Enter From Date' : null,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   width: tabletWidth,
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         vertical: 10.0, horizontal: 10.0),
                      //     child: DateTimeField(
                      //       controller: _toDatetext,
                      //       format: dateFormat,
                      //       keyboardType: TextInputType.number,
                      //       onShowPicker: (context, currentValue) {
                      //         return showDatePicker(
                      //             context: context,
                      //             firstDate: DateTime(1900),
                      //             initialDate: currentValue ?? DateTime.now(),
                      //             lastDate: DateTime(2100));
                      //       },
                      //       autovalidate: autoValidate,
                      //       validator: (date) =>
                      //           date == null ? 'Invalid date' : null,
                      //       onChanged: (date) => setState(() {
                      //         toValue = date;
                      //         print('Selected Date: ${toValue}');
                      //       }),
                      //       onSaved: (date) => setState(() {
                      //         toValue = date;
                      //         print('Selected value Date: $_toDatetext');
                      //         savedCount++;
                      //       }),
                      //       resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                      //       readOnly: readOnly,
                      //       decoration: InputDecoration(
                      //         border: OutlineInputBorder(),
                      //         labelText: 'To Date',
                      //         errorText:
                      //             _toDatevalidate ? 'Enter Purchase Date' : null,
                      //       ),
                      //     ),
                      //     // DateTimeField(
                      //     //   format: dateFormat,
                      //     //   controller: _toDatetext,
                      //     //   onShowPicker: (context, currentValue) async {
                      //     //     final date = await showDatePicker(
                      //     //         context: context,
                      //     //         firstDate: DateTime(1900),
                      //     //         initialDate: currentValue ?? DateTime.now(),
                      //     //         lastDate: DateTime(2100));
                      //     //     if (date != null) {
                      //     //       final time = await showTimePicker(
                      //     //         context: context,
                      //     //         initialTime: TimeOfDay.fromDateTime(
                      //     //             currentValue ?? DateTime.now()),
                      //     //       );
                      //     //       return DateTimeField.combine(date, time);
                      //     //     } else {
                      //     //       return currentValue;
                      //     //     }
                      //     //   },
                      //     //   autovalidate: _toDatevalidate,
                      //     //   validator: (date) =>
                      //     //       date == null ? 'Invalid date' : null,
                      //     //   onChanged: (date) => setState(() {
                      //     //     toValue = date;
                      //     //     print('Selected Date: ${toValue}');
                      //     //   }),
                      //     //   onSaved: (date) => setState(() {
                      //     //     toValue = date;
                      //     //     print('Selected value Date: $_toDatetext');
                      //     //     savedCount++;
                      //     //   }),
                      //     //   resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                      //     //   readOnly: readOnly,
                      //     //   decoration: InputDecoration(
                      //     //     border: OutlineInputBorder(),
                      //     //     labelText: 'To Date',
                      //     //     errorText:
                      //     //         _toDatevalidate ? 'Enter Purchase Date' : null,
                      //     //   ),
                      //     // ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 10, vertical: 20),
                      //   child: Material(
                      //     elevation: 5.0,
                      //     color: PrimaryColor,
                      //     borderRadius: BorderRadius.circular(10.0),
                      //     child: MaterialButton(
                      //       onPressed: () async {
                      //         setState(() {
                      //           _fromDatetext.text.isEmpty
                      //               ? _fromDatevalidate = true
                      //               : _fromDatevalidate = false;
                      //           _toDatetext.text.isEmpty
                      //               ? _toDatevalidate = true
                      //               : _toDatevalidate = false;
                      //
                      //           int dateDiff =
                      //               toValue.difference(fromValue).inDays;
                      //           print('Date: $dateDiff');
                      //           if (dateDiff >= 0) {
                      //             _getFilterPurchase('2', proName,
                      //                 _fromDatetext.text, _toDatetext.text);
                      //             // _getbothpaymentDate(PaymentMode,_fromDatetext.text, _toDatetext.text);
                      //           } else {
                      //             Fluttertoast.showToast(
                      //               msg:
                      //                   "Select from date must be less than to date!!!",
                      //               toastLength: Toast.LENGTH_SHORT,
                      //               backgroundColor: Colors.black38,
                      //               textColor: Color(0xffffffff),
                      //               gravity: ToastGravity.BOTTOM,
                      //             );
                      //           }
                      //         });
                      //         CircularProgressIndicator();
                      //         // _toDatetext.clear();
                      //       },
                      //       minWidth: 75,
                      //       height: 5.0,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(5.0),
                      //         child: Text(
                      //           "Go",
                      //           style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.white,
                      //             fontSize: 20.0,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          child:
                          DateTimeField(
                            controller: _fromDatetext,
                            format: dateFormat,
                            keyboardType: TextInputType.number,
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                            },
                            autovalidate: autoValidate,
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
                            resetIcon:
                                showResetIcon ? Icon(Icons.delete) : null,
                            readOnly: readOnly,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'From Date',
                              errorText:
                                  _fromDatevalidate ? 'Enter From Date' : null,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          child: DateTimeField(
                            controller: _toDatetext,
                            format: dateFormat,
                            keyboardType: TextInputType.number,
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                            },
                            autovalidate: autoValidate,
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
                            resetIcon:
                                showResetIcon ? Icon(Icons.delete) : null,
                            readOnly: readOnly,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'To Date',
                              errorText: _toDatevalidate
                                  ? 'Enter Purchase Date'
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 60,
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
                                  _getPurchase('1', '', _fromDatetext.text,
                                      _toDatetext.text);
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
                            },
                            minWidth: 60,
                            height: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "Go",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                DataTable(columns: [
                  DataColumn(
                      label: Expanded(
                    child: Container(
                      child: Center(
                        child: Text('Sr No',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Container(
                      child: Center(
                        child: Text('Date',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Container(
                      child: Center(
                        child: Text('Product Name',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Container(
                      child: Text('GST',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Container(
                      child: Center(
                        child: Text('Qty',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Container(
                      child: Center(
                        child: Text('Product Qty',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Container(
                      child: Center(
                        child: Text('Total',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )),
                ], rows: getDataRowList()),
              ],
            )),
          ),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobilePurchaseReport() {
    void handleClick(String value) {
      switch (value) {
        case 'Add Purchase':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPurchase()));
          break;
        case 'Import Sales':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImportPurchase()));
          break;
        case 'Add Supplier':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddSupplierDetails()));
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
                        controller: _searchQuery,
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
                        "Purchase Report List",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      );
                      _searchQuery.clear();
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
              _searchPurchaseList.length != 0
                  ? IconButton(
                      icon: Icon(Icons.print, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PurchaseReportPrint(1, _searchPurchaseList);
                        }));
                      },
                    )
                  : Text(''),
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
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        child:  DropdownSearch<ProductModel>(
                          items: productList,
                          showClearButton: true,
                          showSearchBox: true,
                          label: 'Product *',
                          hint: "Select a Product",
                          onChanged: (value) {

                            if (value != null) {
                              proId = value.proId.toString();
                              proName = value.proName;
                              if (_fromDatetext.text.isEmpty ||
                                  _toDatetext.text.isEmpty) {
                                print('date Empty 1');
                                _getPurchase('2', value.proId.toString(),
                                    _fromDatetext.text, _toDatetext.text);
                              } else {
                                print('date Empty 3');
                                _getPurchase('3', value.proId.toString(),
                                    _fromDatetext.text, _toDatetext.text);
                              }
                            } else {
                              proId = null;
                              proName = null;
                              if (_fromDatetext.text.isEmpty ||
                                  _toDatetext.text.isEmpty) {
                                print('date Value Empty 0');
                                _getPurchase('0', '', '', '');
                              } else {
                                print('date Value Empty 2');
                                _getPurchase('1', '', _fromDatetext.text,
                                    _toDatetext.text);
                              }
                            }

                          },
                        ),
                        // DropdownSearch(
                        //   items: productList,
                        //   showClearButton: true,
                        //   showSearchBox: true,
                        //   label: 'Product *',
                        //   hint: "Select a Product",
                        //   selectedItem: 'All',
                        //   searchBoxDecoration: InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                        //     labelText: "Search a Product",
                        //   ),
                        //   onChanged: (String data) {
                        //     print(data);
                        //     proName = data;
                        //     if (proName != null) {
                        //       if (proName == 'All') {
                        //         print('$proName');
                        //         _getPurchase('0', '', '', '');
                        //       } else {
                        //         print('$proName');
                        //         _getPurchase('0', proName, '', '');
                        //       }
                        //     }
                        //   },
                        // ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        child: DateTimeField(
                          controller: _fromDatetext,
                          format: dateFormat,
                          keyboardType: TextInputType.number,
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                          autovalidate: autoValidate,
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
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        child: DateTimeField(
                          controller: _toDatetext,
                          format: dateFormat,
                          keyboardType: TextInputType.number,
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                          autovalidate: autoValidate,
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
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 60,
                      height: 30,
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
                                _getPurchase('1', proName, _fromDatetext.text,
                                    _toDatetext.text);
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
                          },
                          minWidth: 60,
                          height: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              "Go",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: _searchPurchaseList.length,
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
                                        "Invoice No:- ${_searchPurchaseList[index].Purchaseid.toString()} ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${_searchPurchaseList[index].PurchaseDate}",
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
                                        Text("Company Name: ",
                                            style: headHintTextStyle),
                                        Text(
                                            "${_searchPurchaseList[index].PurchaseCompanyname}",
                                            style: headsubTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Total Amount:      ",
                                            style: headHintTextStyle),
                                        Text(
                                            "Rs.${_searchPurchaseList[index].PurchaseTotal.toString()}",
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

  // void ShowPurchasedetails() {
  //   final Future<Database> dbFuture = databaseHelper.initializeDatabase();
  //   dbFuture.then((value) {
  //     Future<List<Purchase>> purchaseListFuture =
  //         databaseHelper.getpurchaseList();
  //     purchaseListFuture.then((PurchaseCatList) {
  //       setState(() {
  //         this.purchaseList = PurchaseCatList;
  //         this.count = PurchaseCatList.length;
  //         print("Printing Purchalist//${count}");
  //       });
  //     });
  //   });
  // }

  DataRow getRow(int index) {
    var srNo = index + 1;
    return DataRow(cells: [
      DataCell(Center(child: Text(srNo.toString()))),
      DataCell(Center(child: Text(purchaseList[index].PurchaseDate))),
      DataCell(Center(child: Text(purchaseList[index].PurchaseProductName))),
      DataCell(Center(
          child: Text(purchaseList[index].PurchaseProductRate.toString()))),
      DataCell(Center(child: Text(purchaseList[index].PurchaseGST.toString()))),
      DataCell(Center(
          child: Text(purchaseList[index].PurchaseProductQty.toString()))),
      DataCell(Center(
          child: Text(purchaseList[index].PurchaseProductSubTotal.toString()))),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < purchaseList.length; i++) {
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
                onPressed: () async {
                  PurchaseDelete purchasedelete = new PurchaseDelete();
                  var result =
                      await purchasedelete.getPurchaseDelete(id.toString());
                  print("//////////////////Print result//////$result");
                  print("///delete id///$id");
                  Navigator.of(context).pop();

                  if (_toDatetext.text.isNotEmpty &&
                      _fromDatetext.text.isNotEmpty) {
                    _getPurchase('1', '', _fromDatetext.text.toString(),
                        _toDatetext.text.toString());
                  } else {
                    _getPurchase('0', '', '', '');
                  }
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
//   void _getPurchase() async {
//     setState(() {
//       _showCircle = true;
//     });
//     PurchaseFetch purchasefetch = new PurchaseFetch();
//     var purchaseData = await purchasefetch.getReturnPurchaseFetch("1");
//     print('$purchaseData');
//     var resid = purchaseData["resid"];
//     if (resid == 200) {
//       int rowcount = purchaseData["rowcount"];
//       if (rowcount > 0) {
//         var purchasesd = purchaseData["purchase"];
//         List<Purchase> tempPurchase = [];
//         print(purchasesd.length);
//         for (var n in purchasesd) {
//           // Purchase pro = Purchase(
//           //     int.parse(n["PurchaseId"]),
//           //     n["PurchaseCustomername"],
//           //     n["PurchaseDate"],
//           //     n["PurchaseProductName"],
//           //     n["PurchaseProductRate"],
//           //     n["PurchaseProductQty"],
//           //     n["PurchaseProductSubTotal"],
//           //     n["PurchaseSubTotal"],
//           //     n["PurchaseDiscount"],
//           //     n["PurchaseGST"],
//           //     n["PurchaseMiscellaneons"],
//           //     n["PurchaseTotalAmount"],
//           //     n["PurchaseNarration"],
//           //     n["productids"]);
//           // tempPurchase.add(pro);
//         }
//
//         setState(() {
//           this.purchaseList = tempPurchase;
//           _searchPurchaseList = tempPurchase;
//           _showCircle = false;
//         });
//
//         _searchQuery.addListener(() {
//           setState(() {
//             if (purchaseList != null) {
//               String s = _searchQuery.text;
//               _searchPurchaseList = purchaseList
//                   .where((element) =>
//                       element.PurchaseIds.toString()
//                           .toLowerCase()
//                           .contains(s.toLowerCase()) ||
//                       element.PurchaseCompanyname.toLowerCase()
//                           .contains(s.toLowerCase()) ||
//                       element.PurchaseProductName.toLowerCase()
//                           .contains(s.toLowerCase()) ||
//                       element.PurchaseDate.toLowerCase()
//                           .contains(s.toLowerCase()) ||
//                       element.PurchaseTotal.toString()
//                           .toLowerCase()
//                           .contains(s.toLowerCase()))
//                   .toList();
//             }
//           });
//         });
//
//         print("//////purchaselist/////////$purchaseList.length");
//       } else {
//         String msg = purchaseData["message"];
//         Fluttertoast.showToast(
//           msg: msg,
//           toastLength: Toast.LENGTH_SHORT,
//           backgroundColor: PrimaryColor,
//           textColor: Color(0xffffffff),
//           gravity: ToastGravity.BOTTOM,
//         );
//         setState(() {
//           _showCircle = false;
//         });
//       }
//     } else {
//       String msg = purchaseData["message"];
//       Fluttertoast.showToast(
//         msg: msg,
//         toastLength: Toast.LENGTH_SHORT,
//         backgroundColor: PrimaryColor,
//         textColor: Color(0xffffffff),
//         gravity: ToastGravity.BOTTOM,
//       );
//       setState(() {
//         _showCircle = false;
//       });
//     }
//   }

  void _getPurchase(forall, suplierId, fromDate, toDate) async {
    setState(() {
      _showCircle = true;
      purchaseList.clear();
    });
    PurchaseFetch purchasefetch = new PurchaseFetch();
    var purchaseData = await purchasefetch.getDatewisePurchaseReportFetch(
        forall, suplierId, fromDate, toDate);
    print('$purchaseData');
    var resid = purchaseData["resid"];
    if (resid == 200) {
      var rowcount = purchaseData["rowcount"];
      if (rowcount > 0) {
        var purchasesd = purchaseData["purchaseproductre"];
        List<Purchase> tempPurchase = [];
        print(purchasesd.length);
        // for (var n in purchasesd) {
        //   print('Pro Name ${n["productname"]}');
        //   Purchase pro = Purchase.onlyProducts(
        //       n+1,
        //       n["pedate"],
        //       n["productid"],
        //       n["productname"],
        //       n["peproductrate"],
        //       n["peproductquntity"],
        //       n["peproductgst"],
        //       n["peproductsubtotal"]);
        //   tempPurchase.add(pro);
        // }

        for (int i = 0; i < purchasesd.length; i++) {
          Purchase pro = Purchase.onlyProducts(
              i + 1,
              purchasesd[i]["pedate"]!=null ?  purchasesd[i]["pedate"]:"",
              purchasesd[i]["productid"]!=null ?  purchasesd[i]["productid"]:"",
              purchasesd[i]["productname"]!=null ?  purchasesd[i]["productname"]:"",
              purchasesd[i]["peproductrate"]!=null ?  purchasesd[i]["peproductrate"]:"",
              purchasesd[i]["peproductquntity"]!=null ?  purchasesd[i]["peproductquntity"]:"",
              purchasesd[i]["peproductgst"]!=null ?  purchasesd[i]["peproductgst"]:"",
              purchasesd[i]["peproductsubtotal"]!=null ?  purchasesd[i]["peproductsubtotal"]:"");

          tempPurchase.add(pro);
        }

        setState(() {
          this.purchaseList = tempPurchase;
          _searchPurchaseList = tempPurchase;
          _showCircle = false;
        });

        _searchQuery.addListener(() {
          setState(() {
            if (purchaseList != null) {
              String s = _searchQuery.text;
              _searchPurchaseList = purchaseList
                  .where((element) =>
                      element.PurchaseIds.toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.PurchaseCompanyname.toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.PurchaseProductName.toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.PurchaseDate.toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element.PurchaseTotal.toString()
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
        String msg = purchaseData["message"];
        Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: PrimaryColor,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      String msg = purchaseData["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  // void _getProducts() async {
  //   ProductFetch Productfetch = new ProductFetch();
  //   var productData = await Productfetch.getposproduct("1");
  //   var resid = productData["resid"];
  //   if (resid == 200) {
  //     var productsd = productData["product"];
  //     print(productsd.length);
  //     List<String> products = [];
  //     products.add('All');
  //     for (var n in productsd) {
  //       products.add(n['ProductName']);
  //     }
  //
  //     setState(() {
  //       productList = products;
  //     });
  //   } else {
  //     String msg = productData["message"];
  //     Fluttertoast.showToast(
  //       msg: msg,
  //       toastLength: Toast.LENGTH_SHORT,
  //       backgroundColor: Colors.black38,
  //       textColor: Color(0xffffffff),
  //       gravity: ToastGravity.BOTTOM,
  //     );
  //   }
  // }

  void _getProducts() async {
    ProductFetch Productfetch = new ProductFetch();
    var productData = await Productfetch.getposHotelproduct("1");
    var resid = productData["resid"];
    if (resid == 200) {
      var productsd = productData["product"];
      print(productsd.length);
      List<ProductModel> products = [];
      for (var n in productsd) {
        ProductModel pro = ProductModel.withIdGST(
            n['ProductId'],
            n['ProductName'],
            n['ProductCategories'],
            n['ProductSellingPrice'],
            n['IntegratedTax']);
        products.add(pro);
      }

      setState(() {
        productList = products;
      });
    } else {
      String msg = productData["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

// void _getFilterPurchase(String action, String proName, sDate, eDate) async {
//   setState(() {
//     _showCircle = true;
//     purchaseList.clear();
//   });
//   String purComName = proName;
//   if (purComName == null) {
//     purComName = 'All';
//   }
//
//   PurchaseFetch purchasefetch = new PurchaseFetch();
//   var purchaseData = await purchasefetch.getFilterProductWisePurchaseFetch(
//       action, purComName, sDate, eDate);
//   print('$purchaseData');
//
//   var resid = purchaseData["resid"];
//   if (resid == 200) {
//     var rowcount = purchaseData["rowcount"];
//     if (rowcount > 0) {
//       var purchasesd = purchaseData["purchase"];
//       List<Purchase> tempPurchase = [];
//       print(purchasesd.length);
//       for (var n in purchasesd) {
//         // Purchase pro = Purchase(
//         //     int.parse(n["PurchaseId"]),
//         //     n["PurchaseCustomername"],
//         //     n["PurchaseDate"],
//         //     n["PurchaseProductName"],
//         //     n["PurchaseProductRate"],
//         //     n["PurchaseProductQty"],
//         //     n["PurchaseProductSubTotal"],
//         //     n["PurchaseSubTotal"],
//         //     n["PurchaseDiscount"],
//         //     n["PurchaseGST"],
//         //     n["PurchaseMiscellaneons"],
//         //     n["PurchaseTotalAmount"],
//         //     n["PurchaseNarration"],
//         //     n["productids"]);
//         // tempPurchase.add(pro);
//       }
//       setState(() {
//         this.purchaseList = tempPurchase;
//         _searchPurchaseList = tempPurchase;
//         _showCircle = false;
//       });
//
//       _searchQuery.addListener(() {
//         setState(() {
//           if (purchaseList != null) {
//             String s = _searchQuery.text;
//             _searchPurchaseList = purchaseList
//                 .where((element) =>
//                     element.PurchaseIds.toString()
//                         .toLowerCase()
//                         .contains(s.toLowerCase()) ||
//                     element.PurchaseCompanyname.toLowerCase()
//                         .contains(s.toLowerCase()) ||
//                     element.PurchaseProductName.toLowerCase()
//                         .contains(s.toLowerCase()) ||
//                     element.PurchaseDate.toLowerCase()
//                         .contains(s.toLowerCase()) ||
//                     element.PurchaseTotal.toString()
//                         .toLowerCase()
//                         .contains(s.toLowerCase()))
//                 .toList();
//           }
//         });
//       });
//       print("//////purchaselist/////////$purchaseList.length");
//     } else {
//       setState(() {
//         _showCircle = false;
//       });
//       String msg = purchaseData["message"];
//       Fluttertoast.showToast(
//         msg: msg,
//         toastLength: Toast.LENGTH_SHORT,
//         backgroundColor: PrimaryColor,
//         textColor: Color(0xffffffff),
//         gravity: ToastGravity.BOTTOM,
//       );
//     }
//   } else {
//     setState(() {
//       _showCircle = false;
//     });
//     String msg = purchaseData["message"];
//     Fluttertoast.showToast(
//       msg: msg,
//       toastLength: Toast.LENGTH_SHORT,
//       backgroundColor: PrimaryColor,
//       textColor: Color(0xffffffff),
//       gravity: ToastGravity.BOTTOM,
//     );
//   }
// }
}
