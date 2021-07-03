import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/EhotelAdapter/POS_Sales_Insert.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_shop_fetch.dart';
import 'package:retailerp/Adpater/fetch_shop_ac_type.dart';
import 'package:retailerp/Adpater/insert_walkinCustomer.dart';
import 'package:retailerp/Adpater/ledger_model.dart';
import 'package:retailerp/Adpater/pos_customer-fetch.dart';
import 'package:retailerp/Adpater/pos_ledger_fetch.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/EhotelModel/Shop.dart';
import 'package:retailerp/LocalDbModels/customer_model.dart';
import 'package:retailerp/POSUIONE/bill_print1.dart';
import 'package:retailerp/POSUIONE/pos_frontpage.dart';
import 'package:retailerp/POSUITwo/billing_productdata_trial_two.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/ledger_pay_type_model.dart';
import 'package:retailerp/models/shop_bank_ac_type.dart';
import 'package:retailerp/utils/POSProviders/billing_productdata.dart';
import 'package:retailerp/utils/const.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

enum PaymentMode { cash, debit, upi }

class BillingScreenTwo extends StatefulWidget {
  BillingScreenTwo(this.billingAmount, this.DATE);

  final double billingAmount;
  final String DATE;

  @override
  _BillingScreenTwoState createState() => _BillingScreenTwoState();
}

class _BillingScreenTwoState extends State<BillingScreenTwo> {
  PaymentMode _paymode = PaymentMode.cash;
  String Paymentmode, PhoneNo;

  List<int> ProductID = new List();
  List<String> ProductName = new List();
  List<double> RATE = new List();
  List<double> Quant = new List();
  List<double> ProSubtotal = new List();
  List<double> GSTPER = new List();
  bool printbtnShow = true;
  bool cards = false;
  String TypeCard;
  String CardName;
  String DebitCardNumber;
  String DebitCardOnName;
  String UPIBankName;
  String UPITransactionId;

  List<ShopBankACType> mBankTypeList = [];
  String _mBankId;
  String _mBankName;

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

  final posFrontPage = POSFrontPage();

  List<CustomerModel> localcustomerList;
  DatabaseHelper databaseHelper = DatabaseHelper();
  int customercount = 0;

  String CustomerName;
  String CustomerId;

  List<LedgerPayTypeModel> ledgerList = [];
  List<LedgerModel> CustomerList = new List();

  bool cashView = true;
  bool debitView = false;
  bool upiView = false;
  bool custView = false;

  int discountprice = 0;
  int discountvalue;
  double total_amount;
  double payableamount;
  WalkinCustomer walkinCustomer = new WalkinCustomer();
  SalesInsert salesInsert = new SalesInsert();
  CustomerFetch customerfetch = new CustomerFetch();
  String _ledgerId, _ledgerPaymodename, _ledgeraccounttypeid, _accounttypename;

