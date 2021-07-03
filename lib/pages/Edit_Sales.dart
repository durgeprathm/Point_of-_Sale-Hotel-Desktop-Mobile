import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/models/Sales.dart';

import 'dashboard.dart';

class EditSales extends StatefulWidget {
  EditSales(this.indexFetch, this.SalesListFetch);
  @override
  final int indexFetch;
  List<Sales> SalesListFetch = new List();
  _EditSalesState createState() => _EditSalesState();
}

class _EditSalesState extends State<EditSales> {
  @override
  int rowpro = 1;
  bool enable = true;
  String EditProductName;
  String EditProductRate;
  String EditProductQty;
  String EditProductSubTotal;
  var tempProductSubTotal, tempProductRate, tempProductQty, tempProductName;
  @override
  void initState() {
    setState(() {
      EditSCustomerName =
          widget.SalesListFetch[widget.indexFetch].SalesCustomername;
      this._EditSCustomertext.text =
          widget.SalesListFetch[widget.indexFetch].SalesCustomername;
      this._EditSDatetext.text =
          widget.SalesListFetch[widget.indexFetch].SalesDate;
      this._EditSSubTotaltext.text =
          widget.SalesListFetch[widget.indexFetch].SalesSubTotal.toString();
      this._EditSDiscounttext.text =
          widget.SalesListFetch[widget.indexFetch].SalesDiscount.toString();
      this._EditSgsttext.text =
          widget.SalesListFetch[widget.indexFetch].SalesGST.toString();
      this._EditStotalAmounttext.text =
          widget.SalesListFetch[widget.indexFetch].SalesTotal.toString();
      this._EditSNarration.text =
          widget.SalesListFetch[widget.indexFetch].SalesNarration;
      this._EditSPayMode.text =
          widget.SalesListFetch[widget.indexFetch].SalesPaymentMode;
      EditProductName =
          widget.SalesListFetch[widget.indexFetch].SalesProductName;
      EditProductRate =
          widget.SalesListFetch[widget.indexFetch].SalesProductRate;
      EditProductQty = widget.SalesListFetch[widget.indexFetch].SalesProductQty;
      EditProductSubTotal =
          widget.SalesListFetch[widget.indexFetch].SalesProductSubTotal;
      print(EditProductName);
      print(EditProductRate);
      print(EditProductQty);
      print(EditProductSubTotal);
      tempProductSubTotal = EditProductSubTotal.split("#");
      tempProductName = EditProductName.split("#");
      tempProductRate = EditProductRate.split("#");
      tempProductQty = EditProductQty.split("#");
      print(tempProductName);
      print(tempProductRate);
      print(tempProductQty);
      print(tempProductSubTotal);
    });
  }

  TextEditingController _EditSDatetext = TextEditingController();
  TextEditingController _EditSCustomertext = TextEditingController();
  // TextEditingController _SProNametext = TextEditingController();
  //TextEditingController _SProRatetext = TextEditingController();
  //TextEditingController _SProQtytext = TextEditingController();
  //TextEditingController _SproSubTotaltext = TextEditingController();
  TextEditingController _EditSSubTotaltext = TextEditingController();
  TextEditingController _EditSDiscounttext = TextEditingController();
  TextEditingController _EditSgsttext = TextEditingController();
  TextEditingController _EditStotalAmounttext = TextEditingController();
  TextEditingController _EditSNarration = TextEditingController();
  TextEditingController _EditSPayMode = TextEditingController();

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

  int EditSalesid;
  String EditSCustomerName;
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

//-------------------------------------------
  static const int kTabletBreakpoint = 552;
  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileEditSales();
    } else {
      content = _buildTabletEditSales();
    }

    return content;
  }

