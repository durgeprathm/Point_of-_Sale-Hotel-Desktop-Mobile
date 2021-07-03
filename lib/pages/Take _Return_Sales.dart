import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/pos_customer-fetch.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/LocalDbModels/customer_model.dart';
import 'package:retailerp/utils/const.dart';

import 'Add_Sales.dart';
import 'Manage_Sales.dart';
import 'dashboard.dart';

class TakeReturnSales extends StatefulWidget {
  @override
  _TakeReturnSalesState createState() => _TakeReturnSalesState();
}

class _TakeReturnSalesState extends State<TakeReturnSales> {
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileTakeReturnSales();
    } else {
      content = _buildTabletTakeReturnSales();
    }

    return content;
  }

  @override
  void initState() {
    _getCustomer();
  }

  List<CustomerModel> CustomerList = new List();
  List<String> customerName = new List();
  @override
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  final format = DateFormat("yyyy-MM-dd");
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;

  //String DepartmentName;
  String VoucherCustomerName;
  String VoucherNarration;
  String BillDate;
  String VoucherAmount;
  String BillNumber;

  bool _VoucherCustomervalidate = false;
  bool _BillDatevalidate = false;
  bool _BillNumbervalidate = false;
  bool _VoucherAmountvalidate = false;

  TextEditingController _VoucherCustomertext = TextEditingController();
  TextEditingController _BillDatetext = TextEditingController();
  TextEditingController __BillNumbertext = TextEditingController();
  TextEditingController _VoucherAmounttext = TextEditingController();

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletTakeReturnSales() {
    void handleClick(String value) {
      switch (value) {
        case 'View Sales Return':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.undoAlt),
            SizedBox(
              width: 20.0,
            ),
            Text('Take Sales Return'),
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
                'View Sales Return',
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
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownSearch(
                      isFilteredOnline: true,
                      showClearButton: true,
                      showSearchBox: true,
                      items: customerName,
                      label: "Customer Name",
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        VoucherCustomerName = value;
                      },
                    ),
                    // DropdownSearch(
                    //   items: customerName,
                    //   label: "Customer Name",
                    //   onChanged: (value) {
                    //     VoucherCustomerName = value;
                    //   },
                    //   // autoValidate:
                    //   // SCustomerName == null ? true : false,
                    //   dropdownSearchDecoration: InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     errorText: _VoucherCustomervalidate
                    //         ? 'Select Customer Name'
                    //         : null,
                    //   ),
                    // ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child:
                    DateTimeField(
                      controller: _BillDatetext,
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
                        labelText: 'Bill Date',
                        errorText: _BillDatevalidate ? 'Enter Bill Date' : null,
                      ),
                    ),
                    // DateTimeField(
                    //   format: format,
                    //   controller: _BillDatetext,
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
                    //   onChanged: (date) => setState(() {
                    //     var formattedDate =
                    //         "${value.day}-${value.month}-${value.year}";
                    //     changedCount++;
                    //     BillDate = formattedDate.toString();
                    //   }),
                    //   // onSaved: (date) => setState(() {
                    //   //   value = date;
                    //   //   savedCount++;
                    //   // }),
                    //   resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                    //   readOnly: readOnly,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     labelText: 'Bill Date',
                    //     errorText: _BillDatevalidate ? 'Enter Bill Date' : null,
                    //     // helperText: 'Changed: $changedCount, Saved: $savedCount, $value',
                    //     // hintText: "Deactivated At: "
                    //   ),
                    // ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Expanded(
                    child: DropdownSearch(
                      items: customerName,
                      label: "Select Bill Number",
                      onChanged: (value) {
                        BillNumber = value;
                      },

                      // autoValidate:
                      // SCustomerName == null ? true : false,
                      // dropdownSearchDecoration: InputDecoration(
                      //   border: OutlineInputBorder(),
                      //   errorText:
                      //       _BillNumbervalidate ? 'Select Bill Number' : null,
                      // ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _VoucherAmounttext,
                      obscureText: false,
                      onChanged: (value) {
                        VoucherAmount = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Voucher Amount',
                        errorText: _VoucherAmountvalidate
                            ? 'Enter Voucher Amount'
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      obscureText: false,
                      maxLines: 3,
                      onChanged: (value) {
                        VoucherNarration = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Narration',
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(200),
                            height: ScreenUtil.getInstance().setHeight(180),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                PrimaryColor,
                                PrimaryColor,
                              ]
                              ),
                              borderRadius: BorderRadius.circular(6.0),
                              // boxShadow: [
                              //   BoxShadow(
                              //       // color: Color(0xFF6078ea).withOpacity(.3),
                              //       color: PrimaryColor,
                              //       offset: Offset(0.0, 8.0),
                              //       blurRadius: 8.0)
                              // ]
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: ()  {
                                  setState(() {
                                    if (VoucherCustomerName == null ||
                                        BillDate == null ||
                                        BillNumber == null ||
                                        VoucherAmount == null) {
                                      _VoucherCustomertext.text.isEmpty
                                          ? _VoucherCustomervalidate = true
                                          : _VoucherCustomervalidate = false;
                                      _BillDatetext.text.isEmpty
                                          ? _BillDatevalidate = true
                                          : _BillDatevalidate = false;
                                      __BillNumbertext.text.isEmpty
                                          ? _BillNumbervalidate = true
                                          : _BillNumbervalidate = false;
                                      _VoucherAmounttext.text.isEmpty
                                          ? _VoucherAmountvalidate = true
                                          : _VoucherAmountvalidate = false;
                                    } else {
                                      print(VoucherCustomerName);
                                      print(BillDate);
                                      print(BillNumber);
                                      print(VoucherAmount);
                                      print(VoucherNarration);

                                      // Sales s = new Sales.copyWith(
                                      //     SCustomerName,
                                      //     SDate,
                                      //     JoinedProductName,
                                      //     JoinedProductRate,
                                      //     JoinedProductQty,
                                      //     JoinedProductSubTotal,
                                      //     SSubTotal.toString(),
                                      //     SDiscount.toString(),
                                      //     Sgst.toString(),
                                      //     StotalAmount.toString(),
                                      //     SNarration,
                                      //     "");
                                    }
                                  });
                                },
                                child: Center(
                                  child: Text("Exchange",
                                      style: btnTextStyle),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 15,),
                    Row(
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(200),
                            height: ScreenUtil.getInstance().setHeight(180),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                PrimaryColor,
                                PrimaryColor,
                              ]
                              ),
                              borderRadius: BorderRadius.circular(6.0),
                              // boxShadow: [
                              //   BoxShadow(
                              //       // color: Color(0xFF6078ea).withOpacity(.3),
                              //       color: PrimaryColor,
                              //       offset: Offset(0.0, 8.0),
                              //       blurRadius: 8.0)
                              // ]
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: ()  {
                                  setState(() {
                                    if (VoucherCustomerName == null ||
                                        BillDate == null ||
                                        BillNumber == null ||
                                        VoucherAmount == null) {
                                      _VoucherCustomertext.text.isEmpty
                                          ? _VoucherCustomervalidate = true
                                          : _VoucherCustomervalidate = false;
                                      _BillDatetext.text.isEmpty
                                          ? _BillDatevalidate = true
                                          : _BillDatevalidate = false;
                                      __BillNumbertext.text.isEmpty
                                          ? _BillNumbervalidate = true
                                          : _BillNumbervalidate = false;
                                      _VoucherAmounttext.text.isEmpty
                                          ? _VoucherAmountvalidate = true
                                          : _VoucherAmountvalidate = false;
                                    } else {
                                      print(VoucherCustomerName);
                                      print(BillDate);
                                      print(BillNumber);
                                      print(VoucherAmount);
                                      print(VoucherNarration);

                                      // Sales s = new Sales.copyWith(
                                      //     SCustomerName,
                                      //     SDate,
                                      //     JoinedProductName,
                                      //     JoinedProductRate,
                                      //     JoinedProductQty,
                                      //     JoinedProductSubTotal,
                                      //     SSubTotal.toString(),
                                      //     SDiscount.toString(),
                                      //     Sgst.toString(),
                                      //     StotalAmount.toString(),
                                      //     SNarration,
                                      //     "");
                                    }
                                  });
                                },
                                child: Center(
                                  child: Text("Generate Voucher",
                                      style: btnTextStyle),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  //--------Tablet Mode End-------------//

  //---------Mobile View-------------------//
  Widget _buildMobileTakeReturnSales() {
    void handleClick(String value) {
      switch (value) {
        case 'View Sales Return':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.undoAlt),
            SizedBox(
              width: 20.0,
            ),
            Text('Take Sales Return'),
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
                'View Sales Return',
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
                  items: customerName,
                  label: "Customer Name",
                  onChanged: (value) {
                    VoucherCustomerName = value;
                  },
                  // autoValidate:
                  // SCustomerName == null ? true : false,
                  // dropdownSearchDecoration: InputDecoration(
                  //   border: OutlineInputBorder(),
                  //   errorText: _VoucherCustomervalidate
                  //       ? 'Select Customer Name'
                  //       : null,
                  // ),
                ),
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
                  child:
                  DateTimeField(
                    controller: _BillDatetext,
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
                      labelText: 'Bill Date',
                      errorText: _BillDatevalidate ? 'Enter Bill Date' : null,
                    ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Expanded(
                  child: DropdownSearch(
                    items: customerName,
                    label: "Select Bill Number",
                    onChanged: (value) {
                      VoucherCustomerName = value;
                    },
                    // autoValidate:
                    // SCustomerName == null ? true : false,
                    // dropdownSearchDecoration: InputDecoration(
                    //   border: OutlineInputBorder(),
                    //   errorText: _VoucherCustomervalidate
                    //       ? 'Select Bill Number'
                    //       : null,
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Expanded(
                  child: TextField(
                    controller: _VoucherAmounttext,
                    obscureText: false,
                    onChanged: (value) {
                      VoucherAmount = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Voucher Amount',
                      errorText: _VoucherAmountvalidate
                          ? 'Enter Voucher Amount'
                          : null,
                    ),
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
                    VoucherNarration = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Narration',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                    child: Material(
                      color: PRODUCTRATEBG,
                      borderRadius: BorderRadius.circular(10.0),
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            if (VoucherCustomerName == null ||
                                BillDate == null ||
                                BillNumber == null ||
                                VoucherAmount == null) {
                              _VoucherCustomertext.text.isEmpty
                                  ? _VoucherCustomervalidate = true
                                  : _VoucherCustomervalidate = false;
                              _BillDatetext.text.isEmpty
                                  ? _BillDatevalidate = true
                                  : _BillDatevalidate = false;
                              __BillNumbertext.text.isEmpty
                                  ? _BillNumbervalidate = true
                                  : _BillNumbervalidate = false;
                              _VoucherAmounttext.text.isEmpty
                                  ? _VoucherAmountvalidate = true
                                  : _VoucherAmountvalidate = false;
                            } else {
                              print(VoucherCustomerName);
                              print(BillDate);
                              print(BillNumber);
                              print(VoucherAmount);
                              print(VoucherNarration);

                              // Sales s = new Sales.copyWith(
                              //     SCustomerName,
                              //     SDate,
                              //     JoinedProductName,
                              //     JoinedProductRate,
                              //     JoinedProductQty,
                              //     JoinedProductSubTotal,
                              //     SSubTotal.toString(),
                              //     SDiscount.toString(),
                              //     Sgst.toString(),
                              //     StotalAmount.toString(),
                              //     SNarration,
                              //     "");
                            }
                          });
                        },
                        minWidth: 100.0,
                        height: 35.0,
                        child: Text(
                          'Exchange',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                    child: Material(
                      color: PRODUCTRATEBG,
                      borderRadius: BorderRadius.circular(10.0),
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            if (VoucherCustomerName == null ||
                                BillDate == null ||
                                BillNumber == null ||
                                VoucherAmount == null) {
                              _VoucherCustomertext.text.isEmpty
                                  ? _VoucherCustomervalidate = true
                                  : _VoucherCustomervalidate = false;
                              _BillDatetext.text.isEmpty
                                  ? _BillDatevalidate = true
                                  : _BillDatevalidate = false;
                              __BillNumbertext.text.isEmpty
                                  ? _BillNumbervalidate = true
                                  : _BillNumbervalidate = false;
                              _VoucherAmounttext.text.isEmpty
                                  ? _VoucherAmountvalidate = true
                                  : _VoucherAmountvalidate = false;
                            } else {
                              print(VoucherCustomerName);
                              print(BillDate);
                              print(BillNumber);
                              print(VoucherAmount);
                              print(VoucherNarration);

                              // Sales s = new Sales.copyWith(
                              //     SCustomerName,
                              //     SDate,
                              //     JoinedProductName,
                              //     JoinedProductRate,
                              //     JoinedProductQty,
                              //     JoinedProductSubTotal,
                              //     SSubTotal.toString(),
                              //     SDiscount.toString(),
                              //     Sgst.toString(),
                              //     StotalAmount.toString(),
                              //     SNarration,
                              //     "");
                            }
                          });
                        },
                        minWidth: 100.0,
                        height: 35.0,
                        child: Text(
                          'Generate Voucher',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

//---------Mobile View End-------------------//

  //-------------------------------------
//from server customer From data base
  void _getCustomer() async {
    CustomerFetch customerfetch = new CustomerFetch();
    var customerData = await customerfetch.getCustomerFetch("1");
    var resid = customerData["resid"];
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
      this.CustomerList = tempCustomer;
    });
    print("//////SalesList/////////$CustomerList.length");

    List<String> tempCustomerNames = [];
    for (int i = 0; i < CustomerList.length; i++) {
      tempCustomerNames.add(CustomerList[i].custName);
    }
    setState(() {
      this.customerName = tempCustomerNames;
    });
    print(customerName);
  }
//-------------------------------------

}
