import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/models/menu.dart';
import 'package:retailerp/models/menu_model.dart';
import 'package:retailerp/models/product_recipe_model.dart';
import 'package:retailerp/providers/data_upload.dart';
import 'package:retailerp/providers/recipe.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/widgets/mobile_edit_menu_item.dart';

class EditMenuScreenNew extends StatefulWidget {
  EditMenuScreenNew(this.indexFetch, this.menuList);

  @override
  final int indexFetch;
  List<Menu> menuList = new List();

  _EditMenuScreenNewState createState() =>
      _EditMenuScreenNewState(this.indexFetch, this.menuList);
}

class _EditMenuScreenNewState extends State<EditMenuScreenNew> {
  final int indexFetch;
  List<Menu> menuList = new List();

  _EditMenuScreenNewState(this.indexFetch, this.menuList);

  static const int kTabletBreakpoint = 552;

  int pProGST;
  String pRowMenuId;
  List<ProductRecipeModel> productList = [];
  List<RecipeItems> pTempRecipeList = [];

  List<MenuModel> menuCatList = [];

  bool autoValidate = false;
  String Deactivateat;
  bool showResetIcon = false;
  bool readOnly = false;
  double temp;
  int gst;
  double tempsubtotal;
  int TempQty;

  bool _PMenuCatNamevalidate = false;
  bool _pProNamevalidate = false;
  bool _PProQtyvalidate = false;
  bool _recipeNamevalidate = false;
  bool _recipeAmountvalidate = false;
  bool _pProGStvalidate = false;

  String PProId;
  String pProName;
  double PProQty;

  String pMenuId;
  String pMenuName;
  String pEditMenuId;
  String pEditMenuName;

  bool editMenuCatCheck = false;

  // final _menuCatNametext = TextEditingController();
  final _recipeNametext = TextEditingController();
  final _amounttext = TextEditingController();
  final _pProNametext = TextEditingController();
  final _PProQtytext = TextEditingController();
  final _pProGSTtext = TextEditingController();
  final _menuCategorytext = TextEditingController();

  var tempProductId, tempProductName, tempProductGst, tempProductQTY;
  DataUpload dataUpload = new DataUpload();

  bool visAddBtn = false;
  bool visSaveBtn = false;
  bool visProDropDown = false;
  bool visProTextField = false;

  RecipeItems recipeItem;

