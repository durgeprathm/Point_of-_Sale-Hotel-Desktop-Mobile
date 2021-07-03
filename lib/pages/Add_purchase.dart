import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/POS_Purchase_Insert.dart';
import 'package:retailerp/Adpater/pos_supplier_fetch.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/Purchase.dart';
import 'package:retailerp/models/supplier.dart';
import 'package:retailerp/utils/PurchaseDeleteProvider.dart';

import 'Add_Supliers.dart';
import 'Import_purchase.dart';
import 'Manage_Purchase.dart';
import 'Manage_Suppliers.dart';
import 'dashboard.dart';

class AddPurchase extends StatefulWidget {
  @override
  _AddPurchaseState createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchase> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  PurchaseInsert purchaseinsert = new PurchaseInsert();

  @override
  void initState() {
    _getSupplier();
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

  // final _PProNametext = TextEditingController();
  // final _PProRatetext = TextEditingController();
  // final _PProQtytext = TextEditingController();
  // final _PproSubTotaltext = TextEditingController();
  final _PSubTotaltext = TextEditingController();
  final _PDiscounttext = TextEditingController();
  final _Pgsttext = TextEditingController();
  final _PtotalAmounttext = TextEditingController();

  bool _PDatevalidate = false;
  bool _PProNamevalidate = false;
  bool _PProRatevalidate = false;
  bool _PProQtyvalidate = false;
  bool _PproSubTotalvalidate = false;
  bool _PSubTotalvalidate = false;
  bool _PDiscountvalidate = false;
  bool _Pgstvalidate = false;
  bool _PtotalAmountvalidate = false;

  String PCompanyName;
  String PDate;
  String PProName;
  double PProRate;
  double PProQty;
  double PProSubTotal;
  double PSubTotal;
  double PDiscount;
  double Pgst;
  double PMiscellaneons;
  double PtotalAmount;
  String PNarration;

  List<String> LocalPurchaseProductName = new List();
  List<double> LocalPurchaseProductRate = new List();
  List<int> LocalPurchaseProductQty = new List();
  List<double> LocalPurchaseProductSubTotal = new List();
  List<TextEditingController> _PProNametext = new List();
  List<TextEditingController> _PProRatetext = new List();
  List<TextEditingController> _PProQtytext = new List();
  List<TextEditingController> _PproSubTotaltext = new List();

  final dateFormat = DateFormat("dd-MM-yyyy");
  final initialValue = DateTime.now();

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text('Add Purchase'),
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
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Material(
              shape: Border.all(color: Colors.blueGrey, width: 5),
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
                              // [
                              //   "Bosch",
                              //   "Vitoba",
                              //   "Ibm",
                              //   "Tcs",
                              //   "QIS",
                              //   "persistence",
                              //   "persistenceQISTcsIbmVitobaBoschVitobaIbm"
                              // ],
                              label: "Supplier Company Name",
                              onChanged: (value) {
                                PCompanyName = value;
                                print(PCompanyName);
                              },
                              // selectedItem: "Tunisia",
                              // validator: (String item) {
                              //   if (item == null)
                              //     return "Required field";
                              //   else if (item == "Brazil")
                              //     return "Invalid item";
                              //   else
                              //     return null;
                              // },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10.0),
                            // child: TextField(
                            //   obscureText: false,
                            //   decoration: InputDecoration(
                            //     border: OutlineInputBorder(),
                            //     labelText: 'Purchase Date',
                            //   ),
                            // ),
                            // child: DateTimeField(
                            //   format: dateFormat,
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
                            //   validator: (date) =>
                            //       date == null ? 'Invalid date' : null,
                            //   initialValue: initialValue,
                            //   onChanged: (date) => setState(() {
                            //     value = date;
                            //     print('date changedCount $date');
                            //     changedCount++;
                            //   }),
                            //   onSaved: (date) => setState(() {
                            //     value = date;
                            //     print('date savedCount $date');
                            //     savedCount++;
                            //   }),
                            //   resetIcon:
                            //       showResetIcon ? Icon(Icons.delete) : null,
                            //   readOnly: readOnly,
                            // ),

                          child:  DateTimeField(
                              format: dateFormat,
                              controller: _PDatetext,
                              onShowPicker: (context, currentValue) async {
                                final date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate:
                                        currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                                if (date != null) {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                        currentValue ?? DateTime.now()),
                                  );
                                  return DateTimeField.combine(date, time);
                                } else {
                                  return currentValue;
                                }
                              },
                              autovalidate: autoValidate,
                              validator: (date) =>
                                  date == null ? 'Invalid date' : null,
                              onChanged: (date) => setState(() {
                                var formattedDate =
                                    "${value.day}-${value.month}-${value.year}";
                                changedCount++;
                                PDate = formattedDate.toString();
                                print('Selected Date: ${_PDatetext.text}');
                              }),
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
                                errorText: _PDatevalidate
                                    ? 'Enter Purchase Date'
                                    : null,
                                // helperText: 'Changed: $changedCount, Saved: $savedCount, $value',
                                // hintText: "Deactivated At: "
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Material(
                      shape: Border.all(color: ProductbtnColor, width: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          // height: 150.0,
                          child: ListView.builder(
                              itemCount: rowpro,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                _PProNametext.add(new TextEditingController());
                                _PProRatetext.add(new TextEditingController());
                                _PProQtytext.add(new TextEditingController());
                                _PproSubTotaltext.add(
                                    new TextEditingController());
                                return Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: _PProNametext[index],
                                            obscureText: false,
                                            onChanged: (value) {
                                              PProName = value;
                                            },
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Product Name',
                                              errorText: _PProNamevalidate
                                                  ? 'Enter Product Name'
                                                  : null,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: _PProRatetext[index],
                                            obscureText: false,
                                            onChanged: (value) {
                                              PProRate = double.parse(value);
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Product Rate',
                                              errorText: _PProRatevalidate
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
                                            controller: _PProQtytext[index],
                                            obscureText: false,
                                            onChanged: (value) {
                                              PProQty = double.parse(value);
                                              temp = (PProRate * PProQty);
                                              TempQty = int.parse(value);

                                              _PproSubTotaltext[index].text =
                                                  temp.toString();
                                              PProSubTotal = double.parse(
                                                  _PproSubTotaltext[index]
                                                      .text);
                                              //inserting data in Array

                                              // print('ProductName: $PProName');
                                              // LocalPurchaseProductName.add(
                                              //     PProName);
                                              // LocalPurchaseProductRate.add(
                                              //     PProRate);
                                              // LocalPurchaseProductQty.add(
                                              //     TempQty);
                                              // LocalPurchaseProductSubTotal.add(
                                              //     PProSubTotal);

                                              //calculating SubTotal of sales
                                              // tempsubtotal = 0;
                                              // LocalPurchaseProductSubTotal
                                              //     .forEach((num e) {
                                              //   tempsubtotal += e;
                                              // });
                                              // _PSubTotaltext.text =
                                              //     (tempsubtotal).toString();
                                              // PSubTotal = tempsubtotal;
                                              // gst = 0;
                                              // //calculating Discount of sales
                                              // _PDiscounttext.text =
                                              //     (gst).toString();
                                              // PDiscount = gst;
                                              // //calculating Gst of sales
                                              // _Pgsttext.text = (gst).toString();
                                              // Pgst = gst;
                                              // //calculating Total of purchase
                                              // _PtotalAmounttext.text =
                                              //     (tempsubtotal).toString();
                                              // PtotalAmount = tempsubtotal;
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Product Quantity',
                                              errorText: _PProQtyvalidate
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
                                            controller:
                                                _PproSubTotaltext[index],
                                            obscureText: false,
                                            onChanged: (value) {
                                              // PProSubTotal=double.parse(value);
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Product Subtotal',
                                              errorText: _PproSubTotalvalidate
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
                                                FontAwesomeIcons.save,
                                                color: Colors.green,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  print('Add Btn Call');
                                                  print(
                                                      'ProductName: $PProName');
                                                  LocalPurchaseProductName.add(
                                                      PProName);
                                                  LocalPurchaseProductRate.add(
                                                      PProRate);
                                                  LocalPurchaseProductQty.add(
                                                      TempQty);
                                                  LocalPurchaseProductSubTotal
                                                      .add(PProSubTotal);
                                                  tempsubtotal = 0;
                                                  LocalPurchaseProductSubTotal
                                                      .forEach((num e) {
                                                    tempsubtotal += e;
                                                  });
                                                  _PSubTotaltext.text =
                                                      (tempsubtotal).toString();
                                                  PSubTotal = tempsubtotal;

                                                  gst = 0;
                                                  //calculating Discount of sales
                                                  _PDiscounttext.text =
                                                      (gst).toString();
                                                  PDiscount = gst;
                                                  //calculating Gst of sales
                                                  _Pgsttext.text =
                                                      (gst).toString();
                                                  Pgst = gst;
                                                  //calculating Total of purchase
                                                  _PtotalAmounttext.text =
                                                      (tempsubtotal).toString();
                                                  PtotalAmount = tempsubtotal;
                                                });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: IconButton(
                                              icon: FaIcon(
                                                FontAwesomeIcons.plusCircle,
                                                color: ProductbtnColor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  print('Add Btn Call');
                                                  print(
                                                      'ProductName: $PProName');
                                                  LocalPurchaseProductName.add(
                                                      PProName);
                                                  LocalPurchaseProductRate.add(
                                                      PProRate);
                                                  LocalPurchaseProductQty.add(
                                                      TempQty);
                                                  LocalPurchaseProductSubTotal
                                                      .add(PProSubTotal);
                                                  tempsubtotal = 0;
                                                  LocalPurchaseProductSubTotal
                                                      .forEach((num e) {
                                                    tempsubtotal += e;
                                                  });
                                                  _PSubTotaltext.text =
                                                      (tempsubtotal).toString();
                                                  PSubTotal = tempsubtotal;

                                                  gst = 0;
                                                  //calculating Discount of sales
                                                  _PDiscounttext.text =
                                                      (gst).toString();
                                                  PDiscount = gst;
                                                  //calculating Gst of sales
                                                  _Pgsttext.text =
                                                      (gst).toString();
                                                  Pgst = gst;
                                                  //calculating Total of purchase
                                                  _PtotalAmounttext.text =
                                                      (tempsubtotal).toString();
                                                  PtotalAmount = tempsubtotal;
                                                  rowpro++;
                                                });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: IconButton(
                                              icon: FaIcon(
                                                FontAwesomeIcons.minusCircle,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if (rowpro != 1) {
                                                    rowpro--;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                      elevation: 5.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10.0),
                            child: TextField(
                              controller: _PSubTotaltext,
                              obscureText: false,
                              onChanged: (value) {
                                PSubTotal = double.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Subtotal Amount',
                                errorText: _PSubTotalvalidate
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
                              controller: _PDiscounttext,
                              obscureText: false,
                              onChanged: (value) {
                                PDiscount = double.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Discount Amount',
                                errorText: _PDiscountvalidate
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
                              controller: _Pgsttext,
                              obscureText: false,
                              onChanged: (value) {
                                Pgst = double.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'GST Amount',
                                errorText: _Pgstvalidate
                                    ? 'Enter Product GST Amount'
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
                              obscureText: false,
                              onChanged: (value) {
                                PMiscellaneons = double.parse(value);
                                print(PMiscellaneons);
                                if (PMiscellaneons == null) {
                                  PMiscellaneons = 0;
                                } else {
                                  PtotalAmount = PtotalAmount + PMiscellaneons;
                                  print(PtotalAmount);
                                  _PtotalAmounttext.text =
                                      (PtotalAmount).toString();
                                }
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
                              controller: _PtotalAmounttext,
                              obscureText: false,
                              onChanged: (value) {
                                PtotalAmount = double.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Total Amount',
                                errorText: _PtotalAmountvalidate
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
                              obscureText: false,
                              maxLines: 3,
                              onChanged: (value) {
                                PNarration = value;
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
                        child: FlatButton(
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black12),
                          ),
                          textColor: Colors.white,
                          onPressed: () async {
                            // Respond to button press
                            if (PDate == null ||
                                PProName == null ||
                                PProRate == null ||
                                PProQty == null ||
                                PProSubTotal == null ||
                                PSubTotal == null ||
                                PDiscount == null ||
                                Pgst == null ||
                                PtotalAmount == null) {
                              _PDatetext.text.isEmpty
                                  ? _PDatevalidate = true
                                  : _PDatevalidate = false;
                              // _PProNametext[index].text.isEmpty ? _PProNamevalidate = true : _PProNamevalidate = false;
                              // _PProRatetext[index].text.isEmpty ? _PProRatevalidate = true : _PProRatevalidate = false;
                              // _PProQtytext[index].text.isEmpty ? _PProQtyvalidate = true : _PProQtyvalidate = false;
                              // _PproSubTotaltext[index].text.isEmpty ? _PproSubTotalvalidate = true : _PproSubTotalvalidate = false;
                              _PSubTotaltext.text.isEmpty
                                  ? _PSubTotalvalidate = true
                                  : _PSubTotalvalidate = false;
                              _PDiscounttext.text.isEmpty
                                  ? _PDiscountvalidate = true
                                  : _PDiscountvalidate = false;
                              _Pgsttext.text.isEmpty
                                  ? _Pgstvalidate = true
                                  : _Pgstvalidate = false;
                              _PtotalAmounttext.text.isEmpty
                                  ? _PtotalAmountvalidate = true
                                  : _PtotalAmountvalidate = false;
                            } else {
                              String JoinedPurchaseProductName =
                                  LocalPurchaseProductName.join("#");
                              print(JoinedPurchaseProductName);
                              // var temp123 = JoinedProductName.split("#");
                              // print(temp123);
                              String JoinedPurchaseProductRate =
                                  LocalPurchaseProductRate.join("#");
                              print(JoinedPurchaseProductRate);
                              String JoinedPurchaseProductQty =
                                  LocalPurchaseProductQty.join("#");
                              print(JoinedPurchaseProductQty);
                              String JoinedPurchaseProductSubTotal =
                                  LocalPurchaseProductSubTotal.join("#");
                              print(JoinedPurchaseProductSubTotal);
                              print(PCompanyName);
                              print('Date: ${_PDatetext.text}');
                              print(LocalPurchaseProductName);
                              print(LocalPurchaseProductRate);
                              print(LocalPurchaseProductQty);
                              print(LocalPurchaseProductSubTotal);
                              print(PSubTotal);
                              print(PDiscount);
                              print(Pgst);
                              print(PMiscellaneons);
                              print(PtotalAmount);
                              print(PNarration);

                              //insert on server
                              // var result =
                              //     await purchaseinsert.getpospurchaseinsert(
                              //         PCompanyName,
                              //         _PDatetext.text.toString(),
                              //         JoinedPurchaseProductName,
                              //         JoinedPurchaseProductRate,
                              //         JoinedPurchaseProductQty,
                              //         JoinedPurchaseProductSubTotal,
                              //         PSubTotal.toString(),
                              //         PDiscount.toString(),
                              //         Pgst.toString(),
                              //         PMiscellaneons.toString(),
                              //         PtotalAmount.toString(),
                              //         PNarration);
                              // if (result == null) {
                              //   _showMyDialog('Filed !', Colors.red);
                              // } else {
                              //   _showMyDialog(
                              //       'Data Successfully Save !', Colors.green);
                              // }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "ADD PURCHASE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  //---------------Tablet Mode End-------------//
  //---------------Mobile Mode Start-------------//
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text('Add Purchase'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            shape: Border.all(color: Colors.blueGrey, width: 5),
            child: Column(children: [
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: DropdownSearch(
                  items: CompanyName,
                  // [
                  //   "Bosch",
                  //   "Vitoba",
                  //   "Ibm",
                  //   "Tcs",
                  //   "QIS",
                  //   "persistence",
                  // ],
                  label: "Supplier Company Name",
                  onChanged: (value) {
                    PCompanyName = value;
                    print(PCompanyName);
                  },
                  // validator: (String item) {
                  //   if (item == null)
                  //     return "Required field";
                  //   else if (item == "Brazil")
                  //     return "Invalid item";
                  //   else
                  //     return null;
                  // },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  // child: TextField(
                  //   obscureText: false,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: 'Purchase Date',
                  //   ),
                  // ),
                  child: DateTimeField(
                    format: format,
                    controller: _PDatetext,
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                    autovalidate: autoValidate,
                    validator: (date) => date == null ? 'Invalid date' : null,
                    onChanged: (date) => setState(() {
                      var formattedDate =
                          "${value.day}-${value.month}-${value.year}";
                      //value = date;
                      changedCount++;
                      PDate = formattedDate.toString();
                      print('Selected Date: $PDate');
                    }),
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
                      errorText: _PDatevalidate ? 'Enter Purchase Date' : null,
                      // helperText: 'Changed: $changedCount, Saved: $savedCount, $value',
                      // hintText: "Deactivated At: "
                    ),
                  )),
              //-------------------------------------------------------

              Container(
                height: 380.0,
                child: ListView.builder(
                    itemCount: rowpro,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      _PProNametext.add(new TextEditingController());
                      _PProRatetext.add(new TextEditingController());
                      _PProQtytext.add(new TextEditingController());
                      _PproSubTotaltext.add(new TextEditingController());
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Material(
                          //shape: Border.all(color: Colors.blueGrey, width: 5),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Add Purchase   ${index + 1} ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (rowpro != 1) {
                                                rowpro--;
                                              }
                                            });
                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.trash,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (PProName == null ||
                                                  PProRate == null ||
                                                  PProQty == null ||
                                                  PProSubTotal == null) {
                                                print('Product not ad');
                                                _PProNametext[index]
                                                        .text
                                                        .isEmpty
                                                    ? _PProNamevalidate = true
                                                    : _PProNamevalidate = false;
                                                _PProRatetext[index]
                                                        .text
                                                        .isEmpty
                                                    ? _PProRatevalidate = true
                                                    : _PProRatevalidate = false;
                                                _PProQtytext[index].text.isEmpty
                                                    ? _PProQtyvalidate = true
                                                    : _PProQtyvalidate = false;
                                                _PproSubTotaltext[index]
                                                        .text
                                                        .isEmpty
                                                    ? _PproSubTotalvalidate =
                                                        true
                                                    : _PproSubTotalvalidate =
                                                        false;
                                              } else {
                                                print(
                                                    'Product Name: $PProName');
                                                LocalPurchaseProductName.add(
                                                    PProName);
                                                LocalPurchaseProductRate.add(
                                                    PProRate);
                                                LocalPurchaseProductQty.add(
                                                    TempQty);
                                                LocalPurchaseProductSubTotal
                                                    .add(PProSubTotal);
                                                rowpro++;
                                              }
                                            });
                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.plus,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  color: Colors.blue,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _PProNametext[index],
                                    obscureText: false,
                                    onChanged: (value) {
                                      PProName = value;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Product Name',
                                      errorText: _PProNamevalidate
                                          ? 'Enter Product Name'
                                          : null,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: _PProRatetext[index],
                                          obscureText: false,
                                          onChanged: (value) {
                                            PProRate = double.parse(value);
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Rate',
                                            errorText: _PProRatevalidate
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
                                          controller: _PProQtytext[index],
                                          obscureText: false,
                                          onChanged: (value) {
                                            PProQty = double.parse(value);
                                            temp = (PProRate * PProQty);
                                            TempQty = int.parse(value);

                                            _PproSubTotaltext[index].text =
                                                temp.toString();
                                            PProSubTotal = double.parse(
                                                _PproSubTotaltext[index].text);
                                            //inserting data in Array
                                            // LocalPurchaseProductName.add(
                                            //     PProName);
                                            // LocalPurchaseProductRate.add(
                                            //     PProRate);
                                            // LocalPurchaseProductQty.add(
                                            //     TempQty);
                                            // LocalPurchaseProductSubTotal.add(
                                            //     PProSubTotal);
                                            //calculating SubTotal of sales
                                            tempsubtotal = 0;
                                            LocalPurchaseProductSubTotal
                                                .forEach((num e) {
                                              tempsubtotal += e;
                                            });
                                            _PSubTotaltext.text =
                                                (tempsubtotal).toString();
                                            PSubTotal = tempsubtotal;
                                            gst = 0;
                                            //calculating Discount of sales
                                            _PDiscounttext.text =
                                                (gst).toString();
                                            PDiscount = gst;
                                            //calculating Gst of sales
                                            _Pgsttext.text = (gst).toString();
                                            Pgst = gst;
                                            //calculating Total of purchase
                                            _PtotalAmounttext.text =
                                                (tempsubtotal).toString();
                                            PtotalAmount = tempsubtotal;
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Quantity',
                                            errorText: _PProQtyvalidate
                                                ? 'Enter Product Quntity'
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _PproSubTotaltext[index],
                                    obscureText: false,
                                    onChanged: (value) {
                                      PProSubTotal = double.parse(value);
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Product Subtotal',
                                      errorText: _PproSubTotalvalidate
                                          ? 'Enter Product Subtotal'
                                          : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          elevation: 10.0,
                        ),
                      );
                    }),
              ),

              //----------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _PSubTotaltext,
                  obscureText: false,
                  onChanged: (value) {
                    PSubTotal = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Subtotal Amount',
                    errorText: _PSubTotalvalidate
                        ? 'Enter Product Subtotal Amount'
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _PDiscounttext,
                  obscureText: false,
                  onChanged: (value) {
                    PDiscount = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Discount Amount',
                    errorText: _PDiscountvalidate
                        ? 'Enter Product Discount Amount'
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _Pgsttext,
                  obscureText: false,
                  onChanged: (value) {
                    Pgst = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'GST Amount',
                    errorText:
                        _Pgstvalidate ? 'Enter Product GST Amount' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  obscureText: false,
                  onChanged: (value) {
                    PMiscellaneons = double.parse(value);
                    print(PMiscellaneons);
                    if (PMiscellaneons == null) {
                      PMiscellaneons = 0;
                    } else {
                      PtotalAmount = PtotalAmount + PMiscellaneons;
                      print(PtotalAmount);
                      _PtotalAmounttext.text = (PtotalAmount).toString();
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Miscellaneous Amount',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _PtotalAmounttext,
                  obscureText: false,
                  onChanged: (value) {
                    PtotalAmount = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Total Amount',
                    errorText: _PtotalAmountvalidate
                        ? 'Enter Product Total Amount'
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  obscureText: false,
                  maxLines: 3,
                  onChanged: (value) {
                    PNarration = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Narration',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Material(
                  color: PRODUCTRATEBG,
                  borderRadius: BorderRadius.circular(10.0),
                  child: MaterialButton(
                    onPressed: () {
                      // Respond to button press
                      setState(() async {
                        if (PDate == null ||
                            PProName == null ||
                            PProRate == null ||
                            PProQty == null ||
                            PProSubTotal == null ||
                            PSubTotal == null ||
                            PDiscount == null ||
                            Pgst == null ||
                            PtotalAmount == null) {
                          _PDatetext.text.isEmpty
                              ? _PDatevalidate = true
                              : _PDatevalidate = false;
                          // _PProNametext[index].text.isEmpty ? _PProNamevalidate = true : _PProNamevalidate = false;
                          // _PProRatetext[index].text.isEmpty ? _PProRatevalidate = true : _PProRatevalidate = false;
                          // _PProQtytext[index].text.isEmpty ? _PProQtyvalidate = true : _PProQtyvalidate = false;
                          // _PproSubTotaltext[index].text.isEmpty ? _PproSubTotalvalidate = true : _PproSubTotalvalidate = false;
                          _PSubTotaltext.text.isEmpty
                              ? _PSubTotalvalidate = true
                              : _PSubTotalvalidate = false;
                          _PDiscounttext.text.isEmpty
                              ? _PDiscountvalidate = true
                              : _PDiscountvalidate = false;
                          _Pgsttext.text.isEmpty
                              ? _Pgstvalidate = true
                              : _Pgstvalidate = false;
                          _PtotalAmounttext.text.isEmpty
                              ? _PtotalAmountvalidate = true
                              : _PtotalAmountvalidate = false;
                        } else {
                          String JoinedPurchaseProductName =
                              LocalPurchaseProductName.join("#");
                          print(JoinedPurchaseProductName);
                          // var temp123 = JoinedProductName.split("#");
                          // print(temp123);
                          String JoinedPurchaseProductRate =
                              LocalPurchaseProductRate.join("#");
                          print(JoinedPurchaseProductRate);
                          String JoinedPurchaseProductQty =
                              LocalPurchaseProductQty.join("#");
                          print(JoinedPurchaseProductQty);
                          String JoinedPurchaseProductSubTotal =
                              LocalPurchaseProductSubTotal.join("#");
                          print(JoinedPurchaseProductSubTotal);
                          print(PCompanyName);
                          print(PDate);
                          print(LocalPurchaseProductName);
                          print(LocalPurchaseProductRate);
                          print(LocalPurchaseProductQty);
                          print(LocalPurchaseProductSubTotal);
                          print(PSubTotal);
                          print(PDiscount);
                          print(Pgst);
                          print(PMiscellaneons);
                          print(PtotalAmount);
                          print(PNarration);
                          //
                          //   // final pur= purchaseData.purchase;
                          //   Purchase purchse = new Purchase.copyWith(
                          //       PCompanyName,
                          //       PDate,
                          //       JoinedPurchaseProductName,
                          //       JoinedPurchaseProductRate,
                          //       JoinedPurchaseProductQty,
                          //       JoinedPurchaseProductSubTotal,
                          //       PSubTotal.toString(),
                          //       PDiscount.toString(),
                          //       Pgst.toString(),
                          //       PMiscellaneons.toString(),
                          //       PtotalAmount.toString(),
                          //       PNarration);
                          //   Provider.of<PurchaseDeleteProvider>(context,
                          //           listen: false)
                          //       .addPurchase(purchse);
                          //   DatabaseHelper databaseHelper = new DatabaseHelper();
                          //   var res =
                          //       await databaseHelper.insertPurchase(purchse);
                          //
                          //   //print("///////////////////${purchaseData.purchase.length}");
                          //   //insert on server
                          //   var result =
                          //       await purchaseinsert.getpospurchaseinsert(
                          //           PCompanyName,
                          //           PDate,
                          //           JoinedPurchaseProductName,
                          //           JoinedPurchaseProductRate,
                          //           JoinedPurchaseProductQty,
                          //           JoinedPurchaseProductSubTotal,
                          //           PSubTotal.toString(),
                          //           PDiscount.toString(),
                          //           Pgst.toString(),
                          //           PMiscellaneons.toString(),
                          //           PtotalAmount.toString(),
                          //           PNarration);
                          //
                          //   if (result == null && res == null) {
                          //     _showMyDialog('Filed !', Colors.red);
                          //   } else {
                          //     _showMyDialog(
                          //         'Data Successfully Save !', Colors.green);
                          //     print("//////in purchase////////$res");
                          //   }
                        }
                      });
                    },
                    minWidth: 100.0,
                    height: 35.0,
                    child: Text(
                      'Add Purchase',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  //---------------Mobile Mode End-------------//

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

  //-------------------------------------
//from server for fetching Company name
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
  }
//-------------------------------------

}
