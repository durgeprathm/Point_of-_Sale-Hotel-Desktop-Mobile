import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/POS_Purchase_Insert.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/Adpater/pos_supplier_fetch.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/Purchase.dart';
import 'package:retailerp/models/purchase_model.dart';
import 'package:retailerp/models/sales_model.dart';
import 'package:retailerp/models/supplier.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/purchase_item_widget.dart';

import 'Add_Supliers.dart';
import 'Import_purchase.dart';
import 'Manage_Purchase.dart';
import 'Manage_Suppliers.dart';
import 'dashboard.dart';

class ReturnPurchaseNew extends StatefulWidget {
  @override
  _ReturnPurchaseNewState createState() => _ReturnPurchaseNewState();
}

class _ReturnPurchaseNewState extends State<ReturnPurchaseNew> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  PurchaseInsert purchaseinsert = new PurchaseInsert();

  @override
  void initState() {
    Provider.of<PurchaseModel>(context, listen: false).clear();
    _getSupplier();
    _getProducts();
  } //-------------------------------------------

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

  //-------------------------------------------
  List<Supplier> SupplierList = new List();
  List<String> CompanyName = new List();
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  int rowpro = 1;
  final format = DateFormat("yyyy-MM-dd");
  bool autoValidate = false;
  String Deactivateat;
  bool showResetIcon = false;
  bool readOnly = false;
  double temp;
  double gst;
  double tempsubtotal;
  int TempQty;
  double tempMiscellaneons;

  final _PCompanyNametext = TextEditingController();
  final _PDatetext = TextEditingController();
  final _pSubTotaltext = TextEditingController();
  final _pDiscounttext = TextEditingController();
  final _pgsttext = TextEditingController();
  final _pTotalAmounttext = TextEditingController();
  final _pMiscellaneonsController = TextEditingController();
  final pNarrationController = TextEditingController();

  bool _sComNamevalidate = false;
  bool _pDatevalidate = false;
  bool _pProNamevalidate = false;
  bool _pProRatevalidate = false;
  bool _pProGStvalidate = false;
  bool _pProQtyvalidate = false;
  bool _pProSubTotalvalidate = false;
  bool _pSubTotalvalidate = false;
  bool _pDiscountvalidate = false;
  bool _pGstvalidate = false;
  bool _pTotalAmountvalidate = false;

  int pProId;
  String pCompanyName;
  String pDate;
  String pProName;
  double pProRate;
  int pProGST;
  int pProQty;
  double pProSubTotal;
  double pSubTotal;
  double pDiscount;
  double pGst;
  double pMiscellaneons;
  double pTotalAmount;
  String pNarration;

  final _pProNametext = TextEditingController();
  final _pProRatetext = TextEditingController();
  final _pProGSTtext = TextEditingController();
  final _pProQtytext = TextEditingController();
  final _pProSubTotaltext = TextEditingController();

  final dateFormat = DateFormat("dd-MM-yyyy");
  final initialValue = DateTime.now();

  List<String> proNameList = new List();
  List<ProductModel> productList;
  bool showspinnerlog = false;

