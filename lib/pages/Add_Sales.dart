import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/pos_customer-fetch.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/LocalDbModels/customer_model.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/pages/sale_billing_new.dart';


import 'Import_sales.dart';
import 'Manage_Sales.dart';
import 'dashboard.dart';

class AddSales extends StatefulWidget {
  @override
  _AddSalesState createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
  static const int kTabletBreakpoint = 552;
  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery
        .of(context)
        .size
        .shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileAddSales();
    } else {
      content = _buildTabletAddSales();
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

  int rowpro = 1;
  final _SDatetext = TextEditingController();
  final _SCustomertext = TextEditingController();

  // final _SProNametext = TextEditingController();
  // final _SProRatetext = TextEditingController();
  // final _SProQtytext = TextEditingController();
  // final _SproSubTotaltext = TextEditingController();
  TextEditingController _SSubTotaltext = TextEditingController();
  TextEditingController _SDiscounttext = TextEditingController();
  TextEditingController _Sgsttext = TextEditingController();
  TextEditingController _StotalAmounttext = TextEditingController();

  bool _SDatevalidate = false;
  bool _SProNamevalidate = false;
  bool _SProRatevalidate = false;
  bool _SProQtyvalidate = false;
  bool _SproSubTotalvalidate = false;
  bool _SSubTotalvalidate = false;
  bool _SDiscountvalidate = false;
  bool _Sgstvalidate = false;
  bool _StotalAmountvalidate = false;
  bool _SCustomervalidate = false;

  // String SDate;
  String SProName;
  double SProRate;
  double SProQty;
  double SproSubTotal;
  double SSubTotal;
  double SDiscount;
  double Sgst;
  double StotalAmount;
  String SNarration;
  double temp;
  double tempsubtotal;
  double gst;
  String SDate;
  String SCustomerName;
  int TempQty;

  List<String> LocalProductName = new List();
  List<double> LocalProductRate = new List();
  List<int> LocalProductQty = new List();
  List<double> LocalProductSubTotal = new List();
  List<TextEditingController> _SProNametext = new List();
  List<TextEditingController> _SProRatetext = new List();
  List<TextEditingController> _SProQtytext = new List();
  List<TextEditingController> _SproSubTotaltext = new List();

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletAddSales() {

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text('Sales Brochure'),
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
                            child: Container(
                              height: 68,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                // child: TextField(
                                //   obscureText: false,
                                //   decoration: InputDecoration(
                                //     border: OutlineInputBorder(),
                                //     labelText: 'Purchase Date',
                                //   ),
                                // ),

                                child: DropdownSearch(
                                  items: //[
                                     customerName,
                                    // "Prathmesh Durge",
                                    // "Rajat Bhatulakar",
                                    // "Praful Sakharkhede",
                                    // "Ajikya Bhonde",
                                    // "Mrunal Gadepayale",
                                    // "Heena Mehar",
                                    // "Siddesh Dadwe",
                                    // "Pratikahya Awadude",
                                    // "Harsh Carathe"
                                  //],
                                  label: "Customer Name",
                                  onChanged: (value) {
                                    SCustomerName = value;
                                  },
                                  // autoValidate:
                                  // SCustomerName == null ? true : false,
                                  dropdownSearchDecoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    errorText: _SCustomervalidate
                                        ? 'Select Customer Name'
                                        : null,
                                  ),
                                  // validator: (SPersonName) {
                                  //   if (SPersonName == null)
                                  //     return "Select Customer Name";
                                  //   else
                                  //     return null;
                                  // },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
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
                                  format: format,
                                  controller: _SDatetext,
                                  onShowPicker: (context,
                                      currentValue) async {
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
                                      return DateTimeField.combine(
                                          date, time);
                                    } else {
                                      return currentValue;
                                    }
                                  },
                                  autovalidate: autoValidate,
                                  validator: (date) =>
                                  date == null ? 'Invalid date' : null,
                                  onChanged: (date) =>
                                      setState(() {
                                        var formattedDate = "${value.day}-${value.month}-${value.year}";
                                        changedCount++;
                                        SDate = formattedDate.toString();
                                      }),
                                  // onSaved: (date) => setState(() {
                                  //   value = date;
                                  //   savedCount++;
                                  // }),
                                  resetIcon:
                                  showResetIcon ? Icon(Icons.delete) : null,
                                  readOnly: readOnly,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Sales Date',
                                    errorText: _SDatevalidate
                                        ? 'Enter Sales Date'
                                        : null,
                                    // helperText: 'Changed: $changedCount, Saved: $savedCount, $value',
                                    // hintText: "Deactivated At: "
                                  ),
                                )),
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
                                  _SProNametext.add(
                                      new TextEditingController());
                                  _SProRatetext.add(
                                      new TextEditingController());
                                  _SProQtytext.add(
                                      new TextEditingController());
                                  _SproSubTotaltext.add(
                                      new TextEditingController());
                                  return Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                15.0),
                                            child:
                                            TextField(
                                              controller: _SProNametext[index],
                                              obscureText: false,
                                              onChanged: (value) {
                                                SProName = value;
                                              },
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Product Name',
                                                errorText: _SProNamevalidate
                                                    ? 'Enter Product Name'
                                                    : null,
                                              ),
                                            ),
                                            // DropdownSearch(
                                            //   items: customerName,
                                            //   label: "Customer Name",
                                            //   //controller: _SProNametext[index],
                                            //   onChanged: (value) {
                                            //     SCustomerName = value;
                                            //   },
                                            //   // autoValidate:
                                            //   // SCustomerName == null ? true : false,
                                            //   dropdownSearchDecoration: InputDecoration(
                                            //     border: OutlineInputBorder(),
                                            //     errorText: _SCustomervalidate
                                            //         ? 'Select Customer Name'
                                            //         : null,
                                            //   ),
                                            // ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                8.0),
                                            child: TextField(
                                              controller: _SProRatetext[index],
                                              obscureText: false,
                                              keyboardType:
                                              TextInputType.number,
                                              onChanged: (value) {
                                                SProRate =
                                                    double.parse(value);
                                              },
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Product Rate',
                                                errorText: _SProRatevalidate
                                                    ? 'Enter Product Rate'
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                8.0),
                                            child: TextField(
                                              controller: _SProQtytext[index],
                                              obscureText: false,
                                              keyboardType:
                                              TextInputType.number,
                                              onChanged: (value) {
                                                SProQty = double.parse(value);
                                                temp = (SProRate * SProQty);
                                                TempQty = int.parse(value);
                                                // _SproSubTotaltext[index]. = temp;
                                                _SproSubTotaltext[index]
                                                    .text =
                                                    temp.toString();
                                                SproSubTotal = double.parse(
                                                    _SproSubTotaltext[index]
                                                        .text);
                                                //inserting data in Array
                                                LocalProductName.add(
                                                    SProName);
                                                LocalProductRate.add(
                                                    SProRate);
                                                LocalProductQty.add(TempQty);
                                                LocalProductSubTotal.add(
                                                    SproSubTotal);

                                                //calculating SubTotal of sales
                                                tempsubtotal = 0;
                                                LocalProductSubTotal.forEach(
                                                        (num e) {
                                                      tempsubtotal += e;
                                                    });
                                                _SSubTotaltext.text =
                                                    (tempsubtotal).toString();
                                                SSubTotal = tempsubtotal;
                                                gst = 0;
                                                //calculating Discount of sales
                                                _SDiscounttext.text =
                                                    (gst).toString();
                                                SDiscount = gst;
                                                //calculating Gst of sales
                                                _Sgsttext.text =
                                                    (gst).toString();
                                                Sgst = gst;
                                                //calculating Total of sales
                                                _StotalAmounttext.text =
                                                    (tempsubtotal).toString();
                                                StotalAmount = tempsubtotal;
                                              },
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Product Quantity',
                                                errorText: _SProQtyvalidate
                                                    ? 'Enter Product Quantity'
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                8.0),
                                            child: TextField(
                                              controller:
                                              _SproSubTotaltext[index],
                                              obscureText: false,
                                              keyboardType:
                                              TextInputType.number,
                                              onChanged: (value) {},
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Product Subtotal',
                                                // errorText: _SproSubTotalvalidate ? 'Enter Product Subtotal' : null,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(0.0),
                                              child: IconButton(
                                                icon: FaIcon(
                                                  FontAwesomeIcons.plusCircle,
                                                  color: ProductbtnColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    if (SProName == null ||
                                                        SProRate == null ||
                                                        SProQty == null) {
                                                      _SProNametext[index]
                                                          .text
                                                          .isEmpty
                                                          ?
                                                      _SProNamevalidate =
                                                      true
                                                          : _SProNamevalidate =
                                                      false;
                                                      _SProRatetext[index]
                                                          .text
                                                          .isEmpty
                                                          ?
                                                      _SProRatevalidate =
                                                      true
                                                          : _SProRatevalidate =
                                                      false;
                                                      _SProQtytext[index]
                                                          .text
                                                          .isEmpty
                                                          ? _SProQtyvalidate =
                                                      true
                                                          : _SProQtyvalidate =
                                                      false;
                                                      // _SproSubTotaltext[index].text.isEmpty ? _SproSubTotalvalidate = true : _SproSubTotalvalidate = false;
                                                    } else {
                                                      // SProName="";
                                                      // SProRate="";
                                                      // SProQty="";
                                                      rowpro++;

                                                      // print( _controllers1[index]);
                                                      print(
                                                          "///////PRODUCTNAME////////$LocalProductName");
                                                      print(
                                                          "///////PRODUCTRATE////////$LocalProductRate");
                                                      print(
                                                          "///////PRODUCTQTY////////$LocalProductQty");
                                                      print(
                                                          "///////PRODUCTSUBTOTAL////////$LocalProductSubTotal");
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(0.0),
                                              child: IconButton(
                                                icon: FaIcon(
                                                  FontAwesomeIcons
                                                      .minusCircle,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    if (rowpro != 1) {
                                                      rowpro--;
                                                      LocalProductName
                                                          .removeAt(
                                                          index);
                                                      LocalProductRate
                                                          .removeAt(
                                                          index);
                                                      LocalProductQty
                                                          .removeAt(
                                                          index);
                                                      LocalProductSubTotal
                                                          .removeAt(index);
                                                      // _SProNametext[index].clear();
                                                      // _SProRatetext[index].clear();
                                                      // _SProQtytext[index].clear();
                                                      // _SproSubTotaltext[index].clear();
                                                      print(LocalProductName);
                                                      print(LocalProductRate);
                                                      print(LocalProductQty);
                                                      print(
                                                          LocalProductSubTotal);
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
                                controller: _SSubTotaltext,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Subtotal Amount',
                                  errorText: _SSubTotalvalidate
                                      ? 'Plz Enter Subtotal Amount'
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
                                controller: _SDiscounttext,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  SDiscount = double.parse(value);
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Discount Amount',
                                  errorText: _SDiscountvalidate
                                      ? 'Plz Enter Discount Amount'
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
                                controller: _Sgsttext,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  Sgst = double.parse(value);
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'GST Amount',
                                  errorText: _Sgstvalidate
                                      ? 'Plz Enter GST Amount'
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
                                controller: _StotalAmounttext,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  StotalAmount = double.parse(value);
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Total Amount',
                                  errorText: _StotalAmountvalidate
                                      ? 'Plz Enter Total Amount'
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
                                  SNarration = value;
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
                                if (SProName == null ||
                                    SProRate == null ||
                                    SProQty == null ||
                                    SproSubTotal == null ||
                                    SSubTotal == null ||
                                    SDiscount == null ||
                                    Sgst == null ||
                                    StotalAmount == null) {
                                  _SDatetext.text.isEmpty
                                      ? _SDatevalidate = true
                                      : _SDatevalidate = false;
                                  _SCustomertext.text.isEmpty
                                      ? _SCustomervalidate = true
                                      : _SCustomervalidate = false;
                                  // _SProNametext[index].text.isEmpty ? _SProNamevalidate = true : _SProNamevalidate = false;
                                  // _SProRatetext.text.isEmpty ? _SProRatevalidate = true : _SProRatevalidate = false;
                                  // _SProQtytext.text.isEmpty ? _SProQtyvalidate = true : _SProQtyvalidate = false;
                                  // _SproSubTotaltext.text.isEmpty ? _SproSubTotalvalidate = true : _SproSubTotalvalidate = false;
                                  _SSubTotaltext.text.isEmpty
                                      ? _SSubTotalvalidate = true
                                      : _SSubTotalvalidate = false;
                                  _SDiscounttext.text.isEmpty
                                      ? _SDiscountvalidate = true
                                      : _SDiscountvalidate = false;
                                  _Sgsttext.text.isEmpty
                                      ? _Sgstvalidate = true
                                      : _Sgstvalidate = false;
                                  _StotalAmounttext.text.isEmpty
                                      ? _StotalAmountvalidate = true
                                      : _StotalAmountvalidate = false;
                                } else {
                                  String JoinedProductName =
                                  LocalProductName.join("#");
                                  print(JoinedProductName);
                                  // var temp123 = JoinedProductName.split("#");
                                  // print(temp123);
                                  String JoinedProductRate =
                                  LocalProductRate.join("#");
                                  print(JoinedProductRate);
                                  String JoinedProductQty =
                                  LocalProductQty.join("#");
                                  print(JoinedProductQty);
                                  String JoinedProductSubTotal =
                                  LocalProductSubTotal.join("#");
                                  print(JoinedProductSubTotal);
                                  print(SCustomerName);
                                  print(SDate);
                                  print(LocalProductName);
                                  print(LocalProductRate);
                                  print(LocalProductQty);
                                  print(LocalProductSubTotal);
                                  print(SSubTotal);
                                  print(SDiscount);
                                  print(Sgst);
                                  print(StotalAmount);
                                  print(SNarration);
                                  Sales s = new Sales.copyWith(
                                      SCustomerName,
                                      SDate,
                                      JoinedProductName,
                                      JoinedProductRate,
                                      JoinedProductQty,
                                      JoinedProductSubTotal,
                                      SSubTotal.toString(),
                                      SDiscount.toString(),
                                      Sgst.toString(),
                                      StotalAmount.toString(),
                                      SNarration,
                                      "");
                                  // showModalBottomSheet(
                                  //     context: context,
                                  //     isScrollControlled: true,
                                  //     builder: (context) =>
                                  //         SingleChildScrollView(
                                  //             child: Container(
                                  //               padding: EdgeInsets.only(
                                  //                   bottom:
                                  //                   MediaQuery
                                  //                       .of(context)
                                  //                       .viewInsets
                                  //                       .bottom),
                                  //               child: SaleBillingScreenNew(s),
                                  //             )));
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "PAYMENT",
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
  Widget _buildMobileAddSales() {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text('Sales Brochure'),
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
                // child: TextField(
                //   obscureText: false,
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     labelText: 'Purchase Date',
                //   ),
                // ),

                child: DropdownSearch(
                  items: customerName,
                  // [
                  //   "Prathmesh Durge",
                  //   "Rajat Bhatulakar",
                  //   "Praful Sakharkhede",
                  //   "Ajikya Bhonde",
                  //   "Mrunal Gadepayale",
                  //   "Heena Mehar",
                  //   "Siddesh Dadwe",
                  //   "Pratikahya Awadude",
                  //   "Harsh Carathe"
                  // ],
                  label: "Customer Name",
                  onChanged: (value) {
                     SCustomerName=value;
                  },
                  // autoValidate:
                  // SCustomerName == null ? true : false,
                  dropdownSearchDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    errorText: _SCustomervalidate ? 'Select Customer Name' : null,
                  ),
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
                  child: DateTimeField(
                    format: format,
                    controller: _SDatetext,
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
                    onChanged: (date) =>
                        setState(() {
                          var formattedDate = "${value.day}-${value.month}-${value.year}";
                          changedCount++;
                          SDate = formattedDate.toString();
                        }),
                    // onSaved: (date) => setState(() {
                    //   value = date;
                    //   savedCount++;
                    // }),
                    resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                    readOnly: readOnly,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Sales Date',
                      errorText: _SDatevalidate ? 'Enter Sales Date' : null,
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
                      _SProNametext.add(new TextEditingController());
                      _SProRatetext.add(new TextEditingController());
                      _SProQtytext.add(new TextEditingController());
                      _SproSubTotaltext.add(new TextEditingController());
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
                                    mainAxisAlignment: MainAxisAlignment
                                        .center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Add Sales   ${index + 1} ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50.0,
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
                                          icon: FaIcon(FontAwesomeIcons.trash,
                                            color: Colors.white,

                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (SProName == null ||
                                                  SProRate == null ||
                                                  SProQty == null) {
                                                _SProNametext[index].text
                                                    .isEmpty
                                                    ? _SProNamevalidate = true
                                                    : _SProNamevalidate =
                                                false;
                                                _SProRatetext[index].text
                                                    .isEmpty
                                                    ? _SProRatevalidate = true
                                                    : _SProRatevalidate =
                                                false;
                                                _SProQtytext[index].text
                                                    .isEmpty
                                                    ? _SProQtyvalidate = true
                                                    : _SProQtyvalidate =
                                                false;
                                                // _SproSubTotaltext[index].text.isEmpty ? _SproSubTotalvalidate = true : _SproSubTotalvalidate = false;
                                              }
                                              else {
                                                // SProName="";
                                                // SProRate="";
                                                // SProQty="";
                                                rowpro++;

                                                // print( _controllers1[index]);
                                                print(
                                                    "///////PRODUCTNAME////////$LocalProductName");
                                                print(
                                                    "///////PRODUCTRATE////////$LocalProductRate");
                                                print(
                                                    "///////PRODUCTQTY////////$LocalProductQty");
                                                print(
                                                    "///////PRODUCTSUBTOTAL////////$LocalProductSubTotal");
                                              }
                                            });
                                          },
                                          icon: FaIcon(FontAwesomeIcons.plus,
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
                                    controller: _SProNametext[index],
                                    obscureText: false,
                                    onChanged: (value) {
                                      SProName = value;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Product Name',
                                      errorText: _SProNamevalidate
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
                                          controller: _SProRatetext[index],
                                          obscureText: false,
                                          keyboardType:
                                          TextInputType.number,
                                          onChanged: (value) {
                                            SProRate = double.parse(value);
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Rate',
                                            errorText: _SProRatevalidate
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
                                          controller: _SProQtytext[index],
                                          obscureText: false,
                                          keyboardType:
                                          TextInputType.number,
                                          onChanged: (value) {
                                            SProQty = double.parse(value);
                                            temp = (SProRate * SProQty);
                                            TempQty = int.parse(value);
                                            // _SproSubTotaltext[index]. = temp;
                                            _SproSubTotaltext[index].text =
                                                temp.toString();
                                            SproSubTotal = double.parse(
                                                _SproSubTotaltext[index]
                                                    .text);
                                            //inserting data in Array
                                            LocalProductName.add(SProName);
                                            LocalProductRate.add(SProRate);
                                            LocalProductQty.add(TempQty);
                                            LocalProductSubTotal.add(
                                                SproSubTotal);

                                            //calculating SubTotal of sales
                                            tempsubtotal = 0;
                                            LocalProductSubTotal.forEach((
                                                num e) {
                                              tempsubtotal += e;
                                            });
                                            _SSubTotaltext.text =
                                                (tempsubtotal).toString();
                                            SSubTotal = tempsubtotal;
                                            gst = 0;
                                            //calculating Discount of sales
                                            _SDiscounttext.text =
                                                (gst).toString();
                                            SDiscount = gst;
                                            //calculating Gst of sales
                                            _Sgsttext.text = (gst).toString();
                                            Sgst = gst;
                                            //calculating Total of sales
                                            _StotalAmounttext.text =
                                                (tempsubtotal).toString();
                                            StotalAmount = tempsubtotal;
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Quantity',
                                            errorText: _SProQtyvalidate
                                                ? 'Enter Product Quantity'
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
                                    controller: _SproSubTotaltext[index],
                                    readOnly: true,
                                    enableInteractiveSelection: true,
                                    obscureText: false,
                                    keyboardType:
                                    TextInputType.number,
                                    onChanged: (value) {},
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Product Subtotal',
                                      errorText: _SproSubTotalvalidate
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
                    }
                ),
              ),

              //----------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _SSubTotaltext,
                  readOnly: true,
                  enableInteractiveSelection: true,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Subtotal Amount',
                    errorText: _SSubTotalvalidate
                        ? 'Plz Enter Subtotal Amount'
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _SDiscounttext,
                  readOnly: true,
                  enableInteractiveSelection: true,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    SDiscount = double.parse(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Discount Amount',
                    errorText: _SDiscountvalidate
                        ? 'Plz Enter Discount Amount'
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _Sgsttext,
                  readOnly: true,
                  enableInteractiveSelection: true,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    Sgst = double.parse(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'GST Amount',
                    errorText: _Sgstvalidate ? 'Plz Enter GST Amount' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _StotalAmounttext,
                  readOnly: true,
                  enableInteractiveSelection: true,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    StotalAmount = double.parse(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Total Amount',
                    errorText: _StotalAmountvalidate
                        ? 'Plz Enter Total Amount'
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
                    SNarration = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Narration',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Material(
                  color: PRODUCTRATEBG,
                  borderRadius: BorderRadius.circular(10.0),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        if (SProName == null || SProRate == null ||
                            SProQty == null || SproSubTotal == null ||
                            SSubTotal == null || SDiscount == null ||
                            Sgst == null || StotalAmount == null) {
                          _SDatetext.text.isEmpty
                              ? _SDatevalidate = true
                              : _SDatevalidate = false;
                          _SCustomertext.text.isEmpty ?
                          _SCustomervalidate = true : _SCustomervalidate =
                          false;
                          // _SProNametext[index].text.isEmpty ? _SProNamevalidate = true : _SProNamevalidate = false;
                          // _SProRatetext.text.isEmpty ? _SProRatevalidate = true : _SProRatevalidate = false;
                          // _SProQtytext.text.isEmpty ? _SProQtyvalidate = true : _SProQtyvalidate = false;
                          // _SproSubTotaltext.text.isEmpty ? _SproSubTotalvalidate = true : _SproSubTotalvalidate = false;
                          _SSubTotaltext.text.isEmpty ?
                          _SSubTotalvalidate = true : _SSubTotalvalidate =
                          false;
                          _SDiscounttext.text.isEmpty ?
                          _SDiscountvalidate = true : _SDiscountvalidate =
                          false;
                          _Sgsttext.text.isEmpty
                              ? _Sgstvalidate = true
                              : _Sgstvalidate = false;
                          _StotalAmounttext.text.isEmpty
                              ? _StotalAmountvalidate = true
                              : _StotalAmountvalidate = false;
                        }
                        else {
                          String JoinedProductName = LocalProductName.join(
                              "#");
                          print(JoinedProductName);
                          String JoinedProductRate = LocalProductRate.join(
                              "#");
                          print(JoinedProductRate);
                          String JoinedProductQty = LocalProductQty.join("#");
                          print(JoinedProductQty);
                          String JoinedProductSubTotal = LocalProductSubTotal
                              .join("#");
                          print(JoinedProductSubTotal);
                          print(SCustomerName);
                          print(SDate);
                          print(LocalProductName);
                          print(LocalProductRate);
                          print(LocalProductQty);
                          print(LocalProductSubTotal);
                          print(SSubTotal);
                          print(SDiscount);
                          print(Sgst);
                          print(StotalAmount);
                          print(SNarration);
                          Sales s = new Sales.copyWith(SCustomerName, SDate, JoinedProductName, JoinedProductRate, JoinedProductQty, JoinedProductSubTotal, SSubTotal.toString(), SDiscount.toString(), Sgst.toString(), StotalAmount.toString(), SNarration,"");
                          // showModalBottomSheet(
                          //     context: context,
                          //     isScrollControlled: true,
                          //     builder: (context) => SingleChildScrollView(
                          //         child:Container(
                          //           padding: EdgeInsets.only(
                          //               bottom: MediaQuery.of(context).viewInsets.bottom
                          //           ),
                          //           child: SaleBillingScreenNew(s),
                          //         )
                          //     )
                          // );
                        }
                      });
                    },
                    minWidth: 100.0,
                    height: 35.0,
                    child: Text(
                      'Payment',
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
    for(int i=0;i<CustomerList.length;i++){
      tempCustomerNames.add(CustomerList[i].custName);
    }
    setState(() {
      this.customerName = tempCustomerNames;
    });
    print(customerName);
  }
//-------------------------------------



}
