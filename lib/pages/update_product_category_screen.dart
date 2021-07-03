import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/LocalDbModels/product_category.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/popup_menu.dart';
import 'package:retailerp/providers/data_upload.dart';
import 'package:retailerp/providers/popup_menu_item.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/utils/my_navigator.dart';
import 'package:retailerp/widgets/pro_cat_drop_down_widget.dart';
import 'package:sqflite/sqflite.dart';

class UpdateProductCategoryScreen extends StatefulWidget {
  // final ProductCategory productCategory;
  // final int rowId;
  // final int cType;
  // final String cName;

  final int indexFetch;
 final List<ProductCategory> pCatList;

  // UpdateProductCategoryScreen(
  //     this.productCategory, this.rowId, this.cType, this.cName);

  UpdateProductCategoryScreen(this.indexFetch, this.pCatList);

  @override
  State<StatefulWidget> createState() {
    // return _UpdateProductCategoryScreenState(
    //     this.productCategory, this.rowId, this.cType, this.cName);
    return _UpdateProductCategoryScreenState(this.indexFetch, this.pCatList);
  }
}

class _UpdateProductCategoryScreenState
    extends State<UpdateProductCategoryScreen> {
  final int indexFetch;
  final  List<ProductCategory> productCatList;

  // List<ProductCategory> pCatList = new List();

  _UpdateProductCategoryScreenState(this.indexFetch, this.productCatList);

  // _UpdateProductCategoryScreenState(
  //   this._productCategory,
  //   this.rowId,
  //   this._cType,
  //   this._cName,
  // );

  DatabaseHelper databaseHelper = DatabaseHelper();
  final _cNameController = TextEditingController();
  final _cCodeController = TextEditingController();
  final _cNameID = 1;
  final _cCodeID = 2;
  bool _cNameValidate = false;
  bool _cCodeValidate = false;
  String _cName;
  String _cCode;
  int _cType;
  int rowId;
  int proCatParentId;
  DataUpload dataUpload = new DataUpload();
  bool showspinnerlog = false;

  // List<String> mProdCatType = ['Primary', 'Grossa', 'Code39'];
  int count = 0;

  int mCatTypeValue;
  ProductCategory _productCategory;
  String mCatTypeValueName;
  bool error = false;
  PopupMenu _selectedMenu = productCategoryPopupMenu1[0];
  String labels;

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
    // productCatList = pCatList;
    print(productCatList);
    // selectedProPCatName = productCatList[indexFetch].pCategoryname;
    rowId = productCatList[indexFetch].catid;
    _cCodeController.text = productCatList[indexFetch].pParentCategoryName;
    _cNameController.text = productCatList[indexFetch].pCategoryname;
    proCatParentId = productCatList[indexFetch].pParentCategoryId;
  }

  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    // labels = _cName;
    // _cType =cType;

    var shortestSide = MediaQuery
        .of(context)
        .size
        .shortestSide;

    // _cNameController.text = _cName;
    // print("CTypeValue: $_cType");
    var screenOrien = MediaQuery
        .of(context)
        .orientation;
    double tabletwidth = MediaQuery
        .of(context)
        .size
        .width * (.60);
    double mobwidth = MediaQuery
        .of(context)
        .size
        .width;

    print('_UpdateProductCategoryScreenState');
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product Category"),
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

                          shortestSide < kTabletBreakpoint
                              ? TextField(
                            enabled: false,
                            controller: _cCodeController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Product Name',
                            ),
                          )
                              : Container(
                            width: tabletwidth,
                            child: TextField(
                              enabled: false,
                              controller: _cCodeController,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Product Name',
                              ),
                            ),
                          ),

                          // shortestSide < kTabletBreakpoint
                          //     ? DropdownSearch<ProductCategory>(
                          //         items: productCatList,
                          //         showClearButton: true,
                          //         showSearchBox: true,
                          //         label: 'Product Category*',
                          //         hint: "Select a Product Category",
                          //         autoValidateMode:
                          //             AutovalidateMode.onUserInteraction,
                          //         validator: (ProductCategory u) => u == null
                          //             ? "Product field is required "
                          //             : null,
                          //         onChanged: (ProductCategory data) {
                          //           // pProCatId = data.catid;
                          //           // pProCatName = data.pCategoryname.toString();
                          //           // pProCatParentId = data.pParentCategoryId;
                          //           // ppProCatParentName =
                          //           //     data.pParentCategoryName.toString();
                          //         },
                          //       )
                          //     : Container(
                          //         width: tabletwidth,
                          //         child: DropdownSearch<ProductCategory>(
                          //           items: productCatList,
                          //           showClearButton: true,
                          //           showSearchBox: true,
                          //           label: 'Product Category*',
                          //           hint: "Select a Product Category",
                          //           autoValidateMode:
                          //               AutovalidateMode.onUserInteraction,
                          //           validator: (ProductCategory u) => u == null
                          //               ? "Product field is required "
                          //               : null,
                          //           selectedItem: productCatList[indexFetch].pCategoryname,
                          //           onChanged: (ProductCategory data) {
                          //             print(data);
                          //             // pProCatId = data.catid;
                          //             // pProCatName = data.pCategoryname.toString();
                          //             // pProCatParentId = data.pParentCategoryId;
                          //             // ppProCatParentName =
                          //             //     data.pParentCategoryName.toString();
                          //           },
                          //         ),
                          //       ),
                          // _cType != 0
                          //     ? ProCatDropDownWidget.withValue(
                          //         productCatList,
                          //         _productCategory,
                          //         _getDropDownValue,
                          //         1,
                          //         .60,
                          //         _cType)
                          //     : ProCatDropDownWidget(productCatList,
                          //         _productCategory, _getDropDownValue, 1, .60),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              width: screenOrien == Orientation.portrait
                                  ? mobwidth
                                  : tabletwidth,
                              child: TextField(
                                controller: _cNameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelStyle: labelTextStyle,
                                    hintText: 'Enter a Category Name',
                                    errorText: _cNameValidate
                                        ? 'Field Can\'t Be Empty'
                                        : null),
                                onChanged: (value) => _cName = value,
                              ),
                            ),
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
                                  if (_cNameController.text.isEmpty) {
                                    error = true;
                                    _cNameValidate = true;
                                  } else {
                                    _cNameValidate = false;
                                  }
                                  bool errorCheck = (!_cNameValidate);

                                  if (errorCheck) {
                                    print('values: $mCatTypeValue');

                                    if (mCatTypeValue == null) {
                                      _saveToServer(0);
                                    } else {
                                      _saveToServer(mCatTypeValue);
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
                              height: 80.0,
                              child: Text(
                                'Update',
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

  // void moveToLastScreen() {
  //   Navigator.pop(context, true);
  // }

  void _saveToServer(int id) async {
    try {
      setState(() {
        showspinnerlog = true;
      });

      print('Update _saveToServer Call:');
      int result;

      // var idToString = await databaseHelper.getParentProductName(id);
      // if (id != null) {
      //   result = await databaseHelper.updateProductCategory(
      //       ProductCategory.withId(
      //           rowId, _cName, proCatParentId, _cCodeController.text.toString()));
      //   databaseHelper.getRepalceNameProductCat(rowId, _cName);
      //   print("rPlaceL:");
      // }

      // if (result != 0) {
      // final prodata = await dataUpload.upDateProCatData(rowId.toString(),
      //     _cName, proCatParentId.toString(), _cCodeController.text.toString());
      final prodata = await DataUpload().upDateProCatData(
          rowId.toString(),
              _cName, proCatParentId.toString(), _cCodeController.text.toString());
      int resid = prodata["resid"];
      String msg = prodata["message"];

      print(resid);
      if (resid == 200) {
        setState(() {
          showspinnerlog = false;
        });
        _showUploadDialog(msg, Colors.green);

        // Fluttertoast.showToast(
        //   msg: "Product category updated Successfully",
        //   toastLength: Toast.LENGTH_SHORT,
        //   backgroundColor: Colors.black38,
        //   textColor: Color(0xffffffff),
        //   gravity: ToastGravity.BOTTOM,
        // );

      } else {
        setState(() {
          showspinnerlog = false;
        });
        _showUploadDialog(msg, Colors.red);
        // _showAlertDialog('Status', 'Problem Saving to add product category');
      }

      // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      //   return ManageProductCategory();
      // }));
      // } else {
      // Failure

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
                    Navigator.pop(context, true);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _getDropDownValue(int value, String parentName, int _taxid,
      ProductCategory proCatValue) {
    print('Update Drop Call: $value');
    setState(() {
      switch (_taxid) {
        case 1:
          mCatTypeValue = value;
          print('value Value: $value');
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
