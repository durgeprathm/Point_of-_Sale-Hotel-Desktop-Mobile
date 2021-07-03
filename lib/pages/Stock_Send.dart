import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/pos_ProductNameStockTransfer_fetch.dart';
import 'package:retailerp/Adpater/pos_department_fetch.dart';
import 'package:retailerp/Adpater/pos_stocktransfer_insert.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/EhotelModel/StockTransfer.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/models/Department.dart';
import 'package:retailerp/models/product_recipe_model.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/StockTransfer_item_widget.dart';
import 'package:retailerp/widgets/mobile_cart_item.dart';
import 'package:retailerp/widgets/stock_send_mobile_cart_item.dart';

import 'Import_sales.dart';
import 'Manage_Sales.dart';
import 'dashboard.dart';

class StockSend extends StatefulWidget {
  @override
  _StockSendState createState() => _StockSendState();
}

class _StockSendState extends State<StockSend> {
  static const int kTabletBreakpoint = 552;
  bool showspinnerlog = false;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileStockSend();
    } else {
      content = _buildTabletStockSend();
    }

    return content;
  }

  @override
  void initState() {
    final DateTime now = DateTime.now();
    final String formatted = format.format(now);
    _StockDatetext.text = formatted;
    Provider.of<StockTranferProvider>(context, listen: false).clear();
    _getCustomer();
    _getProductName();
  }

  StockTransferInsert stocktranfer = new StockTransferInsert();

  // List<ProductRecipeModel> ProductNameList = new List();
  List<Department> departmentList = new List();

  // List<String> ProductName = new List();

  // List<String> DepartmentName = new List();

  List<ProductRecipeModel> productList = [];
  bool supListVisibility = false;
  @override
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  final format = DateFormat("yyyy-MM-dd");
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;

  int rowpro = 1;
  final _StockDatetext = TextEditingController();
  final _StockNarrationtext = TextEditingController();
  final _StockDeparmenttext = TextEditingController();

  bool _StockDatevalidate = false;
  bool _StockProNamevalidate = false;
  bool _StockProQtyvalidate = false;
  bool _StockDepartmentvalidate = false;

  String StockDepartmentId;
  String StockDepartmentName;
  String StockProName;
  int StockProQty;
  String StockNarration;
  String StockDate;
  int TempQty;

  List<String> LocalProductName = new List();
  List<int> LocalProductQty = new List();
  final _StockProNametext = TextEditingController();
  final _StockProQtytext = TextEditingController();

  String PProId;
  String PProName;
  double PProQty;

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletStockSend() {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    void handleClick(String value) {
      switch (value) {
        case 'Manage Stock':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ManageSales()));
          break;
        case 'Add Department':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ImportSales()));

          break;
      }
    }

    double tabletwidth = MediaQuery.of(context).size.width * (.90);
    double tabletHeight = MediaQuery.of(context).size.height * (.35);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.share),
            SizedBox(
              width: 20.0,
            ),
            Text('Send Stock'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return RetailerHomePage();
              }));
            },
          ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Manage Stock',
                'Add Department',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: showspinnerlog,
        child: SingleChildScrollView(
          child:
              Consumer<StockTranferProvider>(builder: (context, cart, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DropdownSearch<Department>(
                              items: departmentList,
                              showClearButton: true,
                              showSearchBox: true,
                              label: 'Department Name',
                              hint: "Select Department Name",
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (data) {
                                if (data != null) {
                                  StockDepartmentName = data.DepartmentName;
                                  StockDepartmentId =
                                      data.DepartmentId.toString();
                                } else {
                                  StockDepartmentName = null;
                                  StockDepartmentId = null;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: DateTimeField(
                              controller: _StockDatetext,
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
                                labelText: 'Stock Transfer Date',
                                errorText: _StockDatevalidate
                                    ? 'Enter Stock Transfer Date'
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownSearch<ProductRecipeModel>(
                              items: productList,
                              showClearButton: true,
                              showSearchBox: true,
                              label: 'Product Name',
                              hint: "Select a Product",
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (data) {
                                if (data != null) {
                                  StockProName = data.proName;
                                  PProId = data.id.toString();
                                } else {
                                  StockProName = null;
                                  PProId = null;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _StockProQtytext,
                              obscureText: false,
                              onChanged: (value) async {
                                StockProQty = int.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Product Quntity',
                                errorText: _StockProQtyvalidate
                                    ? 'Enter Product Quntity'
                                    : null,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.plusCircle,
                                  color: PrimaryColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    // print('Add Btn Call');
                                    // print('ProductName: $pProName');

                                    if (_StockProNametext.text.isEmpty) {
                                      _StockProNamevalidate = true;
                                    } else if (_StockProQtytext.text == 0) {
                                      _StockProQtyvalidate = true;
                                    } else {
                                      _StockProQtyvalidate = false;
                                    }

                                    bool errorCheck = (!StockProName.isEmpty &&
                                        !_StockProQtyvalidate);

                                    print('Product Name: $StockProName');
                                    print('Product Qty: $StockProQty');

                                    if (errorCheck) {
                                      print('Product PProId: $PProId');
                                      print('Product Qty: $StockProQty');

                                      final stockTranferProduct =
                                          StockTranfer.custWithId(
                                        PProId,
                                        StockProName,
                                        StockProQty.toString(),
                                      );
                                      Provider.of<StockTranferProvider>(context,
                                              listen: false)
                                          .addStockTranfer(stockTranferProduct);

                                      _StockProNametext.text = '';
                                      _StockProQtytext.text = '';
                                      StockProName = null;
                                      // print("/////${cart.itemCount}");
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Check Product data!!!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        backgroundColor: PrimaryColor,
                                        textColor: Color(0xffffffff),
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                    }
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: cart.itemCount == 0 ? false : true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: tabletHeight,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: cart.itemCount,
                                itemBuilder: (context, int index) {
                                  final cartItem = cart.pStockTranfer[index];
                                  return StockTranferItemWidget(
                                      cartItem, index);
                                }),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _StockNarrationtext,
                              obscureText: false,
                              maxLines: 3,
                              onChanged: (value) {
                                StockNarration = value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Narration',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: InkWell(
                              child: Container(
                                width: ScreenUtil.getInstance().setWidth(250),
                                height: ScreenUtil.getInstance().setHeight(180),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    PrimaryColor,
                                    PrimaryColor,
                                  ]),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () async {
                                      setState(() {
                                        _StockDatetext.text.isEmpty
                                            ? _StockDatevalidate = true
                                            : _StockDatevalidate = false;

                                        bool errorCheck = !_StockDatevalidate;
                                        if (errorCheck) {
                                          if (cart.itemCount != 0) {
                                            uploadData(cart);
                                          } else {
                                            Fluttertoast.showToast(
                                              msg: "Select Product data!!!",
                                              toastLength: Toast.LENGTH_SHORT,
                                              backgroundColor: PrimaryColor,
                                              textColor: Color(0xffffffff),
                                              gravity: ToastGravity.BOTTOM,
                                            );
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: "Check Date !!!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            backgroundColor: PrimaryColor,
                                            textColor: Color(0xffffffff),
                                            gravity: ToastGravity.BOTTOM,
                                          );
                                        }
                                      });
                                    },
                                    child: Center(
                                      child: Text("SEND",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 20,
                                              letterSpacing: 1.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  //--------Tablet Mode End-------------//

  //---------Mobile View-------------------//
  Widget _buildMobileStockSend() {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    void handleClick(String value) {
      switch (value) {
        case 'Manage Stock':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ManageSales()));
          break;
        case 'Add Department':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ImportSales()));

          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.share),
            SizedBox(
              width: 20.0,
            ),
            Text('Send Stock'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return RetailerHomePage();
              }));
            },
          ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Manage Stock',
                'Add Department',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Consumer<StockTranferProvider>(builder: (context, cart, child) {
            return Column(children: [
              SizedBox(
                height: 10.0,
              ),
              DropdownSearch<Department>(
                items: departmentList,
                showClearButton: true,
                showSearchBox: true,
                label: 'Department Name',
                hint: "Select Department Name",
                autoValidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (data) {
                  if (data != null) {
                    StockDepartmentName = data.DepartmentName;
                    StockDepartmentId = data.DepartmentId.toString();
                  } else {
                    StockDepartmentName = null;
                    StockDepartmentId = null;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                // child: TextField(
                //   controller: _SDatetext,
                //   obscureText: false,
                //   onChanged: (value) {
                //     SDate=value;
                //   },
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     labelText: 'Sale Date',
                //     errorText: _SDatevalidate ? 'Enter Sale Date' : null,
                //   ),
                // ),
                child: DateTimeField(
                  controller: _StockDatetext,
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
                    labelText: 'Stock Transfer Date',
                    errorText:
                        _StockDatevalidate ? 'Enter Stock Transfer Date' : null,
                  ),
                ),
              ),
              //-------------------------------------------------------

              Row(
                children: [
                  Expanded(
                    child: DropdownSearch<ProductRecipeModel>(
                      items: productList,
                      showClearButton: true,
                      showSearchBox: true,
                      label: 'Product Name',
                      hint: "Select a Product",
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (data) {
                        if (data != null) {
                          StockProName = data.proName;
                          PProId = data.id.toString();
                        } else {
                          StockProName = null;
                          PProId = null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _StockProQtytext,
                      obscureText: false,
                      onChanged: (value) {
                        PProQty = double.parse(value);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Product Quantity',
                        errorText:
                            _StockProQtyvalidate ? 'Product Quantity' : null,
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
                        if (_StockProQtytext.text.isEmpty) {
                          _StockProQtyvalidate = true;
                        } else if (_StockProQtytext.text == 0) {
                          _StockProQtyvalidate = true;
                        } else {
                          _StockProQtyvalidate = false;
                        }

                        bool errorCheck = (!_StockProQtyvalidate);

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
                            final recips = StockTranfer.custWithId(
                                PProId, PProName, PProQty.toStringAsFixed(2));
                            Provider.of<StockTranferProvider>(context,
                                    listen: false)
                                .addStockTranfer(recips);
                            print("/////${cart.itemCount}");
                            supListVisibility = true;
                            _StockProQtytext.text = '';
                            PProQty = null;
                            PProName = '';
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

              Visibility(
                visible: cart.itemCount == 0 ? false : true,
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: cart.itemCount,
                          itemBuilder: (context, int index) {
                            final cartItem = cart.pStockTranfer[index];
                            return StockSendMobileCartItem(cartItem);
                          }),
                    ),
                  ],
                ),
              ),

              // Container(
              //   height: 300.0,
              //   child: ListView.builder(
              //       itemCount: rowpro,
              //       shrinkWrap: true,
              //       scrollDirection: Axis.vertical,
              //       itemBuilder: (context, index) {
              //         // _StockProNametext.add(new TextEditingController());
              //         // _StockProQtytext.add(new TextEditingController());
              //
              //         return Padding(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 20.0, vertical: 10.0),
              //           child: Material(
              //             //shape: Border.all(color: Colors.blueGrey, width: 5),
              //             child: Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Column(
              //                 children: [
              //                   Container(
              //                     child: Row(
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       children: [
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: Text(
              //                             "Product   ${index + 1} ",
              //                             style: TextStyle(
              //                               fontWeight: FontWeight.bold,
              //                               fontSize: 20.0,
              //                               color: Colors.white,
              //                             ),
              //                           ),
              //                         ),
              //                         SizedBox(
              //                           width: 50.0,
              //                         ),
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: IconButton(
              //                             onPressed: () {
              //                               setState(() {
              //                                 if (rowpro != 1) {
              //                                   rowpro--;
              //                                 }
              //                               });
              //                             },
              //                             icon: FaIcon(
              //                               FontAwesomeIcons.trash,
              //                               color: Colors.white,
              //                             ),
              //                           ),
              //                         ),
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: IconButton(
              //                             onPressed: () {
              //                               setState(() {
              //                                 if (StockProName == null ||
              //                                     StockProQty == null) {
              //                                   _StockProNametext
              //                                           .text
              //                                           .isEmpty
              //                                       ? _StockProNamevalidate =
              //                                           true
              //                                       : _StockProNamevalidate =
              //                                           false;
              //                                   _StockProQtytext
              //                                           .text
              //                                           .isEmpty
              //                                       ? _StockProQtyvalidate =
              //                                           true
              //                                       : _StockProQtyvalidate =
              //                                           false;
              //                                 } else {
              //                                   LocalProductName.add(
              //                                       StockProName);
              //                                   LocalProductQty.add(
              //                                       StockProQty);
              //                                   rowpro++;
              //
              //                                   print(
              //                                       "///////PRODUCTNAME////////$LocalProductName");
              //                                   print(
              //                                       "///////PRODUCTQTY////////$LocalProductQty");
              //                                 }
              //                               });
              //                             },
              //                             icon: FaIcon(
              //                               FontAwesomeIcons.plus,
              //                               color: Colors.white,
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                     color: Colors.blue,
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: TextField(
              //                       controller: _StockProNametext,
              //                       obscureText: false,
              //                       onChanged: (value) {
              //                         StockProName = value;
              //                       },
              //                       decoration: InputDecoration(
              //                         border: OutlineInputBorder(),
              //                         labelText: 'Product Name',
              //                         errorText: _StockProNamevalidate
              //                             ? 'Enter Product Name'
              //                             : null,
              //                       ),
              //                     ),
              //                   ),
              //                   Row(
              //                     children: [
              //                       Expanded(
              //                         child: Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: TextField(
              //                             controller: _StockProQtytext,
              //                             obscureText: false,
              //                             keyboardType: TextInputType.number,
              //                             onChanged: (value) {
              //                               StockProQty = int.parse(value);
              //                             },
              //                             decoration: InputDecoration(
              //                               border: OutlineInputBorder(),
              //                               labelText: 'Quantity',
              //                               errorText: _StockProQtyvalidate
              //                                   ? 'Enter Product Quantity'
              //                                   : null,
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             elevation: 10.0,
              //           ),
              //         );
              //       }),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _StockNarrationtext,
                  obscureText: false,
                  maxLines: 3,
                  onChanged: (value) {
                    StockNarration = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Narration',
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      width: ScreenUtil.getInstance().setWidth(330),
                      height: ScreenUtil.getInstance().setHeight(100),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          PrimaryColor,
                          PrimaryColor,
                        ]),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Material(
                        color: PrimaryColor,
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              uploadData(cart);
                              // if (StockDepartmentName == null ||
                              //     StockDate == null) {
                              //   _StockDatetext.text.isEmpty
                              //       ? _StockDatevalidate = true
                              //       : _StockDatevalidate = false;
                              //   _StockDeparmenttext.text.isEmpty
                              //       ? _StockDepartmentvalidate = true
                              //       : _StockDepartmentvalidate = false;
                              // } else {
                              //   List<String> proId = new List();
                              //   List<String> proName = new List();
                              //   List<String> proQty = new List();
                              //
                              //   var pTempRecipeList = cart.pStockTranfer;
                              //
                              //   pTempRecipeList.forEach((element) {
                              //     proId.add(element.StockTranferProductId);
                              //     proName.add(element.StockTranferProductName);
                              //     proQty.add(element.StockTranferProductQty
                              //         .toString());
                              //   });
                              //   String JoinedProductId = proId.join("#");
                              //   String JoinedProductName = proName.join("#");
                              //   print(JoinedProductName);
                              //   String JoinedProductQty = proQty.join("#");
                              //   print(JoinedProductQty);
                              //   print(StockDepartmentName);
                              //   print(StockDate);
                              //   print(LocalProductName);
                              //   print(LocalProductQty);
                              //   var result =
                              //       stocktranfer.getStockTransferInsert(
                              //           StockDepartmentName,
                              //           StockDate,
                              //           JoinedProductId,
                              //           JoinedProductName,
                              //           JoinedProductQty,
                              //           StockNarration);
                              //   if (result == null) {
                              //     _showMyDialog('Filed !', Colors.red);
                              //   } else {
                              //     _showMyDialog(
                              //         'Data Successfully Save !', Colors.green);
                              //   }
                              // }
                            });
                          },
                          child: Center(
                            child: Text("SEND",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 18,
                                    letterSpacing: 1.0)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(60),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Material(
                  color: PRODUCTRATEBG,
                  borderRadius: BorderRadius.circular(10.0),
                  child: MaterialButton(
                    onPressed: () {},
                    minWidth: 100.0,
                    height: 35.0,
                    child: Text(
                      'Send',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ]);
          }),
        ),
      ),
    );
  }

//---------Mobile View End-------------------//

  void uploadData(cart) async {
    setState(() {
      showspinnerlog = true;
    });
    if (StockDepartmentName.isNotEmpty) {
      List<String> TempStockTransferProductID = new List();
      List<String> TempStockTransferProductName = new List();
      List<String> TempStockTransferProductQuntity = new List();

      List<StockTranfer> pTempRecipeList = [];
      pTempRecipeList = cart.pStockTranfer;

      pTempRecipeList.forEach((element) {
        TempStockTransferProductID.add(element.StockTranferProductId);
        TempStockTransferProductName.add(element.StockTranferProductName);
        TempStockTransferProductQuntity.add(element.StockTranferProductQty);
      });

      String JoinedProductId = TempStockTransferProductID.join("#");
      String JoinedProductName = TempStockTransferProductName.join("#");
      print(JoinedProductName);
      String JoinedProductQty = TempStockTransferProductQuntity.join("#");
      print(JoinedProductQty);
      print(StockDepartmentName);
      print(StockNarration);
      var result = await stocktranfer.getStockTransferInsert(
          StockDepartmentId,
          _StockDatetext.text.toString(),
          JoinedProductId,
          JoinedProductName,
          JoinedProductQty,
          StockNarration);
      if (result == null) {
        setState(() {
          showspinnerlog = false;
        });
        _showMyDialog('Filed !', Colors.red);
      } else {
        int resid = result['resid'];
        if (resid == 200) {
          setState(() {
            showspinnerlog = false;
          });
          String msg = result["message"];
          Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: PrimaryColor,
            textColor: Color(0xffffffff),
            gravity: ToastGravity.BOTTOM,
          );
          cart.clear();
          // StockDepartmentName = null;
          // StockDepartmentId = null;
          StockNarration = null;
          _StockNarrationtext.text = '';
          // pNarrationController.text = '';
          // _showMyDialog('Data Successfully Save !', Colors.green);
        } else {
          setState(() {
            showspinnerlog = false;
          });
          // _showMyDialog('Filed !', Colors.red);
          String msg = result["message"];
          Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: PrimaryColor,
            textColor: Color(0xffffffff),
            gravity: ToastGravity.BOTTOM,
          );
        }
      }
    } else {
      setState(() {
        showspinnerlog = false;
      });
      Fluttertoast.showToast(
        msg: "Select Stock Department Name",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

//from server customer From data base
  void _getCustomer() async {
    setState(() {
      showspinnerlog = true;
    });
    DepartmentFetch departmentfetch = new DepartmentFetch();
    var departmentData = await departmentfetch.getDepartmentFetch("1");
    int resid = departmentData["resid"];

    if (resid == 200) {
      var Departmentsd = departmentData["department"];
      print(Departmentsd.length);
      List<Department> tempDepartment = [];
      for (var n in Departmentsd) {
        Department pro = Department(
          int.parse(n["DepartmentId"]),
          n["DepartmentName"],
          n["DepartmentNarration"],
        );
        tempDepartment.add(pro);
      }
      setState(() {
        this.departmentList = tempDepartment;
        showspinnerlog = false;
      });
      print("//////SalesList/////////$departmentList.length");
    } else {
      setState(() {
        showspinnerlog = false;
      });
      String msg = departmentData["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }

    // List<String> tempCustomerNames = [];
    // for (int i = 0; i < departmentList.length; i++) {
    //   tempCustomerNames.add(departmentList[i].DepartmentName);
    // }
    // setState(() {
    //   this.DepartmentName = tempCustomerNames;
    // });
    // print(DepartmentName);
  }

//-------------------------------------
//--------insert popup Start-------------------------------
  Future<void> _showMyDialog(String msg, Color col) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
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
                },
              ),
            ],
          ),
        );
      },
    );
  }

//---------------------------------------

//from server customer From data base
  void _getProductName() async {
    setState(() {
      showspinnerlog = true;
    });
    ProductNameStockTransferFetch productnamestocktransferfetch =
        new ProductNameStockTransferFetch();
    var productnamestocktransferfetchData = await productnamestocktransferfetch
        .getProductNameStockTransferFetch("1");
    var resid = productnamestocktransferfetchData["resid"];

    if (resid == 200) {
      var productnamestocktransferfetchsd =
          productnamestocktransferfetchData["product"];
      //print(productnamestocktransferfetchsd.length);
      List<ProductModel> tempProductName = [];
      List<ProductRecipeModel> tempProductNames = [];
      for (var n in productnamestocktransferfetchsd) {
        ProductRecipeModel item =
            ProductRecipeModel(id: n['ProductId'], proName: n['ProductName']);
        tempProductNames.add(item);
      }
      setState(() {
        // this.ProductNameList = tempProductName;
        productList = tempProductNames;
        showspinnerlog = false;
      });
    } else {
      setState(() {
        showspinnerlog = false;
      });
      String msg = productnamestocktransferfetchData["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }

    // List<String> tempProductsNames = [];
    // for (int i = 0; i < ProductNameList.length; i++) {
    //   tempProductsNames.add(ProductNameList[i].proName);
    // }
    // setState(() {
    //   this.ProductName = tempProductsNames;
    // });
    // print(ProductName);
  }

//-------------------------------------

}
