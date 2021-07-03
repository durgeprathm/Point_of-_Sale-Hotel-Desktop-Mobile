import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/Purchase.dart';
import 'package:retailerp/utils/PurchaseDeleteProvider.dart';


class EditPurchaseScreen extends StatefulWidget {
  EditPurchaseScreen(this.indexFetch, this.PurchaseListFetch);
  @override
  final int indexFetch;
  List<Purchase> PurchaseListFetch = new List();
  _EditPurchaseScreenState createState() => _EditPurchaseScreenState();
}

class _EditPurchaseScreenState extends State<EditPurchaseScreen> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  @override
  int rowpro = 1;
  double temp;
  double gst;
  double tempsubtotal;
  int TempQty;
  double tempMiscellaneons;
  String EditPCompanyNametext;
  String EditProductName;
  String EditProductRate;
  String EditProductQty;
  String EditProductSubTotal;
  var tempProductSubTotal, tempProductRate, tempProductQty, tempProductName;
  bool enable = true;

  void initState() {
    setState(() {
      EditPCompanyNametext =
          widget.PurchaseListFetch[widget.indexFetch].PurchaseCompanyname;
      this._EditPCompanyNametext.text =
          widget.PurchaseListFetch[widget.indexFetch].PurchaseCompanyname;
      this._EditPDatetext.text =
          widget.PurchaseListFetch[widget.indexFetch].PurchaseDate;
      this._EditPSubTotaltext.text = widget
          .PurchaseListFetch[widget.indexFetch].PurchaseSubTotal
          .toString();
      this._EditPDiscounttext.text = widget
          .PurchaseListFetch[widget.indexFetch].PurchaseDiscount
          .toString();
      this._EditPgsttext.text =
          widget.PurchaseListFetch[widget.indexFetch].PurchaseGST.toString();
      this._EditPMiscellaneons.text = widget
          .PurchaseListFetch[widget.indexFetch].PurchaseMiscellaneons
          .toString();
      this._EditPtotalAmounttext.text =
          widget.PurchaseListFetch[widget.indexFetch].PurchaseTotal.toString();
      this._EditPNarration.text =
          widget.PurchaseListFetch[widget.indexFetch].PurchaseNarration;
      EditProductName =
          widget.PurchaseListFetch[widget.indexFetch].PurchaseProductName;
      EditProductRate =
          widget.PurchaseListFetch[widget.indexFetch].PurchaseProductRate;
      EditProductQty =
          widget.PurchaseListFetch[widget.indexFetch].PurchaseProductQty;
      EditProductSubTotal =
          widget.PurchaseListFetch[widget.indexFetch].PurchaseProductSubTotal;
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

  TextEditingController _EditPCompanyNametext = TextEditingController();
  TextEditingController _EditPDatetext = TextEditingController();
  // final _PProNametext = TextEditingController();
  // final _PProRatetext = TextEditingController();
  // final _PProQtytext = TextEditingController();
  // final _PproSubTotaltext = TextEditingController();
  TextEditingController _EditPSubTotaltext = TextEditingController();
  TextEditingController _EditPDiscounttext = TextEditingController();
  TextEditingController _EditPgsttext = TextEditingController();
  TextEditingController _EditPtotalAmounttext = TextEditingController();
  TextEditingController _EditPNarration = TextEditingController();
  TextEditingController _EditPMiscellaneons = TextEditingController();

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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.moneyBill),
            SizedBox(
              width: 20.0,
            ),
            Text('Updating Information:- $EditPCompanyNametext'),
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10.0),
                            child: TextField(
                              controller: _EditPCompanyNametext,
                              readOnly: true,
                              enableInteractiveSelection: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Company Name',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10.0),
                            child: TextField(
                              controller: _EditPDatetext,
                              readOnly: true,
                              enableInteractiveSelection: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Purchase Date',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Material(
                      shape: Border.all(color:Colors.blueGrey, width: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          // height: 150.0,
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
                      elevation: 5.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10.0),
                            child: TextField(
                              controller: _EditPSubTotaltext,
                              readOnly: true,
                              enableInteractiveSelection: true,
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
                              controller: _EditPDiscounttext,
                              readOnly: true,
                              enableInteractiveSelection: true,
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
                              controller: _EditPgsttext,
                              readOnly: true,
                              enableInteractiveSelection: true,
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
                              controller: _EditPMiscellaneons,
                              readOnly: enable,
                              enableInteractiveSelection: enable,
                              obscureText: false,
                              onChanged: (value) {
                                PMiscellaneons = double.parse(value);
                                print(PMiscellaneons);
                                if (PMiscellaneons == null) {
                                  PMiscellaneons = 0;
                                } else {
                                  PtotalAmount = PtotalAmount + PMiscellaneons;
                                  print(PtotalAmount);
                                  _EditPtotalAmounttext.text =
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
                              controller: _EditPtotalAmounttext,
                              readOnly: true,
                              enableInteractiveSelection: true,
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
                              controller: _EditPNarration,
                              readOnly: enable,
                              enableInteractiveSelection: enable,
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
                              // Respond to button press
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
                            onPressed: () async {
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
                                  _EditPDatetext.text.isEmpty
                                      ? _PDatevalidate = true
                                      : _PDatevalidate = false;
                                  // _PProNametext[index].text.isEmpty ? _PProNamevalidate = true : _PProNamevalidate = false;
                                  // _PProRatetext[index].text.isEmpty ? _PProRatevalidate = true : _PProRatevalidate = false;
                                  // _PProQtytext[index].text.isEmpty ? _PProQtyvalidate = true : _PProQtyvalidate = false;
                                  // _PproSubTotaltext[index].text.isEmpty ? _PproSubTotalvalidate = true : _PproSubTotalvalidate = false;
                                  _EditPSubTotaltext.text.isEmpty
                                      ? _PSubTotalvalidate = true
                                      : _PSubTotalvalidate = false;
                                  _EditPDiscounttext.text.isEmpty
                                      ? _PDiscountvalidate = true
                                      : _PDiscountvalidate = false;
                                  _EditPgsttext.text.isEmpty
                                      ? _Pgstvalidate = true
                                      : _Pgstvalidate = false;
                                  _EditPtotalAmounttext.text.isEmpty
                                      ? _PtotalAmountvalidate = true
                                      : _PtotalAmountvalidate = false;
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
      )),
    );
  }

  DataRow getRow(int index) {
    _PProNametext.add(new TextEditingController());
    _PProRatetext.add(new TextEditingController());
    _PProQtytext.add(new TextEditingController());
    _PproSubTotaltext.add(new TextEditingController());
    _PProNametext[index].text = tempProductName[index].toString();
    _PProRatetext[index].text = tempProductRate[index].toString();
    _PProQtytext[index].text = tempProductQty[index].toString();
    _PproSubTotaltext[index].text = tempProductSubTotal[index].toString();
    return DataRow(cells: [
      DataCell(Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          controller: _PProNametext[index],
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
          controller: _PProRatetext[index],
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
          controller: _PProQtytext[index],
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
          controller: _PproSubTotaltext[index],
          readOnly: enable,
          enableInteractiveSelection: enable,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Product SubTotal',
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


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child:  AlertDialog(
            title: Text("Want to Edit Information!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                ],
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
                  }
              ),
            ],
          ),
        );
      },
    );
  }



}
