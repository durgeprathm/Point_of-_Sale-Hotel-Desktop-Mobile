import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:retailerp/Adpater/EhotelAdapter/POS_Sales_Insert.dart';
import 'package:retailerp/POSUIONE/bill_print.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/pages/bill_print_new.dart';
import 'package:retailerp/utils/const.dart';

class SaleBillingScreenNew extends StatefulWidget {
  SaleBillingScreenNew(this.sale, this.getClear);

  final Sales sale;
  Function getClear;

  @override
  _SaleBillingScreenNewState createState() =>
      _SaleBillingScreenNewState(this.sale, this.getClear);
}

enum PaymentMode { cash, debit, upi }

class _SaleBillingScreenNewState extends State<SaleBillingScreenNew> {
  static const int kTabletBreakpoint = 552;
  Sales sale;
  Function getClear;

  _SaleBillingScreenNewState(this.sale, this.getClear);

  List<String> ProductID = new List();
  List<String> ProductName = new List();
  List<String> RATE = new List();
  List<String> Quant = new List();
  List<String> ProSubtotal = new List();
  List<String> GSTPER = new List();

  String TypeCard;
  String CardName;
  String DebitCardNumber;
  String DebitCardOnName;
  String UPIBankName;
  String UPITransactionId;
  bool cashView = true;
  bool debitView = false;
  bool upiView = false;
  bool custView = false;
  double payableamount;
  List<String> DebitCards = [
    "Mastercard Cards",
    "Visa Cards",
    "RuPay Cards",
    "Maestro Cards",
    "Contactless Cards",
    "Visa Electron Cards"
  ];
  List<String> CreditCards = [
    "Student Credit cards",
    "Subprime Credit cards",
    "Secured Credit cards",
    "Balance transfer Credit cards",
    "Travel Credit cards",
    "Titanium Credit cards"
  ];

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    // print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileSaleBillingScreenNew();
    } else {
      content = _buildTabletSaleBillingScreenNew();
    }

    return content;
  }

  PaymentMode _paymode = PaymentMode.cash;
  String PaymentModeorg;

  //DatabaseHelper databaseHelper = new DatabaseHelper();
  SalesInsert salesInsert = new SalesInsert();

  //-----------------Tablet View Start-------------//
  Widget _buildTabletSaleBillingScreenNew() {
    payableamount = double.parse(sale.SalesTotal);
    double tabletHeight = MediaQuery.of(context).size.height * (.12);
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
                style: TextStyle(fontSize: 22.0, color: Colors.white),
              ),
            ),
            Container(
              height: tabletHeight,
              child: Row(
                children: [
                  Container(
                      child: Row(
                    children: [
                      Radio(
                        value: PaymentMode.cash,
                        groupValue: _paymode,
                        onChanged: (PaymentMode value) {
                          setState(() {
                            _paymode = value;
                            cashView = true;
                            debitView = false;
                            upiView = false;
                          });
                        },
                      ),
                      Text("Cash")
                    ],
                  )),
                  Container(
                      child: Row(
                    children: [
                      Radio(
                        value: PaymentMode.debit,
                        groupValue: _paymode,
                        onChanged: (PaymentMode value) {
                          setState(() {
                            _paymode = value;
                            cashView = false;
                            debitView = true;
                            upiView = false;
                            print(_paymode);
                          });
                        },
                      ),
                      Text("Card")
                    ],
                  )),
                  Container(
                      child: Row(
                    children: [
                      Radio(
                        value: PaymentMode.upi,
                        groupValue: _paymode,
                        onChanged: (PaymentMode value) {
                          setState(() {
                            _paymode = value;
                            cashView = false;
                            debitView = false;
                            upiView = true;
                          });
                        },
                      ),
                      Text("UPI")
                    ],
                  )),
                ],
              ),
            ),
            Visibility(visible: cashView, child: cashWidget(payableamount)),
            Visibility(visible: debitView, child: debitWidget()),
            Visibility(visible: upiView, child: upiWidget()),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: PrimaryColor,
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
                      if (_paymode == PaymentMode.cash) {
                        var result = await salesInsert.getSalesHotelInsert(
                            sale.SalesCustomerId,
                            sale.SalesCustomername,
                            sale.SalesCustomerMobileNo,
                            sale.SalesDate,
                            sale.SalesProductId,
                            sale.SalesProductRate.toString(),
                            sale.SalesProductQty.toString(),
                            sale.SalesProductSubTotal,
                            sale.SalesSubTotal.toString(),
                            sale.SalesDiscount.toString(),
                            sale.SalesGST.toString(),
                            sale.SalesTotal.toString(),
                            sale.SalesNarration,
                            PaymentModeorg,
                            sale.SalesIDs,
                            "0",
                            "0",
                            "0",
                            "0",
                            "0",
                            "0");
                        print(result);
                        var resid = result["resid"];
                        if (resid == 200) {
                          getClear(true);
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Bill generated successfully ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: PrimaryColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Error. Try again ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      } else if (_paymode == PaymentMode.debit) {
                        var result = await salesInsert.getSalesHotelInsert(
                            sale.SalesCustomerId,
                            sale.SalesCustomername,
                            sale.SalesCustomerMobileNo,
                            sale.SalesDate,
                            sale.SalesProductId,
                            sale.SalesProductRate.toString(),
                            sale.SalesProductQty.toString(),
                            sale.SalesProductSubTotal,
                            sale.SalesSubTotal.toString(),
                            sale.SalesDiscount.toString(),
                            sale.SalesGST.toString(),
                            sale.SalesTotal.toString(),
                            sale.SalesNarration,
                            PaymentModeorg,
                            sale.SalesIDs,
                            CardName,
                            DebitCardOnName,
                            DebitCardNumber,
                            "0",
                            "0",
                            TypeCard);
                        print(result);
                        var resid = result["resid"];
                        if (resid == 200) {
                          getClear(true);
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Bill generated successfully ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: PrimaryColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Error. Try again ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      } else if (_paymode == PaymentMode.upi) {
                        var result = await salesInsert.getSalesHotelInsert(
                            sale.SalesCustomerId,
                            sale.SalesCustomername,
                            sale.SalesCustomerMobileNo,
                            sale.SalesDate,
                            sale.SalesProductId,
                            sale.SalesProductRate.toString(),
                            sale.SalesProductQty.toString(),
                            sale.SalesProductSubTotal,
                            sale.SalesSubTotal.toString(),
                            sale.SalesDiscount.toString(),
                            sale.SalesGST.toString(),
                            sale.SalesTotal.toString(),
                            sale.SalesNarration,
                            PaymentModeorg,
                            sale.SalesIDs,
                            "0",
                            "0",
                            "0",
                            UPIBankName,
                            UPITransactionId,
                            "0");
                        print(result);
                        var resid = result["resid"];
                        if (resid == 200) {
                          getClear(true);
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Bill generated successfully ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: PrimaryColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Error. Try again ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                      //
                      //
                      // print("//////result Server////////$result");
                      // if (result == null) {
                      //   _showMyDialog('Failed !', Colors.red);
                      // } else {
                      //   _showMyDialog('Data Successfully Save !', Colors.green);
                      // }
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
                  color: PrimaryColor,
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
                      if (_paymode == PaymentMode.cash) {
                        var result = await salesInsert.getSalesHotelInsert(
                            sale.SalesCustomerId,
                            sale.SalesCustomername,
                            sale.SalesCustomerMobileNo,
                            sale.SalesDate,
                            sale.SalesProductId,
                            sale.SalesProductRate.toString(),
                            sale.SalesProductQty.toString(),
                            sale.SalesProductSubTotal,
                            sale.SalesSubTotal.toString(),
                            sale.SalesDiscount.toString(),
                            sale.SalesGST.toString(),
                            sale.SalesTotal.toString(),
                            sale.SalesNarration,
                            PaymentModeorg,
                            sale.SalesIDs,
                            "0",
                            "0",
                            "0",
                            "0",
                            "0",
                            "0");
                        print(result);
                        var resid = result["resid"];
                        if (resid == 200) {
                          getClear(true);
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Bill generated successfully ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: PrimaryColor,
                              textColor: Colors.white,
                              fontSize: 16.0);

                          ProductName = sale.SalesProductName.split("#");
                          RATE = sale.SalesProductRate.split("#");
                          Quant = sale.SalesProductName.split("#");
                          ProSubtotal = sale.SalesProductSubTotal.split("#");
                          GSTPER = sale.SalesGST.split("#");
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return BillPrintNew(
                                ProductName,
                                RATE,
                                Quant,
                                ProSubtotal,
                                GSTPER,
                                sale.SalesSubTotal,
                                sale.SalesDiscount,
                                payableamount,
                                sale.SalesCustomername,
                                sale.SalesDate);
                          }));
                        } else {
                          Fluttertoast.showToast(
                              msg: "Error. Try again ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      } else if (_paymode == PaymentMode.debit) {
                        var result = await salesInsert.getSalesHotelInsert(
                            sale.SalesCustomerId,
                            sale.SalesCustomername,
                            sale.SalesCustomerMobileNo,
                            sale.SalesDate,
                            sale.SalesProductId,
                            sale.SalesProductRate.toString(),
                            sale.SalesProductQty.toString(),
                            sale.SalesProductSubTotal,
                            sale.SalesSubTotal.toString(),
                            sale.SalesDiscount.toString(),
                            sale.SalesGST.toString(),
                            sale.SalesTotal.toString(),
                            sale.SalesNarration,
                            PaymentModeorg,
                            sale.SalesIDs,
                            CardName,
                            DebitCardOnName,
                            DebitCardNumber,
                            "0",
                            "0",
                            TypeCard);
                        print(result);
                        var resid = result["resid"];
                        if (resid == 200) {
                          getClear(true);
                          Navigator.pop(context);
                          ProductName = sale.SalesProductName.split("#");
                          RATE = sale.SalesProductRate.split("#");
                          Quant = sale.SalesProductName.split("#");
                          ProSubtotal = sale.SalesProductSubTotal.split("#");
                          GSTPER = sale.SalesGST.split("#");
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return BillPrintNew(
                                ProductName,
                                RATE,
                                Quant,
                                ProSubtotal,
                                GSTPER,
                                sale.SalesSubTotal,
                                sale.SalesDiscount,
                                payableamount,
                                sale.SalesCustomername,
                                sale.SalesDate);
                          }));
                          Fluttertoast.showToast(
                              msg: "Bill generated successfully ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: PrimaryColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Error. Try again ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      } else if (_paymode == PaymentMode.upi) {
                        var result = await salesInsert.getSalesHotelInsert(
                            sale.SalesCustomerId,
                            sale.SalesCustomername,
                            sale.SalesCustomerMobileNo,
                            sale.SalesDate,
                            sale.SalesProductId,
                            sale.SalesProductRate.toString(),
                            sale.SalesProductQty.toString(),
                            sale.SalesProductSubTotal,
                            sale.SalesSubTotal.toString(),
                            sale.SalesDiscount.toString(),
                            sale.SalesGST.toString(),
                            sale.SalesTotal.toString(),
                            sale.SalesNarration,
                            PaymentModeorg,
                            sale.SalesIDs,
                            "0",
                            "0",
                            "0",
                            UPIBankName,
                            UPITransactionId,
                            "0");
                        print(result);
                        var resid = result["resid"];
                        if (resid == 200) {
                          getClear(true);
                          Navigator.pop(context);
                          ProductName = sale.SalesProductName.split("#");
                          RATE = sale.SalesProductRate.split("#");
                          Quant = sale.SalesProductName.split("#");
                          ProSubtotal = sale.SalesProductSubTotal.split("#");
                          GSTPER = sale.SalesGST.split("#");
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return BillPrintNew(
                                ProductName,
                                RATE,
                                Quant,
                                ProSubtotal,
                                GSTPER,
                                sale.SalesSubTotal,
                                sale.SalesDiscount,
                                payableamount,
                                sale.SalesCustomername,
                                sale.SalesDate);
                          }));
                          Fluttertoast.showToast(
                              msg: "Bill generated successfully ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: PrimaryColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Error. Try again ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
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
  Widget _buildMobileSaleBillingScreenNew() {
    double mobHeight = MediaQuery.of(context).size.height * (.12);
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(15.0),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Payment Rs ${sale.SalesTotal.toString()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  Container(
                      child: Row(
                    children: [
                      Radio(
                        value: PaymentMode.cash,
                        groupValue: _paymode,
                        onChanged: (PaymentMode value) {
                          setState(() {
                            _paymode = value;
                            cashView = true;
                            debitView = false;
                            upiView = false;
                          });
                        },
                      ),
                      Text("Cash")
                    ],
                  )),
                  Container(
                      child: Row(
                    children: [
                      Radio(
                        value: PaymentMode.debit,
                        groupValue: _paymode,
                        onChanged: (PaymentMode value) {
                          setState(() {
                            _paymode = value;
                            cashView = false;
                            debitView = true;
                            upiView = false;
                            print(_paymode);
                          });
                        },
                      ),
                      Text("Card")
                    ],
                  )),
                  Container(
                      child: Row(
                    children: [
                      Radio(
                        value: PaymentMode.upi,
                        groupValue: _paymode,
                        onChanged: (PaymentMode value) {
                          setState(() {
                            _paymode = value;
                            cashView = false;
                            debitView = false;
                            upiView = true;
                          });
                        },
                      ),
                      Text("UPI")
                    ],
                  )),
                ],
              ),
            ),
            Visibility(visible: cashView, child: mobCashWidget(payableamount)),
            Visibility(visible: debitView, child: mobDebitWidget()),
            Visibility(visible: upiView, child: mobUpiWidget()),
            SizedBox(
              height: 10,
            ),
            // ListTile(
            //   title: const Text('Cash'),
            //   leading: Radio(
            //     value: PaymentMode.cash,
            //     groupValue: _paymode,
            //     onChanged: (PaymentMode value) {
            //       setState(() {
            //         _paymode = value;
            //       });
            //     },
            //   ),
            // ),
            // ListTile(
            //   title: const Text('Debit Card'),
            //   leading: Radio(
            //     value: PaymentMode.debit,
            //     groupValue: _paymode,
            //     onChanged: (PaymentMode value) {
            //       setState(() {
            //         _paymode = value;
            //       });
            //     },
            //   ),
            // ),
            // ListTile(
            //   title: const Text('UPI'),
            //   leading: Radio(
            //     value: PaymentMode.upi,
            //     groupValue: _paymode,
            //     onChanged: (PaymentMode value) {
            //       setState(() {
            //         _paymode = value;
            //       });
            //     },
            //   ),
            // ),
            Row(
              children: [
                SizedBox(
                  width: 90.0,
                ),
                Material(
                  color: PrimaryColor,
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
                      // var result = await salesInsert.getSalesHotelInsertWihId(
                      //     sale.SalesIDs,
                      //     sale.SalesCustomername,
                      //     sale.SalesDate,
                      //     sale.SalesProductName,
                      //     sale.SalesProductRate.toString(),
                      //     sale.SalesProductQty.toString(),
                      //     sale.SalesProductSubTotal,
                      //     sale.SalesSubTotal.toString(),
                      //     sale.SalesDiscount.toString(),
                      //     sale.SalesGST.toString(),
                      //     sale.SalesTotal.toString(),
                      //     sale.SalesNarration,
                      //     PaymentModeorg);

                      if (_paymode == PaymentMode.cash) {
                        var result = await salesInsert.getSalesHotelInsert(
                            sale.SalesCustomerId,
                            sale.SalesCustomername,
                            sale.SalesCustomerMobileNo,
                            sale.SalesDate,
                            sale.SalesProductId,
                            sale.SalesProductRate.toString(),
                            sale.SalesProductQty.toString(),
                            sale.SalesProductSubTotal,
                            sale.SalesSubTotal.toString(),
                            sale.SalesDiscount.toString(),
                            sale.SalesGST.toString(),
                            sale.SalesTotal.toString(),
                            sale.SalesNarration,
                            PaymentModeorg,
                            sale.SalesIDs,
                            "",
                            "",
                            "",
                            "",
                            "",
                            "");
                        print(result);
                        var resid = result["resid"];
                        if (resid == 200) {
                          getClear(true);
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Bill generated successfully ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: PrimaryColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Error. Try again ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      } else if (_paymode == PaymentMode.debit) {
                        var result = await salesInsert.getSalesHotelInsert(
                            sale.SalesCustomerId,
                            sale.SalesCustomername,
                            sale.SalesCustomerMobileNo,
                            sale.SalesDate,
                            sale.SalesProductId,
                            sale.SalesProductRate.toString(),
                            sale.SalesProductQty.toString(),
                            sale.SalesProductSubTotal,
                            sale.SalesSubTotal.toString(),
                            sale.SalesDiscount.toString(),
                            sale.SalesGST.toString(),
                            sale.SalesTotal.toString(),
                            sale.SalesNarration,
                            PaymentModeorg,
                            sale.SalesIDs,
                            CardName,
                            DebitCardOnName,
                            DebitCardNumber,
                            "",
                            "",
                            TypeCard);
                        print(result);
                        var resid = result["resid"];
                        if (resid == 200) {
                          getClear(true);
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Bill generated successfully ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: PrimaryColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Error. Try again ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      } else if (_paymode == PaymentMode.upi) {
                        var result = await salesInsert.getSalesHotelInsert(
                            sale.SalesCustomerId,
                            sale.SalesCustomername,
                            sale.SalesCustomerMobileNo,
                            sale.SalesDate,
                            sale.SalesProductId,
                            sale.SalesProductRate.toString(),
                            sale.SalesProductQty.toString(),
                            sale.SalesProductSubTotal,
                            sale.SalesSubTotal.toString(),
                            sale.SalesDiscount.toString(),
                            sale.SalesGST.toString(),
                            sale.SalesTotal.toString(),
                            sale.SalesNarration,
                            PaymentModeorg,
                            sale.SalesIDs,
                            "",
                            "",
                            "",
                            UPIBankName,
                            UPITransactionId,
                            "");
                        print(result);
                        var resid = result["resid"];
                        if (resid == 200) {
                          getClear(true);
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Bill generated successfully ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: PrimaryColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Error. Try again ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }

                      //
                      //
                      // print("//////result Server////////$result");
                      // if (result == null) {
                      //   _showMyDialog('Failed !', Colors.red);
                      // } else {
                      //   _showMyDialog('Data Successfully Save !', Colors.green);
                      // }
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
                  color: PrimaryColor,
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
                      if (_paymode == PaymentMode.cash) {
                        var result = await salesInsert.getSalesHotelInsert(
                            sale.SalesCustomerId,
                            sale.SalesCustomername,
                            sale.SalesCustomerMobileNo,
                            sale.SalesDate,
                            sale.SalesProductId,
                            sale.SalesProductRate.toString(),
                            sale.SalesProductQty.toString(),
                            sale.SalesProductSubTotal,
                            sale.SalesSubTotal.toString(),
                            sale.SalesDiscount.toString(),
                            sale.SalesGST.toString(),
                            sale.SalesTotal.toString(),
                            sale.SalesNarration,
                            PaymentModeorg,
                            sale.SalesIDs,
                            "0",
                            "0",
                            "0",
                            "0",
                            "0",
                            "0");
                        print(result);
                        var resid = result["resid"];
                        if (resid == 200) {
                          getClear(true);
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Bill generated successfully ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: PrimaryColor,
                              textColor: Colors.white,
                              fontSize: 16.0);

                          ProductName = sale.SalesProductName.split("#");
                          RATE = sale.SalesProductRate.split("#");
                          Quant = sale.SalesProductName.split("#");
                          ProSubtotal = sale.SalesProductSubTotal.split("#");
                          GSTPER = sale.SalesGST.split("#");
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return BillPrintNew(
                                ProductName,
                                RATE,
                                Quant,
                                ProSubtotal,
                                GSTPER,
                                sale.SalesSubTotal,
                                sale.SalesDiscount,
                                payableamount,
                                sale.SalesCustomername,
                                sale.SalesDate);
                          }));
                        } else {
                          Fluttertoast.showToast(
                              msg: "Error. Try again ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      } else if (_paymode == PaymentMode.debit) {
                        var result = await salesInsert.getSalesHotelInsert(
                            sale.SalesCustomerId,
                            sale.SalesCustomername,
                            sale.SalesCustomerMobileNo,
                            sale.SalesDate,
                            sale.SalesProductId,
                            sale.SalesProductRate.toString(),
                            sale.SalesProductQty.toString(),
                            sale.SalesProductSubTotal,
                            sale.SalesSubTotal.toString(),
                            sale.SalesDiscount.toString(),
                            sale.SalesGST.toString(),
                            sale.SalesTotal.toString(),
                            sale.SalesNarration,
                            PaymentModeorg,
                            sale.SalesIDs,
                            CardName,
                            DebitCardOnName,
                            DebitCardNumber,
                            "0",
                            "0",
                            TypeCard);
                        print(result);
                        var resid = result["resid"];
                        if (resid == 200) {
                          getClear(true);
                          Navigator.pop(context);
                          ProductName = sale.SalesProductName.split("#");
                          RATE = sale.SalesProductRate.split("#");
                          Quant = sale.SalesProductName.split("#");
                          ProSubtotal = sale.SalesProductSubTotal.split("#");
                          GSTPER = sale.SalesGST.split("#");
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return BillPrintNew(
                                ProductName,
                                RATE,
                                Quant,
                                ProSubtotal,
                                GSTPER,
                                sale.SalesSubTotal,
                                sale.SalesDiscount,
                                payableamount,
                                sale.SalesCustomername,
                                sale.SalesDate);
                          }));
                          Fluttertoast.showToast(
                              msg: "Bill generated successfully ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: PrimaryColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Error. Try again ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      } else if (_paymode == PaymentMode.upi) {
                        var result = await salesInsert.getSalesHotelInsert(
                            sale.SalesCustomerId,
                            sale.SalesCustomername,
                            sale.SalesCustomerMobileNo,
                            sale.SalesDate,
                            sale.SalesProductId,
                            sale.SalesProductRate.toString(),
                            sale.SalesProductQty.toString(),
                            sale.SalesProductSubTotal,
                            sale.SalesSubTotal.toString(),
                            sale.SalesDiscount.toString(),
                            sale.SalesGST.toString(),
                            sale.SalesTotal.toString(),
                            sale.SalesNarration,
                            PaymentModeorg,
                            sale.SalesIDs,
                            "0",
                            "0",
                            "0",
                            UPIBankName,
                            UPITransactionId,
                            "0");
                        print(result);
                        var resid = result["resid"];
                        if (resid == 200) {
                          getClear(true);
                          Navigator.pop(context);
                          ProductName = sale.SalesProductName.split("#");
                          RATE = sale.SalesProductRate.split("#");
                          Quant = sale.SalesProductName.split("#");
                          ProSubtotal = sale.SalesProductSubTotal.split("#");
                          GSTPER = sale.SalesGST.split("#");
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return BillPrintNew(
                                ProductName,
                                RATE,
                                Quant,
                                ProSubtotal,
                                GSTPER,
                                sale.SalesSubTotal,
                                sale.SalesDiscount,
                                payableamount,
                                sale.SalesCustomername,
                                sale.SalesDate);
                          }));
                          Fluttertoast.showToast(
                              msg: "Bill generated successfully ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: PrimaryColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Error. Try again ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
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

  Widget cashWidget(double paymentamount) {
    double cashValue;
    double changeValue;
    TextEditingController textEditingControllerChange = TextEditingController();
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.20,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  cashValue = double.parse(value);
                  changeValue = cashValue - paymentamount;
                  if (changeValue < 0) {
                    textEditingControllerChange.text = 0.toString();
                  } else {
                    textEditingControllerChange.text = changeValue.toString();
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cash',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.20,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: textEditingControllerChange,
                onChanged: (value) {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Change',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget debitWidget() {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.20,
              child: DropdownSearch(
                isFilteredOnline: true,
                showClearButton: true,
                showSearchBox: true,
                items: [
                  "Debit Card",
                  "Credit Card",
                ],
                label: "Card",
                autoValidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  setState(() {
                    TypeCard = value;
                    print(TypeCard);
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.20,
              child: DropdownSearch(
                isFilteredOnline: true,
                showClearButton: true,
                showSearchBox: true,
                items: TypeCard == "Debit Card" ? DebitCards : CreditCards,
                label: "Card Type",
                autoValidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  CardName = value;
                  print(CardName);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.20,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  DebitCardOnName = value;
                  print(DebitCardOnName);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name on card',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.20,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  DebitCardNumber = value;
                  print(DebitCardNumber);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Card No',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget upiWidget() {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.30,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  UPIBankName = value;
                  print(UPIBankName);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Bank Name',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.30,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  UPITransactionId = value;
                  print(UPITransactionId);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Transaction Id',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mobCashWidget(double paymentamount) {
    double cashValue;
    double changeValue;
    TextEditingController textEditingControllerChange = TextEditingController();
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  cashValue = double.parse(value);
                  changeValue = cashValue - paymentamount;
                  if (changeValue < 0) {
                    textEditingControllerChange.text = 0.toString();
                  } else {
                    textEditingControllerChange.text = changeValue.toString();
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cash',
                ),
              ),
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Expanded(
            child: Container(
              height: 50,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: textEditingControllerChange,
                onChanged: (value) {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Change',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mobDebitWidget() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  child: DropdownSearch(
                    isFilteredOnline: true,
                    showClearButton: true,
                    showSearchBox: true,
                    items: [
                      "Debit Card",
                      "Credit Card",
                    ],
                    label: "Card",
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      setState(() {
                        TypeCard = value;
                        print(TypeCard);
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 6,
              ),
              Expanded(
                child: Container(
                  height: 50,
                  child: DropdownSearch(
                    isFilteredOnline: true,
                    showClearButton: true,
                    showSearchBox: true,
                    items: TypeCard == "Debit Card" ? DebitCards : CreditCards,
                    label: "Card Type",
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      CardName = value;
                      print(CardName);
                    },
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
                child: Container(
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      DebitCardOnName = value;
                      print(DebitCardOnName);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name on card',
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 6,
              ),
              Expanded(
                child: Container(
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      DebitCardNumber = value;
                      print(DebitCardNumber);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Card No',
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 6,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget mobUpiWidget() {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  UPIBankName = value;
                  print(UPIBankName);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Bank Name',
                ),
              ),
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Expanded(
            child: Container(
              height: 50,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  UPITransactionId = value;
                  print(UPITransactionId);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Transaction Id',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
