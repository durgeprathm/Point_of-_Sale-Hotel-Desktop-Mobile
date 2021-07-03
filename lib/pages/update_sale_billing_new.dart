import 'package:flutter/material.dart';
import 'package:retailerp/Adpater/EhotelAdapter/POS_Sales_Insert.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/utils/const.dart';

class UpdateSaleBillingScreenNew extends StatefulWidget {
  final Sales sale;
  final int proId;

  UpdateSaleBillingScreenNew(this.proId, this.sale);

  @override
  _UpdateSaleBillingScreenNewState createState() =>
      _UpdateSaleBillingScreenNewState(this.proId, this.sale);
}

enum PaymentMode { cash, debit, upi }

class _UpdateSaleBillingScreenNewState
    extends State<UpdateSaleBillingScreenNew> {
  static const int kTabletBreakpoint = 552;
  Sales sale;
  int proId;

  _UpdateSaleBillingScreenNewState(this.proId, this.sale);

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    // print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileUpdateSaleBillingScreenNew();
    } else {
      content = _buildTabletUpdateSaleBillingScreenNew();
    }

    return content;
  }

  PaymentMode _paymode = PaymentMode.cash;
  String PaymentModeorg;

  //DatabaseHelper databaseHelper = new DatabaseHelper();
  SalesInsert salesInsert = new SalesInsert();

  //-----------------Tablet View Start-------------//
  Widget _buildTabletUpdateSaleBillingScreenNew() {
    // Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: PrimaryColor,
              child: Text(
                "Payment Rs ${sale.SalesTotal}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text('Cash'),
              leading: Radio(
                value: PaymentMode.cash,
                groupValue: _paymode,
                onChanged: (PaymentMode value) {
                  setState(() {
                    _paymode = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Debit Card'),
              leading: Radio(
                value: PaymentMode.debit,
                groupValue: _paymode,
                onChanged: (PaymentMode value) {
                  setState(() {
                    _paymode = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('UPI'),
              leading: Radio(
                value: PaymentMode.upi,
                groupValue: _paymode,
                onChanged: (PaymentMode value) {
                  setState(() {
                    _paymode = value;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: PRODUCTRATEBG,
                  borderRadius: BorderRadius.circular(10.0),
                  child: MaterialButton(
                    onPressed: () async {
                      if (_paymode == PaymentMode.cash) {
                        PaymentModeorg = "CASH";
                      } else if (_paymode == PaymentMode.debit) {
                        PaymentModeorg = "DEBIT";
                      } else {
                        PaymentModeorg = "UPI";
                      }
                      // Navigator.pop(context);
                      print(sale.SalesCustomername);
                      print(sale.SalesDate);
                      print(sale.SalesProductName);
                      print(sale.SalesProductRate.toString());
                      print(sale.SalesProductQty.toString());
                      print(sale.SalesProductSubTotal);
                      print(sale.SalesSubTotal.toString());
                      print(sale.SalesDiscount.toString());
                      print(sale.SalesGST.toString());
                      print(sale.SalesTotal.toString());
                      print(sale.SalesNarration.toString());
                      print(PaymentModeorg);

                      var result = await salesInsert.updateSalesDataWihId(
                          proId.toString(),
                          sale.SalesIDs,
                          sale.SalesCustomername,
                          sale.SalesDate,
                          sale.SalesProductName,
                          sale.SalesProductRate.toString(),
                          sale.SalesProductQty.toString(),
                          sale.SalesProductSubTotal,
                          sale.SalesSubTotal.toString(),
                          sale.SalesDiscount.toString(),
                          sale.SalesGST.toString(),
                          sale.SalesTotal.toString(),
                          sale.SalesNarration,
                          PaymentModeorg);
                      print("//////result Server////////$result");
                      if (result == null) {
                        _showMyDialog('Failed !', Colors.red);
                      } else {
                        _showMyDialog('Data Successfully Save !', Colors.green);
                      }
                    },
                    minWidth: 100.0,
                    height: 35.0,
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50.0,
                ),
                Material(
                  color: PRODUCTRATEBG,
                  borderRadius: BorderRadius.circular(10.0),
                  child: MaterialButton(
                    onPressed: () async {
                      if (_paymode == PaymentMode.cash) {
                        PaymentModeorg = "CASH";
                      } else if (_paymode == PaymentMode.debit) {
                        PaymentModeorg = "DEBIT";
                      } else {
                        PaymentModeorg = "UPI";
                      }
                      print(sale.SalesCustomername);
                      print(sale.SalesDate);
                      print(sale.SalesProductName);
                      print(sale.SalesProductRate.toString());
                      print(sale.SalesProductQty.toString());
                      print(sale.SalesProductSubTotal);
                      print(sale.SalesSubTotal.toString());
                      print(sale.SalesDiscount.toString());
                      print(sale.SalesGST.toString());
                      print(sale.SalesTotal.toString());
                      print(sale.SalesNarration.toString());
                      print(PaymentModeorg);

                      var result = await salesInsert.updateSalesDataWihId(
                          proId.toString(),
                          sale.SalesIDs,
                          sale.SalesCustomername,
                          sale.SalesDate,
                          sale.SalesProductName,
                          sale.SalesProductRate.toString(),
                          sale.SalesProductQty.toString(),
                          sale.SalesProductSubTotal,
                          sale.SalesSubTotal.toString(),
                          sale.SalesDiscount.toString(),
                          sale.SalesGST.toString(),
                          sale.SalesTotal.toString(),
                          sale.SalesNarration,
                          PaymentModeorg);
                      print(result);
                      if (result == null) {
                        _showMyDialog('Filed !', Colors.red);
                      } else {
                        _showMyDialog('Data Successfully Save !', Colors.green);
                      }
                    },
                    minWidth: 100.0,
                    height: 35.0,
                    child: Text(
                      'Print',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
    // }
  }

  //-----------------Tablet View Start-------------//
  //-----------------Mobile View Start-------------//
  Widget _buildMobileUpdateSaleBillingScreenNew() {
    //  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: PrimaryColor,
              child: Text(
                "Payment Rs 50",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text('Cash'),
              leading: Radio(
                value: PaymentMode.cash,
                groupValue: _paymode,
                onChanged: (PaymentMode value) {
                  setState(() {
                    _paymode = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Debit Card'),
              leading: Radio(
                value: PaymentMode.debit,
                groupValue: _paymode,
                onChanged: (PaymentMode value) {
                  setState(() {
                    _paymode = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('UPI'),
              leading: Radio(
                value: PaymentMode.upi,
                groupValue: _paymode,
                onChanged: (PaymentMode value) {
                  setState(() {
                    _paymode = value;
                  });
                },
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 90.0,
                ),
                Material(
                  color: PRODUCTRATEBG,
                  borderRadius: BorderRadius.circular(10.0),
                  child: MaterialButton(
                    onPressed: () async {
                      if (_paymode == PaymentMode.cash) {
                        PaymentModeorg = "CASH";
                      } else if (_paymode == PaymentMode.debit) {
                        PaymentModeorg = "DEBIT";
                      } else {
                        PaymentModeorg = "UPI";
                      }
                      print(PaymentModeorg);
                      var result = await salesInsert.updateSalesDataWihId(
                          proId.toString(),
                          sale.SalesIDs,
                          sale.SalesCustomername,
                          sale.SalesDate,
                          sale.SalesProductName,
                          sale.SalesProductRate.toString(),
                          sale.SalesProductQty.toString(),
                          sale.SalesProductSubTotal,
                          sale.SalesSubTotal.toString(),
                          sale.SalesDiscount.toString(),
                          sale.SalesGST.toString(),
                          sale.SalesTotal.toString(),
                          sale.SalesNarration,
                          PaymentModeorg);
                      print(result);
                      if (result == null) {
                        _showMyDialog('Filed !', Colors.red);
                      } else {
                        _showMyDialog('Data Successfully Save !', Colors.green);
                      }
                    },
                    minWidth: 100.0,
                    height: 35.0,
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Material(
                  color: PRODUCTRATEBG,
                  borderRadius: BorderRadius.circular(10.0),
                  child: MaterialButton(
                    onPressed: () async {
                      // BillPrint();
                      //print(_paymode);
                      if (_paymode == PaymentMode.cash) {
                        PaymentModeorg = "CASH";
                      } else if (_paymode == PaymentMode.debit) {
                        PaymentModeorg = "DEBIT";
                      } else {
                        PaymentModeorg = "UPI";
                      }
                      print(PaymentModeorg);
                      var result = await salesInsert.updateSalesDataWihId(
                          proId.toString(),
                          sale.SalesIDs,
                          sale.SalesCustomername,
                          sale.SalesDate,
                          sale.SalesProductName,
                          sale.SalesProductRate.toString(),
                          sale.SalesProductQty.toString(),
                          sale.SalesProductSubTotal,
                          sale.SalesSubTotal.toString(),
                          sale.SalesDiscount.toString(),
                          sale.SalesGST.toString(),
                          sale.SalesTotal.toString(),
                          sale.SalesNarration,
                          PaymentModeorg);
                      if (result == null) {
                        _showMyDialog('Filed !', Colors.red);
                      } else {
                        _showMyDialog('Data Successfully Save !', Colors.green);
                      }
                    },
                    minWidth: 100.0,
                    height: 35.0,
                    child: Text(
                      'Print',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
    // }
  }

  //-----------------Mobile View End-------------//
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
