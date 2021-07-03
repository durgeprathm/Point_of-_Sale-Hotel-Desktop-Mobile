import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/LocalDbModels/product_rate.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/providers/data_upload.dart';
import 'package:retailerp/providers/popup_menu_item.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/const.dart';
import '../widgets/rowtextfields.dart';
import '../models/popup_menu.dart';
import 'package:intl/intl.dart';

class UpdateProductRateScreen extends StatefulWidget {
  final int indexId;
  final List<ProductRate> productRateList;

  UpdateProductRateScreen(this.indexId, this.productRateList);

  @override
  UpdateProductRateScreenState createState() =>
      UpdateProductRateScreenState(this.indexId, this.productRateList);
}

class UpdateProductRateScreenState extends State<UpdateProductRateScreen> {
  final int indexId;
  final List<ProductRate> productRateList;
  String mProTypeParentValueName;
  DataUpload dataUpload = new DataUpload();
  bool showspinnerlog = false;
  String UpdatedProductRateId;
  UpdateProductRateScreenState(this.indexId, this.productRateList);

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<ProductModel> productList;

  // List<ProductModel> productList;
  ProductModel _productModel;

  final _cRateController = TextEditingController();
  final _cProNameController = TextEditingController();
  final _cProGSTController = TextEditingController();
  final _cRateID = 1;
  final _cProGSTID = 2;
  bool _cRateValidate = false;
  bool _cPRoGSTValidate = false;
  double _cRate;
  double _cPRoGST;

  int count = 0;
  double prevRate;
  int getProId;
  String getProCatName;
  int getProCatId;

  DateTime selectedDate = DateTime.now();
  String _selectdate = DateFormat('dd/MM/yyyy').format(new DateTime.now());

  PopupMenu _selectedMenu = productRatePopupMenu1[0];

