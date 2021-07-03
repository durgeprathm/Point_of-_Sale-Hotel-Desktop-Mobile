import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/EhotelAdapter/POS_Sales_Insert.dart';
import 'package:retailerp/Adpater/EhotelAdapter/update_salesdata.dart';
import 'package:retailerp/Adpater/insert_walkinCustomer.dart';
import 'package:retailerp/Adpater/pos_customer-fetch.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/LocalDbModels/customer_model.dart';
import 'package:retailerp/editPOSUI/EditbillProviders/edit_billprovider.dart';
import 'package:retailerp/utils/const.dart';
import 'table_bill_print_edit.dart';

enum PaymentMode { cash, debit, upi }

class TableBillingScreenEdit extends StatefulWidget {
  TableBillingScreenEdit(this.billingAmount, this.DATE);
  final double billingAmount;
  final String DATE;

  @override
  _TableBillingScreenEditState createState() => _TableBillingScreenEditState();
}

class _TableBillingScreenEditState extends State<TableBillingScreenEdit> {
  PaymentMode _paymode = PaymentMode.cash;
  String Paymentmode, PhoneNo;
 // UpdateOrderStatus updateOrderStatus = new UpdateOrderStatus();
  List<String> OrderID = new List();
  List<int> ProductID = new List();
  List<String> ProductName = new List();
  List<double> RATE = new List();
  List<int> Quant = new List();
  List<double> ProSubtotal = new List();
  List<double> GSTPER = new List();
  List<CustomerModel> localcustomerList;
  // DatabaseHelper databaseHelper = DatabaseHelper();
  int customercount = 0;
  String CustomerName;
  int discountprice = 0;
  int discountvalue;
  double total_amount;
  double payableamount;

  bool cashView = true;
  bool debitView = false;
  bool upiView = false;
  bool custView = false;

  List<String> servercustomerList = ['Walkin Customer'];
  WalkinCustomer walkinCustomer = new WalkinCustomer();
  SalesUpdate salesupdate = new SalesUpdate();
  CustomerFetch customerfetch = new CustomerFetch();

  bool cards = false;
  String TypeCard;
  String CardName;
  String DebitCardNumber;
  String DebitCardOnName;
  String UPIBankName;
  String UPITransactionId;
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


  List<String> getCustomerNames() {
    List<String> tempclist = List();
    if (customercount != 0) {
      for (int i = 0; i < localcustomerList.length; i++) {
        tempclist.add(localcustomerList[i].custName.toString());
      }
    }
    return tempclist;
  }

  Future<void> serverCustomerList() async {
    var response = await customerfetch.getCustomerFetch("1");
    var customerSD = response["customer"];
    List<CustomerModel> tempcustomerList = [];
    List<String> tempCustoNames = [];
    for (var n in customerSD) {
      CustomerModel cust = new CustomerModel(
          n["CustomerDate"],
          n["CustomerName"],
          n["CustomerMobNo"],
          n["CustomerEmail"],
          n["CustomerAddress"],
          n["CustomerCreditType"],
          n["CustomerTaxSupplier"],
          int.parse(n["CustomerType"]));
      tempcustomerList.add(cust);
    }

    tempcustomerList.forEach((element) {
      tempCustoNames.add(element.custName);
    });

    setState(() {
      servercustomerList = tempCustoNames;
    });
  }

  @override
  void initState() {
    serverCustomerList();
    setState(() {
      payableamount = widget.billingAmount;
      total_amount = widget.billingAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderItemProviderEdit>(builder: (context, productData, child) {
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
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      Container(
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: DropdownSearch(
                            items: getCustomerNames() != null
                                ? getCustomerNames()
                                : "no products",
                            label: "Select Customer",
                            onChanged: (item) {
                              setState(() {
                                CustomerName = item;
                                print(CustomerName);
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.plusCircle,
                          color: PrimaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            custView = true;
                          });
                          },
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
                height: 30,
                child: ListTile(
                  title: Text("Total Bill"),
                  trailing: Text(
                    "${Rupees}${productData.totalAmount1.toString()}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: PrimaryColor),
                  ),
                ),
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
                                    true, // user must tap button!
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
                    "${productData.totalAmount1.toString()}",
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
                height: 30,
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
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Material(
                        color: PrimaryColor,
                        borderRadius: BorderRadius.circular(30.0),
                        child: MaterialButton(
                          onPressed: () async {

                            int temp = productData.orderitems.length;
                            print(temp);

                            if (CustomerName == null) {
                              setState(() {
                                CustomerName = "";
                              });
                            }

                            for (int i = 0; i < temp; i++) {
                              ProductID.add(productData.orderitems[i].pid);
                              ProductName.add(
                                  productData.orderitems[i].productname);
                              RATE.add(productData.orderitems[i].productprice);
                              Quant.add(
                                  productData.orderitems[i].productquntity);
                              ProSubtotal.add(
                                  productData.orderitems[i].subTotal);
                              GSTPER.add(productData.orderitems[i].gstperce);
                              // OrderID.add(productData.orderitems[i].orderID);
                            }
                            print(ProductName);
                            var MENUIDJOIN = ProductID.join("#");
                            var PRODUCTNAMEJOIN = ProductName.join("#");
                            var RATEJOIN = RATE.join("#");
                            var QUANTJOIN = Quant.join("#");
                            var SubJOIN = ProSubtotal.join("#");
                            var GSTPERJOIN = GSTPER.join("#");

                            print(MENUIDJOIN);
                            print(PRODUCTNAMEJOIN);
                            print(RATEJOIN);
                            print(SubJOIN);

                            print("ORDER ID////////////////////$TempOrderFour");

                            print(QUANTJOIN);
                            print(widget.billingAmount);

                            setState(() {
                              if (_paymode == PaymentMode.cash) {
                                Paymentmode = "CASH";
                              } else if (_paymode == PaymentMode.debit) {
                                Paymentmode = "DEBIT";
                              } else {
                                Paymentmode = "UPI";
                              }
                            });

                            print("SAoles ID ${editSalesID.toString()}");
                              double tempstotal = productData.totalAmount1 -
                                  productData.TotalGSTAmount;
                              String subtotal = tempstotal.toStringAsFixed(2);
                              var response = await salesupdate.updateSalesOrder(
                                  "",
                                  CustomerName,
                                  CustomerName,
                                subtotal.toString(),
                                discountprice.toStringAsFixed(2),
                                payableamount.toStringAsFixed(2),
                                  editSalesID.toString(),
                                  editDate.toString(),
                                  MENUIDJOIN.toString(),
                                  QUANTJOIN.toString(),
                                  RATEJOIN.toString(),
                                  GSTPERJOIN.toString(),
                                  SubJOIN.toString(),
                                "",
                                "",
                                  Paymentmode.toString()
                              );

                              var resid = response["resid"];

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
                                  return TableBillPrintEdit(
                                      ProductName,
                                      RATE,
                                      Quant,
                                      ProSubtotal,
                                      GSTPER,
                                      subtotal,
                                      discountprice.toStringAsFixed(2),
                                      payableamount.toStringAsFixed(2),
                                      CustomerName,
                                      widget.DATE);
                                }));
                              }
                            },
                          minWidth: 100.0,
                          height: 35.0,
                          child: Text(
                            'Print',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
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
            ],
          ),
        ),
      );
    });
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
          GestureDetector(
            onTap: () async {
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

              setState(() {
                CustomerName = CustomerNameTemp;
              });

              print(res);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add',
                style: TextStyle(
                    color: PrimaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