//---------------Tablet Mode Start-------------//
  Widget _buildTabletAddPurchase() {
    void handleClick(String value) {
      switch (value) {
        case 'Add Supplier':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddSupplierDetails()));
          break;
        case 'Manage Purchase':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Managepurchase()));
          break;
        case 'Import Purchase':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImportPurchase()));
          break;
        case 'Manage Suppliers':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ManageSuppliers()));
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
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text('Purchase Return'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Manage Purchase',
                'Import Purchase',
                'Add Supplier',
                'Manage Suppliers',
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
            child: Consumer<PurchaseModel>(builder: (context, cart, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  shape: Border.all(color: PrimaryColor, width: 2),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                child: DropdownSearch(
                                  items: CompanyName,
                                  label: "Supplier Company Name",
                                  onChanged: (value) {
                                    pCompanyName = value;
                                    print(pCompanyName);
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
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
                                    labelText: 'Purchase Date',
                                    errorText: _pDatevalidate
                                        ? 'Enter Purchase Date'
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
                                //             currentValue ?? DateTime.now(),
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
                                //       showResetIcon ? Icon(Icons.delete) : null,
                                //   readOnly: readOnly,
                                //   decoration: InputDecoration(
                                //     border: OutlineInputBorder(),
                                //     labelText: 'Purchase Date',
                                //     errorText: _pDatevalidate
                                //         ? 'Enter Purchase Date'
                                //         : null,
                                //   ),
                                // ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownSearch<ProductModel>(
                                  items: productList,
                                  showClearButton: true,
                                  showSearchBox: true,
                                  label: 'Product *',
                                  hint: "Select a Product",
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (ProductModel u) => u == null
                                      ? "Product field is required "
                                      : null,
                                  onChanged: (ProductModel data) {
                                    print(data);
                                    pProId = data.proId;
                                    pProName = data.proName.toString();
                                    _pProRatetext.text =
                                        data.proSellingPrice.toString();
                                    pProRate = data.proSellingPrice;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _pProRatetext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    pProRate = double.parse(value);
                                    if (pProQty != null &&
                                        pProRate != null &&
                                        pProGST != null) {
                                      temp = (pProRate * pProQty) +
                                          latestGSTAmount(pProRate,
                                              double.parse('$pProGST'));
                                      TempQty = int.parse(value);
                                      _pProSubTotaltext.text =
                                          temp.toStringAsFixed(2);
                                      pProSubTotal =
                                          double.parse(_pProSubTotaltext.text);
                                      latestTotalAmount();
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Product Rate',
                                    errorText: _pProRatevalidate
                                        ? 'Enter Product Rate'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _pProGSTtext,
                                  obscureText: false,
                                  onChanged: (value) async {
                                    pProGST = int.parse(value);

                                    if (pProQty != null && pProRate != null) {
                                      temp = (pProRate * pProQty) +
                                          latestGSTAmount(
                                              pProRate, double.parse(value));
                                      TempQty = int.parse(value);
                                      _pProSubTotaltext.text =
                                          temp.toStringAsFixed(2);
                                      pProSubTotal =
                                          double.parse(_pProSubTotaltext.text);
                                      latestTotalAmount();
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Including GST',
                                    errorText:
                                        _pProGStvalidate ? 'Enter GST' : null,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _pProQtytext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    pProQty = int.parse(value);

                                    if (pProGST != null) {
                                      temp = (pProRate * pProQty) +
                                          latestGSTAmount(pProRate,
                                              double.parse('$pProGST'));
                                      TempQty = int.parse(value);
                                      _pProSubTotaltext.text =
                                          temp.toStringAsFixed(2);
                                      pProSubTotal =
                                          double.parse(_pProSubTotaltext.text);
                                      latestTotalAmount();
                                    } else {
                                      temp = (pProRate * pProQty);
                                      TempQty = int.parse(value);
                                      _pProSubTotaltext.text = temp.toString();
                                      pProSubTotal =
                                          double.parse(_pProSubTotaltext.text);
                                      latestTotalAmount();
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Product Quantity',
                                    errorText: _pProQtyvalidate
                                        ? 'Enter Product Quntity'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _pProSubTotaltext,
                                  enabled: false,
                                  obscureText: false,
                                  onChanged: (value) {
                                    // pProSubTotal=double.parse(value);
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Product Subtotal',
                                    errorText: _pProSubTotalvalidate
                                        ? 'Enter Product Subtotal'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.plusCircle,
                                      color: PrimaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        print('Add Btn Call');
                                        print('ProductName: $pProName');

                                        // if (_pProNametext.text.isEmpty) {
                                        //   _pProNamevalidate = true;
                                        // } else {
                                        //   _pProNamevalidate = false;
                                        // }

                                        if (_pProRatetext.text.isEmpty) {
                                          _pProRatevalidate = true;
                                        } else if (_pProRatetext.text == 0) {
                                          _pProRatevalidate = true;
                                        } else {
                                          _pProRatevalidate = false;
                                        }

                                        if (_pProQtytext.text.isEmpty) {
                                          _pProQtyvalidate = true;
                                        } else if (_pProQtytext.text == 0) {
                                          _pProQtyvalidate = true;
                                        } else {
                                          _pProQtyvalidate = false;
                                        }

                                        bool errorCheck = (!pProName.isEmpty &&
                                            !_pProRatevalidate &&
                                            !_pProQtyvalidate);

                                        if (errorCheck) {
                                          final purProduct = PurchaseItem.cust(
                                              pProId,
                                              pProName,
                                              pProRate,
                                              pProGST,
                                              pProQty,
                                              pProSubTotal.toString());
                                          Provider.of<PurchaseModel>(context,
                                                  listen: false)
                                              .addPurchaseProduct(purProduct);
                                          _pSubTotaltext.text = cart.totalAmount
                                              .toStringAsFixed(2);
                                          latestTotalAmount();
                                          // _pProNametext.text = '';
                                          _pProRatetext.text = '';
                                          _pProQtytext.text = '';
                                          _pProSubTotaltext.text = '';
                                          _pProGSTtext.text = '';
                                          pProGST = 0;
                                          print("/////${cart.itemCount}");
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: "Check Product data!!!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            backgroundColor: Colors.black38,
                                            textColor: Color(0xffffffff),
                                            gravity: ToastGravity.BOTTOM,
                                          );
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Visibility(
                          visible: cart.itemCount == 0 ? false : true,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: tabletwidth,
                              height: tabletHeight,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: cart.itemCount,
                                  itemBuilder: (context, int index) {
                                    final cartItem = cart.pProduct[index];
                                    return PurchaseItemWidget(
                                        cartItem, latestSubTotalAmount);
                                  }),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                child: TextField(
                                  controller: _pSubTotaltext,
                                  obscureText: false,
                                  enabled: false,
                                  onChanged: (value) {
                                    latestTotalAmount();
                                    // pSubTotal = double.parse(value);
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Subtotal Amount',
                                    errorText: _pSubTotalvalidate
                                        ? 'Enter Product Subtotal Amount'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                child: TextField(
                                  controller: _pDiscounttext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    // pDiscount = double.parse(value);
                                    latestTotalAmount();
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Discount Amount',
                                    errorText: _pDiscountvalidate
                                        ? 'Enter Product Discount Amount'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 10.0),
                                  child: TextField(
                                    controller: _pgsttext,
                                    obscureText: false,
                                    onChanged: (value) {
                                      latestTotalAmount();
                                      // pGst = double.parse(value);
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'GST Amount',
                                      errorText: _pGstvalidate
                                          ? 'Enter Product GST Amount'
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                child: TextField(
                                  controller: _pMiscellaneonsController,
                                  obscureText: false,
                                  onChanged: (value) {
                                    latestTotalAmount();
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Miscellaneous Amount',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                child: TextField(
                                  enabled: false,
                                  controller: _pTotalAmounttext,
                                  obscureText: false,
                                  onChanged: (value) {
                                    pTotalAmount = double.parse(value);
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Total Amount',
                                    errorText: _pTotalAmountvalidate
                                        ? 'Enter Product Total Amount'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                child: TextField(
                                  controller: pNarrationController,
                                  obscureText: false,
                                  maxLines: 3,
                                  onChanged: (value) {
                                    pNarration = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Narration',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Material(
                            elevation: 5.0,
                            color: PrimaryColor,
                            borderRadius: BorderRadius.circular(10.0),
                            child: MaterialButton(
                              onPressed: () async {
                                // Respond to button press
                                _PDatetext.text.isEmpty
                                    ? _pDatevalidate = true
                                    : _pDatevalidate = false;

                                _pDiscounttext.text.isEmpty
                                    ? _pDiscounttext.text = '0'
                                    : _pDiscountvalidate = false;

                                // _pgsttext.text.isEmpty
                                //     ? _pgsttext.text = '0'
                                //     : _pGstvalidate = false;

                                _pMiscellaneonsController.text.isEmpty
                                    ? _pMiscellaneonsController.text = '0'
                                    : _pTotalAmountvalidate = false;

                                bool errorCheck = (!_pDatevalidate);

                                if (_pSubTotaltext.text.isEmpty ||
                                    _pSubTotaltext.text == 0) {
                                  Fluttertoast.showToast(
                                    msg: "Add Products",
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.black38,
                                    textColor: Color(0xffffffff),
                                    gravity: ToastGravity.BOTTOM,
                                  );
                                } else {
                                  if (errorCheck) {
                                    uploadData(cart);
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Select Date",
                                      toastLength: Toast.LENGTH_SHORT,
                                      backgroundColor: Colors.black38,
                                      textColor: Color(0xffffffff),
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                  }
                                }
                              },
                              minWidth: 150,
                              child: Text(
                                'Add Purchase',
                                style: btnHeadTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        })),
      ),
    );
  }

  Widget _buildMobileAddPurchase() {
    void handleClick(String value) {
      switch (value) {
        case 'Add Supplier':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddSupplierDetails()));
          break;
        case 'Manage Purchase':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Managepurchase()));
          break;
        case 'Import Purchase':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImportPurchase()));
          break;
        case 'Manage Suppliers':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ManageSuppliers()));
          break;
      }
    }

    double mobHeight = MediaQuery.of(context).size.height * (.30);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text('Purchase Return'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Manage Purchase',
                'Import Purchase',
                'Add Supplier',
                'Manage Suppliers',
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
            child: Consumer<PurchaseModel>(builder: (context, cart, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    DropdownSearch(
                      items: CompanyName,
                      label: "Supplier Company Name",
                      onChanged: (value) {
                        pCompanyName = value;
                        print(pCompanyName);
                      },
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
                        labelText: 'Purchase Date',
                        errorText:
                            _pDatevalidate ? 'Enter Purchase Date' : null,
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
                    //     labelText: 'Purchase Date',
                    //     errorText:
                    //         _pDatevalidate ? 'Enter Purchase Date' : null,
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
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
                        pProName = data.proName.toString();
                        _pProRatetext.text = data.proSellingPrice.toString();
                        pProRate = data.proSellingPrice;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _pProRatetext,
                            obscureText: false,
                            onChanged: (value) {
                              pProRate = double.parse(value);
                              if (pProQty != null &&
                                  pProRate != null &&
                                  pProGST != null) {
                                temp = (pProRate * pProQty) +
                                    latestGSTAmount(
                                        pProRate, double.parse('$pProGST'));
                                TempQty = int.parse(value);
                                _pProSubTotaltext.text =
                                    temp.toStringAsFixed(2);
                                pProSubTotal =
                                    double.parse(_pProSubTotaltext.text);
                                latestTotalAmount();
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Product Rate',
                              errorText: _pProRatevalidate
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
                            controller: _pProGSTtext,
                            obscureText: false,
                            onChanged: (value) async {
                              pProGST = int.parse(value);

                              if (pProQty != null && pProRate != null) {
                                temp = (pProRate * pProQty) +
                                    latestGSTAmount(
                                        pProRate, double.parse(value));
                                TempQty = int.parse(value);
                                _pProSubTotaltext.text =
                                    temp.toStringAsFixed(2);
                                pProSubTotal =
                                    double.parse(_pProSubTotaltext.text);
                                latestTotalAmount();
                              }
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
                          child: TextField(
                            controller: _pProQtytext,
                            obscureText: false,
                            onChanged: (value) {
                              pProQty = int.parse(value);

                              if (pProGST != null) {
                                temp = (pProRate * pProQty) +
                                    latestGSTAmount(
                                        pProRate, double.parse('$pProGST'));
                                TempQty = int.parse(value);
                                _pProSubTotaltext.text =
                                    temp.toStringAsFixed(2);
                                pProSubTotal =
                                    double.parse(_pProSubTotaltext.text);
                                latestTotalAmount();
                              } else {
                                temp = (pProRate * pProQty);
                                TempQty = int.parse(value);
                                _pProSubTotaltext.text =
                                    temp.toStringAsFixed(2);
                                pProSubTotal =
                                    double.parse(_pProSubTotaltext.text);
                                latestTotalAmount();
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Product Quantity',
                              errorText: _pProQtyvalidate
                                  ? 'Enter Product Quntity'
                                  : null,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _pProSubTotaltext,
                            enabled: false,
                            obscureText: false,
                            onChanged: (value) {
                              // pProSubTotal=double.parse(value);
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Product Subtotal',
                              errorText: _pProSubTotalvalidate
                                  ? 'Enter Product Subtotal'
                                  : null,
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
                              print('Add Btn Call');
                              print('ProductName: $pProName');

                              // if (_pProNametext.text.isEmpty) {
                              //   _pProNamevalidate = true;
                              // } else {
                              //   _pProNamevalidate = false;
                              // }

                              if (_pProRatetext.text.isEmpty) {
                                _pProRatevalidate = true;
                              } else if (_pProRatetext.text == 0) {
                                _pProRatevalidate = true;
                              } else {
                                _pProRatevalidate = false;
                              }

                              if (_pProQtytext.text.isEmpty) {
                                _pProQtyvalidate = true;
                              } else if (_pProQtytext.text == 0) {
                                _pProQtyvalidate = true;
                              } else {
                                _pProQtyvalidate = false;
                              }

                              bool errorCheck = (!pProName.isEmpty &&
                                  !_pProRatevalidate &&
                                  !_pProQtyvalidate);

                              if (errorCheck) {
                                final purProduct = PurchaseItem.cust(
                                    pProId,
                                    pProName,
                                    pProRate,
                                    pProGST,
                                    pProQty,
                                    pProSubTotal.toString());
                                Provider.of<PurchaseModel>(context,
                                        listen: false)
                                    .addPurchaseProduct(purProduct);
                                _pSubTotaltext.text =
                                    cart.totalAmount.toStringAsFixed(2);
                                latestTotalAmount();
                                // _pProNametext.text = '';
                                _pProRatetext.text = '';
                                _pProQtytext.text = '';
                                _pProSubTotaltext.text = '';
                                _pProGSTtext.text = '';
                                pProGST = 0;
                                print("/////${cart.itemCount}");
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Check Product data!!!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.black38,
                                  textColor: Color(0xffffffff),
                                  gravity: ToastGravity.BOTTOM,
                                );
                              }
                            });
                          },
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
                          height: mobHeight,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: cart.itemCount,
                              itemBuilder: (context, int index) {
                                final cartItem = cart.pProduct[index];
                                return PurchaseItemWidget(
                                    cartItem, latestSubTotalAmount);
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _pSubTotaltext,
                            obscureText: false,
                            enabled: false,
                            onChanged: (value) {
                              latestTotalAmount();
                              // pSubTotal = double.parse(value);
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Subtotal Amount',
                              errorText: _pSubTotalvalidate
                                  ? 'Enter Product Subtotal Amount'
                                  : null,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _pDiscounttext,
                            obscureText: false,
                            onChanged: (value) {
                              // pDiscount = double.parse(value);
                              latestTotalAmount();
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Discount Amount',
                              errorText: _pDiscountvalidate
                                  ? 'Enter Product Discount Amount'
                                  : null,
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
                          child: TextField(
                            controller: _pMiscellaneonsController,
                            obscureText: false,
                            onChanged: (value) {
                              latestTotalAmount();
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Miscellaneous Amount',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            enabled: false,
                            controller: _pTotalAmounttext,
                            obscureText: false,
                            onChanged: (value) {
                              pTotalAmount = double.parse(value);
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Total Amount',
                              errorText: _pTotalAmountvalidate
                                  ? 'Enter Product Total Amount'
                                  : null,
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
                          child: TextField(
                            controller: pNarrationController,
                            obscureText: false,
                            maxLines: 3,
                            onChanged: (value) {
                              pNarration = value;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Narration',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Material(
                      elevation: 5.0,
                      color: PrimaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      child: MaterialButton(
                        onPressed: () async {
                          // Respond to button press
                          _PDatetext.text.isEmpty
                              ? _pDatevalidate = true
                              : _pDatevalidate = false;

                          _pDiscounttext.text.isEmpty
                              ? _pDiscounttext.text = '0'
                              : _pDiscountvalidate = false;

                          // _pgsttext.text.isEmpty
                          //     ? _pgsttext.text = '0'
                          //     : _pGstvalidate = false;

                          _pMiscellaneonsController.text.isEmpty
                              ? _pMiscellaneonsController.text = '0'
                              : _pTotalAmountvalidate = false;

                          bool errorCheck = (!_pDatevalidate);

                          if (_pSubTotaltext.text.isEmpty ||
                              _pSubTotaltext.text == 0) {
                            Fluttertoast.showToast(
                              msg: "Add Products",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.black38,
                              textColor: Color(0xffffffff),
                              gravity: ToastGravity.BOTTOM,
                            );
                          } else {
                            if (errorCheck) {
                              uploadData(cart);
                            } else {
                              Fluttertoast.showToast(
                                msg: "Select Date",
                                toastLength: Toast.LENGTH_SHORT,
                                backgroundColor: Colors.black38,
                                textColor: Color(0xffffffff),
                                gravity: ToastGravity.BOTTOM,
                              );
                            }
                          }
                        },
                        minWidth: 150,
                        child: Text(
                          'Add Purchase',
                          style: btnHeadTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        })),
      ),
    );
  }

  void _getSupplier() async {
    SupplierFetch supplierfetch = new SupplierFetch();
    var supplierData = await supplierfetch.getSupplierFetch("1");
    print(supplierData);
    var resid = supplierData["resid"];

    if (resid == 200) {
      var suppliersd = supplierData["supplier"];
      List<Supplier> tempSupplier = [];
      for (var n in suppliersd) {
        Supplier pro = Supplier(
            int.parse(n["SupplierId"]),
            n["SupplierCustomername"],
            n["SupplierComapanyPersonName"],
            n["SupplierMobileNumber"],
            n["SupplierEmail"],
            n["SupplierAddress"],
            n["SupplierUdyogAadhar"],
            n["SupplierCINNumber"],
            n["SupplierGSTType"],
            n["SupplierGSTNumber"],
            n["SupplierFAXNumber"],
            n["SupplierPANNumber"],
            n["SupplierLicenseType"],
            n["SupplierLicenseName"],
            n["SupplierBankName"],
            n["SupplierBankBranch"],
            n["SupplierAccountType"],
            n["SupplierAccountNumber"],
            n["SupplierIFSCCode"],
            n["SupplierUPINumber"]);
        tempSupplier.add(pro);
      }
      setState(() {
        this.SupplierList = tempSupplier;
      });
      print("//////SalesList/////////$SupplierList.length");

      List<String> tempCompanyNames = [];
      for (int i = 0; i < SupplierList.length; i++) {
        tempCompanyNames.add(SupplierList[i].SupplierComapanyName);
      }
      setState(() {
        this.CompanyName = tempCompanyNames;
      });
      print(CompanyName);
    } else {}
  }

  void latestSubTotalAmount(double subTotalAmount) {
    _pSubTotaltext.text = subTotalAmount.toStringAsFixed(2);
    latestTotalAmount();
  }

  void latestTotalAmount() {
    setState(() {
      pSubTotal = double.parse(_pSubTotaltext.text);
      pDiscount = _pDiscounttext.text.isNotEmpty
          ? double.parse(_pDiscounttext.text)
          : 0;
      pGst = _pgsttext.text.isNotEmpty ? double.parse(_pgsttext.text) : 0;
      pMiscellaneons = _pMiscellaneonsController.text.isNotEmpty
          ? double.parse(_pMiscellaneonsController.text)
          : 0;

      double temp;

      temp = pSubTotal - pDiscount;
      temp = temp + pGst + pMiscellaneons;
      _pTotalAmounttext.text = temp.toString();
    });
  }

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

  void uploadData(cart) async {
    if (pCompanyName.isNotEmpty) {
      List<String> proIds = new List();
      List<String> proName = new List();
      List<String> proRate = new List();
      List<String> proQty = new List();
      List<String> proGst = new List();
      List<String> proProSubTotal = new List();
      List<PurchaseItem> pTempRecipeList = [];
      pTempRecipeList = cart.pProduct;

      pTempRecipeList.forEach((element) {
        proIds.add(element.Purchaseid.toString());
        proName.add(element.PurchaseProductName);
        proRate.add(element.PurchaseProductRate.toString());
        proGst.add(element.PurchaseGST.toString());
        proQty.add(element.PurchaseProductQty.toString());
        proProSubTotal.add(element.PurchaseProductSubTotal.toString());
      });

      String JoinedProductIds = proIds.join("#");
      String JoinedPurchaseProductName = proName.join("#");
      print(JoinedPurchaseProductName);
      String JoinedPurchaseProductRate = proRate.join("#");
      print(JoinedPurchaseProductRate);
      String JoinedProductGst = proGst.join("#");
      String JoinedPurchaseProductQty = proQty.join("#");
      print(JoinedPurchaseProductQty);
      String JoinedPurchaseProductSubTotal = proProSubTotal.join("#");
      print(JoinedPurchaseProductSubTotal);
      print(pCompanyName);
      print('Date: ${_PDatetext.text}');
      print(pSubTotal);
      print(pDiscount);
      print(pGst);
      print(pMiscellaneons);
      print(pNarration);

      // insert on server
      var result = await purchaseinsert.getReturnPurchaseInsertWithIds(
          JoinedProductIds,
          pCompanyName,
          _PDatetext.text.toString(),
          JoinedPurchaseProductName,
          JoinedPurchaseProductRate,
          JoinedProductGst,
          JoinedPurchaseProductQty,
          JoinedPurchaseProductSubTotal,
          pSubTotal.toString(),
          pDiscount.toString(),
          pMiscellaneons.toString(),
          _pTotalAmounttext.text.toString(),
          pNarration);
      if (result == null) {
        _showMyDialog('Filed !', Colors.red);
      } else {
        cart.clear();
        _pSubTotaltext.text = '';
        _pDiscounttext.text = '';
        _pgsttext.text = '';
        _pTotalAmounttext.text = '';
        _pMiscellaneonsController.text = '';
        pNarrationController.text = '';
        _showMyDialog('Data Successfully Save !', Colors.green);
      }
    } else {
      Fluttertoast.showToast(
        msg: "Select supplier company name",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
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
        productList.forEach((element) {
          proNameList.add(element.proName);
        });
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
