import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:retailerp/Adpater/Insert_Product_Rate.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/LocalDbModels/product_rate.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/providers/data_upload.dart';
import 'package:retailerp/providers/popup_menu_item.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/utils/my_navigator.dart';
import 'package:retailerp/widgets/drop_down_widget.dart';
import 'package:retailerp/widgets/pro_drop_down_string_widget.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/const.dart';
import '../widgets/rowtextfields.dart';
import '../models/popup_menu.dart';
import 'package:intl/intl.dart';

class AddProductRateScreen extends StatefulWidget {
  @override
  _AddProductRateScreenRateState createState() =>
      _AddProductRateScreenRateState();
}

class _AddProductRateScreenRateState extends State<AddProductRateScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<ProductModel> productList;
  ProductModel _productModel;
  InsertProductRate dataUpload = new InsertProductRate();
  bool showspinnerlog = false;

  final _cRateController = TextEditingController();
  final _cProGSTController = TextEditingController();

  final _cRateID = 1;
  final _cProGSTID = 2;
  bool _cRateValidate = false;
  bool _cPRoGSTValidate = false;
  double _cRate;
  double _cPRoGST;
  int count = 0;

  DateTime selectedDate = DateTime.now();
  String _selectdate = DateFormat('dd/MM/yyyy').format(new DateTime.now());

  PopupMenu _selectedMenu = productRatePopupMenu1[0];

  int mProTypeValue;
  String mSelName;
  String mProTypeParentValueName;
  int mProTypeParentValue;

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
  String rateWithGST = "0.00";
  String rateWithoutGst = "0.00";

  void _getInputValue(String inputValue, int id) {
    setState(() {
      switch (id) {
        case 1:
          {
            _cRate = double.parse(inputValue);
            latestTotalAmount();
            // if (_cProGSTController.text.toString() == null) {
            //   // latestSellingWithGSTCal(
            //   //     double.parse(_pSellingPriceController.text), 0);
            //   print(
            //       '_integratedTaxController:Call ${_cProGSTController.text.toString()}');
            //   rateWithoutGst = '0.00';
            //   rateWithGST = inputValue;
            // } else {
            //   print('else: Call');
            //
            //   latestSellingWithGSTCal(double.parse(_cRateController.text),
            //       double.parse(_cProGSTController.text));
            // }
          }
          break;

        case 2:
          {
            _cPRoGST = double.parse(inputValue);
            latestTotalAmount();
            // if (_cRateController.text.toString() == null) {
            //   rateWithoutGst = '0.00';
            //   rateWithGST = '0.00';
            //   // latestSellingWithGSTCal(
            //   //     0, double.parse(_integratedTaxController.text));
            // } else {
            //   latestSellingWithGSTCal(double.parse(_cRateController.text),
            //       double.parse(_cProGSTController.text));
            // }
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

  Widget _buildMobileAddPurchase() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product Rate"),
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
              return productRatePopupMenu1.map((PopupMenu popupMenu) {
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
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ProDropDownStringWidget(productList,
                    //     _productModel, _getDropDownValueCat, 1, .60),
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
                        mProTypeValue = data.proId;
                        mSelName = data.proName.toString();
                        mProTypeParentValueName = data.proCategory.toString();
                        mProTypeParentValue = data.proCatId;
                        _cRateController.text = data.proSellingPrice.toString();
                        _cProGSTController.text =
                            data.proIntegreatedTax.toString();
                        _cRate = data.proSellingPrice;
                        _cPRoGST = double.parse(data.proIntegreatedTax);
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
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                      autovalidate: autoValidate,
                      validator: (date) => date == null ? 'Invalid date' : null,
                      onChanged: (date) => setState(() {}),
                      onSaved: (date) => setState(() {
                        value = date;
                        print('Selected value Date: $value');
                        savedCount++;
                      }),
                      resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                      readOnly: readOnly,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Product Expire Date*',
                        errorText:
                            _pDatevalidate ? 'Enter Product Expire Date' : null,
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
                    //     labelText: 'Product Expire Date*',
                    //     errorText:
                    //         _pDatevalidate ? 'Enter Product Expire Date' : null,
                    //   ),
                    // ),

                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _cRateController,
                            obscureText: false,
                            onChanged: (value) {
                              _cRate = double.parse(value);
                              latestTotalAmount();
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Product Rate',
                              errorText:
                                  _cRateValidate ? 'Enter Product Rate' : null,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _cProGSTController,
                            obscureText: false,
                            onChanged: (value) async {
                              _cPRoGST = double.parse(value);
                              latestTotalAmount();
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Including GST',
                              errorText: _cPRoGSTValidate ? 'Enter GST' : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "*Rate Without GST:- $rateWithoutGst",
                          style: labelTextStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '*Rate With GST:- $rateWithGST',
                          style: labelTextStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          elevation: 5.0,
                          color: PrimaryColor,
                          borderRadius: BorderRadius.circular(15.0),
                          child: MaterialButton(
                            onPressed: () async {
                              setState(() {
                                if (_cRateController.text.isEmpty) {
                                  _cRateValidate = true;
                                } else {
                                  _cRateValidate = false;
                                }
                                if (_cProGSTController.text.isEmpty) {
                                  // _cPRoGSTValidate = true;
                                  _cProGSTController.text = '0';
                                }
                                // else {
                                //   _cPRoGSTValidate = false;
                                // }

                                print('_cRateValidate Call $_cRateValidate');
                                print('mSelName Call $mSelName');

                                bool errorCheck =
                                    (!_cRateValidate && mSelName != null);

                                if (errorCheck) {
                                  // _saveToloc();
                                  _uploadToServer();
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
                            minWidth: 200,
                            child: Text(
                              'Save',
                              style: btnHeadTextStyle,
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildTabletAddPurchase() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product Rate"),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
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
              return productRatePopupMenu1.map((PopupMenu popupMenu) {
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
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DropdownSearch<ProductModel>(
                            items: productList,
                            showClearButton: true,
                            showSearchBox: true,
                            label: 'Product *',
                            hint: "Select a Product",
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (ProductModel u) =>
                                u == null ? "Product field is required " : null,
                            onChanged: (ProductModel data) {
                              print(data);
                              mProTypeValue = data.proId;
                              mSelName = data.proName.toString();
                              mProTypeParentValueName =
                                  data.proCategory.toString();
                              mProTypeParentValue = data.proCatId;
                              _cRateController.text =
                                  data.proSellingPrice.toString();
                              _cProGSTController.text =
                                  data.proIntegreatedTax.toString();
                              _cRate = data.proSellingPrice;
                              _cPRoGST = double.parse(data.proIntegreatedTax);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: DateTimeField(
                            controller: _PDatetext,
                            format: format,
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
                              labelText: 'Product Expire Date*',
                              errorText: _pDatevalidate
                                  ? 'Enter Product Expire Date'
                                  : null,
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
                          //     labelText: 'Product Expire Date*',
                          //     errorText:
                          //     _pDatevalidate ? 'Enter Product Expire Date' : null,
                          //   ),
                          // ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _cRateController,
                            obscureText: false,
                            onChanged: (value) {
                              _cRate = double.parse(value);
                              latestTotalAmount();
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Product Rate',
                              errorText:
                                  _cRateValidate ? 'Enter Product Rate' : null,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _cProGSTController,
                            obscureText: false,
                            onChanged: (value) async {
                              _cPRoGST = double.parse(value);
                              latestTotalAmount();
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Including GST',
                              errorText: _cPRoGSTValidate ? 'Enter GST' : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "*Rate Without GST:- $rateWithoutGst",
                          style: labelTextStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '*Rate With GST:- $rateWithGST',
                          style: labelTextStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          elevation: 5.0,
                          color: PrimaryColor,
                          borderRadius: BorderRadius.circular(15.0),
                          child: MaterialButton(
                            onPressed: () async {
                              setState(() {
                                if (_cRateController.text.isEmpty) {
                                  _cRateValidate = true;
                                } else {
                                  _cRateValidate = false;
                                }
                                if (_cProGSTController.text.isEmpty) {
                                  // _cPRoGSTValidate = true;
                                  _cProGSTController.text = '0';
                                }
                                // else {
                                //   _cPRoGSTValidate = false;
                                // }

                                print('_cRateValidate Call $_cRateValidate');
                                print('mSelName Call $mSelName');

                                bool errorCheck =
                                    (!_cRateValidate && mSelName != null);

                                if (errorCheck) {
                                  // _saveToloc();
                                  _uploadToServer();
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
                            minWidth: 200,
                            child: Text(
                              'Save',
                              style: btnHeadTextStyle,
                            ),
                          ),
                        ),
                      ],
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
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _selectdate = DateFormat('dd/MM/yyyy').format(picked);
        print("Date Selected:  $_selectdate");
      });
  }

  void _saveToloc() async {
    var result = await databaseHelper.insertProductRate(ProductRate(
        mProTypeValue,
        mSelName,
        mProTypeParentValueName,
        _PDatetext.text.toString(),
        _cRate,
        mProTypeParentValue));

    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Product Saved Successfully');
      setState(() {
        _cRateController.text = '';
      });
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

  _getDropDownValueCat(int value, String sName, String parentName, int _taxid,
      ProductModel productModel, String price, int proParentId) {
    setState(() {
      switch (_taxid) {
        case 1:
          mProTypeValue = value;
          print('sName Value: $sName');
          mSelName = sName;
          mProTypeParentValueName = productModel.proCategory;
          mProTypeParentValue = proParentId;
          _cRateController.text = productModel.proSellingPrice.toString();
          _cProGSTController.text = productModel.proIntegreatedTax.toString();
          latestTotalAmount();
          // if (productModel.proIntegreatedTax.toString() != null ||
          //     productModel.proIntegreatedTax.toString().isNotEmpty) {
          //   _cProGSTController.text = productModel.proIntegreatedTax.toString();
          //   latestSellingWithGSTCal(double.parse(_cRateController.text),
          //       double.parse(_cProGSTController.text));
          // }
          print('${productModel.proSellingPrice}');
          print('${productModel.proIntegreatedTax}');
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
        ProductModel pro = ProductModel.withId(
            int.parse(n['ProductId']),
            n['ProductType'],
            int.parse(n['ProductCode']),
            n['ProductName'],
            n['ProductCompanyName'],
            n['ProductCategories'],
            int.parse(n['ProductCategoriesID']),
            0,
            double.parse(n['ProductSellingPrice']),
            n['HSNCode'],
            n['Tax'],
            '',
            n['Unit'],
            int.parse(n['ProductOpeningBalance']),
            n['ProductBillingMethod'],
            n['IntegratedTax'],
            '');
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
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void latestSellingWithGSTCal(double totalAmount, double GST) {
    // double totalAmount = 200;
    // double GST = 18;
    print('totalAmount: $totalAmount');
    setState(() {
      double mainPrice = totalAmount / (100 + GST) * 100;
      double cal = totalAmount * (GST / (100 + GST));
      print('Without GST ' + mainPrice.toString());
      print('Add GST ' + cal.toString());
      double check = mainPrice + cal;
      print('Calculation ' + check.toString());
      rateWithoutGst = mainPrice.toStringAsFixed(2);
      rateWithGST = check.toStringAsFixed(2);

      // if (totalAmount == 0.00 && GST == 0.00) {
      //   rateWithoutGst = '0.00';
      //   rateWithGST = '0.00';
      // } else if (totalAmount == null) {
      //   rateWithoutGst = '0.00';
      //   rateWithGST = '0.00';
      // } else if (totalAmount != 0 && GST != 0) {
      //   double mainPrice = totalAmount / (100 + GST) * 100;
      //   double cal = totalAmount * (GST / (100 + GST));
      //   print('Without GST ' + mainPrice.toString());
      //   print('Add GST ' + cal.toString());
      //   double check = mainPrice + cal;
      //   print('Calculation ' + check.toString());
      //   rateWithoutGst = mainPrice.toStringAsFixed(2);
      //   rateWithGST = check.toStringAsFixed(2);
      // } else if (GST == null) {
      //   rateWithGST = 'NA';
      //   rateWithoutGst = totalAmount.toStringAsFixed(2);
      // } else {
      //   rateWithoutGst = '0.00';
      //   rateWithGST = '0.00';
      // }
    });
  }

  void latestTotalAmount() {
    setState(() {
      var totalAmount = double.parse(_cRateController.text);

      print('GST ${_cProGSTController.text}');
      if (_cProGSTController.text == null ||
          _cProGSTController.text.isEmpty ||
          _cProGSTController.text == 0.00) {
        rateWithGST = totalAmount.toStringAsFixed(2);
        rateWithoutGst = '0.00';
        print('GST Null ${_cProGSTController.text}');
      } else {
        print('GST Not Null ${_cProGSTController.text}');
        var GST = double.parse(_cProGSTController.text);
        double mainPrice = totalAmount / (100 + GST) * 100;
        double cal = totalAmount * (GST / (100 + GST));
        print('Without GST ' + mainPrice.toString());
        print('Add GST ' + cal.toString());
        double check = mainPrice + cal;
        print('Calculation ' + check.toString());
        rateWithoutGst = mainPrice.toStringAsFixed(2);
        rateWithGST = check.toStringAsFixed(2);
      }
    });
  }

  void _uploadToServer() async {
    setState(() {
      showspinnerlog = true;
    });
    print(mProTypeValue);
    print(mProTypeValue);
    print(mSelName);
    print(mProTypeParentValueName);
    print(_PDatetext.text.toString());
    print(_cProGSTController.text.toString());

    final prodata = await dataUpload.getInsertProductRate(
        mProTypeValue.toString(),
        mSelName,
        mProTypeParentValueName,
        _PDatetext.text.toString(),
        _cRateController.text.toString(),
        _cProGSTController.text.toString());

    var resid = prodata["resid"];
    print(resid);
    if (resid == 200) {
      setState(() {
        showspinnerlog = false;
        _cRateController.text = '';
        _cProGSTController.text = '';
        // _showAlertDialog('Status', 'Product Rate Saved Successfully');
      });
      Fluttertoast.showToast(
        msg: "Product Rate Saved Successfully",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
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
  }
}