//-------------------------------------------
//---------------Tablet Mode Start-------------//
  Widget _buildTabletEditSales() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text('Updating Information:- $EditSCustomerName '),
          ],
        ),
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
                                child: TextField(
                                  controller: _EditSCustomertext,
                                  readOnly: enable,
                                  enableInteractiveSelection: enable,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Customer Name',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              child: TextField(
                                controller: _EditSDatetext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                onChanged: (value) {
                                  SDate = value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Sale Date',
                                  errorText:
                                      _SDatevalidate ? 'Enter Sale Date' : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Material(
                        shape: Border.all(color: Colors.blueGrey, width: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: DataTable(
                              columns: [
                                DataColumn(
                                    label: Expanded(
                                  child: Container(
                                    child: Text('Product Name',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                )),
                                DataColumn(
                                    label: Expanded(
                                  child: Container(
                                    width: 200,
                                    child: Text('Product Rate',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                )),
                                DataColumn(
                                    label: Expanded(
                                  child: Container(
                                    child: Text('Product Quntity',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                )),
                                DataColumn(
                                  label: Expanded(
                                    child: Container(
                                      child: Text('Product SubTotal',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ],
                              rows: getDataRowList(),
                            ),
                          ),
                        ),
                      ),
                      // elevation: 5.0,
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              child: TextField(
                                controller: _EditSSubTotaltext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
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
                                controller: _EditSDiscounttext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
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
                                controller: _EditSgsttext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
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
                                controller: _EditStotalAmounttext,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
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
                                controller: _EditSPayMode,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
                                obscureText: false,
                                onChanged: (value) {
                                  SNarration = value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Mode Of Payment',
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
                                controller: _EditSNarration,
                                readOnly: enable,
                                enableInteractiveSelection: enable,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: FlatButton(
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black12),
                              ),
                              textColor: Colors.white,
                              onPressed: () {
                                _showMyDialog();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "EDIT",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
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
                                    _EditSDatetext.text.isEmpty
                                        ? _SDatevalidate = true
                                        : _SDatevalidate = false;
                                    _EditSCustomertext.text.isEmpty
                                        ? _SCustomervalidate = true
                                        : _SCustomervalidate = false;
                                    // _SProNametext[index].text.isEmpty ? _SProNamevalidate = true : _SProNamevalidate = false;
                                    // _SProRatetext.text.isEmpty ? _SProRatevalidate = true : _SProRatevalidate = false;
                                    // _SProQtytext.text.isEmpty ? _SProQtyvalidate = true : _SProQtyvalidate = false;
                                    // _SproSubTotaltext.text.isEmpty ? _SproSubTotalvalidate = true : _SproSubTotalvalidate = false;
                                    _EditSSubTotaltext.text.isEmpty
                                        ? _SSubTotalvalidate = true
                                        : _SSubTotalvalidate = false;
                                    _EditSDiscounttext.text.isEmpty
                                        ? _SDiscountvalidate = true
                                        : _SDiscountvalidate = false;
                                    _EditSgsttext.text.isEmpty
                                        ? _Sgstvalidate = true
                                        : _Sgstvalidate = false;
                                    _EditStotalAmounttext.text.isEmpty
                                        ? _StotalAmountvalidate = true
                                        : _StotalAmountvalidate = false;
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "UPDATE",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobileEditSales() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text('Updating Information'),
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
                child: TextField(
                  readOnly: true,
                  enableInteractiveSelection: true,
                  controller: _EditSCustomertext,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Company Name',
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: TextField(
                    controller: _EditSDatetext,
                    readOnly: true,
                    enableInteractiveSelection: true,
                    onChanged: (value) {
                      SDate=value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Sale Date',
                      errorText: _SDatevalidate ? 'Enter Sale Date' : null,
                    ),
                  ),
                  ),
              //-------------------------------------------------------

              Container(
               // height: 380.0,
                child: ListView.builder(
                    itemCount: tempProductSubTotal.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      _SProNametext.add(new TextEditingController());
                      _SProRatetext.add(new TextEditingController());
                      _SProQtytext.add(new TextEditingController());
                      _SproSubTotaltext.add(new TextEditingController());
                      _SProNametext[index].text = tempProductName[index].toString();
                      _SProRatetext[index].text = tempProductRate[index].toString();
                      _SProQtytext[index].text = tempProductQty[index].toString();
                      _SproSubTotaltext[index].text = tempProductSubTotal[index].toString();
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
                                              if (SProName == null ||
                                                  SProRate == null ||
                                                  SProQty == null) {
                                                _SProNametext[index]
                                                        .text
                                                        .isEmpty
                                                    ? _SProNamevalidate = true
                                                    : _SProNamevalidate = false;
                                                _SProRatetext[index]
                                                        .text
                                                        .isEmpty
                                                    ? _SProRatevalidate = true
                                                    : _SProRatevalidate = false;
                                                _SProQtytext[index].text.isEmpty
                                                    ? _SProQtyvalidate = true
                                                    : _SProQtyvalidate = false;
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
                                  child: new TextField(
                                    controller: _SProNametext[index],
                                    readOnly: enable,
                                    enableInteractiveSelection: enable,
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
                                        child: new TextField(
                                          controller: _SProRatetext[index],
                                          readOnly: enable,
                                          enableInteractiveSelection: enable,
                                          keyboardType: TextInputType.number,
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
                                        child: new TextField(
                                          controller: _SProQtytext[index],
                                          readOnly: enable,
                                          enableInteractiveSelection: enable,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            SProQty = double.parse(value);
                                            temp = (SProRate * SProQty);
                                            TempQty = int.parse(value);
                                            // _SproSubTotaltext[index]. = temp;
                                            _SproSubTotaltext[index].text =
                                                temp.toString();
                                            SproSubTotal = double.parse(
                                                _SproSubTotaltext[index].text);
                                            //inserting data in Array
                                            LocalProductName.add(SProName);
                                            LocalProductRate.add(SProRate);
                                            LocalProductQty.add(TempQty);
                                            LocalProductSubTotal.add(
                                                SproSubTotal);

                                            //calculating SubTotal of sales
                                            tempsubtotal = 0;
                                            LocalProductSubTotal.forEach(
                                                (num e) {
                                              tempsubtotal += e;
                                            });
                                            _EditSSubTotaltext.text =
                                                (tempsubtotal).toString();
                                            SSubTotal = tempsubtotal;
                                            gst = 0;
                                            //calculating Discount of sales
                                            _EditSDiscounttext.text =
                                                (gst).toString();
                                            SDiscount = gst;
                                            //calculating Gst of sales
                                            _EditSgsttext.text = (gst).toString();
                                            Sgst = gst;
                                            //calculating Total of sales
                                            _EditStotalAmounttext.text =
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
                                  child: new TextField(
                                    controller: _SproSubTotaltext[index],
                                    readOnly: true,
                                    enableInteractiveSelection: true,
                                    obscureText: false,
                                    keyboardType: TextInputType.number,
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
                    }),
              ),

              //----------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _EditSSubTotaltext,
                  readOnly: true,
                  enableInteractiveSelection: true,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Subtotal Amount',
                    errorText:
                        _SSubTotalvalidate ? 'Plz Enter Subtotal Amount' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _EditSDiscounttext,
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
                    errorText:
                        _SDiscountvalidate ? 'Plz Enter Discount Amount' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _EditSgsttext,
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
                  controller: _EditStotalAmounttext,
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
                    errorText:
                        _StotalAmountvalidate ? 'Plz Enter Total Amount' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  obscureText: false,
                  readOnly: enable,
                  enableInteractiveSelection: enable,
                  controller: _EditSNarration,
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  readOnly: true,
                  enableInteractiveSelection: true,
                  controller: _EditSPayMode,
                  onChanged: (value) {
                    SNarration = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Payment Mode',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            _showMyDialog();
                          });
                        },
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Edit',
                            style: TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            if (SProName == null ||
                                SProRate == null ||
                                SProQty == null ||
                                SproSubTotal == null ||
                                SSubTotal == null ||
                                SDiscount == null ||
                                Sgst == null ||
                                StotalAmount == null) {
                              _EditSDatetext.text.isEmpty
                                  ? _SDatevalidate = true
                                  : _SDatevalidate = false;
                              _EditSCustomertext.text.isEmpty
                                  ? _SCustomervalidate = true
                                  : _SCustomervalidate = false;
                              // _SProNametext[index].text.isEmpty ? _SProNamevalidate = true : _SProNamevalidate = false;
                              // _SProRatetext.text.isEmpty ? _SProRatevalidate = true : _SProRatevalidate = false;
                              // _SProQtytext.text.isEmpty ? _SProQtyvalidate = true : _SProQtyvalidate = false;
                              // _SproSubTotaltext.text.isEmpty ? _SproSubTotalvalidate = true : _SproSubTotalvalidate = false;
                              _EditSSubTotaltext.text.isEmpty
                                  ? _SSubTotalvalidate = true
                                  : _SSubTotalvalidate = false;
                              _EditSDiscounttext.text.isEmpty
                                  ? _SDiscountvalidate = true
                                  : _SDiscountvalidate = false;
                              _EditSgsttext.text.isEmpty
                                  ? _Sgstvalidate = true
                                  : _Sgstvalidate = false;
                              _EditStotalAmounttext.text.isEmpty
                                  ? _StotalAmountvalidate = true
                                  : _StotalAmountvalidate = false;
                            } else {
                              String JoinedProductName = LocalProductName.join("#");
                              print(JoinedProductName);
                              String JoinedProductRate = LocalProductRate.join("#");
                              print(JoinedProductRate);
                              String JoinedProductQty = LocalProductQty.join("#");
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
                            }
                          });
                        },
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
//---------------Mobile Mode End-------------//

  DataRow getRow(int index) {
    _SProNametext.add(new TextEditingController());
    _SProRatetext.add(new TextEditingController());
    _SProQtytext.add(new TextEditingController());
    _SproSubTotaltext.add(new TextEditingController());
    _SProNametext[index].text = tempProductName[index].toString();
    _SProRatetext[index].text = tempProductRate[index].toString();
    _SProQtytext[index].text = tempProductQty[index].toString();
    _SproSubTotaltext[index].text = tempProductSubTotal[index].toString();
    return DataRow(cells: [
      DataCell(Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          controller: _SProNametext[index],
          readOnly: enable,
          enableInteractiveSelection: enable,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Product Name',
          ),
        ),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          controller: _SProRatetext[index],
          readOnly: enable,
          enableInteractiveSelection: enable,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Product Rate',
          ),
        ),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          controller: _SProQtytext[index],
          readOnly: enable,
          enableInteractiveSelection: enable,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Product Qty',
          ),
        ),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          controller: _SproSubTotaltext[index],
          readOnly: enable,
          enableInteractiveSelection: enable,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Product Sub Total',
          ),
        ),
      )),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < tempProductSubTotal.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }
//----------------------dialog for Edit -------------------------
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              "Want to Edit Information!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: Text('Edit'),
                  onPressed: () async {
                    setState(() {
                      enable = false;
                      Navigator.of(context).pop();
                    });
                  }),
            ],
          ),
        );
      },
    );
  }
  //---------------------MOBILE PRODUCTS-------------------
  DataRow getMobileRow(int index) {
    _SProNametext.add(new TextEditingController());
    _SProRatetext.add(new TextEditingController());
    _SProQtytext.add(new TextEditingController());
    _SproSubTotaltext.add(new TextEditingController());
    _SProNametext[index].text = tempProductName[index].toString();
    _SProRatetext[index].text = tempProductRate[index].toString();
    _SProQtytext[index].text = tempProductQty[index].toString();
    _SproSubTotaltext[index].text = tempProductSubTotal[index].toString();
    return DataRow(cells: [
      DataCell(Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          controller: _SProNametext[index],
          readOnly: enable,
          enableInteractiveSelection: enable,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Product Name',
          ),
        ),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          controller: _SProRatetext[index],
          readOnly: enable,
          enableInteractiveSelection: enable,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Product Rate',
          ),
        ),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          controller: _SProQtytext[index],
          readOnly: enable,
          enableInteractiveSelection: enable,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Product Qty',
          ),
        ),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          controller: _SproSubTotaltext[index],
          readOnly: enable,
          enableInteractiveSelection: enable,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Product Sub Total',
          ),
        ),
      )),
    ]);
  }
}