  @override
  void initState() {
    setState(() {
      payableamount = widget.billingAmount;
      total_amount = widget.billingAmount;
    });
    _getLedger();
    _getShopBankACType();
    _getCustomerList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDataTrialTwo>(builder: (context, productData, child) {
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
                  "Payment Rs ${productData.totalAmount1.toString()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
              ),
              Divider(
                thickness: 2.0,
                color: PrimaryColor,
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: DropdownSearch<LedgerModel>(
                            isFilteredOnline: true,
                            showClearButton: true,
                            showSearchBox: true,
                            items: CustomerList,
                            label: "Customer Name",
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value) {
                               CustomerName = value.ledgerCustomername;
                               CustomerId = value.ledgerId;

                              if (value != null) {
                                print("value ledgerId : ${value.ledgerId}");
                                if (value.ledgerId == '0') {
                                  setState(() {
                                    custView = true;
                                  });
                                } else {
                                  setState(() {
                                    custView = false;
                                  });
                                }
                              } else {
                                setState(() {
                                  custView = false;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Visibility(visible: custView, child: addCustomer())
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 2.0,
                color: PrimaryColor,
              ),
              Container(
                height: 35,
                child: ListTile(
                  title: Text("Discount Amount"),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "${discountprice.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: PrimaryColor),
                          ),
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Icon(
                              Icons.edit,
                              color: PrimaryColor,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: AlertDialog(
                                      title: Text('Enter Discount Price'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            TextField(
                                              autofocus: true,
                                              textAlign: TextAlign.left,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  labelText: "Discount Price"),
                                              onChanged: (newText) {
                                                discountvalue =
                                                    int.parse(newText);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Add'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            setState(() {
                                              discountprice = discountvalue;
                                              payableamount =
                                                  total_amount - discountprice;
                                            });
                                            // productData.updatePrice(updatedPrice,product);
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Close'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            // productData.updatePrice(updatedPrice,product);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                child: ListTile(
                  title: Text("Payable Amount"),
                  trailing: Text(
                    "${payableamount.toString()}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: PrimaryColor),
                  ),
                ),
              ),
              Container(
                height: 30,
                child: ListTile(
                  title: Text("Date"),
                  trailing: Text(
                    widget.DATE,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: PrimaryColor),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  thickness: 2.0,
                  color: PrimaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Amount: ${payableamount.toString()}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: PrimaryColor),
                ),
              ),

              Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: DropdownSearch<LedgerPayTypeModel>(
                    isFilteredOnline: true,
                    showClearButton: true,
                    showSearchBox: true,
                    items: ledgerList,
                    label: "Payment Type",
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      if (value != null) {
                        _ledgerId = value.ledgerId;
                        _ledgerPaymodename = value.ledgerPaymodename;
                        _ledgeraccounttypeid = value.ledgeraccounttypeid;
                        _accounttypename = value.accounttypename;
                        switch (_ledgeraccounttypeid) {
                          case "2":
                            {
                              setState(() {
                                cashView = true;
                                debitView = false;
                                upiView = false;
                              });
                            }
                            break;

                          case "7":
                            {
                              setState(() {
                                cashView = false;
                                debitView = true;
                                upiView = false;
                              });
                            }
                            break;

                          case "37":
                            {
                              setState(() {
                                cashView = false;
                                debitView = false;
                                upiView = true;
                              });
                            }
                            break;

                          default:
                            {
                              print("Invalid choice");
                            }
                            break;
                        }
                      } else {
                        _ledgerId = null;
                        _ledgerPaymodename = null;
                        _ledgeraccounttypeid = null;
                        _accounttypename = null;
                      }
                    },
                  ),
                ),
              ),
              Visibility(visible: cashView, child: cashWidget(payableamount)),
              Visibility(visible: debitView, child: upiWidget()),
              Visibility(visible: upiView, child: upiWidget()),
              printbtnShow
                  ? Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Material(
                              color: PrimaryColor,
                              borderRadius: BorderRadius.circular(30.0),
                              child: MaterialButton(
                                onPressed: () async {
                                  setState(() {
                                    printbtnShow = false;
                                  });
                                  int temp = productData.products.length;
                                  print(temp);
                                  for (int i = 0; i < temp; i++) {
                                    ProductID.add(productData.products[i].pid);
                                    ProductName.add(productData.products[i].productname);
                                    RATE.add(
                                        productData.products[i].productprice);
                                    Quant.add(
                                        productData.products[i].productquntity);
                                    ProSubtotal.add(
                                        productData.products[i].subTotal);
                                    GSTPER
                                        .add(productData.products[i].gstperce);
                                  }
                                  print(ProductName);
                                  var MENUIDJOIN = ProductID.join("#");
                                  var PRODUCTNAMEJOIN = ProductName.join("#");
                                  var RATEJOIN = RATE.join("#");
                                  var QUANTJOIN = Quant.join("#");
                                  var SubJOIN = ProSubtotal.join("#");
                                  var GSTPERJOIN = GSTPER.join("#");

                                  print(_ledgerId);
                                  print(widget.DATE);
                                  print(CustomerId);
                                  print(CustomerName);
                                  print(discountprice.toStringAsFixed(2));
                                  print( payableamount.toStringAsFixed(2));
                                  print(_ledgeraccounttypeid);
                                  print(_mBankId);
                                  print(MENUIDJOIN);
                                  print(PRODUCTNAMEJOIN);
                                  print(RATEJOIN);
                                  print(SubJOIN);
                                  print(QUANTJOIN);
                                  print(widget.billingAmount);


                                  print(Paymentmode);
                                  double tempstotal = productData.totalAmount1 -
                                      productData.TotalGSTAmount;
                                  String subtotal =
                                      tempstotal.toStringAsFixed(2);
                                    var response = await salesInsert.insertPOSOrder(
                                        "0",
                                       _ledgerId,
                                        "narration",
                                        widget.DATE,
                                        CustomerId,
                                        CustomerName,
                                        "",
                                        subtotal,
                                        discountprice.toStringAsFixed(2),
                                        payableamount.toStringAsFixed(2),
                                        MENUIDJOIN,
                                        QUANTJOIN,
                                        RATEJOIN,
                                        SubJOIN,
                                        GSTPERJOIN,_ledgeraccounttypeid, _mBankId!=null?_mBankId:'');

                                    var resid = response["resid"];
                                    var billno = response["menusaleid"];
                                    if (resid == 200) {
                                      productData.ClearTask();
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                          msg: "Bill genrated Sucessfully",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.redAccent,
                                          textColor: Colors.white,
                                          fontSize: 16.0);

                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (_) {
                                        return BillPrint1(
                                            ProductName,
                                            RATE,
                                            Quant,
                                            ProSubtotal,
                                            GSTPER,
                                            subtotal,
                                            discountprice.toStringAsFixed(2),
                                            payableamount.toStringAsFixed(2),
                                            CustomerName,
                                            widget.DATE,
                                            billno.toString());
                                      }));
                                      setState(() {
                                        printbtnShow = true;
                                      });
                                    } else if (resid != 200) {
                                      setState(() {
                                        printbtnShow = true;
                                      });
                                    }
                                },
                                minWidth: 100.0,
                                height: 35.0,
                                child: Text(
                                  'Print',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                        ],
                      ),
                    )
                  : Center(child: CircularProgressIndicator())
            ],
          ),
        ),
      );
    });
  }


  Widget upiWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownSearch<ShopBankACType>(
          items: mBankTypeList,
          label: "Bank Name *",
          onChanged: (value) {
            if (value != null) {
              _mBankId = value.shopBankId;
              _mBankName = value.shopBankName;
            } else {
              _mBankId = null;
              _mBankName = null;
            }
          },
        ),
      ),
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

  Widget addCustomer() {
    String CustomerNameTemp, CustomerMob;
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: TextField(
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  CustomerName = value;
                  print("CustomerName: $CustomerName");
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Customer Name',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  PhoneNo = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mobile N.o',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.plusCircle,
                color: PrimaryColor,
              ),
              onPressed: () async {
                if (CustomerName == null) {
                  Fluttertoast.showToast(
                      msg: "Please Enter Customer Name",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: PrimaryColor,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }

                if (CustomerMob == null) {
                  setState(() {
                    CustomerMob = "";
                  });
                }

                var res = await walkinCustomer.sendWalkinData(
                    widget.DATE, CustomerName, PhoneNo);
                var resid = res["resid"];
                if (resid == 200) {
                  Fluttertoast.showToast(
                      msg: "Customer Added Sucessfully",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: PrimaryColor,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  Fluttertoast.showToast(
                      msg: "Error",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.redAccent,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }

                // setState(() {
                //   CustomerName = CustomerNameTemp;
                // });

                print(res);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _getShopBankACType() async {
    ShopBankACTypeFetch accounttypefetch = new ShopBankACTypeFetch();
    var accounttypefetchData =
        await accounttypefetch.getShopBankACTypeFetch("0");
    var resid = accounttypefetchData["resid"];
    if (resid == 200) {
      var rowcount = accounttypefetchData["rowcount"];
      if (rowcount > 0) {
        var fetchsd = accounttypefetchData["shopbanklist"];
        List<ShopBankACType> tempShopBankACTypeList = [];
        for (var n in fetchsd) {
          ShopBankACType pro = ShopBankACType(
            n["ShopBankId"],
            n["ShopBankName"],
          );
          tempShopBankACTypeList.add(pro);
          setState(() {
            this.mBankTypeList = tempShopBankACTypeList;
            // showspinnerlog = false;
          });
          print("//////ShopBankACTypeList/////////$mBankTypeList.length");
        }
      } else {
        setState(() {
          // showspinnerlog = false;
        });
        String msg = accounttypefetchData["message"];
        // Fluttertoast.showToast(
        //   msg: msg,
        //   toastLength: Toast.LENGTH_SHORT,
        //   backgroundColor: Colors.black38,
        //   textColor: Color(0xffffffff),
        //   gravity: ToastGravity.BOTTOM,
        // );
      }
    } else {
      setState(() {
        // showspinnerlog = true;
      });
      String msg = accounttypefetchData["message"];
      // Fluttertoast.showToast(
      //   msg: msg,
      //   toastLength: Toast.LENGTH_SHORT,
      //   backgroundColor: Colors.black38,
      //   textColor: Color(0xffffffff),
      //   gravity: ToastGravity.BOTTOM,
      // );
    }
  }

  void _getLedger() async {
    LedgerFetch ledger = new LedgerFetch();
    var supplierData = await ledger.getLedgerPayTypeFetch("0");
    print(supplierData);
    var resid = supplierData["resid"];
    if (resid == 200) {
      var rowcount = supplierData["rowcount"];
      if (rowcount > 0) {
        var ledgersd = supplierData["ledgerpaymodelist"];
        List<LedgerPayTypeModel> tempSupplier = [];
        for (var n in ledgersd) {
          LedgerPayTypeModel leg = LedgerPayTypeModel(
              n["ledgerId"],
              n["ledgerPaymodename"],
              n["ledgeraccounttypeid"],
              n["accounttypename"]);
          tempSupplier.add(leg);
        }
        setState(() {
          this.ledgerList = tempSupplier;
          // _showProgress =false;
        });
        print("//////SalesList/////////$ledgerList.length");
      }
    }
  }

  void _getCustomerList() async {
    LedgerFetch ledger = new LedgerFetch();
    var supplierData = await ledger.getLedgerFetch("0");
    print(supplierData);
    var resid = supplierData["resid"];
    if (resid == 200) {
      var rowcount = supplierData["rowcount"];
      if (rowcount > 0) {
        var ledgersd = supplierData["ledgercustomerlist"];
        List<LedgerModel> tempSupplier = [];
        LedgerModel walkleg = LedgerModel(
          '0',
          'Walking',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
        );
        tempSupplier.add(walkleg);
        for (var n in ledgersd) {
          LedgerModel leg = LedgerModel(
            n["ledgerId"],
            n["ledgerCustomername"],
            n["ledgerComapanyPersonName"],
            n["ledgerMobileNumber"],
            n["ledgerEmail"],
            n["ledgerAddress"],
            n["ledgerUdyogAadhar"],
            n["ledgerCINNumber"],
            n["ledgerGSTType"],
            n["ledgerGSTNumber"],
            n["ledgerFAXNumber"],
            n["ledgerPANNumber"],
            n["ledgerLicenseType"],
            n["ledgerLicenseName"],
            n["ledgerBankName"],
            n["ledgerBankBranch"],
            n["ledgerAccountType"],
            n["ledgerAccountNumber"],
            n["ledgerIFSCCode"],
            n["ledgerUPINumber"],
          );
          tempSupplier.add(leg);
        }
        setState(() {
          this.CustomerList = tempSupplier;
        });
        print("//////SalesList/////////$ledgerList.length");
      }
    }
  }
}
