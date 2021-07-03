import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/fetch_menuList.dart';
import 'package:retailerp/Adpater/pos_customer-fetch.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/LocalDbModels/customer_model.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/models/menu.dart';
import 'package:retailerp/models/sales_model.dart';
import 'package:retailerp/pages/sale_billing_new.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/sales_item_widget.dart';

import 'Import_sales.dart';
import 'Manage_Sales.dart';

class AddSalesNew extends StatefulWidget {
  @override
  _AddSalesNewState createState() => _AddSalesNewState();
}

class _AddSalesNewState extends State<AddSalesNew> {
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    // print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileAddSalesNew();
    } else {
      content = _buildTabletAddSalesNew();
    }

    return content;
  }

  @override
  void initState() {
    final DateTime now = DateTime.now();
    final String formatted = format.format(now);
    _PDatetext.text = formatted;

    Provider.of<SalesModel>(context, listen: false).clear();
    _getCustomer();
    // _getProducts();
    _getMenu();
  }

  List<CustomerModel> customerList = new List();
  List<Menu> menuList = [];

  // List<String> customerName = new List();
  // List<String> proNameList = new List();
  List<ProductModel> productList;
  ProductModel _productModel;
  bool showspinnerlog = false;

  @override
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

  // double tempMiscellaneons;

  final _PCompanyNametext = TextEditingController();
  final _PDatetext = TextEditingController();
  final _pSubTotaltext = TextEditingController();
  final _pDiscounttext = TextEditingController();
  final _pgsttext = TextEditingController();
  final _pTotalAmounttext = TextEditingController();

  // final _pMiscellaneonsController = TextEditingController();
  final pNarrationController = TextEditingController();

  bool _sCustomervalidate = false;
  bool _pDatevalidate = false;
  bool _pmenuNamevalidate = false;
  bool _pmenuRatevalidate = false;
  bool _pmenuGStvalidate = false;
  bool _pmenuQtyvalidate = false;
  bool _pmenuSubTotalvalidate = false;
  bool _pSubTotalvalidate = false;
  bool _pDiscountvalidate = false;
  bool _pGstvalidate = false;
  bool _pTotalAmountvalidate = false;

  String sCustomerId;
  String sCustomerName;
  String sCustomerMob;
  String pDate;
  int pmenuId;
  String pmenuName;
  double pmenuRate;
  int pmenuGST;
  int pmenuQty;
  double pmenuSubTotal;
  double pSubTotal;
  double pDiscount;
  double pGst;

  // double pMiscellaneons;
  double pTotalAmount;
  String pNarration;

  final _pmenuNametext = TextEditingController();
  final _pmenuRatetext = TextEditingController();
  final _pmenuGSTtext = TextEditingController();
  final _pmenuQtytext = TextEditingController();
  final _pmenuSubTotaltext = TextEditingController();

  final dateFormat = DateFormat("dd-MM-yyyy");
  final initialValue = DateTime.now();

  Widget _buildTabletAddSalesNew() {
    void handleClick(String value) {
      switch (value) {
        case 'Manage Sales':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ManageSales()));
          break;
        case 'Import Sales':
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
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text(
              'Sales Voucher',
              style: appBarTitleTextStyle,
            ),
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
                'Manage Sales',
                'Import Sales',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: dashboadrNavTextStyle,
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ModalProgressHUD(
          inAsyncCall: showspinnerlog,
          child: SingleChildScrollView(
              child: Consumer<SalesModel>(builder: (context, cart, child) {
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownSearch<CustomerModel>(
                                    isFilteredOnline: true,
                                    showClearButton: true,
                                    showSearchBox: true,
                                    items: customerList,
                                    label: "Customer Name",
                                    autoValidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      if (value != null) {
                                        sCustomerName = value.custName;
                                        sCustomerId = value.custId.toString();
                                        sCustomerMob =
                                            value.custMobileNo.toString();
                                      } else {
                                        sCustomerName = null;
                                        sCustomerId = null;
                                        sCustomerMob = null;
                                      }
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
                                    style: labelTextStyle,
                                    validator: (date) =>
                                        date == null ? 'Invalid date' : null,
                                    onChanged: (date) => setState(() {}),
                                    onSaved: (date) => setState(() {
                                      value = date;
                                      print('Selected value Date: $value');
                                      savedCount++;
                                    }),
                                    resetIcon: showResetIcon
                                        ? Icon(Icons.delete)
                                        : null,
                                    readOnly: readOnly,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Sales Date',
                                      errorText: _pDatevalidate
                                          ? 'Enter Sales Date'
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownSearch<Menu>(
                                    items: menuList,
                                    showClearButton: true,
                                    showSearchBox: true,
                                    label: 'Menu *',
                                    hint: "Select a Menu",
                                    autoValidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (Menu u) => u == null
                                        ? "Menu field is required "
                                        : null,
                                    onChanged: (data) {
                                      if (data != null) {
                                        print(data);
                                        pmenuId = int.parse(data.id);
                                        pmenuName = data.menuName.toString();
                                        _pmenuRatetext.text =
                                            data.menuRate.toString();
                                        _pmenuGSTtext.text =
                                            data.menuGst.toString();
                                        pmenuRate = double.parse(data.menuRate);
                                        pmenuGST = int.parse(data.menuGst);
                                      } else {
                                        print(data);
                                        pmenuId = null;
                                        pmenuName = null;
                                        _pmenuRatetext.text = '';
                                        _pmenuGSTtext.text = '';
                                        pmenuRate = null;
                                        pmenuGST = null;
                                      }
                                    },
                                  ),

                                  // TextField(
                                  //   controller: _pProNametext,
                                  //   obscureText: false,
                                  //   onChanged: (value) {
                                  //     pProName = value;
                                  //   },
                                  //   decoration: InputDecoration(
                                  //     border: OutlineInputBorder(),
                                  //     labelText: 'Product Name',
                                  //     errorText: _pProNamevalidate
                                  //         ? 'Enter Product Name'
                                  //         : null,
                                  //   ),
                                  // ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _pmenuRatetext,
                                    obscureText: false,
                                    onChanged: (value) {
                                      pmenuRate = double.parse(value);
                                      if (pmenuQty != null &&
                                          pmenuRate != null &&
                                          pmenuGST != null) {
                                        temp = (pmenuRate * pmenuQty) +
                                            latestGSTAmount(pmenuRate,
                                                double.parse('$pmenuGST'));
                                        TempQty = int.parse(value);
                                        _pmenuSubTotaltext.text =
                                            temp.toStringAsFixed(2);
                                        pmenuSubTotal = double.parse(
                                            _pmenuSubTotaltext.text);
                                        latestTotalAmount();
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Product Rate',
                                      errorText: _pmenuRatevalidate
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
                                    controller: _pmenuGSTtext,
                                    obscureText: false,
                                    onChanged: (value) async {
                                      pmenuGST = int.parse(value);

                                      if (pmenuQty != null &&
                                          pmenuRate != null) {
                                        temp = (pmenuRate * pmenuQty) +
                                            latestGSTAmount(
                                                pmenuRate, double.parse(value));
                                        TempQty = int.parse(value);
                                        _pmenuSubTotaltext.text =
                                            temp.toStringAsFixed(2);
                                        pmenuSubTotal = double.parse(
                                            _pmenuSubTotaltext.text);
                                        latestTotalAmount();
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Including GST',
                                      errorText: _pmenuGStvalidate
                                          ? 'Enter GST'
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _pmenuQtytext,
                                    obscureText: false,
                                    onChanged: (value) {
                                      pmenuQty = int.parse(value);

                                      if (pmenuGST != null) {
                                        temp = (pmenuRate * pmenuQty) +
                                            latestGSTAmount(pmenuRate,
                                                double.parse('$pmenuGST'));
                                        TempQty = int.parse(value);
                                        _pmenuSubTotaltext.text =
                                            temp.toStringAsFixed(2);
                                        pmenuSubTotal = double.parse(
                                            _pmenuSubTotaltext.text);
                                        latestTotalAmount();
                                      } else {
                                        temp = (pmenuRate * pmenuQty);
                                        TempQty = int.parse(value);
                                        _pmenuSubTotaltext.text =
                                            temp.toStringAsFixed(2);
                                        pmenuSubTotal = double.parse(
                                            _pmenuSubTotaltext.text);
                                        latestTotalAmount();
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Product Quantity',
                                      errorText: _pmenuQtyvalidate
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
                                    controller: _pmenuSubTotaltext,
                                    // enabled: false,
                                    obscureText: false,
                                    onChanged: (value) {
                                      // pProSubTotal=double.parse(value);
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Product Subtotal',
                                      errorText: _pmenuSubTotalvalidate
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
                                          print('ProductName: $pmenuName');

                                          // if (_pmenuNametext.text.isEmpty) {
                                          //   _pmenuNamevalidate = true;
                                          // } else {
                                          //   _pmenuNamevalidate = false;
                                          // }

                                          if (_pmenuRatetext.text.isEmpty) {
                                            _pmenuRatevalidate = true;
                                          } else if (_pmenuRatetext.text == 0) {
                                            _pmenuRatevalidate = true;
                                          } else {
                                            _pmenuRatevalidate = false;
                                          }

                                          if (_pmenuQtytext.text.isEmpty) {
                                            _pmenuQtyvalidate = true;
                                          } else if (_pmenuQtytext.text == 0) {
                                            _pmenuQtyvalidate = true;
                                          } else {
                                            _pmenuQtyvalidate = false;
                                          }

                                          bool errorCheck =
                                              (!pmenuName.isEmpty &&
                                                  !_pmenuRatevalidate &&
                                                  !_pmenuQtyvalidate);

                                          print('menuductName: $pmenuName');
                                          print('pmenuRate: $pmenuRate');
                                          print('menuductName: $pmenuQty');
                                          print(
                                              'pmenuSubTotal: $pmenuSubTotal');

                                          if (errorCheck) {
                                            print('menuductName: $pmenuName');
                                            print('pmenuRate: $pmenuRate');
                                            print('menuductName: $pmenuQty');
                                            print(
                                                'pmenuSubTotal: $pmenuSubTotal');

                                            if (_pmenuGSTtext.text.isEmpty) {
                                              pmenuGST = 0;
                                            }

                                            final salesmenuduct =
                                                SalesItem.cust(
                                                    pmenuId,
                                                    pmenuName,
                                                    pmenuRate,
                                                    pmenuQty,
                                                    pmenuSubTotal.toString(),
                                                    pmenuGST);
                                            Provider.of<SalesModel>(context,
                                                    listen: false)
                                                .addSalesProduct(salesmenuduct);
                                            _pSubTotaltext.text =
                                                cart.totalAmount.toString();
                                            latestTotalAmount();
                                            // _pProNametext.text = '';
                                            _pmenuRatetext.text = '';
                                            _pmenuQtytext.text = '';
                                            _pmenuSubTotaltext.text = '';
                                            _pmenuGSTtext.text = '';
                                            pmenuGST = 0;
                                            print("/////${cart.itemCount}");
                                          } else {
                                            Fluttertoast.showToast(
                                              msg: "Check menuduct data!!!",
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
                                      final cartItem = cart.pSales[index];
                                      return SalesItemWidget(
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
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             vertical: 20.0, horizontal: 10.0),
                          //         child: TextField(
                          //           controller: _pgsttext,
                          //           obscureText: false,
                          //           onChanged: (value) {
                          //             latestTotalAmount();
                          //             // pGst = double.parse(value);
                          //           },
                          //           keyboardType: TextInputType.number,
                          //           decoration: InputDecoration(
                          //             border: OutlineInputBorder(),
                          //             labelText: 'GST Amount',
                          //             errorText: _pGstvalidate
                          //                 ? 'Enter Product GST Amount'
                          //                 : null,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     Expanded(
                          //       child: Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             vertical: 20.0, horizontal: 10.0),
                          //         child: TextField(
                          //           enabled: false,
                          //           controller: _pTotalAmounttext,
                          //           obscureText: false,
                          //           onChanged: (value) {
                          //             pTotalAmount = double.parse(value);
                          //           },
                          //           keyboardType: TextInputType.number,
                          //           decoration: InputDecoration(
                          //             border: OutlineInputBorder(),
                          //             labelText: 'Total Amount',
                          //             errorText: _pTotalAmountvalidate
                          //                 ? 'Enter Product Total Amount'
                          //                 : null,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
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
                                  setState(() {
                                    _PDatetext.text.isEmpty
                                        ? _pDatevalidate = true
                                        : _pDatevalidate = false;

                                    _pDiscounttext.text.isEmpty
                                        ? _pDiscounttext.text = '0'
                                        : _pDiscountvalidate = false;

                                    _pgsttext.text.isEmpty
                                        ? _pgsttext.text = '0'
                                        : _pGstvalidate = false;

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
                                  });
                                },
                                minWidth: 150,
                                child: Text(
                                  'PAYMENT',
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
      ),
    );
  }

  Widget _buildMobileAddSalesNew() {
    void handleClick(String value) {
      switch (value) {
        case 'Manage Sales':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ManageSales()));
          break;
        case 'Import Sales':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ImportSales()));

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
            Text('Sales Vochure'),
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
                'Manage Sales',
                'Import Sales',
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ModalProgressHUD(
          inAsyncCall: showspinnerlog,
          child: SingleChildScrollView(
              child: Consumer<SalesModel>(builder: (context, cart, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      DropdownSearch<CustomerModel>(
                        isFilteredOnline: true,
                        showClearButton: true,
                        showSearchBox: true,
                        items: customerList,
                        label: "Customer Name",
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) {
                          if (value != null) {
                            sCustomerName = value.custName;
                            sCustomerId = value.custId.toString();
                            sCustomerMob = value.custMobileNo.toString();
                          } else {
                            sCustomerName = null;
                            sCustomerId = null;
                            sCustomerMob = null;
                          }
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
                          labelText: 'Sales Date',
                          errorText: _pDatevalidate ? 'Enter Sales Date' : null,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownSearch<Menu>(
                        items: menuList,
                        showClearButton: true,
                        showSearchBox: true,
                        label: 'Menu *',
                        hint: "Select a Menu",
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (Menu u) =>
                            u == null ? "Menu field is required " : null,
                        onChanged: (data) {
                          if (data != null) {
                            print(data);
                            pmenuId = int.parse(data.id);
                            pmenuName = data.menuName.toString();
                            _pmenuRatetext.text = data.menuRate.toString();
                            _pmenuGSTtext.text = data.menuGst.toString();
                            pmenuRate = double.parse(data.menuRate);
                            pmenuGST = int.parse(data.menuGst);
                          } else {
                            print(data);
                            pmenuId = null;
                            pmenuName = null;
                            _pmenuRatetext.text = '';
                            _pmenuGSTtext.text = '';
                            pmenuRate = null;
                            pmenuGST = null;
                          }
                        },
                      ),
                      // DropdownSearch<ProductModel>(
                      //   items: productList,
                      //   showClearButton: true,
                      //   showSearchBox: true,
                      //   label: 'Product *',
                      //   hint: "Select a Product",
                      //   autoValidateMode: AutovalidateMode.onUserInteraction,
                      //   validator: (ProductModel u) =>
                      //       u == null ? "Product field is required " : null,
                      //   onChanged: (ProductModel data) {
                      //     print(data);
                      //     pmenuId = data.proId;
                      //     pmenuName = data.proName.toString();
                      //     _pmenuRatetext.text = data.proSellingPrice.toString();
                      //     pmenuRate = data.proSellingPrice;
                      //   },
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _pmenuRatetext,
                              obscureText: false,
                              onChanged: (value) {
                                pmenuRate = double.parse(value);
                                if (pmenuQty != null &&
                                    pmenuRate != null &&
                                    pmenuGST != null) {
                                  temp = (pmenuRate * pmenuQty) +
                                      latestGSTAmount(
                                          pmenuRate, double.parse('$pmenuGST'));
                                  TempQty = int.parse(value);
                                  _pmenuSubTotaltext.text =
                                      temp.toStringAsFixed(2);
                                  pmenuSubTotal =
                                      double.parse(_pmenuSubTotaltext.text);
                                  latestTotalAmount();
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'menu Rate',
                                errorText: _pmenuRatevalidate
                                    ? 'Enter menu Rate'
                                    : null,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _pmenuGSTtext,
                              obscureText: false,
                              onChanged: (value) async {
                                pmenuGST = int.parse(value);

                                if (pmenuQty != null && pmenuRate != null) {
                                  temp = (pmenuRate * pmenuQty) +
                                      latestGSTAmount(
                                          pmenuRate, double.parse(value));
                                  TempQty = int.parse(value);
                                  _pmenuSubTotaltext.text =
                                      temp.toStringAsFixed(2);
                                  pmenuSubTotal =
                                      double.parse(_pmenuSubTotaltext.text);
                                  latestTotalAmount();
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Including GST',
                                errorText:
                                    _pmenuGStvalidate ? 'Enter GST' : null,
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
                              controller: _pmenuQtytext,
                              obscureText: false,
                              onChanged: (value) {
                                pmenuQty = int.parse(value);

                                if (pmenuGST != null) {
                                  temp = (pmenuRate * pmenuQty) +
                                      latestGSTAmount(
                                          pmenuRate, double.parse('$pmenuGST'));
                                  TempQty = int.parse(value);
                                  _pmenuSubTotaltext.text =
                                      temp.toStringAsFixed(2);
                                  pmenuSubTotal =
                                      double.parse(_pmenuSubTotaltext.text);
                                  latestTotalAmount();
                                } else {
                                  temp = (pmenuRate * pmenuQty);
                                  TempQty = int.parse(value);
                                  _pmenuSubTotaltext.text = temp.toStringAsFixed(2);
                                  pmenuSubTotal =
                                      double.parse(_pmenuSubTotaltext.text);
                                  latestTotalAmount();
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'menu Quantity',
                                errorText: _pmenuQtyvalidate
                                    ? 'Enter menu Quntity'
                                    : null,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _pmenuSubTotaltext,
                              // enabled: false,
                              obscureText: false,
                              onChanged: (value) {
                                // pmenuSubTotal=double.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'menu Subtotal',
                                errorText: _pmenuSubTotalvalidate
                                    ? 'Enter menu Subtotal'
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
                                    print('Add Btn Call');
                                    print('menuName: $pmenuName');

                                    // if (_pmenuNametext.text.isEmpty) {
                                    //   _pmenuNamevalidate = true;
                                    // } else {
                                    //   _pmenuNamevalidate = false;
                                    // }

                                    if (_pmenuRatetext.text.isEmpty) {
                                      _pmenuRatevalidate = true;
                                    } else if (_pmenuRatetext.text == 0) {
                                      _pmenuRatevalidate = true;
                                    } else {
                                      _pmenuRatevalidate = false;
                                    }

                                    if (_pmenuQtytext.text.isEmpty) {
                                      _pmenuQtyvalidate = true;
                                    } else if (_pmenuQtytext.text == 0) {
                                      _pmenuQtyvalidate = true;
                                    } else {
                                      _pmenuQtyvalidate = false;
                                    }

                                    bool errorCheck = (!pmenuName.isEmpty &&
                                        !_pmenuRatevalidate &&
                                        !_pmenuQtyvalidate);

                                    print('menudName: $pmenuName');
                                    print('pmenuRate: $pmenuRate');
                                    print('menudName: $pmenuQty');
                                    print('pmenuSubTotal: $pmenuSubTotal');

                                    if (errorCheck) {
                                      print('menudName: $pmenuName');
                                      print('pmenuRate: $pmenuRate');
                                      print('menuName: $pmenuQty');
                                      print('pmenuSubTotal: $pmenuSubTotal');

                                      if (_pmenuGSTtext.text.isEmpty) {
                                        pmenuGST = 0;
                                      }

                                      final salesmenuduct = SalesItem.cust(
                                          pmenuId,
                                          pmenuName,
                                          pmenuRate,
                                          pmenuQty,
                                          pmenuSubTotal.toString(),
                                          pmenuGST);
                                      Provider.of<SalesModel>(context,
                                              listen: false)
                                          .addSalesProduct(salesmenuduct);
                                      _pSubTotaltext.text =
                                          cart.totalAmount.toString();
                                      latestTotalAmount();
                                      // _pmenuNametext.text = '';
                                      _pmenuRatetext.text = '';
                                      _pmenuQtytext.text = '';
                                      _pmenuSubTotaltext.text = '';
                                      _pmenuGSTtext.text = '';
                                      pmenuGST = 0;
                                      print("/////${cart.itemCount}");
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Check menu data!!!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        backgroundColor: Colors.black38,
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
                        child: Container(
                          // width: tabletwidth,
                          height: mobHeight,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: cart.itemCount,
                              itemBuilder: (context, int index) {
                                final cartItem = cart.pSales[index];
                                return SalesItemWidget(
                                    cartItem, latestSubTotalAmount);
                              }),
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
                              onChanged: (value) {
                                latestTotalAmount();
                                // pSubTotal = double.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Subtotal Amount',
                                errorText: _pSubTotalvalidate
                                    ? 'Enter menu Subtotal Amount'
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
                                    ? 'Enter menu Discount Amount'
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
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
                              ? 'Enter menu Total Amount'
                              : null,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
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
                      SizedBox(
                        height: 10,
                      ),
                      Material(
                        elevation: 5.0,
                        color: PrimaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                        child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _PDatetext.text.isEmpty
                                  ? _pDatevalidate = true
                                  : _pDatevalidate = false;

                              _pDiscounttext.text.isEmpty
                                  ? _pDiscounttext.text = '0'
                                  : _pDiscountvalidate = false;

                              _pgsttext.text.isEmpty
                                  ? _pgsttext.text = '0'
                                  : _pGstvalidate = false;

                              bool errorCheck = (!_pDatevalidate);

                              if (_pSubTotaltext.text.isEmpty ||
                                  _pSubTotaltext.text == 0) {
                                Fluttertoast.showToast(
                                  msg: "Add menus",
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
                            });
                          },
                          minWidth: 150,
                          child: Text(
                            'PAYMENT',
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
      ),
    );
  }

  void _getCustomer() async {
    CustomerFetch customerfetch = new CustomerFetch();
    var customerData = await customerfetch.getCustomerFetch("1");
    var resid = customerData["resid"];
    if (resid == 200) {
      var customersd = customerData["customer"];

      print(customersd.length);
      List<CustomerModel> tempCustomer = [];
      for (var n in customersd) {
        CustomerModel pro = CustomerModel.withId(
            int.parse(n["CustomerId"]),
            n["CustomerDate"],
            n["CustomerName"],
            n["CustomerMobNo"],
            n["CustomerEmail"],
            n["CustomerAddress"],
            n["CustomerCreditType"],
            n["CustomerTaxSupplier"],
            int.parse(n["CustomerType"]));
        tempCustomer.add(pro);
      }
      setState(() {
        this.customerList = tempCustomer;
      });
      print("//////SalesList/////////$customerList.length");

      List<String> tempCustomerNames = [];
      for (int i = 0; i < customerList.length; i++) {
        tempCustomerNames.add(customerList[i].custName);
      }
      // setState(() {
      //   this.customerName = tempCustomerNames;
      // });
      // print(customerName);
    } else {
      String msg = customerData["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

//-------------------------------------

  void latestSubTotalAmount(double subTotalAmount) {
    _pSubTotaltext.text = subTotalAmount.toString();
    latestTotalAmount();
  }

  void latestTotalAmount() {
    setState(() {
      pSubTotal = double.parse(_pSubTotaltext.text);
      pDiscount = _pDiscounttext.text.isNotEmpty
          ? double.parse(_pDiscounttext.text)
          : 0;
      pGst = _pgsttext.text.isNotEmpty ? double.parse(_pgsttext.text) : 0;

      double temp;

      temp = pSubTotal - pDiscount;
      temp = temp + pGst;
      _pTotalAmounttext.text = temp.toStringAsFixed(2);
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
          // proNameList.add(element.proName);
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

  void _getMenu() async {
    setState(() {
      showspinnerlog = true;
    });
    MenuList purchasefetch = new MenuList();
    var purchaseData = await purchasefetch.getHotelMenu("0");
    print('$purchaseData');
    var resid = purchaseData["resid"];
    if (resid == 200) {
      var rowcount = purchaseData["rowcount"];

      if (rowcount > 0) {
        var purchasesd = purchaseData["menu"];
        List<Menu> tempMenu = [];
        print(purchasesd.length);
        for (var n in purchasesd) {
          Menu pro = Menu(
              n["MenuId"],
              n["MenuName"],
              n["MenuProductId"],
              n["MenuProductName"],
              n["MenuProductQty"],
              n["Menucategory"],
              n["Menucategioresname"],
              n["MenuRate"],
              n["MenuGST"]);
          tempMenu.add(pro);
        }

        setState(() {
          menuList = tempMenu;
          showspinnerlog = false;
        });
        print("//////purchaselist/////////$menuList.length");
      } else {
        setState(() {
          showspinnerlog = false;
        });
        String msg = purchaseData["message"];
        Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: PrimaryColor,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      String msg = purchaseData["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void uploadData(cart) async {
    if (sCustomerName.isNotEmpty) {
      List<String> proIds = new List();
      List<String> proName = new List();
      List<String> proRate = new List();
      List<String> proQty = new List();
      List<String> proGst = new List();
      List<String> proProSubTotal = new List();
      List<SalesItem> pTempRecipeList = [];
      pTempRecipeList = cart.pSales;

      pTempRecipeList.forEach((element) {
        proIds.add(element.Salesid.toString());
        proName.add(element.SalesProductName);
        proRate.add(element.SalesProductRate.toString());
        proQty.add(element.SalesProductQty.toString());
        proProSubTotal.add(element.SalesProductSubTotal.toString());
        proGst.add(element.SalesGST.toString());
      });

      String JoinedProductIds = proIds.join("#");

      String JoinedProductName = proName.join("#");
      // print(JoinedProductName);
      String JoinedProductRate = proRate.join("#");
      // print(JoinedProductRate);
      String JoinedProductQty = proQty.join("#");
      String JoinedProductGst = proGst.join("#");
      // print(JoinedProductQty);
      String JoinedProductSubTotal = proProSubTotal.join("#");
      // print(JoinedProductSubTotal);

      Sales s = new Sales.copyWithCustId(
          sCustomerId,
          sCustomerName,
          sCustomerMob,
          _PDatetext.text.toString(),
          JoinedProductIds,
          JoinedProductName,
          JoinedProductRate,
          JoinedProductQty,
          JoinedProductSubTotal,
          pSubTotal.toStringAsFixed(2),
          pDiscount.toStringAsFixed(2),
          JoinedProductGst,
          _pTotalAmounttext.text.toString(),
          pNarration,
          '');

      print(sCustomerName);
      print(_PDatetext.text.toString());
      print(JoinedProductName);
      print(JoinedProductRate);
      print(JoinedProductQty);
      print(JoinedProductSubTotal);
      print(pSubTotal.toString());
      print(pDiscount.toString());
      print(pGst.toString());
      print(_pTotalAmounttext.text.toString());
      print(pNarration);

      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => SingleChildScrollView(
                  child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SaleBillingScreenNew(s, returnToClearData),
              )));

      // insert on server
      // var result = await purchaseinsert.getpospurchaseinsert(
      //     sCustomerName,
      //     _PDatetext.text.toString(),
      //     JoinedProductName,
      //     JoinedProductRate,
      //     JoinedProductQty,
      //     JoinedProductSubTotal,
      //     pSubTotal.toString(),
      //     pDiscount.toString(),
      //     pGst.toString(),
      //     pMiscellaneons.toString(),
      //     _pTotalAmounttext.text.toString(),
      //     pNarration);
      // if (result == null) {
      //   _showMyDialog('Filed !', Colors.red);
      // } else {
      //   cart.clear();
      //   _pSubTotaltext.text = '';
      //   _pDiscounttext.text = '';
      //   _pgsttext.text = '';
      //   _pTotalAmounttext.text = '';
      //   _pMiscellaneonsController.text = '';
      //   pNarrationController.text = '';
      //   _showMyDialog('Data Successfully Save !', Colors.green);
      // }
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

  double latestGSTAmount(double totalAmount, double GST) {
    double mainPrice = totalAmount / (100 + GST) * 100;
    double cal = totalAmount * (GST / (100 + GST));
    print('Without GST ' + mainPrice.toString());
    print('Add GST ' + cal.toString());
    double check = mainPrice + cal;
    print('Calculation ' + check.toString());
    return cal;
  }

  returnToClearData(bool value) {
    Provider.of<SalesModel>(context, listen: false).clear();
    _PCompanyNametext.text = '';
    // _PDatetext.text = '';
    _pSubTotaltext.text = '';
    _pDiscounttext.text = '';
    _pgsttext.text = '';
    _pTotalAmounttext.text = '';
    pNarrationController.text = '';

    sCustomerId = null;
    sCustomerName = null;
    sCustomerMob = null;
    // pDate = null;
    pmenuId = null;
    pmenuName = null;
    pmenuRate = null;
    pmenuGST = null;
    pmenuQty = null;
    pmenuSubTotal = null;
    pSubTotal = null;
    pDiscount = null;
    pGst = null;

    pTotalAmount = null;
    pNarration = null;

    _pmenuNametext.text = '';
    _pmenuRatetext.text = '';
    _pmenuGSTtext.text = '';
    _pmenuQtytext.text = '';
    _pmenuSubTotaltext.text = '';
  }
}
