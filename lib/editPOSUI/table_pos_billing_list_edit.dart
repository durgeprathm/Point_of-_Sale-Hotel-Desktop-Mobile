import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/editPOSUI/EditbillProviders/edit_billprovider.dart';

class TableProductbillinglistEdit extends StatefulWidget {
  @override
  _TableProductbillinglistEditState createState() =>
      _TableProductbillinglistEditState();
}

class _TableProductbillinglistEditState extends State<TableProductbillinglistEdit> {
  List<int> mytempsubTotal = new List();
  double updatedPrice;
  @override
  Widget build(BuildContext context) {
    double billheight = MediaQuery.of(context).size.height * .50;
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child:
          Consumer<OrderItemProviderEdit>(builder: (context, productData, child) {
        return Container(
          height: billheight,
          child: ListView.builder(
            itemCount: productData.productCount,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, int index) {
              final product = productData.orderitems[index];
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Material(
                  elevation: 3.0,
                  child: Container(
                    height: 75,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                              child: ListTile(
                                  title: Text(product.productname),
                                  subtitle: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Basic Amt: $Rupees${productData.getBasicAmount(product).toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                  ))),
                        ),
                        Expanded(
                          child: Container(
                              child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: IconButton(
                                  icon: FaIcon(
                                      product.productquntity == 1
                                          ? FontAwesomeIcons.trash
                                          : FontAwesomeIcons.minusCircle,
                                      color: product.productquntity == 1
                                          ? Colors.red
                                          : ProductbtnColor),
                                  onPressed: () {
                                    productData.decreaseQuant(product);
                                    productData.decupdateSTotal(product);
                                    productData
                                        .fungetFinalSubtotalminus(product);
                                    if (product.productquntity < 1) {
                                      productData.deleteTask(product);
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child:
                                      Text(product.productquntity.toString())),
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.plusCircle,
                                    color: ProductbtnColor,
                                  ),
                                  onPressed: () {
                                    productData.increaseQuant(product);
                                    productData.updateSTotal(product);
//
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(product.subTotal.toString())),
                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: true,
                                      // user must tap button!
                                      builder: (BuildContext context) {
                                        return SingleChildScrollView(
                                          child: AlertDialog(
                                            title: Text('Enter Price'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  TextField(
                                                    autofocus: true,
                                                    textAlign: TextAlign.left,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                        labelText: "Price"),
                                                    onChanged: (newText) {
                                                      updatedPrice =
                                                          double.parse(newText);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('Add'),
                                                onPressed: () {
                                                  if (updatedPrice == null) {
                                                    Navigator.of(context).pop();
                                                  } else {
                                                    Navigator.of(context).pop();
                                                    productData.updatePrice(
                                                        updatedPrice, product);
                                                    updatedPrice = null;
                                                  }
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
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

//Padding(
//padding: EdgeInsets.only(bottom: 5),
//child: Consumer<ProductData>(
//builder: (context, productData, child) {
//return Container(
//height: 160,
//child: ListView.builder(
//itemCount: productData.productCount,
//shrinkWrap: true,
//scrollDirection: Axis.vertical,
//itemBuilder: (context, int index) {
//final product =
//productData.products[index];
//return Container(
//child: Row(
//children: [
//SizedBox(
//width: 2.0,
//),
//Expanded(
//child: Container(
//child: ListTile(
//title: Text(product.productname),
//subtitle: Text(product
//    .productprice
//    .toString()),
//)),
//),
//Expanded(
//child: Container(
//child: Row(
//children: [
//Padding(
//padding:
//EdgeInsets.all(5.0),
//child: IconButton(
//icon: FaIcon(
//product.productquntity == 1 ? FontAwesomeIcons.trash :
//FontAwesomeIcons
//    .minusCircle,
//color: product.productquntity == 1 ? Colors.red:
//ProductbtnColor),
//onPressed: () {
//productData.decreaseQuant(product);
//productData.decupdateSTotal(product);
//if(product.productquntity < 1){
//productData.deleteTask(product);
//}
//},
//),
//),
//Padding(
//padding:
//EdgeInsets.all(5.0),
//child: Text(product.productquntity.toString())),
//Padding(
//padding:
//EdgeInsets.all(5.0),
//child: IconButton(
//icon: FaIcon(
//FontAwesomeIcons
//    .plusCircle,
//color: ProductbtnColor,
//),
//onPressed: () {
//productData.increaseQuant(product);
//productData.updateSTotal(product);
//},
//),
//),
//SizedBox(
//width: 15.0,
//),
//Padding(
//padding:
//EdgeInsets.all(10),
//child:
//Text(product.subTotal.toString()))
//],
//)),
//)
//],
//),
//);
//},
//),
//);
//}),
//);
