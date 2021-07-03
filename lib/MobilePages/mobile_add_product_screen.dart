import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/LocalDbModels/product_category.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/LocalDbModels/product_rate.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/popup_menu.dart';
import 'package:retailerp/models/radio_button_list.dart';
import 'package:retailerp/providers/data_upload.dart';
import 'package:retailerp/providers/popup_menu_item.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/utils/my_navigator.dart';
import 'package:retailerp/widgets/radiogroup.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/const.dart';
import '../widgets/drop_down_widget.dart';
import '../widgets/rowtextfields.dart';
import 'package:retailerp/widgets/pro_cat_drop_down_widget.dart';

class MobileAddProductScreen extends StatefulWidget {
  @override
  _MobileAddProductScreenState createState() => _MobileAddProductScreenState();
}

class _MobileAddProductScreenState extends State<MobileAddProductScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<String> mType = ['Service', 'Product'];
  DataUpload dataUpload = new DataUpload();

  // List<String> mCategory = ['Banana', 'Apple', 'Oil'];
  List<String> mUnit = ['Box', 'Price'];
  String _mTypeValue;
  bool showspinnerlog = false;
  File _image;
  final picker = ImagePicker();
  String _imageFilePath;
  bool _imageCheck = false;

  // String _mCategoryValue = '';
  String _mUnitValue;
  final _pNameController = TextEditingController();
  final _pCodeController = TextEditingController();
  final _cNameController = TextEditingController();

  // final _pPriceController = TextEditingController();
  final _pSellingPriceController = TextEditingController();
  final _pHSNCodeController = TextEditingController();
  final _openingBalController = TextEditingController();
  final _integratedTaxController = TextEditingController();

  final _pNameID = 1;
  final _pCodeID = 2;
  final _cNameID = 3;

  // final _pPriceID = 4;
  final _pSellingPriceID = 5;
  final _pHSNCodeID = 6;
  final _openingBalID = 7;
  final _integratedTaxID = 8;

  bool _pNameValidate = false;
  bool _pCodeValidate = false;
  bool _cNameValidate = false;

  // bool _pPriceValidate = false;
  bool _pSellingPriceValidate = false;
  bool _pHSNCodeValidate = false;
  bool _openingBalValidate = false;
  bool _integratedTaxValidate = false;

  String _pName = "";
  int _pCode;
  String _cName = "";

  // int _pPrice;
  double _pSellingPrice;
  String _pHSNCode = "";
  int _openingBalNCode;
  String _integratedTaxCode = "";

  String _taxRadioButtonItem = 'Nil Rate';
  int _taxid = 1;
  String _billingMethodRadioButtonItem = 'Including Tax';
  int _billingMethodid = 1;
  PopupMenu _selectedMenu = productPopupMenu2[0];

  List<RadioButtonList> raTaxList = [
    RadioButtonList(
      index: 1,
      name: "Nil Rate",
    ),
    RadioButtonList(
      index: 2,
      name: "Exempted",
    ),
    RadioButtonList(
      index: 3,
      name: "Taxable",
    ),
  ];

  List<ProductCategory> productCatList;
  ProductCategory _productCategory;
  int count = 0;
  int mCatTypeValue;
  String mCatTypeValueName;
  bool integrateTaxCheck = false;
  String rateWithGST = "0.00";
  String rateWithoutGst = "0.00";
  int _genProCode;
  int pProCatId;
  String pProCatName;
  int pProCatParentId;
  String ppProCatParentName;

  void _getInputValue(String inputValue, int _taxid) {
    setState(() {
      switch (_taxid) {
        case 1:
          {
            _pName = inputValue;
          }
          break;
        case 2:
          {
            _pCode = int.parse(inputValue);
          }
          break;
        case 3:
          {
            _cName = inputValue;
          }
          break;
        // case 4:
        //   {
        //     _pPrice = int.parse(inputValue);
        //   }
        //   break;
        case 5:
          {
            _pSellingPrice = double.parse(inputValue);
            if (_integratedTaxController.text.toString() == null) {
              // latestSellingWithGSTCal(
              //     double.parse(_pSellingPriceController.text), 0);
              print(
                  '_integratedTaxController:Call ${_integratedTaxController.text.toString()}');
              rateWithoutGst = '0.00';
              rateWithGST = inputValue;
            } else {
              print('else: Call');

              latestSellingWithGSTCal(
                  double.parse(_pSellingPriceController.text),
                  double.parse(_integratedTaxController.text));
            }
          }
          break;
        case 6:
          {
            _pHSNCode = inputValue;
          }
          break;
        case 7:
          {
            _openingBalNCode = int.parse(inputValue);
          }
          break;
        case 8:
          {
            _integratedTaxCode = inputValue;
            if (_pSellingPriceController.text.toString() == null) {
              rateWithoutGst = '0.00';
              rateWithGST = '0.00';
              // latestSellingWithGSTCal(
              //     0, double.parse(_integratedTaxController.text));
            } else {
              latestSellingWithGSTCal(
                  double.parse(_pSellingPriceController.text),
                  double.parse(_integratedTaxController.text));
            }
          }
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getProducts();
    _getProductsCategory();
    // updateListView();
  }

  @override
  Widget build(BuildContext context) {
    double tabletwidth = MediaQuery.of(context).size.width * (.30);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              MyNavigator.goToDashboard(context);
            },
          ),
          new PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              size: 28,
              color: Colors.white,
            ),
            itemBuilder: (BuildContext context) {
              return productPopupMenu2.map((PopupMenu popupMenu) {
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
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      DropDownWidget(
                          'Select Type *', mType, _getDropDownValue, 1, .45),
                      // RowTextFields(
                      //     'Product Code',
                      //     _pCodeController,
                      //     _getInputValue,
                      //     _pCodeID,
                      //     _pCodeValidate,
                      //     'no',
                      //     'Enter a Category Code',
                      //     .45),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _pCodeController,
                              obscureText: false,
                              onChanged: (value) {
                                _pCode = int.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Product Code',
                                errorText: _pCodeValidate
                                    ? 'Enter Category Code'
                                    : null,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _getProducts();
                                _pCode = _genProCode;
                                _pCodeController.text = _pCode.toString();
                              });
                            },
                            icon: Icon(
                              Icons.create_sharp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      RowTextFields(
                          'Product Name *',
                          _pNameController,
                          _getInputValue,
                          _pNameID,
                          _pNameValidate,
                          'text',
                          'Enter a Category Name',
                          .45),
                      RowTextFields(
                          'Company  Name *',
                          _cNameController,
                          _getInputValue,
                          _cNameID,
                          _cNameValidate,
                          'text',
                          'Enter a Company Name',
                          .45),
                      // DropDownWidget('Category Type', mCategory,
                      //     _getDropDownValue, 2, .45),
                      // ProCatDropDownWidget(productCatList, _productCategory,
                      //     _getDropDownValueCat, 2, .45),

                      DropdownSearch<ProductCategory>(
                        items: productCatList,
                        showClearButton: true,
                        showSearchBox: true,
                        label: 'Category Type*',
                        hint: "Select a Product Category",
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (ProductCategory u) =>
                            u == null ? "Product field is required " : null,
                        onChanged: (ProductCategory data) {
                          pProCatId = data.catid;
                          pProCatName = data.pCategoryname.toString();
                          pProCatParentId = data.pParentCategoryId;
                          ppProCatParentName =
                              data.pParentCategoryName.toString();
                        },
                      ),
                      // RowTextFields(
                      //     'Purchase Price *',
                      //     _pPriceController,
                      //     _getInputValue,
                      //     _pPriceID,
                      //     _pPriceValidate,
                      //     'no',
                      //     'Enter a Purchase Price',
                      //     .45),
                      RowTextFields(
                          'Selling Price *',
                          _pSellingPriceController,
                          _getInputValue,
                          _pSellingPriceID,
                          _pSellingPriceValidate,
                          'no',
                          'Enter a Selling Price',
                          .45),
                      RowTextFields(
                          'HSN Code *',
                          _pHSNCodeController,
                          _getInputValue,
                          _pHSNCodeID,
                          _pHSNCodeValidate,
                          'no',
                          'Enter a HSN Code',
                          .45),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tax:*',
                            style: headsubTextStyle,
                          ),
                        ],
                      ),
                      getRadioButton('Nil Rate', 'Exempted', 'Taxable'),
                      Visibility(
                        child: RowTextFields(
                            'Integrated Tax *',
                            _integratedTaxController,
                            _getInputValue,
                            _integratedTaxID,
                            _integratedTaxValidate,
                            'no',
                            'Enter a Integrated Tax',
                            .45),
                        visible: integrateTaxCheck,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Image:*',
                            style: headsubTextStyle,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                            onPressed: () {
                              print('Choose Image Call');
                              getImage();
                            },
                            child:
                                Text('Choose Image', style: flatbtnTextStyle),
                            textColor: PrimaryColor,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: PrimaryColor,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropDownWidget(
                          'Choose Unit *', mUnit, _getDropDownValue, 3, .45),
                      RowTextFields(
                          'Opening Balance *',
                          _openingBalController,
                          _getInputValue,
                          _openingBalID,
                          _openingBalValidate,
                          'no',
                          'Enter a Opening Balance',
                          .45),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Billing Method: *',
                            style: headsubTextStyle,
                          ),
                        ],
                      ),
                      getRadioButtonTwo('Including Tax', 'Excluding Tax'),
                      // Visibility(
                      //   child: RowTextFields(
                      //       'Integrated Tax *',
                      //       _integratedTaxController,
                      //       _getInputValue,
                      //       _integratedTaxID,
                      //       _integratedTaxValidate,
                      //       'no',
                      //       'Enter a Integrated Tax',
                      //       .45),
                      //   visible: integrateTaxCheck,
                      // ),
                      Visibility(
                        child: Container(
                          width: 200,
                          height: 150,
                          child: _image == null
                              ? Text('No image selected.')
                              : Image.file(_image),
                        ),
                        visible: _imageCheck,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Material(
                    elevation: 5.0,
                    color: PrimaryColor,
                    borderRadius: BorderRadius.circular(15.0),
                    child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          if (_pNameController.text.isEmpty) {
                            _pNameValidate = true;
                          } else {
                            _pNameValidate = false;
                          }
                          if (_pCodeController.text.isEmpty) {
                            _pCodeValidate = true;
                          } else {
                            _pCodeValidate = false;
                          }
                          if (_cNameController.text.isEmpty) {
                            _cNameValidate = true;
                          } else {
                            _cNameValidate = false;
                          }

                          if (_pSellingPriceController.text.isEmpty) {
                            _pSellingPriceValidate = true;
                          } else {
                            _pSellingPriceValidate = false;
                          }
                          if (_pHSNCodeController.text.isEmpty) {
                            _pHSNCodeValidate = true;
                          } else {
                            _pHSNCodeValidate = false;
                          }
                          if (_openingBalController.text.isEmpty) {
                            _openingBalValidate = true;
                          } else {
                            _openingBalValidate = false;
                          }

                          print('Tax:  $_taxRadioButtonItem');

                          if (integrateTaxCheck) {
                            if (_integratedTaxController.text.isEmpty) {
                              _integratedTaxValidate = true;
                            } else {
                              _integratedTaxValidate = false;
                            }
                          }

                          bool errorCheck = (!_pNameValidate &&
                              !_pCodeValidate &&
                              !_cNameValidate &&
                              !_pSellingPriceValidate &&
                              !_pHSNCodeValidate &&
                              !_openingBalValidate &&
                              !_integratedTaxValidate &&
                              _mTypeValue != null &&
                              _mUnitValue != null &&
                              pProCatName != null);

                          if (errorCheck) {
                            // if (_image != null) {
                            _saveToloc();
                            // } else {
                            // Fluttertoast.showToast(
                            //   msg: "Choose image Before Proceeding!!!",
                            //   toastLength: Toast.LENGTH_SHORT,
                            //   backgroundColor: Colors.black38,
                            //   textColor: Color(0xffffffff),
                            //   gravity: ToastGravity.BOTTOM,
                            // );
                            // }
                            print('errorCheck Call');

                            print(
                                ' Bill Method: $_billingMethodRadioButtonItem');
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
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getRadioButton(
      String radioItem1, String radioItem2, String radioItem3) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Radio(
              value: 1,
              groupValue: _taxid,
              onChanged: (val) {
                setState(() {
                  _taxRadioButtonItem = radioItem1;
                  _taxid = 1;
                  _integratedTaxController.text = '';
                  rateWithoutGst = '0.00';
                  rateWithGST = _pSellingPriceController.text;
                  integrateTaxCheck = false;
                });
              },
            ),
            Text(
              radioItem1,
              style: labelTextStyle,
            ),
            Radio(
              value: 2,
              groupValue: _taxid,
              onChanged: (val) {
                setState(() {
                  _taxRadioButtonItem = radioItem2;
                  _taxid = 2;
                  _integratedTaxController.text = '';
                  rateWithoutGst = '0.00';
                  rateWithGST = _pSellingPriceController.text;
                  integrateTaxCheck = false;
                });
              },
            ),
            Text(
              radioItem2,
              style: labelTextStyle,
            ),
            Radio(
              value: 3,
              groupValue: _taxid,
              onChanged: (val) {
                setState(() {
                  _taxRadioButtonItem = radioItem3;
                  _taxid = 3;
                  integrateTaxCheck = true;
                });
              },
            ),
            Text(
              radioItem3,
              style: labelTextStyle,
            ),
          ],
        ),
      ],
    );
  }

  Widget getRadioButtonTwo(String radioItem1, String radioItem2) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Radio(
              value: 1,
              groupValue: _billingMethodid,
              onChanged: (val) {
                setState(() {
                  _billingMethodRadioButtonItem = radioItem1;
                  _billingMethodid = 1;
                });
              },
            ),
            Text(
              radioItem1,
              style: labelTextStyle,
            ),
            Radio(
              value: 2,
              groupValue: _billingMethodid,
              onChanged: (val) {
                setState(() {
                  _billingMethodRadioButtonItem = radioItem2;
                  _billingMethodid = 2;
                });
              },
            ),
            Text(
              radioItem2,
              style: labelTextStyle,
            ),
          ],
        ),
      ],
    );
  }

  _getDropDownValue(String value, int _taxid) {
    setState(() {
      switch (_taxid) {
        case 1:
          _mTypeValue = value;
          break;
        // case 2:
        //   _mCategoryValue = value;
        //   break;
        case 3:
          _mUnitValue = value;
          break;
      }
      print('Mtype Value: $_mTypeValue');
    });
  }

  _getDropDownValueCat(
      int value, String parentName, int _taxid, ProductCategory proCatValue) {
    setState(() {
      switch (_taxid) {
        case 2:
          mCatTypeValue = value;
          print('parentName Value: $parentName');
          mCatTypeValueName = parentName;
          _productCategory = proCatValue;
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

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((value) {
      Future<List<ProductCategory>> todoListFuture =
          databaseHelper.getProductCatList();
      todoListFuture.then((productCatList) {
        setState(() {
          this.productCatList = productCatList;
          this.count = productCatList.length;
          _productCategory;
        });
      });
    });
  }

  Future getImage() async {
    print('getImage() Call');
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageFilePath = pickedFile.path;
        _imageCheck = true;
        print('_image Path Call : ${_imageFilePath}');
      } else {
        _imageCheck = false;
        print('No image selected.');
      }
    });
  }

  void _getProductsCategory() async {
    setState(() {
      showspinnerlog = true;
    });
    ProductFetch Productfetch = new ProductFetch();
    var productData = await Productfetch.getProductCategory("1");
    var resid = productData["resid"];
    if (resid == 200) {
      var rowcount = productData["rowcount"];
      if (rowcount == 0) {
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
      } else {
        var productsd = productData["productcategories"];
        print(productsd.length);
        List<ProductCategory> productCat = [];
        for (var n in productsd) {
          ProductCategory pro = ProductCategory.withId(
              int.parse(n['ProductCategoriesId']),
              n['ProductCategoriesName'],
              int.parse(n['productCategioresParentId']),
              n['productCategioresParentName']);
          productCat.add(pro);
        }

        setState(() {
          productCatList = productCat;
          // productList.forEach((element) {
          //   proNameList.add(element.proName);
          // });
          showspinnerlog = false;
        });
      }
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

  void _getProducts() async {
    ProductFetch Productfetch = new ProductFetch();
    var productData = await Productfetch.getposproduct("1");
    var resid = productData["resid"];
    if (resid == 200) {
      var productsd = productData["product"];
      print(productsd.length);
      int codeValue=1;
      for (int i = productsd.length - 1; i < productsd.length; i++) {
        codeValue = int.parse(productsd[i]['ProductId']);
      }
      if (codeValue != null) {
        print(codeValue);
        _genProCode = (codeValue + 1);
      } else {
        _genProCode = 1;
      }
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

  void _saveToloc() async {
    setState(() {
      showspinnerlog = true;
    });
    String _selectdate = DateFormat('dd/MM/yyyy').format(new DateTime.now());

    var result = await databaseHelper.insertProduct(ProductModel(
        _mTypeValue,
        _pCode,
        _pName,
        _cName,
        pProCatName,
        pProCatId,
        null,
        _pSellingPrice,
        _pHSNCode,
        _taxRadioButtonItem,
        _image != null ? _imageFilePath : '',
        _mUnitValue,
        _openingBalNCode,
        _billingMethodRadioButtonItem,
        _integratedTaxCode,
        _selectdate));

    if (result != 0) {
      // Success

      final prodata = await dataUpload.uploadProductData(
          _mTypeValue,
          _pCode.toString(),
          _pName,
          _cName,
          pProCatId.toString(),
          _pSellingPrice.toString(),
          _pHSNCode,
          _taxRadioButtonItem,
          _mUnitValue,
          _openingBalNCode.toString(),
          _billingMethodRadioButtonItem,
          _integratedTaxCode,
          _image != null ? _image : null,"0");

      var resid = prodata["resid"];
      print(resid);
      if (resid == 200) {
        setState(() {
          showspinnerlog = false;
          _showAlertDialog('Status', 'Product Saved Successfully');
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

      await databaseHelper.insertProductRate(ProductRate(result, _pName,
          mCatTypeValueName, _selectdate, _pSellingPrice, mCatTypeValue));

      setState(() {
        _pNameController.text = '';
        _pCodeController.text = '';
        _cNameController.text = '';
        // _pPriceController.text = '';
        _pSellingPriceController.text = '';
        _pHSNCodeController.text = '';
        _openingBalController.text = '';
        _integratedTaxController.text = '';
        _image = null;
      });
    } else {
      setState(() {
        showspinnerlog = false;
      });
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

  _imgFromGallery() async {
    print('_imgFromGallery Call');
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
      print('_imgFromGallery Call');
    });
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
}
