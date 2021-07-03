import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/POS_Purchase_Insert.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/Adpater/pos_supplier_fetch.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/Purchase.dart';
import 'package:retailerp/models/purchase_model.dart';
import 'package:retailerp/models/supplier.dart';
import 'package:retailerp/pages/dashboard.dart';
import 'package:retailerp/utils/PurchaseDeleteProvider.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/purchase_edit_item_widget.dart';
import 'package:retailerp/widgets/purchase_item_widget.dart';

class EditPurchaseScreenNew extends StatefulWidget {
  EditPurchaseScreenNew(this.indexFetch, this.purchaseList);

  @override
  final int indexFetch;
  List<Purchase> purchaseList = new List();

  _EditPurchaseScreenNewState createState() =>
      _EditPurchaseScreenNewState(this.indexFetch, this.purchaseList);
}

class _EditPurchaseScreenNewState extends State<EditPurchaseScreenNew> {
  final int indexFetch;
  List<Purchase> purchaseList = new List();
  PurchaseItem purchitem;
  PurchaseInsert purchaseinsert = new PurchaseInsert();
  DatabaseHelper databaseHelper = new DatabaseHelper();

  _EditPurchaseScreenNewState(this.indexFetch, this.purchaseList);

  List<Supplier> supplierList = new List();

  // List<String> CompanyName = new List();
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
  final _pInvoiceNoController = TextEditingController();
  final _PDatetext = TextEditingController();
  final _pSubTotaltext = TextEditingController();
  final _pDiscounttext = TextEditingController();
  final _pgsttext = TextEditingController();
  final _pTotalAmounttext = TextEditingController();
  final _pMiscellaneonsController = TextEditingController();
  final pNarrationController = TextEditingController();

  bool _pDatevalidate = false;
  bool _pInvoiceNOvalidate = false;
  bool _pProNamevalidate = false;
  bool _pProRatevalidate = false;
  bool _pProGStvalidate = false;
  bool _pProQtyvalidate = false;
  bool _pProSubTotalvalidate = false;
  bool _pSubTotalvalidate = false;
  bool _pDiscountvalidate = false;
  bool _pGstvalidate = false;
  bool _pTotalAmountvalidate = false;

  String pCompanyName;
  String pCompanyID;
  String pInvoiceNo;
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

  final dateFormat = DateFormat("yyyy-MM-dd");
  DateTime initialValue;
  var day;
  var month;
  var year;
  bool visAddBtn = false;
  bool visSaveBtn = false;
  bool visProDropDown = false;
  bool visProTextField = false;
  int pProId;
  List<String> proNameList = new List();
  List<ProductModel> productList;
  int proRowId;

