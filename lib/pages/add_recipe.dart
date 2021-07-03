import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/fetch_unitlist.dart';
import 'package:retailerp/Adpater/pos_product_category_fetch.dart';
import 'package:retailerp/LocalDbModels/product_category.dart';
import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/models/UnitModel.dart';
import 'package:retailerp/models/menu_model.dart';
import 'package:retailerp/models/product_recipe_model.dart';
import 'package:retailerp/providers/data_upload.dart';
import 'package:retailerp/providers/recipe.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/widgets/cart_item.dart';
import 'package:retailerp/widgets/mobile_cart_item.dart';

class AddRecipe extends StatefulWidget {
  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  @override
  void initState() {
    // _getSupplier();
    Provider.of<Recipe>(context, listen: false).clear();
    getDatas();
    getMenuDatas();
    _getProductsCategory();
    _getUnitList();
  }

  final _pProGSTtext = TextEditingController();
  int pProGST;
  static const int kTabletBreakpoint = 552;
  String _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    // print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileAddRecipe();
    } else {
      content = _buildTabletAddRecipe();
    }

    return content;
  }

  List<ProductRecipeModel> productList = [];
  List<RecipeItems> pTempRecipeList = [];

  List<MenuModel> menuList = [];
  bool autoValidate = false;
  String Deactivateat;
  bool showResetIcon = false;
  bool readOnly = false;
  double temp;
  double tempsubtotal;
  int TempQty;

  bool _PMenuCatNamevalidate = false;
  bool _PProQtyvalidate = false;
  bool _recipeNamevalidate = false;
  bool _recipeAmountvalidate = false;
  bool _pProGStvalidate = false;

  String PProId;
  String PProName;
  String productamt;
  double PProQty;

  int pProCatId;
  String pProCatName;

  String pMenuId;
  String pMenuName;
  String editMenuName;
  UnitListFetch unitListFetch = new UnitListFetch();

  final _menuCatNametext = TextEditingController();
  final _recipeNametext = TextEditingController();
  final _amounttext = TextEditingController();
  final _PProQtytext = TextEditingController();
  List<UnitModel> unitList = [];
  List<ProductCategory> productCatList;
  DataUpload dataUpload = new DataUpload();
  String _unitId,hsncode,openingblance,gst,productcode,ProductcompanyName,containsPrice;

  TextEditingController hsncodeTC = TextEditingController();
  TextEditingController openingblanceTC = TextEditingController();
  TextEditingController gstTC = TextEditingController();
  TextEditingController ProductCodeTC = TextEditingController();
  TextEditingController ProductcompanyNameTc = TextEditingController();

  _getUnitList() async {
    var response = await unitListFetch.getUnitList();
    var resid = response["resid"];
    var rowcount = response["rowcount"];
    var unitsd = response["unitlist"];
    List<UnitModel> unitListTemp = [];

    for (var n in unitsd) {
      UnitModel unitModel = new UnitModel(n["unitid"], n["unitname"]);
      unitListTemp.add(unitModel);
    }

    setState(() {
      unitList = unitListTemp;
    });
  }



  Widget _buildTabletAddRecipe() {
    double tabletwidth = MediaQuery.of(context).size.width * (.44);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add Customize Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Consumer<Recipe>(builder: (context, cart, child) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent)
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: tabletwidth,
                                  child: DropdownSearch<ProductCategory>(
                                    items: productCatList,
                                    showClearButton: true,
                                    showSearchBox: true,
                                    label: 'Product Category*',
                                    hint: "Select a Product Category",
                                    autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    validator: (ProductCategory u) =>
                                    u == null
                                        ? "Product field is required "
                                        : null,
                                    onChanged: (ProductCategory data) {
                                      print(data);
                                      pProCatId = data.catid;
                                      pProCatName = data.pCategoryname.toString();

                                    },
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
                                    _showAddMenuCatDialog();
                                  });
                                },
                              ),
                              Expanded(
                                child: Container(
                                  height: 45,
                                  child: TextField(
                                    controller: _recipeNametext,
                                    obscureText: false,
                                    onChanged: (value) {},
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Product Name *',
                                      errorText: _recipeNamevalidate
                                          ? 'Enter Product Name'
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                            child: Container(
                                  height: 45,
                                  child: TextField(
                                    controller: ProductCodeTC,
                                    onChanged: (value) {
                                      productcode = value;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Product Code'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 32,
                              ),
                              Expanded(
                                child: Container(
                                  height: 45,
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    controller: ProductcompanyNameTc,
                                    onChanged: (value){
                                      ProductcompanyName = value;
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Company Name'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent)
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 45,
                                  child: TextField(
                                    controller: _amounttext,
                                    obscureText: false,
                                    onChanged: (value) {

                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Amount *',
                                      errorText:
                                      _recipeAmountvalidate ? 'Enter Amount' : null,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Container(
                                  height: 45,
                                  child: TextField(
                                  controller: hsncodeTC,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'HSN Code'),
                                    onChanged: (value){
                                      hsncode =  value;

                                    },
                                  ),
                                ),
                              ),
//                        Expanded(
//                          child: TextField(
//                            controller: _pProGSTtext,
//                            obscureText: false,
//                            onChanged: (value) async {
//                              pProGST = int.parse(value);
//                            },
//                            keyboardType: TextInputType.number,
//                            decoration: InputDecoration(
//                              border: OutlineInputBorder(),
//                              labelText: 'Including GST',
//                              errorText: _pProGStvalidate ? 'Enter GST' : null,
//                            ),
//                          ),
//                        ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownSearch<UnitModel>(
                                  items: unitList,
                                  label: "Unit Name",
                                  onChanged: (value) {
                                    if (value != null) {

                                      setState(() {
                                        _unitId = value.unitid.toString();
                                      });

                                      print("_mTypeValue:-    ${_unitId}");
                                    } else {
                                      _unitId = "";
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Container(
                                  height: 45,
                                  child: TextField(
                                    controller: openingblanceTC,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value){
                                      openingblance   = value;

                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Opening Balance'),
                                  ),
                                ),
                              ),

//                        Expanded  (
//                          child: TextField(
//                            controller: _pProGSTtext,
//                            obscureText: false,
//                            onChanged: (value) async {
//                              pProGST = int.parse(value);
//                            },
//                            keyboardType: TextInputType.number,
//                            decoration: InputDecoration(
//                              border: OutlineInputBorder(),
//                              labelText: 'Including GST',
//                              errorText: _pProGStvalidate ? 'Enter GST' : null,
//                            ),
//                          ),
//                        ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Visibility(
                                  child: Container(
                                    height: 45,
                                    child: TextField(
                                      controller: gstTC,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        gst = value;
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'GST'),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Visibility(
                                  visible: false,
                                  child: Container(
                                    child: DropdownSearch<UnitModel>(
                                      items: unitList,
                                      label: "Unit Name",
                                      onChanged: (value) {
                                        if (value != null) {

                                          setState(() {
                                            _unitId = value.unitid.toString();
                                          });

                                          print("_mTypeValue:-    ${_unitId}");
                                        } else {
                                          _unitId = "";
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              )


//                        Expanded  (
//                          child: TextField(
//                            controller: _pProGSTtext,
//                            obscureText: false,
//                            onChanged: (value) async {
//                              pProGST = int.parse(value);
//                            },
//                            keyboardType: TextInputType.number,
//                            decoration: InputDecoration(
//                              border: OutlineInputBorder(),
//                              labelText: 'Including GST',
//                              errorText: _pProGStvalidate ? 'Enter GST' : null,
//                            ),
//                          ),
//                        ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent)
                      ),
                      child:    Row(
                        children: [
                          Expanded(
                            child: DropdownSearch<ProductRecipeModel>(
                                items: productList,
                                mode: Mode.BOTTOM_SHEET,
                                isFilteredOnline: true,
                                showClearButton: true,
                                showSearchBox: true,
                                label: 'Contains Name *',
                                autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (ProductRecipeModel u) => u == null
                                    ? "Contains name field is required "
                                    : null,
                                onChanged: (ProductRecipeModel data) {
                                  PProName = data.proName;
                                  PProId = data.id;
                                  productamt = data.proPrice.toString();}
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                              height: 45,
                              child: TextField(
                                controller: _PProQtytext,
                                obscureText: false,
                                onChanged: (value) {
                                  PProQty = double.parse(value);
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Contains Quantity',
                                  errorText:
                                  _PProQtyvalidate ? 'Product Quantity' : null,
                                ),
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
                                if (_PProQtytext.text.isEmpty) {
                                  _PProQtyvalidate = true;
                                } else if (_PProQtytext.text == 0) {
                                  _PProQtyvalidate = true;
                                } else {
                                  _PProQtyvalidate = false;
                                }

                                bool errorCheck = (!_PProQtyvalidate);

                                if (PProName == null) {
                                  Fluttertoast.showToast(
                                    msg: "Select Product Name",
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.black38,
                                    textColor: Color(0xffffffff),
                                    gravity: ToastGravity.BOTTOM,
                                  );
                                } else {
                                  if (errorCheck) {
                                    final recips =
                                    RecipeItems(PProId, PProName, PProQty,double.parse(productamt));
                                    Provider.of<Recipe>(context, listen: false)
                                        .addRecipeItems(recips);
                                    _amounttext.text =  cart.totalAmount1.toString();

                                    setState(() {
                                      containsPrice =  cart.totalAmount1.toString();
                                    });

                                    print("/////${cart.itemCount}");
                                  }
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Material(
                      elevation: 5.0,
                      color: PrimaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      child: MaterialButton(
                        onPressed: () async {

                          print("Product CatID///////${pProCatId.toString()}");
                          _uploadMenuData(cart);
                          setState(() {
                            if (_recipeNametext.text.isEmpty) {
                              _recipeNamevalidate = true;
                            } else   {
                              _recipeNamevalidate = false;
                            }
                            if (_amounttext.text.isEmpty) {
                              _recipeAmountvalidate = true;
                            } else {
                              _recipeAmountvalidate = false;
                            }

                            bool errorCheck = (!_recipeNamevalidate &&
                                !_recipeAmountvalidate);

                            if (errorCheck && pMenuName != null) {

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
                          });
                        },
                        minWidth: 150,
                        height: 60.0,
                        child: Text(
                          'Add Product',
                          style: btnTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: tabletwidth,
                            height: 300,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: cart.itemCount,
                                itemBuilder: (context, int index) {
                                  final cartItem = cart.products[index];
                                  // return CartItem('$index', cartItem.id,
                                  //     cartItem.quantity, cartItem.title);
                                  return CartItem(cartItem,index);
                                  }
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileAddRecipe() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add Recipe'),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Consumer<Recipe>(builder: (context, cart, child) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DropdownSearch<MenuModel>(
                            items: menuList,
                            mode: Mode.BOTTOM_SHEET,
                            isFilteredOnline: true,
                            showClearButton: true,
                            showSearchBox: true,
                            label: 'Menu Category *',
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (MenuModel u) => u == null
                                ? "menu Category field is required "
                                : null,
                            // onFind: (String filter) => getDatas(),
                            onChanged: (MenuModel data) {
                              pMenuName = data.proName;
                              pMenuId = data.id;
                            },
                          ),
                        ),
                        IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.plusCircle,
                            color: PrimaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _showAddMenuCatDialog();
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _recipeNametext,
                      obscureText: false,
                      onChanged: (value) {},
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Recipe Name *',
                        errorText:
                            _recipeNamevalidate ? 'Enter Recipe Name' : null,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amounttext,
                            obscureText: false,
                            onChanged: (value) {},
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Amount *',
                              errorText:
                                  _recipeAmountvalidate ? 'Enter Amount' : null,
                            ),
                          ),
                        ), SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _pProGSTtext,
                            obscureText: false,
                            onChanged: (value) async {
                              pProGST = int.parse(value);

                              // if (_amounttext.text != null) {
                              //   latestGSTAmount(double.parse(_amounttext.text),
                              //       double.parse(value));
                              // }
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Including GST',
                              errorText: _pProGStvalidate ? 'Enter GST' : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownSearch<ProductRecipeModel>(
                            items: productList,
                            mode: Mode.BOTTOM_SHEET,
                            isFilteredOnline: true,
                            showClearButton: true,
                            showSearchBox: true,
                            label: 'Product Name *',
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (ProductRecipeModel u) => u == null
                                ? "product name field is required "
                                : null,
                            onChanged: (ProductRecipeModel data) {
                              PProName = data.proName;
                              PProId = data.id;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _PProQtytext,
                            obscureText: false,
                            onChanged: (value) {
                              PProQty = double.parse(value);
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Product Quantity',
                              errorText:
                                  _PProQtyvalidate ? 'Product Quantity' : null,
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
                              // if (PProName.isEmpty) {
                              //   _PProNamevalidate = true;
                              // } else {
                              //   _PProNamevalidate = false;
                              // }
                              if (_PProQtytext.text.isEmpty) {
                                _PProQtyvalidate = true;
                              } else if (_PProQtytext.text == 0) {
                                _PProQtyvalidate = true;
                              } else {
                                _PProQtyvalidate = false;
                              }

                              bool errorCheck = (!_PProQtyvalidate);

                              if (PProName == null) {
                                Fluttertoast.showToast(
                                  msg: "Select Product Name",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.black38,
                                  textColor: Color(0xffffffff),
                                  gravity: ToastGravity.BOTTOM,
                                );
                              } else {
                                if (errorCheck) {
                                  final recips =
                                      RecipeItems(PProId, PProName, PProQty,0.0);
                                  Provider.of<Recipe>(context, listen: false)
                                      .addRecipeItems(recips);
                                  print("/////${cart.itemCount}");
                                }
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Material(
                      elevation: 5.0,
                      color: PrimaryColor,
                      borderRadius: BorderRadius.circular(15.0),
                      child: MaterialButton(
                        onPressed: () async {
                          setState(() {
                            if (_recipeNametext.text.isEmpty) {
                              _recipeNamevalidate = true;
                            } else {
                              _recipeNamevalidate = false;
                            }
                            if (_amounttext.text.isEmpty) {
                              _recipeAmountvalidate = true;
                            } else {
                              _recipeAmountvalidate = false;
                            }

                            bool errorCheck = (!_recipeNamevalidate &&
                                !_recipeAmountvalidate);

                            if (errorCheck && pMenuName != null) {
                              if (cart.itemCount != 0) {
                                print('Uploaf Datta Call');
                                _uploadMenuData(cart);
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Add product and quantity",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.black38,
                                  textColor: Color(0xffffffff),
                                  gravity: ToastGravity.BOTTOM,
                                );
                              }
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
                          });
                        },
                        minWidth: 150,
                        height: 25.0,
                        child: Text(
                          'Add Recipe',
                          style: btnTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 300,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: cart.itemCount,
                              itemBuilder: (context, int index) {
                                final cartItem = cart.products[index];
                                return MobileCartItem(cartItem);
                              }),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void _getProductsCategory() async {

    try {
      ProductCategoryFetch Productfetch = new ProductCategoryFetch();
      var productData = await Productfetch.getProductCategoryFetch("1");
      var resid = productData["resid"];
      if (resid == 200) {
        var rowcount = productData["rowcount"];
        if (rowcount == 0) {

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
          });
        }
      } else {
        String msg = productData["message"];
        Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: PrimaryColor,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
    }
  }

  Future<void> _showAddMenuCatDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: AlertDialog(
              title: Text('Add Menu Category'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                      controller: _menuCatNametext,
                      autofocus: true,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Menu Category Name",
                        errorText: _PMenuCatNamevalidate
                            ? 'Enter Menu Category Name'
                            : null,
                      ),
                      onChanged: (newText) {
                        editMenuName = newText;
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Close'),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text('Add Category'),
                  onPressed: () async {
                    setState(() {
                      if (_menuCatNametext.text.isEmpty) {
                        _PMenuCatNamevalidate = true;
                      } else {
                        _PMenuCatNamevalidate = false;
                      }

                      bool errorCheck = (!_PMenuCatNamevalidate);
                      if (errorCheck) {
                        _saveMenuCatData();
                        print(editMenuName);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  getDatas() async {

    var map = new Map<String, dynamic>();
    map['ProductId'] = '1';

    String apifile = 'Fetch_Product.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile, data: map);
    var purchasedata = await networkHelper.getData();
    print('purchasedata: ${purchasedata}');

    var resID = purchasedata["resid"];
    print(resID);

    if (resID == 200) {
      var productkList = purchasedata['product'];

      for (var n in productkList) {
        ProductRecipeModel item =
            ProductRecipeModel(id: n['ProductId'], proName: n['ProductName'], proPrice: double.parse(n['ProductSellingPrice']));
        productList.add(item);
      }
    } else {
      // return null;
    }
  }

  getMenuDatas() async {
    var map = new Map<String, dynamic>();
    map['MenucategioresId'] = '1';

    String apifile = 'Fetch_Menu_Catgory.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var data = await networkHelper.getData();
    var resID = data["resid"];
    print('Menu resposne: ${resID}');

    if (resID == 200) {
      var productkList = data['menucategiores'];
      menuList.clear();
      for (var n in productkList) {
        MenuModel item = MenuModel(
            id: n['MenucategioresId'], proName: n['Menucategioresname']);
        menuList.add(item);
      }
    }
  }

  void _saveMenuCatData() async {
    final menudata = await dataUpload.uploadProductMenuData(editMenuName.toString());

    var resid = menudata["resid"];
    print(' menudata: ${resid}');
    if (resid == 200) {
      getMenuDatas();
      _recipeNametext.text = '';
      Navigator.of(context).pop();
    } else {}
  }

  void _uploadMenuData(Recipe cart) async {
    print("START OF FUNCTION Product CatID///////${pProCatId.toString()}");



    List<String> proId = new List();
    List<String> proName = new List();
    List<String> proQty = new List();
    List<double> proPrice = new List();

    pTempRecipeList = cart.products;

    pTempRecipeList.forEach((element) {
      proId.add(element.id);
      proName.add(element.title);
      proQty.add(element.quantity.toString());
      proPrice.add(element.productprice);
    });


    String proIds = proId.join("#");
    String proNames = proName.join("#");
    String proQtys = proQty.join("#");
    String propRICE = proPrice.join("#");

    print('$proIds');

    print(hsncode);
    print(_unitId);
    print(openingblance);
    print(gst);
    print(ProductcompanyName);
    print(productcode);
    print(propRICE);

    var menudata = await dataUpload.uploadCustomizedProduct(
        _recipeNametext.text.toString(),
        _selectdate,
        proIds,
        proQtys,
        propRICE,
        _amounttext.text.toString(),pProCatId.toString(), hsncode!= null ? hsncode : "",_unitId!= null ?_unitId : "" ,openingblance != null ? openingblance : "",gst != null ? gst : "",ProductcompanyName != null ? ProductcompanyName : "",productcode != null ? productcode : "",containsPrice!= null ? containsPrice : "0.0");
    print(menudata);
    var resid = menudata["resid"];
    if (resid == 200) {
      Fluttertoast.showToast(
        msg: "Recipe Save Successfully",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
      cart.clear();
      Navigator.of(context).pop();
    } else {}
  }

  double latestGSTAmount(double totalAmount, double GST) {
    double mainPrice = totalAmount / (100 + GST) * 100;
    double cal = totalAmount * (GST / (100 + GST));
    print('Without GST ' + mainPrice.toString());
    print('Add GST ' + cal.toString());
    double check = mainPrice + cal;
    print('Calculation ' + check.toString());

    return cal;
  }
}
