import 'dart:io';

import 'package:barcode_image/barcode_image.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as img;
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/pages/genrated_barcode_screen.dart';
import 'package:retailerp/providers/popup_menu_item.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/drop_down_widget.dart';
import 'package:retailerp/widgets/pro_drop_down_string_widget.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/const.dart';
import '../widgets/rowtextfields.dart';
import '../models/popup_menu.dart';
import 'package:intl/intl.dart';

class AddBarcode extends StatefulWidget {
  @override
  _AddBarcodeCodeState createState() => _AddBarcodeCodeState();
}

class _AddBarcodeCodeState extends State<AddBarcode> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<ProductModel> productList;
  ProductModel _productModel;
  String mCatTypeValueName;
  String mProPrice;

  // List<String> mBarcodeDisplay = ['Horizontal', 'Vertical'];
  List<String> mBarcodeType = ['CodeBar', 'Code128', 'Code39'];
  String _mBarcodeDisplayValue = 'Horizontal';
  String _mBarcodeValue;

  final _pDateNameController = TextEditingController();
  final _bcQuantityCodeController = TextEditingController();
  final _bcQuantityID = 1;
  bool _bcQuantityValidate = false;
  String _bcQuantity = "";
  int count = 0;

  DateTime selectedDate = DateTime.now();
  String _selectdate = DateFormat('dd/MM/yyyy').format(new DateTime.now());

  PopupMenu _selectedMenu = productPopupMenu4[0];
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  int rowpro = 1;
  final format = DateFormat("yyyy-MM-dd");
  bool autoValidate = false;
  String Deactivateat;
  bool showResetIcon = false;
  bool readOnly = false;
  final _PDatetext = TextEditingController();
  bool _pDatevalidate = false;

  int pProId;
  String pProName;
  bool showspinnerlog = false;

  void _getInputValue(String inputValue, int id) {
    setState(() {
      switch (id) {
        case 1:
          {
            _bcQuantity = inputValue;
          }
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getProducts();
    // updateListView();
  }

  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    // print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileAddPurchase();
    } else {
      content = _buildTabletAddPurchase();
    }
    return content;
  }

  Widget _buildTabletAddPurchase() {
    double tabletwidth = MediaQuery.of(context).size.width * (.60);
    var screenOrien = MediaQuery.of(context).orientation;
    double mobwidth = MediaQuery.of(context).size.width * (.72);
    _pDateNameController.text = _selectdate;

    print('_AddProductCategoryScreenState');
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product Barcode"),
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
              return productPopupMenu4.map((PopupMenu popupMenu) {
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ProDropDownStringWidget(
                  //     productList, _productModel, _getDropDownValueCat, 1, .60),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownSearch<ProductModel>(
                          items: productList,
                          showClearButton: true,
                          showSearchBox: true,
                          label: 'Product *',
                          hint: "Select a Product",
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (ProductModel u) =>
                              u == null ? "Product field is required " : null,
                          onChanged: (ProductModel data) {
                            print(data);
                            pProId = data.proId;
                            mCatTypeValueName = data.proName.toString();
                            mProPrice = data.proSellingPrice.toString();
                          },
                        ),
                      ),SizedBox(width: 15,),
                      Expanded(
                        child:
                        DateTimeField(
                          controller: _PDatetext,
                          format: format,
                          keyboardType: TextInputType.number,
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate:
                                currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                          autovalidate: autoValidate,
                          validator: (date) =>
                          date == null ? 'Invalid date' : null,
                          onChanged: (date) => setState(() {}),
                          onSaved: (date) => setState(() {
                            value = date;
                            print('Selected value Date: $value');
                            savedCount++;
                          }),
                          resetIcon:
                          showResetIcon ? Icon(Icons.delete) : null,
                          readOnly: readOnly,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Packing Date*',
                            errorText: _pDatevalidate ? 'Enter Packing Date' : null,
                          ),
                        ),
                        // DateTimeField(
                        //   format: format,
                        //   controller: _PDatetext,
                        //   onShowPicker: (context, currentValue) async {
                        //     final date = await showDatePicker(
                        //         context: context,
                        //         firstDate: DateTime(1900),
                        //         initialDate: currentValue ?? DateTime.now(),
                        //         lastDate: DateTime(2100));
                        //     if (date != null) {
                        //       final time = await showTimePicker(
                        //         context: context,
                        //         initialTime: TimeOfDay.fromDateTime(
                        //             currentValue ?? DateTime.now()),
                        //       );
                        //       return DateTimeField.combine(date, time);
                        //     } else {
                        //       return currentValue;
                        //     }
                        //   },
                        //   autovalidate: autoValidate,
                        //   validator: (date) =>
                        //       date == null ? 'Invalid date' : null,
                        //   onChanged: (date) => setState(() {}),
                        //   onSaved: (date) => setState(() {
                        //     value = date;
                        //     print('Selected value Date: $value');
                        //     savedCount++;
                        //   }),
                        //   resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                        //   readOnly: readOnly,
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     labelText: 'Packing Date*',
                        //     errorText:
                        //         _pDatevalidate ? 'Enter Packing Date' : null,
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(vertical: 10),
                  //       child: Container(
                  //         width: screenOrien == Orientation.portrait
                  //             ? mobwidth
                  //             : tabletwidth,
                  //         child: TextField(
                  //           controller: _pDateNameController,
                  //           enabled: false,
                  //           enableInteractiveSelection: false,
                  //           decoration: InputDecoration(
                  //             labelText: 'Packing Date*',
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
                  //         color: PrimaryColor,
                  //       ),
                  //       label: Text(''),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  // RowTextFields(
                  //     'Packing Date*',
                  //     _bcQuantityController,
                  //     _getInputValue,
                  //     _bcQuantityID,
                  //     _bcQuantityValidate,
                  //     'no',
                  //     'Enter a Category Code',
                  //     .60),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _bcQuantityCodeController,
                          obscureText: false,
                          onChanged: (value) {
                            _bcQuantity = value;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Category Code*',
                            errorText: _bcQuantityValidate
                                ? 'Enter Category Code'
                                : null,
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: DropdownSearch<String>(
                          validator: (v) => v == null ? "required field" : null,
                          hint: "Select a barcode type",
                          mode: Mode.MENU,
                          showSelectedItem: true,
                          items: ['CodeBar', 'Code128', 'Code39'],
                          label: "Barcode Type*",
                          showClearButton: true,
                          onChanged: (value) {
                            _mBarcodeValue = value;
                          },
                          popupItemDisabled: (String s) => s.startsWith('I'),
                        ),
                      ),
                      // RowTextFields(
                      //     'Barcode Quantity*',
                      //     _bcQuantityCodeController,
                      //     _getInputValue,
                      //     _bcQuantityID,
                      //     _bcQuantityValidate,
                      //     'no',
                      //     'Enter a Category Code',
                      //     .60),
                    ],
                  ),

                  // DropDownWidget(
                  //     'Barcode Type*', mBarcodeType, _getDropDownValue, 1, .60),
                  SizedBox(
                    height: 15,
                  ),
                  // DropDownWidget('Barcode Display*', mBarcodeDisplay,
                  //     _getDropDownValue, 2, .60),
                  Material(
                    elevation: 5.0,
                    color: PrimaryColor,
                    borderRadius: BorderRadius.circular(15.0),
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          if (_bcQuantityCodeController.text.isEmpty) {
                            _bcQuantityValidate = true;
                          } else {
                            _bcQuantityValidate = false;
                          }
                          _PDatetext.text.isEmpty
                              ? _pDatevalidate = true
                              : _pDatevalidate = false;

                          bool errorCheck = (!_bcQuantityValidate &&
                              mCatTypeValueName != null &&
                              _mBarcodeValue != null &&
                              !_pDatevalidate);

                          if (errorCheck) {
                            _captureAndSharePng();
                            print('errorCheck Call');
                          } else {
                            Fluttertoast.showToast(
                              msg:
                                  "Fill all the * Marked fileds Before Proceeding!!!",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.black38,
                              // textColor: Color(0xffffffff),
                              gravity: ToastGravity.BOTTOM,
                            );
                          }
                          // }
                        });
                      },
                      minWidth: 150,
                      height: 25.0,
                      child: Text(
                        'Generate Barcode',
                        style: btnTextStyle,
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
    );
  }

  Widget _buildMobileAddPurchase() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product Barcode"),
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
              return productPopupMenu4.map((PopupMenu popupMenu) {
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownSearch<ProductModel>(
                    items: productList,
                    showClearButton: true,
                    showSearchBox: true,
                    label: 'Product *',
                    hint: "Select a Product",
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (ProductModel u) =>
                        u == null ? "Product field is required " : null,
                    onChanged: (ProductModel data) {
                      print(data);
                      pProId = data.proId;
                      mCatTypeValueName = data.proName.toString();
                      mProPrice = data.proSellingPrice.toString();
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DateTimeField(
                    controller: _PDatetext,
                    format: format,
                    keyboardType: TextInputType.number,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate:
                          currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                    autovalidate: autoValidate,
                    validator: (date) =>
                    date == null ? 'Invalid date' : null,
                    onChanged: (date) => setState(() {}),
                    onSaved: (date) => setState(() {
                      value = date;
                      print('Selected value Date: $value');
                      savedCount++;
                    }),
                    resetIcon:
                    showResetIcon ? Icon(Icons.delete) : null,
                    readOnly: readOnly,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Packing Date*',
                        errorText: _pDatevalidate ? 'Enter Packing Date' : null,
                      ),
                  ),
                  // DateTimeField(
                  //   format: format,
                  //   controller: _PDatetext,
                  //   onShowPicker: (context, currentValue) async {
                  //     final date = await showDatePicker(
                  //         context: context,
                  //         firstDate: DateTime(1900),
                  //         initialDate: currentValue ?? DateTime.now(),
                  //         lastDate: DateTime(2100));
                  //     if (date != null) {
                  //       final time = await showTimePicker(
                  //         context: context,
                  //         initialTime: TimeOfDay.fromDateTime(
                  //             currentValue ?? DateTime.now()),
                  //       );
                  //       return DateTimeField.combine(date, time);
                  //     } else {
                  //       return currentValue;
                  //     }
                  //   },
                  //   autovalidate: autoValidate,
                  //   validator: (date) => date == null ? 'Invalid date' : null,
                  //   onChanged: (date) => setState(() {}),
                  //   onSaved: (date) => setState(() {
                  //     value = date;
                  //     print('Selected value Date: $value');
                  //     savedCount++;
                  //   }),
                  //   resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                  //   readOnly: readOnly,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: 'Packing Date*',
                  //     errorText: _pDatevalidate ? 'Enter Packing Date' : null,
                  //   ),
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                  RowTextFields(
                      'Barcode Quantity*',
                      _bcQuantityCodeController,
                      _getInputValue,
                      _bcQuantityID,
                      _bcQuantityValidate,
                      'no',
                      'Enter a Category Code',
                      .60),
                  SizedBox(
                    height: 10,
                  ),
                  DropDownWidget(
                      'Barcode Type*', mBarcodeType, _getDropDownValue, 1, .60),
                  SizedBox(
                    height: 15,
                  ),
                  Material(
                    elevation: 5.0,
                    color: PrimaryColor,
                    borderRadius: BorderRadius.circular(15.0),
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          if (_bcQuantityCodeController.text.isEmpty) {
                            _bcQuantityValidate = true;
                          } else {
                            _bcQuantityValidate = false;
                          }
                          _PDatetext.text.isEmpty
                              ? _pDatevalidate = true
                              : _pDatevalidate = false;

                          bool errorCheck = (!_bcQuantityValidate &&
                              mCatTypeValueName != null &&
                              _mBarcodeValue != null &&
                              !_pDatevalidate);

                          if (errorCheck) {
                            _captureAndSharePng();
                            print('errorCheck Call');
                          } else {
                            Fluttertoast.showToast(
                              msg:
                                  "Fill all the * Marked fileds Before Proceeding!!!",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.black38,
                              // textColor: Color(0xffffffff),
                              gravity: ToastGravity.BOTTOM,
                            );
                          }
                          // }
                        });
                      },
                      minWidth: 150,
                      height: 25.0,
                      child: Text(
                        'Generate Barcode',
                        style: btnTextStyle,
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
    );
  }

  _getDropDownValue(String value, int _taxid) {
    setState(() {
      switch (_taxid) {
        case 1:
          _mBarcodeValue = value;
          break;
        case 2:
          _mBarcodeDisplayValue = value;
          break;
      }
      // print('Mtype Value: $_mTypeValue');
    });
  }

  void _selectedPopMenu(PopupMenu popupMenu) {
    setState(() {
      _selectedMenu = popupMenu;
      print(_selectedMenu.title);
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

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((value) {
      Future<List<ProductModel>> todoListFuture =
          databaseHelper.getProductList();
      todoListFuture.then((productList) {
        setState(() {
          this.productList = productList;
          this.count = productList.length;
        });
      });
    });
  }

  _getDropDownValueCat(int value, String sName, String pCategoryName,
      int _taxid, ProductModel productModel, String proPrice, int proParentId) {
    setState(() {
      switch (_taxid) {
        case 1:
          // mCatTypeValue = value;
          print('sName Value: $sName');
          mCatTypeValueName = sName;
          mProPrice = proPrice;
          _productModel = productModel;

          break;
      }
      // print('Mtype Value: $_mTypeValue');
    });
  }

  void _getProducts() async {
    setState(() {
      showspinnerlog = true;
    });
    ProductFetch Productfetch = new ProductFetch();
    var productData = await Productfetch.getposproduct("1");
    var resid = productData["resid"];
    if (resid == 200) {
      var productsd = productData["product"];
      print(productsd.length);
      List<ProductModel> products = [];
      for (var n in productsd) {
        ProductModel pro = ProductModel.withIdGST(
            int.parse(n['ProductId']),
            n['ProductName'],
            n['ProductCategories'],
            double.parse(n['ProductSellingPrice']),
            n['IntegratedTax']);
        products.add(pro);
      }

      setState(() {
        productList = products;
        showspinnerlog = false;
      });
    } else {
      setState(() {
        showspinnerlog = false;
      });
      String msg = productData["message"];
    }
  }

  Future<void> _captureAndSharePng() async {
    try {
      // final images = img.Image(600, 350);
      // fill(images, getColor(255, 255, 255));
      // drawBarcode(images, Barcode.code128(), 'Lux',
      //     font: arial_24, height: 12, width: 24);

      final image = img.Image(600, 350);
      fill(image, getColor(255, 255, 255));
      drawBarcode(
        image,
        Barcode.code128(),
        '$mCatTypeValueName',
        font: arial_24,
      );
      // Save the image
      // File('barcode.png').writeAsBytesSync(encodePng(image));

      final tempDir = await getTemporaryDirectory();
      // String proName = '$mCatTypeValueName${_selectdate}';
      // print('PRoName$proName');
      var gh = await File('${tempDir.path}/barcode.png').create();
      await gh.writeAsBytesSync(encodePng(image));

      print('${tempDir.path}/barcode.png');

      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return GenratedBarCodeScreen("Q I Systems, Nagpur", "70206579990",
            "$mCatTypeValueName", "$_selectdate", mProPrice);
        // return GenratedBarCodeScreen();
      }));
    } catch (e) {
      print(e.toString());
    }
  }
}