  void initState() {
    setState(() {
      visAddBtn = true;
      visProDropDown = true;
      _getSupplier();
      _getProducts();

      _PDatetext.text = purchaseList[indexFetch].PurchaseDate;
      DateTime now = DateTime.now();
      String sa = purchaseList[indexFetch].PurchaseDate;
      day = '${sa[8]}${sa[9]}';
      month = '${sa[5]}${sa[6]}';
      year = '${sa[0]}${sa[1]}${sa[2]}${sa[3]}';
      initialValue = new DateTime(
          int.parse(year),
          int.parse(month),
          int.parse(day),
          now.hour,
          now.minute,
          now.second,
          now.millisecond,
          now.microsecond);

      _PCompanyNametext.text = purchaseList[indexFetch].SupplierCustomername;
      _pInvoiceNoController.text = purchaseList[indexFetch].Purchaseinvoice;
      pInvoiceNo = purchaseList[indexFetch].Purchaseinvoice;
      pCompanyID = purchaseList[indexFetch].purchasesupplierid;
      proRowId = purchaseList[indexFetch].Purchaseid;
      pCompanyName = purchaseList[indexFetch].SupplierCustomername;
      _pSubTotaltext.text =
          purchaseList[indexFetch].PurchaseSubTotal.toString();
      _pDiscounttext.text =
          purchaseList[indexFetch].PurchaseDiscount.toString();
      // _pgsttext.text = purchaseList[indexFetch].PurchaseGST.toString();
      _pMiscellaneonsController.text =
          purchaseList[indexFetch].PurchaseMiscellaneons.toString();
      _pTotalAmounttext.text =
          purchaseList[indexFetch].PurchaseTotal.toString();
      pNarrationController.text = purchaseList[indexFetch].PurchaseNarration;

      var slipttedProIDs = purchaseList[indexFetch].PurchaseIds.split("#");
      var slipttedProName =
          purchaseList[indexFetch].PurchaseProductName.split("#");
      var slipttedProRate =
          purchaseList[indexFetch].PurchaseProductRate.split("#");
      var slipttedProGst = purchaseList[indexFetch].PurchaseGST.split("#");
      var slipttedProQty =
          purchaseList[indexFetch].PurchaseProductQty.split("#");
      var slipttedProSubTotal =
          purchaseList[indexFetch].PurchaseProductSubTotal.split("#");

      print('$slipttedProName');
      String proIds;
      String proName;
      String proRate;
      String proGst;
      String proQty;
      String proSubTotal;

      Provider.of<PurchaseModel>(context, listen: false).clear();
      for (int i = 0; i < slipttedProName.length; i++) {
        proIds = "${slipttedProIDs[i]}";
        proName = "${slipttedProName[i]}";
        proRate = "${slipttedProRate[i]}";
        proGst = "${slipttedProGst[i]}";
        proQty = "${slipttedProQty[i]}";
        proSubTotal = "${slipttedProSubTotal[i]}";
        final purProduct = PurchaseItem.cust(
          int.parse(proIds),
          proName,
          double.parse(proRate),
          int.parse(proGst),
          int.parse(proQty),
          proSubTotal,
        );
        Provider.of<PurchaseModel>(context, listen: false)
            .addPurchaseProduct(purProduct);
      }
    });
  }

  static const int kTabletBreakpoint = 552;
  bool showspinnerlog = false;

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