  int mProTypeValue;
  String mSelName;
  String mProTypeValueName;
  String mProName = '';
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

  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileManagepurchase();
    } else {
      content = _buildTabletManagepurchase();
    }

    return content;
  }

  void _getInputValue(String inputValue, int id) {
    setState(() {
      switch (id) {
        case 1:
          {
            _cRate = double.parse(inputValue);
            latestTotalAmount();
          }
          break;

        case 2:
          {
            _cPRoGST = double.parse(inputValue);
            latestTotalAmount();
          }
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    UpdatedProductRateId = productRateList[indexId].proRateId.toString();
    mProTypeValue = productRateList[indexId].proId;
    mSelName = productRateList[indexId].proName.toString();
    _cProNameController.text = productRateList[indexId].proName.toString();
    _cRateController.text = productRateList[indexId].proRate.toString();
    _PDatetext.text = productRateList[indexId].proDate;
    mProTypeParentValueName = productRateList[indexId].proCatName;
    _cProGSTController.text = productRateList[indexId].proGST.toString();
    latestTotalAmount();
    // getTextData();
    // _getProducts();
    // updateListView();
  }

  Widget _buildTabletManagepurchase() {
    double tablet45width = MediaQuery.of(context).size.width * (.45);
    print('_AddProductCategoryScreenState');
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product Rate"),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: tablet45width,
                              child: TextField(
                                enabled: false,
                                enableInteractiveSelection: false,
                                controller: _cProNameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Product Name',
                                  labelStyle: labelTextStyle,
                                ),
                              ),
                            ),
                            Container(
                              width: tablet45width,
                              child: DateTimeField(
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
                              //         initialDate:
                              //         currentValue ?? DateTime.now(),
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
                              //   date == null ? 'Invalid date' : null,
                              //   onChanged: (date) => setState(() {
                              //     // var formattedDate =
                              //     //     "${value.day}-${value.month}-${value.year}";
                              //     // changedCount++;
                              //     // pDate = formattedDate.toString();
                              //     // print('Selected Date: ${_PDatetext.text}');
                              //   }),
                              //   onSaved: (date) => setState(() {
                              //     value = date;
                              //     print('Selected value Date: $value');
                              //     savedCount++;
                              //   }),
                              //   resetIcon:
                              //   showResetIcon ? Icon(Icons.delete) : null,
                              //   readOnly: readOnly,
                              //   decoration: InputDecoration(
                              //     border: OutlineInputBorder(),
                              //     labelText: 'Product Expire Date*',
                              //     errorText: _pDatevalidate
                              //         ? 'Enter Product Expire Date'
                              //         : null,
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RowTextFields(
                                'Rate*',
                                _cRateController,
                                _getInputValue,
                                _cRateID,
                                _cRateValidate,
                                'no',
                                'Enter a Category Rate',
                                .45),

                            // Expanded(
                            //   child: TextField(
                            //     controller: _cRateController,
                            //     obscureText: false,
                            //     onChanged: (value) {
                            //       _cRate = double.parse(value);
                            //       latestTotalAmount();
                            //     },
                            //     keyboardType: TextInputType.number,
                            //     decoration: InputDecoration(
                            //       border: OutlineInputBorder(),
                            //       labelText: 'Product Rate',
                            //       errorText:
                            //           _cRateValidate ? 'Enter Product Rate' : null,
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: 30,
                            // ),
                            RowTextFields(
                                'Including GST',
                                _cProGSTController,
                                _getInputValue,
                                _cProGSTID,
                                _cPRoGSTValidate,
                                'no',
                                'Enter a GST',
                                .45),
                            // Expanded(
                            //   child: TextField(
                            //     controller: _cProGSTController,
                            //     obscureText: false,
                            //     onChanged: (value) {
                            //       _cPRoGST = double.parse(value);
                            //       // temp = (pProRate * pProQty);
                            //       // TempQty = int.parse(value);
                            //       // _pProSubTotaltext.text = temp.toString();
                            //       // pProSubTotal =
                            //       //     double.parse(_pProSubTotaltext.text);
                            //       latestTotalAmount();
                            //     },
                            //     keyboardType: TextInputType.number,
                            //     decoration: InputDecoration(
                            //       border: OutlineInputBorder(),
                            //       labelText: 'Product GST',
                            //       errorText:
                            //           _cPRoGSTValidate ? 'Enter Product GST' : null,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  print('_cRateValidate Call $_cRateValidate');
                                  print('mSelName Call $mSelName');
                                  bool errorCheck = (!_cRateValidate);
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
                                'Update',
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
      ),
    );
  }

  Widget _buildMobileManagepurchase() {
    double tablet45width = MediaQuery.of(context).size.width * (.45);
    print('_AddProductCategoryScreenState');
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product Rate"),
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
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        enabled: false,
                        enableInteractiveSelection: false,
                        controller: _cProNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Product Name',
                          labelStyle: labelTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 10,
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
                        validator: (date) =>
                            date == null ? 'Invalid date' : null,
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
                      //         initialDate:
                      //         currentValue ?? DateTime.now(),
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
                      //   date == null ? 'Invalid date' : null,
                      //   onChanged: (date) => setState(() {
                      //   }),
                      //   onSaved: (date) => setState(() {
                      //     value = date;
                      //     print('Selected value Date: $value');
                      //     savedCount++;
                      //   }),
                      //   resetIcon:
                      //   showResetIcon ? Icon(Icons.delete) : null,
                      //   readOnly: readOnly,
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(),
                      //     labelText: 'Product Expire Date*',
                      //     errorText: _pDatevalidate
                      //         ? 'Enter Product Expire Date'
                      //         : null,
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
                                errorText: _cRateValidate
                                    ? 'Enter Product Rate'
                                    : null,
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
                                errorText:
                                    _cPRoGSTValidate ? 'Enter GST' : null,
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

                                  bool errorCheck = (!_cRateValidate);

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
                                'Update',
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
    if (prevRate.toString() != _cRateController.text.toString()) {
      // databaseHelper.getRepalceProductName(rowId, _pName);
      var res = await databaseHelper.insertProductRate(ProductRate(
          getProId,
          _cProNameController.text.toString(),
          getProCatName,
          _selectdate,
          _cRate,
          getProCatId));
      if (res != 0) {
        await databaseHelper.getRepalceProductData(getProId, _cRate);
        // Success
        // _showAlertDialog('Status', 'Product Rate Saved Successfully');
        Fluttertoast.showToast(
          msg: "Product Rate updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black38,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );

        Navigator.pop(context, true);
        // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        //   return ManageProductRate();
        // }));
      } else {
        // Failure
        _showAlertDialog('Status', 'Problem Saving to update product Rate');
      }
    } else {
      var result = await databaseHelper.updateProductRate(
          _cRate.toString(), _selectdate.toString(), indexId);
      if (result != 0) {
        // Success
        // _showAlertDialog('Status', 'Product Rate Saved Successfully');
        Fluttertoast.showToast(
          msg: "Product Rate updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black38,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );

        Navigator.pop(context, true);
        // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        //   return ManageProductRate();
        // }));
      } else {
        // Failure
        _showAlertDialog('Status', 'Problem Saving to update product Rate');
      }
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void getTextData() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((value) {
      Future<List<ProductRate>> proListFuture =
          databaseHelper.getProductRateSingleData(indexId);
      proListFuture.then((productCatList) {
        setState(() {
          productCatList.forEach((element) {
            _cProNameController.text = element.proName;
            _cRateController.text = element.proRate.toString();
            _selectdate = element.proDate;
            prevRate = double.parse(element.proRate.toString());
            getProId = element.proId;
            getProCatName = element.proCatName;
            getProCatId = element.proCatId;

            latestTotalAmount();
          });
        });
      });
    });
  }

  _getDropDownValueCat(int value, String sName, String parentName, int _taxid,
      ProductModel productModel) {
    setState(() {
      switch (_taxid) {
        case 1:
          mProTypeValue = value;
          print('sName Value: $sName');
          mSelName = sName;
          mProTypeValueName = parentName;
          break;
      }
      // print('Mtype Value: $_mTypeValue');
    });
  }

  void _getProducts() async {
    ProductFetch Productfetch = new ProductFetch();
    var productData = await Productfetch.getposproduct("1");
    var resid = productData["resid"];
    if (resid == 200) {
      var productsd = productData["product"];
      print(productsd.length);
      List<ProductModel> products = [];
      for (var n in productsd) {
        ProductModel pro = ProductModel.withId(
            int.parse(n['ProductSellingPrice']),
            '',
            0,
            n['ProductName'],
            '',
            '',
            int.parse(n['ProductCategories']),
            0,
            double.parse(n['ProductSellingPrice']),
            '',
            '',
            '',
            '',
            0,
            '',
            n['IntegratedTax'],
            '');
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
    print(UpdatedProductRateId);
    print(mProTypeValue);
    print(mSelName);
    print(mProTypeParentValueName);
    print(_PDatetext.text.toString());
    print(_cProGSTController.text.toString());

    final prodata = await dataUpload.uploadProductRateData(
        UpdatedProductRateId,
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
        Fluttertoast.showToast(
          msg: "Product Rate updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black38,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );

        Navigator.pop(context, true);
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
  }
}
