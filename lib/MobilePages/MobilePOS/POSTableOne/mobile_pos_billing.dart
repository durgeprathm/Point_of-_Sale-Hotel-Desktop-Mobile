import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/utils/MobilePOSProviders/billing_productMobile.dart';
import 'package:retailerp/utils/const.dart';


class MobilePOSBill extends StatefulWidget {
  @override
  _MobilePOSBillState createState() => _MobilePOSBillState();
}

enum PaymentMode {cash, debit, upi}

class _MobilePOSBillState extends State<MobilePOSBill> {
  PaymentMode _paymode = PaymentMode.cash;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:  Consumer<ProductDataMobile>(
          builder: (context, productData, child) {
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
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: 40,
                        child: DropdownSearch(
                          items: [
                            "Walk In Customer",
                            "Rajat",
                            "Prathmesh",
                          ],
                          label: "Select Customer",
                          onChanged: (item) {
                            if (item == "Walk In Customer") {
                              _showMyDialog();
                            }
                          },
                        ),
                      ),
                    ),
                    Divider(
                      color: PrimaryColor,
                    ),
                    Text("Selected Products",
                      style: TextStyle(fontWeight: FontWeight.bold),),

                    Material(
                      child: Container(
                          height: 190,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: productData.productCount,
                              itemBuilder: (BuildContext context, int index) {
                                final product =
                                productData.products[index];
                                return Container(
                                  height: 50,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Expanded(
                                        child: Container(
                                            child: ListTile(
                                              title: Text(product.productname),
                                              subtitle: Text(
                                                  product.productprice
                                                      .toString()
                                              ),
                                            )),
                                      ),
                                      Expanded(
                                        child: Container(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                  EdgeInsets.all(5.0),
                                                  child: IconButton(
                                                    icon: FaIcon(
                                                        product
                                                            .productquntity == 1
                                                            ? FontAwesomeIcons
                                                            .trash
                                                            :
                                                        FontAwesomeIcons
                                                            .minusCircle,
                                                        color: product
                                                            .productquntity == 1
                                                            ? Colors.red
                                                            :
                                                        ProductbtnColor),
                                                    onPressed: () {
                                                      productData.decreaseQuant(
                                                          product);
                                                      productData
                                                          .decupdateSTotal(
                                                          product);
                                                      productData
                                                          .fungetFinalSubtotalminus(
                                                          product);

                                                      if (product
                                                          .productquntity < 1) {
                                                        productData.deleteTask(
                                                            product);
                                                      }
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                    padding:
                                                    EdgeInsets.all(5.0),
                                                    child: Text(
                                                        product.productquntity
                                                            .toString())
                                                ),
                                                Padding(
                                                  padding:
                                                  EdgeInsets.all(5.0),
                                                  child: IconButton(
                                                    icon: FaIcon(
                                                      FontAwesomeIcons
                                                          .plusCircle,
                                                      color: ProductbtnColor,
                                                    ),
                                                    onPressed: () {
                                                      productData.increaseQuant(
                                                          product);
                                                      productData.updateSTotal(
                                                          product);
//                                        mytempsubTotal.insert(index,product.subTotal);
//                                                  print(mytempsubTotal);
//                                        productData.funfinalSubtotal(product);
                                                    },
                                                  ),
                                                ),
                                                Text(
                                                    product.subTotal.toString())
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                );
                              }
                          )
                      ),
                    ),
                    Divider(
                      color: PrimaryColor,
                    ),
                    Text("Bill Preview",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    Material(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: 15.0,
                              child: ListTile(
                                title: Text("Total Products"),
                                trailing: Text(productData.productCount.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            Container(
                              height: 15.0,
                              child: ListTile(
                                title: Text("Sub Total"),
                                trailing: Text(
                                    productData.totalAmount1.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            Container(
                              height: 15.0,
                              child: ListTile(
                                title: Text("Discount"),
                                trailing: Text("30₹",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            Container(
                              height: 15.0,
                              child: ListTile(
                                title: Text("SGST"),
                                trailing: Text("6₹",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            Container(
                              height: 15.0,
                              child: ListTile(
                                title: Text("CGST"),
                                trailing: Text("6₹",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            Container(
                              height: 30.0,
                              child: ListTile(
                                title: Text(
                                  "Grand Total",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: Text(productData.totalAmount1.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                        color: PrimaryColor
                    ),
                    Text("Payment Mode",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: PaymentMode.cash,
                                      groupValue: _paymode,
                                      onChanged: (PaymentMode value) {
                                        setState(() {
                                          _paymode = value;
                                        });
                                      },
                                    ),
                                    Text("Cash")
                                  ],
                                )
                            ),
                          ),
                          Expanded(
                            child: Container(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: PaymentMode.debit,
                                      groupValue: _paymode,
                                      onChanged: (PaymentMode value) {
                                        setState(() {
                                          _paymode = value;
                                          print(_paymode);
                                        });
                                      },
                                    ),
                                    Text("Debit")
                                  ],
                                )
                            ),
                          ),
                          Expanded(
                            child: Container(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: PaymentMode.upi,
                                      groupValue: _paymode,
                                      onChanged: (PaymentMode value) {
                                        setState(() {
                                          _paymode = value;
                                        });
                                      },
                                    ),
                                    Text("UPI")
                                  ],
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 0),
                      child: Material(
                        color: SALESBG,
                        borderRadius: BorderRadius.circular(30.0),
                        child: MaterialButton(
                          onPressed: () {
                            //Navigator.pop(context);

                          },
                          minWidth: 100.0,
                          height: 35.0,
                          child: Text(
                            'Save ${productData.totalAmount1.toString()}₹',
                            style: TextStyle(
                                color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      )
    );
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child:  AlertDialog(
            title: Text('Add Customer'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    autofocus: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        labelText: "Customer Name"
                    ),
                    onChanged: (newText) {

                    },
                  ),
                  TextField(
                    autofocus: true,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Mobile N.o"
                    ),
                    onChanged: (newText) {

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
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

//ListTile(
//title: const Text('Cash'),
//leading: Radio(
//value: PaymentMode.cash,
//groupValue: _paymode,
//onChanged: (PaymentMode value) {
//setState(() {
//_paymode = value;
//});
//},
//),
//),
//DataTable(
//columns: [
//DataColumn(label: Text('Product')) ,
//DataColumn(label: Text('Rate')),
//DataColumn(label: Text('Qut')),
//DataColumn(label: Text('Amount')),
//],
//rows: [
//DataRow(cells: [
//DataCell(Text("Milik")),
//DataCell(Text("25")),
//DataCell(Text("3")),
//DataCell(Text("75")),
//]
//),
//DataRow(cells: [
//DataCell(Text("Biscuits")),
//DataCell(Text("25")),
//DataCell(Text("3")),
//DataCell(Text("75")),
//]
//),
//DataRow(cells: [
//DataCell(Text("Tea")),
//DataCell(Text("25")),
//DataCell(Text("3")),
//DataCell(Text("75")),
//]
//),
//DataRow(cells: [
//DataCell(Text("Sugar")),
//DataCell(Text("25")),
//DataCell(Text("3")),
//DataCell(Text("75")),
//]
//),
//],
//),