  Widget _buildTabletAddPurchase() {
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
            Text('Update Purchase'),
          ],
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showspinnerlog,
        child: SingleChildScrollView(
            child: Consumer<PurchaseModel>(builder: (context, cart, child) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Material(
                    shape: Border.all(color: PrimaryColor, width: 2),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             vertical: 20.0, horizontal: 10.0),
                          //         child: DropdownSearch(
                          //           items: CompanyName,
                          //           label: "Supplier Company Name",
                          //           selectedItem: pCompanyName,
                          //           onChanged: (value) {
                          //             pCompanyName = value;
                          //             print(pCompanyName);
                          //           },
                          //         ),
                          //       ),
                          //     ),
                          //     Expanded(
                          //       child: Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             vertical: 20.0, horizontal: 10.0),
                          //         child:
                          //         DateTimeField(
                          //           controller: _PDatetext,
                          //           format: format,
                          //           keyboardType: TextInputType.number,
                          //           onShowPicker: (context, currentValue) {
                          //             return showDatePicker(
                          //                 context: context,
                          //                 firstDate: DateTime(1900),
                          //                 initialDate:
                          //                 currentValue ?? DateTime.now(),
                          //                 lastDate: DateTime(2100));
                          //           },
                          //           autovalidate: autoValidate,
                          //           validator: (date) =>
                          //           date == null ? 'Invalid date' : null,
                          //           onChanged: (date) => setState(() {}),
                          //           onSaved: (date) => setState(() {
                          //             value = date;
                          //             print('Selected value Date: $value');
                          //             savedCount++;
                          //           }),
                          //           resetIcon:
                          //           showResetIcon ? Icon(Icons.delete) : null,
                          //           readOnly: readOnly,
                          //           decoration: InputDecoration(
                          //             border: OutlineInputBorder(),
                          //             labelText: 'Purchase Date',
                          //             errorText: _pDatevalidate
                          //                 ? 'Enter Purchase Date'
                          //                 : null,
                          //           ),
                          //         ),
                          //         // DateTimeField(
                          //         //   format: dateFormat,
                          //         //   controller: _PDatetext,
                          //         //   onShowPicker: (context, currentValue) async {
                          //         //     final date = await showDatePicker(
                          //         //         context: context,
                          //         //         firstDate: DateTime(1900),
                          //         //         initialDate:
                          //         //             currentValue ?? initialValue,
                          //         //         lastDate: DateTime(2100));
                          //         //     if (date != null) {
                          //         //       final time = await showTimePicker(
                          //         //         context: context,
                          //         //         initialTime: TimeOfDay.fromDateTime(
                          //         //             currentValue ?? DateTime.now()),
                          //         //       );
                          //         //       return DateTimeField.combine(date, time);
                          //         //     } else {
                          //         //       return currentValue;
                          //         //     }
                          //         //   },
                          //         //   autovalidate: autoValidate,
                          //         //   validator: (date) =>
                          //         //       date == null ? 'Invalid date' : null,
                          //         //   onChanged: (date) => setState(() {
                          //         //     var formattedDate =
                          //         //         "${value.day}-${value.month}-${value.year}";
                          //         //     changedCount++;
                          //         //     pDate = formattedDate.toString();
                          //         //     print('Selected Date: ${_PDatetext.text}');
                          //         //   }),
                          //         //   onSaved: (date) => setState(() {
                          //         //     value = date;
                          //         //     print('Selected value Date: $value');
                          //         //     savedCount++;
                          //         //   }),
                          //         //   resetIcon:
                          //         //       showResetIcon ? Icon(Icons.delete) : null,
                          //         //   readOnly: readOnly,
                          //         //   decoration: InputDecoration(
                          //         //     border: OutlineInputBorder(),
                          //         //     labelText: 'Purchase Date',
                          //         //     errorText: _pDatevalidate
                          //         //         ? 'Enter Purchase Date'
                          //         //         : null,
                          //         //   ),
                          //         // ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _PCompanyNametext,
                                  obscureText: false,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Supplier Company Name',
                                  ),
                                ),
                                // DropdownSearch<Supplier>(
                                //   items: supplierList,
                                //   label: "Supplier Company Name",
                                //   onChanged: (value) {
                                //     if (value != null) {
                                //       pCompanyID = value.Supplierid.toString();
                                //       pCompanyName = value.SupplierComapanyName;
                                //       print(pCompanyName);
                                //     } else {
                                //       pCompanyID = null;
                                //       pCompanyName = null;
                                //     }
                                //   },
                                // ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _pInvoiceNoController,
                                  obscureText: false,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Invoice No *',
                                    errorText: _pInvoiceNOvalidate
                                        ? 'Enter Invoice No'
                                        : null,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 8.0),
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
                                    resetIcon: showResetIcon
                                        ? Icon(Icons.delete)
                                        : null,
                                    readOnly: readOnly,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Purchase Date',
                                      errorText: _pDatevalidate
                                          ? 'Enter Purchase Date'
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Visibility(
                                visible: visProDropDown,
                                child: Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownSearch<ProductModel>(
                                        items: productList,
                                        showClearButton: true,
                                        showSelectedItem: true,
                                        compareFn:
                                            (ProductModel i, ProductModel s) =>
                                                i.isEqual(s),
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
                                      )),
                                ),
                              ),
                              Visibility(
                                visible: visProTextField,
                                child: Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      enabled: false,
                                      controller: _pProNametext,
                                      obscureText: false,
                                      onChanged: (value) {
                                        pProName = value;
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Product Name',
                                        errorText: _pProNamevalidate
                                            ? 'Enter Product Name'
                                            : null,
                                      ),
                                    ),
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

                                      if (_pProGSTtext.text != null) {
                                        temp = pProRate *
                                                int.parse(_pProQtytext.text) +
                                            latestGSTAmount(
                                                double.parse(
                                                    _pProRatetext.text),
                                                double.parse('$pProGST'));
                                        TempQty = int.parse(value);
                                        _pProSubTotaltext.text =
                                            temp.toStringAsFixed(2);
                                        pProSubTotal = double.parse(
                                            _pProSubTotaltext.text);
                                        latestTotalAmount();
                                      } else {
                                        temp = (pProRate *
                                            int.parse(_pProQtytext.text));
                                        TempQty = int.parse(value);
                                        _pProSubTotaltext.text =
                                            temp.toStringAsFixed(2);
                                        pProSubTotal = double.parse(
                                            _pProSubTotaltext.text);
                                        latestTotalAmount();
                                      }
                                      // temp = (pProRate *
                                      //     int.parse(_pProQtytext.text));
                                      // TempQty = int.parse(value);
                                      // _pProSubTotaltext.text = temp.toString();
                                      // pProSubTotal =
                                      //     double.parse(_pProSubTotaltext.text);
                                      // latestTotalAmount();
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

                                      if (_pProRatetext.text != null &&
                                          _pProQtytext.text != null) {
                                        temp =
                                            (double.parse(_pProRatetext.text) *
                                                    double.parse(
                                                        _pProQtytext.text)) +
                                                latestGSTAmount(
                                                    double.parse(
                                                        _pProRatetext.text),
                                                    double.parse(value));
                                        TempQty = int.parse(value);
                                        _pProSubTotaltext.text =
                                            temp.toStringAsFixed(2);
                                        pProSubTotal = double.parse(
                                            _pProSubTotaltext.text);
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
                                        temp =
                                            (double.parse(_pProRatetext.text) *
                                                    pProQty) +
                                                latestGSTAmount(
                                                    double.parse(
                                                        _pProRatetext.text),
                                                    double.parse('$pProGST'));
                                        TempQty = int.parse(value);
                                        _pProSubTotaltext.text =
                                            temp.toStringAsFixed(2);
                                        pProSubTotal = double.parse(
                                            _pProSubTotaltext.text);
                                        latestTotalAmount();
                                      } else {
                                        temp =
                                            (double.parse(_pProRatetext.text) *
                                                pProQty);
                                        TempQty = int.parse(value);
                                        _pProSubTotaltext.text =
                                            temp.toStringAsFixed(2);
                                        pProSubTotal = double.parse(
                                            _pProSubTotaltext.text);
                                        latestTotalAmount();
                                      }

                                      //
                                      // temp =
                                      // (double.parse(_pProRatetext.text) *
                                      //     pProQty);
                                      // TempQty = int.parse(value);
                                      // _pProSubTotaltext.text =
                                      //     temp.toString();
                                      // pProSubTotal =
                                      //     double.parse(
                                      //         _pProSubTotaltext.text);
                                      // latestTotalAmount();
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
                                    // enabled: false,
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
                                  Visibility(
                                    visible: visSaveBtn,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.save,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            // if (_pProNametext.text.isEmpty) {
                                            //   _pProNamevalidate = true;
                                            // } else {
                                            //   _pProNamevalidate = false;
                                            // }

                                            if (_pProRatetext.text.isEmpty) {
                                              _pProRatevalidate = true;
                                            } else if (_pProRatetext.text ==
                                                0) {
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
                                            // final cartItem = cart.pProduct[index];
                                            bool errorCheck =
                                                (!_pProRatevalidate &&
                                                    !_pProQtyvalidate);

                                            if (errorCheck) {
                                              Provider.of<PurchaseModel>(
                                                      context,
                                                      listen: false)
                                                  .updatePurchaseProduct(
                                                      pProId,
                                                      _pProNametext.text,
                                                      double.parse(
                                                          _pProRatetext.text),
                                                      int.parse(
                                                          _pProGSTtext.text),
                                                      int.parse(
                                                          _pProQtytext.text),
                                                      _pProSubTotaltext.text
                                                          .toString(),
                                                      purchitem);

                                              _pSubTotaltext.text = cart
                                                  .totalAmount
                                                  .toStringAsFixed(2);

                                              latestTotalAmount();
                                              pProName = '';
                                              _pProNametext.text = '';
                                              _pProRatetext.text = '';
                                              _pProGSTtext.text = '';
                                              _pProQtytext.text = '';
                                              _pProSubTotaltext.text = '';

                                              visAddBtn = true;
                                              visProDropDown = true;
                                              visSaveBtn = false;
                                              visProTextField = false;
                                              print("/////${cart.itemCount}");
                                            } else {}
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: visAddBtn,
                                    child: Padding(
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
                                            } else if (_pProRatetext.text ==
                                                0) {
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

                                            bool errorCheck =
                                                (!_pProRatevalidate &&
                                                    !_pProQtyvalidate &&
                                                    !pProName.isEmpty);
                                            if (_pProGSTtext.text.isEmpty) {
                                              pProGST = 0;
                                            }

                                            if (errorCheck) {
                                              final purProduct =
                                                  PurchaseItem.cust(
                                                      pProId,
                                                      pProName,
                                                      pProRate,
                                                      pProGST,
                                                      pProQty,
                                                      pProSubTotal.toString());
                                              Provider.of<PurchaseModel>(
                                                      context,
                                                      listen: false)
                                                  .addPurchaseProduct(
                                                      purProduct);
                                              _pSubTotaltext.text = cart
                                                  .totalAmount
                                                  .toStringAsFixed(2);
                                              latestTotalAmount();
                                              _pProNametext.text = '';
                                              _pProRatetext.text = '';
                                              _pProGSTtext.text = '';
                                              _pProQtytext.text = '';
                                              _pProSubTotaltext.text = '';
                                              print("/////${cart.itemCount}");
                                            } else {
                                              Fluttertoast.showToast(
                                                msg: "check product data!!!",
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
                                      return PurchaseEditItemWidget(
                                          cartItem,
                                          latestSubTotalAmount,
                                          getPurProductItems);
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

                                  _pInvoiceNoController.text.isEmpty
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

                                  bool errorCheck =
                                      (!_pDatevalidate && !_pDatevalidate);

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
                                      // Fluttertoast.showToast(
                                      //   msg: "Upateded Data",
                                      //   toastLength: Toast.LENGTH_SHORT,
                                      //   backgroundColor: Colors.black38,
                                      //   textColor: Color(0xffffffff),
                                      //   gravity: ToastGravity.BOTTOM,
                                      // );
                                      uploadData(cart);
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Select Date",
                                        toastLength: Toast.LENGTH_SHORT,
                                        backgroundColor: PrimaryColor,
                                        textColor: Color(0xffffffff),
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                    }
                                  }
                                },
                                minWidth: 150,
                                child: Text(
                                  'Update',
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
            ),
          );
        })),
      ),
    );
  }

  Widget _buildMobileAddPurchase() {
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
            Text('Update Purchase'),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Consumer<PurchaseModel>(builder: (context, cart, child) {
        return Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _PCompanyNametext,
                      obscureText: false,
                      enabled: false,
                      onChanged: (value) {},
                    ),
                    // DropdownSearch<Supplier>(
                    //   items: supplierList,
                    //   label: "Supplier Company Name",
                    //   onChanged: (value) {
                    //     if (value != null) {
                    //       pCompanyID = value.Supplierid.toString();
                    //       pCompanyName = value.SupplierComapanyName;
                    //       print(pCompanyName);
                    //     } else {
                    //       pCompanyID = null;
                    //       pCompanyName = null;
                    //     }
                    //   },
                    // ),
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
                    //   format: dateFormat,
                    //   controller: _PDatetext,
                    //   onShowPicker: (context, currentValue) async {
                    //     final date = await showDatePicker(
                    //         context: context,
                    //         firstDate: DateTime(1900),
                    //         initialDate:
                    //         currentValue ?? initialValue,
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
                    //     var formattedDate =
                    //         "${value.day}-${value.month}-${value.year}";
                    //     changedCount++;
                    //     pDate = formattedDate.toString();
                    //     print('Selected Date: ${_PDatetext.text}');
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
                    //     labelText: 'Purchase Date',
                    //     errorText: _pDatevalidate
                    //         ? 'Enter Purchase Date'
                    //         : null,
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: visProDropDown,
                      child: DropdownSearch<ProductModel>(
                        items: productList,
                        showClearButton: true,
                        showSelectedItem: true,
                        compareFn: (ProductModel i, ProductModel s) =>
                            i.isEqual(s),
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
                    ),
                    Visibility(
                      visible: visProTextField,
                      child: TextField(
                        enabled: false,
                        controller: _pProNametext,
                        obscureText: false,
                        onChanged: (value) {
                          pProName = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Product Name',
                          errorText:
                              _pProNamevalidate ? 'Enter Product Name' : null,
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
                            controller: _pProRatetext,
                            obscureText: false,
                            onChanged: (value) {
                              pProRate = double.parse(value);

                              if (_pProGSTtext.text != null) {
                                temp = pProRate * int.parse(_pProQtytext.text) +
                                    latestGSTAmount(
                                        double.parse(_pProRatetext.text),
                                        double.parse('$pProGST'));
                                TempQty = int.parse(value);
                                _pProSubTotaltext.text =
                                    temp.toStringAsFixed(2);
                                pProSubTotal =
                                    double.parse(_pProSubTotaltext.text);
                                latestTotalAmount();
                              } else {
                                temp =
                                    (pProRate * int.parse(_pProQtytext.text));
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

                              if (_pProRatetext.text != null &&
                                  _pProQtytext.text != null) {
                                temp = (double.parse(_pProRatetext.text) *
                                        double.parse(_pProQtytext.text)) +
                                    latestGSTAmount(
                                        double.parse(_pProRatetext.text),
                                        double.parse(value));
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
                                temp = (double.parse(_pProRatetext.text) *
                                        pProQty) +
                                    latestGSTAmount(
                                        double.parse(_pProRatetext.text),
                                        double.parse('$pProGST'));
                                TempQty = int.parse(value);
                                _pProSubTotaltext.text =
                                    temp.toStringAsFixed(2);
                                pProSubTotal =
                                    double.parse(_pProSubTotaltext.text);
                                latestTotalAmount();
                              } else {
                                temp = (double.parse(_pProRatetext.text) *
                                    pProQty);
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
                            // enabled: false,
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
                        Row(
                          children: [
                            Visibility(
                              visible: visSaveBtn,
                              child: IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.save,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  setState(() {
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
                                    // final cartItem = cart.pProduct[index];
                                    bool errorCheck = (!_pProRatevalidate &&
                                        !_pProQtyvalidate);

                                    if (errorCheck) {
                                      Provider.of<PurchaseModel>(context,
                                              listen: false)
                                          .updatePurchaseProduct(
                                              pProId,
                                              _pProNametext.text,
                                              double.parse(_pProRatetext.text),
                                              int.parse(_pProGSTtext.text),
                                              int.parse(_pProQtytext.text),
                                              _pProSubTotaltext.text.toString(),
                                              purchitem);

                                      _pSubTotaltext.text =
                                          cart.totalAmount.toStringAsFixed(2);

                                      latestTotalAmount();
                                      pProName = '';
                                      _pProNametext.text = '';
                                      _pProRatetext.text = '';
                                      _pProGSTtext.text = '';
                                      _pProQtytext.text = '';
                                      _pProSubTotaltext.text = '';

                                      visAddBtn = true;
                                      visProDropDown = true;
                                      visSaveBtn = false;
                                      visProTextField = false;
                                      print("/////${cart.itemCount}");
                                    } else {}
                                  });
                                },
                              ),
                            ),
                            Visibility(
                              visible: visAddBtn,
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

                                    bool errorCheck = (!_pProRatevalidate &&
                                        !_pProQtyvalidate &&
                                        !pProName.isEmpty);
                                    if (_pProGSTtext.text.isEmpty) {
                                      pProGST = 0;
                                    }

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
                                      _pProNametext.text = '';
                                      _pProRatetext.text = '';
                                      _pProGSTtext.text = '';
                                      _pProQtytext.text = '';
                                      _pProSubTotaltext.text = '';
                                      print("/////${cart.itemCount}");
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "check product data!!!",
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
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: cart.itemCount == 0 ? false : true,
                      child: Container(
                        height: mobHeight,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: cart.itemCount,
                            itemBuilder: (context, int index) {
                              final cartItem = cart.pProduct[index];
                              return PurchaseEditItemWidget(cartItem,
                                  latestSubTotalAmount, getPurProductItems);
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
                      height: 15,
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
                              // Fluttertoast.showToast(
                              //   msg: "Upateded Data",
                              //   toastLength: Toast.LENGTH_SHORT,
                              //   backgroundColor: Colors.black38,
                              //   textColor: Color(0xffffffff),
                              //   gravity: ToastGravity.BOTTOM,
                              // );
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
                          'Update',
                          style: btnHeadTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      })),
    );
  }

  void latestSubTotalAmount(double subTotalAmount) {
    _pSubTotaltext.text = subTotalAmount.toStringAsFixed(2);
    latestTotalAmount();
  }

  void getPurProductItems(int proId, String proName, double proRate, int Gst,
      int proQty, String subTotalAmount, PurchaseItem item) {
    print('${proName}');
    pProId = proId;
    _pProNametext.text = proName;
    _pProRatetext.text = proRate.toString();
    _pProGSTtext.text = Gst.toString();
    _pProQtytext.text = proQty.toString();
    _pProSubTotaltext.text = subTotalAmount;
    latestTotalAmount();
    print('${item}');
    setState(() {
      visAddBtn = false;
      visProDropDown = false;
      visSaveBtn = true;
      visProTextField = true;
      purchitem = item;
    });
  }

  void latestTotalAmount() {
    setState(() {
      pSubTotal = double.parse(_pSubTotaltext.text);
      pDiscount = _pDiscounttext.text.isNotEmpty
          ? double.parse(_pDiscounttext.text)
          : 0;
      // pGst = _pgsttext.text.isNotEmpty ? double.parse(_pgsttext.text) : 0;
      pMiscellaneons = _pMiscellaneonsController.text.isNotEmpty
          ? double.parse(_pMiscellaneonsController.text)
          : 0;

      double temp;

      temp = pSubTotal - pDiscount;
      temp = temp + pMiscellaneons;
      _pTotalAmounttext.text = temp.toString();
    });
  }

  void _getSupplier() async {
    SupplierFetch supplierfetch = new SupplierFetch();
    var supplierData = await supplierfetch.getSupplierFetch("1");
    print(supplierData);
    var resid = supplierData["resid"];
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
      this.supplierList = tempSupplier;
    });
    print("//////SalesList/////////$supplierList.length");
  }

  void _getProducts() async {
    // setState(() {
    //   showspinnerlog = true;
    // });
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
        // showspinnerlog = false;
      });
    } else {
      setState(() {
        // showspinnerlog = false;
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

  void uploadData(cart) async {
    setState(() {
      showspinnerlog = true;
    });
    try {
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
        // print(pGst);
        print(pMiscellaneons);
        print(pNarration);

        // insert on server
        var result = await purchaseinsert.getposUpdatePurchaseinsertWithIds(
            proRowId.toString(),
            pCompanyID,
            _pInvoiceNoController.text.toString(),
            _PDatetext.text.toString(),
            JoinedProductIds,
            JoinedPurchaseProductName,
            JoinedPurchaseProductRate,
            JoinedProductGst,
            JoinedPurchaseProductQty,
            JoinedPurchaseProductSubTotal,
            pSubTotal != null ? pSubTotal.toStringAsFixed(2) : '0.00',
            pDiscount != null ? pDiscount.toStringAsFixed(2) : '0.00',
            pMiscellaneons != null ? pMiscellaneons.toStringAsFixed(2) : '0.00',
            _pTotalAmounttext.text.toString(),
            pNarration != null ? pNarration : '');

        if (result != null) {
          int resid = result["resid"];
          String mes = result["message"];
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
          // _showMyDialog('Filed !', Colors.red);
        } else {
          _showMyDialog('Filed !', Colors.red);
        }
        // cart.clear();
        // _pInvoiceNoController.text = '';
        // _pSubTotaltext.text = '';
        // _pDiscounttext.text = '';
        // _pgsttext.text = '';
        // _pTotalAmounttext.text = '';
        // _pMiscellaneonsController.text = '';
        // pNarrationController.text = '';
        // _showMyDialog('Data Successfully Save !', Colors.green);
        // if (result == null) {
        //   Fluttertoast.showToast(
        //     msg: "Failed",
        //     toastLength: Toast.LENGTH_SHORT,
        //     backgroundColor: PrimaryColor,
        //     textColor: Color(0xffffffff),
        //     gravity: ToastGravity.BOTTOM,
        //   );
        //   // _showMyDialog('Failed !', Colors.red);
        // } else {
        //   Navigator.pop(context, true);
        //   Fluttertoast.showToast(
        //     msg: "Data Successfully Save !",
        //     toastLength: Toast.LENGTH_SHORT,
        //     backgroundColor: PrimaryColor,
        //     textColor: Color(0xffffffff),
        //     gravity: ToastGravity.BOTTOM,
        //   );
        // cart.clear();
        // _pInvoiceNoController.text = '';
        // _pSubTotaltext.text = '';
        // _pDiscounttext.text = '';
        // _pgsttext.text = '';
        // _pTotalAmounttext.text = '';
        // _pMiscellaneonsController.text = '';
        // pNarrationController.text = '';
        // _showMyDialog('Data Successfully Save !', Colors.green);
      } else {
        Fluttertoast.showToast(
          msg: "Select supplier company name",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black38,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }
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
}
