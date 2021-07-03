import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:retailerp/Adpater/fetch_unitlist.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/LocalDbModels/product_category.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/UnitModel.dart';
import 'package:retailerp/models/popup_menu.dart';
import 'package:retailerp/providers/data_upload.dart';
import 'package:retailerp/providers/popup_menu_item.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/rowtextfields.dart';

class AddProductCategoryScreen extends StatefulWidget {
  @override
  _AddProductCategoryScreenState createState() =>
      _AddProductCategoryScreenState();
}

class _AddProductCategoryScreenState extends State<AddProductCategoryScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  ProductCategory productCategory;
  final _cNameController = TextEditingController();
  final _cCodeController = TextEditingController();
  final _cNameID = 1;
  final _cCodeID = 2;
  bool _cNameValidate = false;
  bool _cCodeValidate = false;
  String _cName = "";
  String _cCode = "";
  DataUpload dataUpload = new DataUpload();
  bool showspinnerlog = false;

  // List<String> mProdCatType = ['Primary', 'Grossa', 'Code39'];
  int count = 0;
  bool _isSelectedDropDown = false;
  List<ProductCategory> productCatList;
  int mCatTypeValue;
  String mCatTypeValueName;
  ProductCategory _productCategory;

  bool error = false;
  PopupMenu _selectedMenu = productCategoryPopupMenu1[0];
  int pProCatId;
  String pProCatName;
  int pProCatParentId;
  String ppProCatParentName;
  UnitListFetch unitListFetch =  new UnitListFetch();
  List<UnitModel> unitList = [];



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
            _cCode = inputValue;
          }
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // updateListView();
    _getProductsCategory();
    // Provider.of<SinglSelectProCat>(context, listen: false).fetchProCatList();
  }

  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    double tabletwidth = MediaQuery.of(context).size.width * .60;
    print('_AddProductCategoryScreenState');
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product Category"),
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
              return productCategoryPopupMenu1.map((PopupMenu popupMenu) {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          // ProCatDropDownWidget(productCatList, _productCategory,
                          //     _getDropDownValue, 1, .60),
                          // ProCatDropDown(),
                          shortestSide < kTabletBreakpoint
                              ? DropdownSearch<ProductCategory>(
                                  items: productCatList,
                                  showClearButton: true,
                                  showSearchBox: true,
                                  label: 'Product Category*',
                                  hint: "Select a Product Category",
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (ProductCategory u) => u == null
                                      ? "Product field is required "
                                      : null,
                                  onChanged: (ProductCategory data) {
                                    pProCatId = data.catid;
                                    pProCatName = data.pCategoryname.toString();
                                    pProCatParentId = data.pParentCategoryId;
                                    ppProCatParentName =
                                        data.pParentCategoryName.toString();
                                  },
                                )
                              : Container(
                                  width: tabletwidth,
                                  child: DropdownSearch<ProductCategory>(
                                    items: productCatList,
                                    showClearButton: true,
                                    showSearchBox: true,
                                    label: 'Product Category*',
                                    hint: "Select a Product Category",
                                    autoValidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (ProductCategory u) => u == null
                                        ? "Product field is required "
                                        : null,
                                    onChanged: (ProductCategory data) {
                                      print(data);
                                      pProCatId = data.catid;
                                      pProCatName =
                                          data.pCategoryname.toString();
                                      pProCatParentId = data.pParentCategoryId;
                                      ppProCatParentName =
                                          data.pParentCategoryName.toString();
                                    },
                                  ),
                                ),
                          RowTextFields(
                              'Category Name*',
                              _cNameController,
                              _getInputValue,
                              _cNameID,
                              _cNameValidate,
                              'text',
                              'Enter a Category Name',
                              .60),
                          // RowTextFields(
                          //     'Category Code*',
                          //     _cCodeController,
                          //     _getInputValue,
                          //     _cCodeID,
                          //     _cCodeValidate,
                          //     'no',
                          //     'Enter a Category Code',
                          //     .60),
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
                                  // if (mCatTypeValue == 'Select Category') {
                                  //   Fluttertoast.showToast(
                                  //     msg: 'Select Category Before Proceeding!!!',
                                  //     toastLength: Toast.LENGTH_SHORT,
                                  //     backgroundColor: PrimaryColor,
                                  //     textColor: Color(0xffffffff),
                                  //     gravity: ToastGravity.BOTTOM,
                                  //   );
                                  // } else {
                                  if (_cNameController.text.isEmpty) {
                                    error = true;
                                    _cNameValidate = true;
                                  } else {
                                    _cNameValidate = false;
                                  }
                                  // Provider.of<SinglSelectProCat>(context,
                                  //         listen: false)
                                  //     .fetchProCatList();
                                  // if (_cCodeController.text.isEmpty) {
                                  //   error = true;
                                  //   _cCodeValidate = true;
                                  // } else {
                                  //   _cCodeValidate = false;
                                  // }

                                  bool errorCheck = (!_cNameValidate);

                                  if (errorCheck) {
                                    print('values: $mCatTypeValue');

                                    if (ppProCatParentName == null) {
                                      _saveToServer(0, 'Primary');
                                    } else {
                                      _saveToServer(pProCatId, pProCatName);
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                      msg:
                                          "Fill all the * Marked fileds Before Proceeding!!!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      backgroundColor: PrimaryColor,
                                      textColor: Color(0xffffffff),
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                  }
                                  // }
                                });
                              },
                              minWidth: 200,
                              height: 60.0,
                              child: Text(
                                'Save',
                                style: btnTextStyle,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
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

  void _getProductsCategory() async {
    try {
      setState(() {
        showspinnerlog = true;
      });
      ProductFetch Productfetch = new ProductFetch();
      var productData = await Productfetch.getProductCategory("1");
      int resid = productData["resid"];
      String msg = productData["message"];
      if (resid == 200) {
        int rowcount = productData["rowcount"];
        if (rowcount > 0) {
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
            showspinnerlog = false;
          });
        } else {
          setState(() {
            showspinnerlog = false;
          });
          _showUploadDialog(msg.toString(), Colors.red);
        }
      } else {
        setState(() {
          showspinnerlog = false;
        });
        _showUploadDialog(msg.toString(), Colors.red);
      }
    } catch (e) {
      setState(() {
        showspinnerlog = false;
      });
      print(e.toString());
    }
  }

  void _saveToServer(int parentValue, String parentName) async {
    try {
      setState(() {
        showspinnerlog = true;
      });

      // var result = await databaseHelper.insertAddProductCategory(
      //     ProductCategory(_cName, parentValue, parentName));
      //
      // if (result != 0) {
      // final prodata = await dataUpload.uploadProCatData(
      //     _cName, parentValue.toString(), parentName);

      final prodata = await dataUpload
          .uploadProCatData(_cName, parentValue.toString(), parentName);
      int resid = prodata["resid"];
      String mes = prodata["message"];
      print(resid);
      if (resid == 200) {
        // _getProductsCategory();
        setState(() {
          showspinnerlog = false;
        });
        _showUploadDialog(mes.toString(), Colors.green);
      } else {
        setState(() {
          showspinnerlog = false;
        });
        // _showAlertDialog('Status', 'Problem Saving to add product category');
        _showUploadDialog(mes.toString(), Colors.red);
      }
      // } else {
      //   // Failure
      //   setState(() {
      //     showspinnerlog = false;
      //   });
      //   _showAlertDialog('Status', 'Problem Saving to add product category');
      // }
    } catch (e) {
      setState(() {
        showspinnerlog = false;
      });
      print(e.toString());
    }
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

  _getDropDownValue(
      int value, String parentName, int _taxid, ProductCategory proCatValue) {
    setState(() {
      switch (_taxid) {
        case 1:
          mCatTypeValue = value;
          print('parentName Value: $parentName');
          mCatTypeValueName = parentName;
          _productCategory = proCatValue;
          break;
      }
      // print('Mtype Value: $_mTypeValue');
    });
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

// void updateListView() {
//   final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//   dbFuture.then((value) {
//     Future<List<ProductCategory>> todoListFuture =
//         databaseHelper.getProductCatList();
//     todoListFuture.then((productCatList) {
//       setState(() {
//         this.productCatList = productCatList;
//         this.count = productCatList.length;
//         _productCategory;
//       });
//     });
//   });
// }
}
// Here is for reading just one barcode:
//
// static Future<Barcode> get(String barcode) async {
// final db = await DbUtil.database;
// var response = await db.query(tableName, where: "$pkName = ?", whereArgs: ['$barcode']);
// return response.isNotEmpty ? Barcode.fromJson(response.first) : null;
// }