  void initState() {
    setState(() {
      visAddBtn = true;
      visProDropDown = true;
      pRowMenuId = menuList[indexFetch].id;
      pMenuId = menuList[indexFetch].menucategoryId;
      pMenuName = menuList[indexFetch].menucategory;
      _menuCategorytext.text = menuList[indexFetch].menucategory;
      _recipeNametext.text = menuList[indexFetch].menuName;
      _amounttext.text = menuList[indexFetch].menuRate.toString();
      _pProGSTtext.text = menuList[indexFetch].menuGst.toString();
      pProGST = int.tryParse(menuList[indexFetch].menuGst) ?? 0;
    });
    getDatas();
    getMenuDatas();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    // print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      // content = _buildMobileAddPurchase();
    } else {
      content = _buildTabletAddPurchase();
    }
    return content;
  }

  Widget _buildTabletAddPurchase() {
    double tabletwidth = MediaQuery.of(context).size.width * (.44);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit Menu'),
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Consumer<Recipe>(builder: (context, cart, child) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _menuCategorytext,
                          obscureText: false,
                          enabled: false,
                          onChanged: (value) {},
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Menu Category *',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.edit,
                          color: PrimaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _showAddMenuCatDialog();
                          });
                        },
                      ),
                      Expanded(
                        child: TextField(
                          controller: _recipeNametext,
                          obscureText: false,
                          onChanged: (value) {},
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Menu Name *',
                            errorText: _recipeNamevalidate
                                ? 'Enter Recipe Name'
                                : null,
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
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _pProGSTtext,
                          obscureText: false,
                          onChanged: (value) async {
                            pProGST = int.parse(value);
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
                    height: 20,
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

                          bool errorCheck =
                              (!_recipeNamevalidate && !_recipeAmountvalidate);

                          if (errorCheck && pMenuId != null) {
                            _uploadMenuData(cart);
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
                      height: 40.0,
                      child: Text(
                        'Edit Menu',
                        style: btnTextStyle,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  // Widget _buildMobileAddPurchase() {
  //   double mobHeight = MediaQuery.of(context).size.height * (.30);
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     appBar: AppBar(
  //       title: Text('Update Recipe'),
  //       actions: [
  //         IconButton(
  //           icon: Icon(Icons.home, color: Colors.white),
  //           onPressed: () {
  //             Navigator.popUntil(
  //                 context, ModalRoute.withName(Navigator.defaultRouteName));
  //           },
  //         ),
  //       ],
  //     ),
  //     body: SafeArea(
  //       child: SingleChildScrollView(
  //         child: GestureDetector(
  //           onTap: () {
  //             FocusScope.of(context).requestFocus(new FocusNode());
  //           },
  //           child: Padding(
  //             padding: const EdgeInsets.all(15.0),
  //             child: Consumer<Recipe>(builder: (context, cart, child) {
  //               return Column(
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                         child: TextField(
  //                           controller: _menuCatNametext,
  //                           obscureText: false,
  //                           enabled: false,
  //                           onChanged: (value) {},
  //                           keyboardType: TextInputType.text,
  //                           decoration: InputDecoration(
  //                             border: OutlineInputBorder(),
  //                             labelText: 'Menu Category',
  //                           ),
  //                         ),
  //                         // DropdownSearch<MenuModel>(
  //                         //   items: menuCatList,
  //                         //   mode: Mode.BOTTOM_SHEET,
  //                         //   isFilteredOnline: true,
  //                         //   showClearButton: true,
  //                         //   showSearchBox: true,
  //                         //   label: 'Menu Name *',
  //                         //   autoValidateMode:
  //                         //       AutovalidateMode.onUserInteraction,
  //                         //   validator: (MenuModel u) => u == null
  //                         //       ? "menu name field is required "
  //                         //       : null,
  //                         //   // onFind: (String filter) => getDatas(),
  //                         //   onChanged: (MenuModel data) {
  //                         //     pMenuName = data.proName;
  //                         //     pMenuId = data.id;
  //                         //   },
  //                         // ),
  //                       ),
  //                       // IconButton(
  //                       //   icon: FaIcon(
  //                       //     FontAwesomeIcons.plusCircle,
  //                       //     color: PrimaryColor,
  //                       //   ),
  //                       //   onPressed: () {
  //                       //     setState(() {
  //                       //       _showAddMenuCatDialog();
  //                       //     });
  //                       //   },
  //                       // ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   // TextField(
  //                   //   controller: _recipeNametext,
  //                   //   obscureText: false,
  //                   //   onChanged: (value) {},
  //                   //   keyboardType: TextInputType.text,
  //                   //   decoration: InputDecoration(
  //                   //     border: OutlineInputBorder(),
  //                   //     labelText: 'Recipe Name *',
  //                   //     errorText:
  //                   //         _recipeNamevalidate ? 'Enter Recipe Name' : null,
  //                   //   ),
  //                   // ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                         child: TextField(
  //                           controller: _amounttext,
  //                           obscureText: false,
  //                           onChanged: (value) {},
  //                           keyboardType: TextInputType.number,
  //                           decoration: InputDecoration(
  //                             border: OutlineInputBorder(),
  //                             labelText: 'Amount *',
  //                             errorText:
  //                                 _recipeAmountvalidate ? 'Enter Amount' : null,
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: 15,
  //                       ),
  //                       Expanded(
  //                         child: TextField(
  //                           controller: _pProGSTtext,
  //                           obscureText: false,
  //                           onChanged: (value) async {
  //                             pProGST = int.parse(value);
  //                             // if (_amounttext.text != null) {
  //                             //   latestGSTAmount(double.parse(_amounttext.text),
  //                             //       double.parse(value));
  //                             // }
  //                           },
  //                           keyboardType: TextInputType.number,
  //                           decoration: InputDecoration(
  //                             border: OutlineInputBorder(),
  //                             labelText: 'Including GST',
  //                             errorText: _pProGStvalidate ? 'Enter GST' : null,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   // Row(
  //                   //   children: [
  //                   //     Visibility(
  //                   //       visible: visProDropDown,
  //                   //       child: Expanded(
  //                   //         child: DropdownSearch<ProductRecipeModel>(
  //                   //           items: productList,
  //                   //           mode: Mode.BOTTOM_SHEET,
  //                   //           isFilteredOnline: true,
  //                   //           showClearButton: true,
  //                   //           showSearchBox: true,
  //                   //           label: 'Product Name *',
  //                   //           autoValidateMode:
  //                   //               AutovalidateMode.onUserInteraction,
  //                   //           validator: (ProductRecipeModel u) => u == null
  //                   //               ? "product name field is required "
  //                   //               : null,
  //                   //           onChanged: (ProductRecipeModel data) {
  //                   //             pProName = data.proName;
  //                   //             PProId = data.id;
  //                   //           },
  //                   //         ),
  //                   //       ),
  //                   //     ),
  //                   //     Visibility(
  //                   //       visible: visProTextField,
  //                   //       child: Expanded(
  //                   //         child: Padding(
  //                   //           padding: const EdgeInsets.all(8.0),
  //                   //           child: TextField(
  //                   //             enabled: false,
  //                   //             controller: _pProNametext,
  //                   //             obscureText: false,
  //                   //             onChanged: (value) {
  //                   //               pProName = value;
  //                   //             },
  //                   //             decoration: InputDecoration(
  //                   //               border: OutlineInputBorder(),
  //                   //               labelText: 'Product Name',
  //                   //               errorText: _pProNamevalidate
  //                   //                   ? 'Enter Product Name'
  //                   //                   : null,
  //                   //             ),
  //                   //           ),
  //                   //         ),
  //                   //       ),
  //                   //     ),
  //                   //     SizedBox(
  //                   //       width: 15,
  //                   //     ),
  //                   //     Expanded(
  //                   //       child: TextField(
  //                   //         controller: _PProQtytext,
  //                   //         obscureText: false,
  //                   //         onChanged: (value) {
  //                   //           PProQty = double.parse(value);
  //                   //         },
  //                   //         keyboardType: TextInputType.number,
  //                   //         decoration: InputDecoration(
  //                   //           border: OutlineInputBorder(),
  //                   //           labelText: 'Product Quantity',
  //                   //           errorText:
  //                   //               _PProQtyvalidate ? 'Product Quantity' : null,
  //                   //         ),
  //                   //       ),
  //                   //     ),
  //                   //     Row(
  //                   //       children: [
  //                   //         Visibility(
  //                   //           visible: visSaveBtn,
  //                   //           child: Padding(
  //                   //             padding: const EdgeInsets.all(0.0),
  //                   //             child: IconButton(
  //                   //               icon: FaIcon(
  //                   //                 FontAwesomeIcons.save,
  //                   //                 color: Colors.green,
  //                   //               ),
  //                   //               onPressed: () {
  //                   //                 setState(() {
  //                   //                   if (_PProQtytext.text.isEmpty) {
  //                   //                     _PProQtyvalidate = true;
  //                   //                   } else if (_PProQtytext.text == 0) {
  //                   //                     _PProQtyvalidate = true;
  //                   //                   } else {
  //                   //                     _PProQtyvalidate = false;
  //                   //                   }
  //                   //
  //                   //                   bool errorCheck = (!_PProQtyvalidate);
  //                   //
  //                   //                   if (_pProNametext.text == null) {
  //                   //                     Fluttertoast.showToast(
  //                   //                       msg: "Select Product Name",
  //                   //                       toastLength: Toast.LENGTH_SHORT,
  //                   //                       backgroundColor: Colors.black38,
  //                   //                       textColor: Color(0xffffffff),
  //                   //                       gravity: ToastGravity.BOTTOM,
  //                   //                     );
  //                   //                   } else {
  //                   //                     if (errorCheck) {
  //                   //                       final recips =
  //                   //                           // RecipeItems(PProId, pProName, PProQty);
  //                   //                           Provider.of<Recipe>(context,
  //                   //                                   listen: false)
  //                   //                               .updateRecipeItems(
  //                   //                                   int.parse(PProId),
  //                   //                                   _pProNametext.text,
  //                   //                                   double.parse(
  //                   //                                       _PProQtytext.text),
  //                   //                                   recipeItem);
  //                   //
  //                   //                       pProName = '';
  //                   //                       _pProNametext.text = '';
  //                   //                       _PProQtytext.text = '';
  //                   //
  //                   //                       visAddBtn = true;
  //                   //                       visProDropDown = true;
  //                   //                       visSaveBtn = false;
  //                   //                       visProTextField = false;
  //                   //                       print("/////${cart.itemCount}");
  //                   //                     }
  //                   //                   }
  //                   //                 });
  //                   //               },
  //                   //             ),
  //                   //           ),
  //                   //         ),
  //                   //         Visibility(
  //                   //           visible: visAddBtn,
  //                   //           child: IconButton(
  //                   //             icon: FaIcon(
  //                   //               FontAwesomeIcons.plusCircle,
  //                   //               color: PrimaryColor,
  //                   //             ),
  //                   //             onPressed: () {
  //                   //               setState(() {
  //                   //                 if (_PProQtytext.text.isEmpty) {
  //                   //                   _PProQtyvalidate = true;
  //                   //                 } else if (_PProQtytext.text == 0) {
  //                   //                   _PProQtyvalidate = true;
  //                   //                 } else {
  //                   //                   _PProQtyvalidate = false;
  //                   //                 }
  //                   //
  //                   //                 bool errorCheck = (!_PProQtyvalidate);
  //                   //
  //                   //                 if (pProName == null) {
  //                   //                   Fluttertoast.showToast(
  //                   //                     msg: "Select Product Name",
  //                   //                     toastLength: Toast.LENGTH_SHORT,
  //                   //                     backgroundColor: Colors.black38,
  //                   //                     textColor: Color(0xffffffff),
  //                   //                     gravity: ToastGravity.BOTTOM,
  //                   //                   );
  //                   //                 } else {
  //                   //                   if (errorCheck) {
  //                   //                     final recips = RecipeItems(
  //                   //                         PProId, pProName, PProQty);
  //                   //                     Provider.of<Recipe>(context,
  //                   //                             listen: false)
  //                   //                         .addRecipeItems(recips);
  //                   //                     print("/////${cart.itemCount}");
  //                   //
  //                   //                     _pProNametext.text = '';
  //                   //                     _PProQtytext.text = '';
  //                   //                   }
  //                   //                 }
  //                   //               });
  //                   //             },
  //                   //           ),
  //                   //         ),
  //                   //       ],
  //                   //     ),
  //                   //   ],
  //                   // ),
  //                   SizedBox(
  //                     height: 15,
  //                   ),
  //                   Container(
  //                     height: mobHeight,
  //                     child: ListView.builder(
  //                         shrinkWrap: true,
  //                         scrollDirection: Axis.vertical,
  //                         itemCount: cart.itemCount,
  //                         itemBuilder: (context, int index) {
  //                           final cartItem = cart.products[index];
  //                           return MobileEditMenuItem(cartItem, getMenuItems);
  //                         }),
  //                   ),
  //                   SizedBox(
  //                     height: 20,
  //                   ),
  //                   Material(
  //                     elevation: 5.0,
  //                     color: PrimaryColor,
  //                     borderRadius: BorderRadius.circular(15.0),
  //                     child: MaterialButton(
  //                       onPressed: () async {
  //                         setState(() {
  //                           if (_recipeNametext.text.isEmpty) {
  //                             _recipeNamevalidate = true;
  //                           } else {
  //                             _recipeNamevalidate = false;
  //                           }
  //                           if (_amounttext.text.isEmpty) {
  //                             _recipeAmountvalidate = true;
  //                           } else {
  //                             _recipeAmountvalidate = false;
  //                           }
  //
  //                           bool errorCheck = (!_recipeNamevalidate &&
  //                               !_recipeAmountvalidate);
  //
  //                           if (errorCheck && pMenuName != null) {
  //                             if (cart.itemCount != 0) {
  //                               print('Uploaf Datta Call');
  //                               _uploadMenuData(cart);
  //                             } else {
  //                               Fluttertoast.showToast(
  //                                 msg: "Add product and quantity",
  //                                 toastLength: Toast.LENGTH_SHORT,
  //                                 backgroundColor: Colors.black38,
  //                                 textColor: Color(0xffffffff),
  //                                 gravity: ToastGravity.BOTTOM,
  //                               );
  //                             }
  //                           } else {
  //                             Fluttertoast.showToast(
  //                               msg:
  //                                   "Fill all the * Marked fileds Before Proceeding!!!",
  //                               toastLength: Toast.LENGTH_SHORT,
  //                               backgroundColor: Colors.black38,
  //                               textColor: Color(0xffffffff),
  //                               gravity: ToastGravity.BOTTOM,
  //                             );
  //                           }
  //                         });
  //                       },
  //                       minWidth: 150,
  //                       height: 25.0,
  //                       child: Text(
  //                         'Update Recipe',
  //                         style: btnTextStyle,
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                 ],
  //               );
  //             }),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  getDatas() async {
    var map = new Map<String, dynamic>();
    map['ProductId'] = '1';

    String apifile = 'Fetch_Product.php';
    NetworkHelper networkHelper =
        new NetworkHelper(apiname: apifile, data: map);
    var purchasedata = await networkHelper.getData();
    print('purchasedata: ${purchasedata}');

    // var productJson = jsonDecode(purchasedata)['product'];
    var resID = purchasedata["resid"];
    print(resID);

    if (resID == 200) {
      var productkList = purchasedata['product'];

      for (var n in productkList) {
        ProductRecipeModel item =
            ProductRecipeModel(id: n['ProductId'], proName: n['ProductName']);
        productList.add(item);
      }
    } else {
      // return null;
    }
  }

  Future<void> _showAddMenuCatDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: AlertDialog(
              title: Text('Edit Menu Category'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                      controller: _menuCategorytext,
                      autofocus: true,
                      enabled: false,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Menu Category Name",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DropdownSearch<MenuModel>(
                      items: menuCatList,
                      mode: Mode.MENU,
                      isFilteredOnline: true,
                      showClearButton: true,
                      showSearchBox: true,
                      label: 'Menu Category *',
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (MenuModel u) =>
                          u == null ? "menu Category field is required " : null,
                      // onFind: (String filter) => getDatas(),
                      onChanged: (MenuModel data) {
                        if (data != null) {
                          pEditMenuName = data.proName;
                          pEditMenuId = data.id;
                        } else {
                          pEditMenuName = null;
                          pEditMenuId = null;
                        }
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
                  child: Text('Save'),
                  onPressed: () async {
                    setState(() {
                      bool errorCheck = (pEditMenuName != null);
                      if (errorCheck) {
                        // _saveMenuCatData();

                        setState(() {
                          _menuCategorytext.text = pEditMenuName;
                          editMenuCatCheck = true;
                        });
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
      menuCatList.clear();
      for (var n in productkList) {
        MenuModel item = MenuModel(
            id: n['MenucategioresId'], proName: n['Menucategioresname']);
        menuCatList.add(item);
      }
    } else {
      // return null;
    }
  }

  void getMenuItems(String proId, String proName, double proRate, recipeItems) {
    print('${proName}');
    PProId = proId.toString();
    _pProNametext.text = proName;
    _PProQtytext.text = proRate.toString();
    setState(() {
      visAddBtn = false;
      visProDropDown = false;
      visSaveBtn = true;
      visProTextField = true;
      recipeItem = recipeItems;
    });
  }

  void _uploadMenuData(Recipe cart) async {
    // List<String> proId = new List();
    // List<String> proName = new List();
    // List<String> proQty = new List();
    //
    // pTempRecipeList = cart.products;
    //
    // pTempRecipeList.forEach((element) {
    //   proId.add(element.id);
    //   proName.add(element.title);
    //   proQty.add(element.quantity.toString());
    // });
    //
    // String proIds = proId.join("#");
    // String proNames = proName.join("#");
    // String proQtys = proQty.join("#");

    final menudata = await dataUpload.uploadUpdateMenuData(
        pRowMenuId,
        _recipeNametext.text.toString(),
        '',
        '',
        '',
        editMenuCatCheck == true ? pEditMenuId : pMenuId,
        _amounttext.text.toString(),
        pProGST.toString());

    var resid = menudata["resid"];
    print('Upload menudata: ${resid}');
    if (resid == 200) {

      Fluttertoast.showToast(
        msg: "Recipe Save Successfully",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.pop(context, true);

    } else {
    }
  }
}
