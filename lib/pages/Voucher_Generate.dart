import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/pos_customer-fetch.dart';
import 'package:retailerp/Adpater/pos_fetch_Voucher_bill_Totalamount.dart';
import 'package:retailerp/Adpater/pos_voucher_bill_number_fetch.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/LocalDbModels/customer_model.dart';
import 'package:retailerp/models/Sales.dart';

import 'Manage_Sales.dart';
import 'dashboard.dart';

class VoucherGenerate extends StatefulWidget {
  @override
  _VoucherGenerateState createState() => _VoucherGenerateState();
}

class _VoucherGenerateState extends State<VoucherGenerate> {
  static const int kTabletBreakpoint = 552;
  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileVoucherGenerate();
    } else {
      content = _buildTabletVoucherGenerate();
    }

    return content;
  }

  @override
  void initState() {
    _getCustomer();
  }

  List<CustomerModel> CustomerList = new List();
  List<String> customerName = new List();
  List<Sales> BillNumberList = new List();
  //List<Sales> BillTotalAmountList = new List();
  List<int> BillNumber = new List();
  List<Sales> BillTotalAmount = new List();

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
  //String BillNumber;

  bool _VoucherCustomervalidate = false;
  bool _BillDatevalidate = false;
  bool _BillNumbervalidate = false;
  bool _VoucherAmountvalidate = false;

  TextEditingController _VoucherCustomertext = TextEditingController();
  TextEditingController _BillDatetext = TextEditingController();
  TextEditingController __BillNumbertext = TextEditingController();
  TextEditingController _VoucherAmounttext = TextEditingController();
  //---------------Tablet Mode Start-------------//
  Widget _buildTabletVoucherGenerate() {
    void handleClick(String value) {
      switch (value) {
        case 'Manage Voucher':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ManageSales()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.gift),
            SizedBox(
              width: 20.0,
            ),
            Text('Voucher Generate'),
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
                'Manage Voucher',
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
              padding: const EdgeInsets.all(40.0),
              child: Material(
                shape: Border.all(color: Colors.blueGrey, width: 5),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownSearch(
                                items: customerName,
                                label: "Customer Name",
                                onChanged: (value) {
                                  VoucherCustomerName = value;
                                  print(VoucherCustomerName);
                                },
                                // autoValidate:
                                // SCustomerName == null ? true : false,
                                dropdownSearchDecoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  errorText: _VoucherCustomervalidate
                                      ? 'Select Customer Name'
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
                                child: DateTimeField(
                                  format: format,
                                  controller: _BillDatetext,
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
                                    BillDate = formattedDate.toString();
                                    print(BillDate);
                                    print("////date//$BillDate///name////$VoucherCustomerName");
                                    _getBillNumberFetchdata(BillDate,VoucherCustomerName);
                                  }),
                                  resetIcon:
                                      showResetIcon ? Icon(Icons.delete) : null,
                                  readOnly: readOnly,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Bill Date',
                                    errorText: _BillDatevalidate
                                        ? 'Enter Bill Date'
                                        : null,
                                    // helperText: 'Changed: $changedCount, Saved: $savedCount, $value',
                                    // hintText: "Deactivated At: "
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownSearch(
                                items: BillNumber,
                                label: "Select Bill Number",
                                onChanged: (value) {
                                  BillNumber = value;
                                },
                                // autoValidate:
                                // SCustomerName == null ? true : false,
                                dropdownSearchDecoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  errorText: _BillNumbervalidate
                                      ? 'Select Bill Number'
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
                                  VoucherNarration = value;
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
                            onPressed: () {
                              // Respond to button press
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
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "Generate Voucher",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
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
      ),
    );
  }

  //--------Tablet Mode End-------------//

  //---------Mobile View-------------------//
  Widget _buildMobileVoucherGenerate() {
    void handleClick(String value) {
      switch (value) {
        case 'Manage Voucher':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ManageSales()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.gift),
            SizedBox(
              width: 20.0,
            ),
            Text('Voucher Generate'),
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
                'Manage Voucher',
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
            child: Column(
                children: [
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
                  dropdownSearchDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    errorText: _VoucherCustomervalidate
                        ? 'Select Customer Name'
                        : null,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: DateTimeField(
                    format: format,
                    controller: _BillDatetext,
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
                      changedCount++;
                      BillDate = formattedDate.toString();
                      _getBillNumberFetchdata(BillDate,VoucherCustomerName);
                    }),
                    resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                    readOnly: readOnly,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Bill Date',
                      errorText: _BillDatevalidate ? 'Enter Bill Date' : null,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Expanded(
                  child: DropdownSearch(
                    items: BillNumber,
                    label: "Select Bill Number",
                    onChanged: (value) {
                      VoucherCustomerName = value;
                    },
                    dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      errorText: _VoucherCustomervalidate
                          ? 'Select Bill Number'
                          : null,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Expanded(
                  child: TextField(
                    controller: _VoucherAmounttext,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
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
  //-------------------------------------
//from server Bill Number From data base
  void _getBillNumberFetchdata(String date,String name) async {
    print("////date//$date///name////$name");
    VoucherBillNoFetch voucherbillnofetch = new VoucherBillNoFetch();
    var voucherbillnoData = await voucherbillnofetch.getVoucherBillNoFetch(date,name);
    var resid = voucherbillnoData["resid"];
    var voucherbillnosd = voucherbillnoData["sales"];
   //print(voucherbillnosd.length);
    List<Sales> tempvoucherbillno = [];
    for (var n in voucherbillnosd) {
      Sales pro = Sales(
          int.parse(n["SalesId"]),
          n["SalesCustomername"],
          n["SalesDate"],
          n["SalesProductName"],
          n["SalesProductRate"],
          n["SalesProductQty"],
          n["SalesProductSubTotal"],
          n["SalesSubTotal"],
          n["SalesDiscount"],
          n["SalesGST"],
          n["SalesTotalAmount"],
          n["SalesNarration"],
          n["SalesPaymentMode"]);
      tempvoucherbillno.add(pro);
    }
    setState(() {
      this.BillNumberList = tempvoucherbillno;
    });
    print("//////SalesList/////////$BillNumberList.length");

    List<int> tempbillno = [];
    for (int i = 0; i < BillNumberList.length; i++) {
      tempbillno.add(BillNumberList[i].Salesid);
    }

    setState(() {
      this.BillNumber = tempbillno;
    });
    print(BillNumber);
  }
//-------------------------------------
  //-------------------------------------
//from server Bill Number From data base
  void _getBillTotalAmountFetchdata(String billnumber) async {
    VoucherBillTotalAmountFetch voucherbilltotalamountfetch = new VoucherBillTotalAmountFetch();
    var voucherbilltotalamountData = await voucherbilltotalamountfetch.getVoucherBillNoFetch(billnumber);
    var resid = voucherbilltotalamountData["resid"];
    var voucherbilltotalamountsd = voucherbilltotalamountData["sales"];
    List<Sales> tempvoucherbilltotalamount=[];
    for (var n in voucherbilltotalamountsd) {
      Sales pro = Sales.withtotalamount(
          n["SalesTotalAmount"],
         );
      tempvoucherbilltotalamount.add(pro);
    }
    String vv;
    vv=tempvoucherbilltotalamount[0].SalesTotal;
    _VoucherAmounttext.text=vv;
  }
//-------------------------------------

}
