import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/POSUIThree/billing_productdata_trial_three.dart';

class ProductbillinglistThree extends StatefulWidget {
  @override
  _ProductbillinglistThreeState createState() => _ProductbillinglistThreeState();
}

class _ProductbillinglistThreeState extends State<ProductbillinglistThree> {
  List<int> mytempsubTotal = new List();
  double updatedPrice,updatedqty;
  TextEditingController qtytextEC = new TextEditingController();
  TextEditingController subtotaltextEC = new TextEditingController();
  String editQty, editSubtotal;

  @override
  Widget build(BuildContext context) {
    double billheight = MediaQuery.of(context).size.height * 0.74;
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Consumer<ProductDataTrialThree>(builder: (context, productData, child) {
        return Container(
          height: billheight,
          child: ListView.builder(
            itemCount: productData.productCount,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, int index) {
              final product = productData.products[index];
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
                                          "Basic Amt: $Rupees${product.productprice.toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                  ))),
                        ),
                        Container(
                            child: Row(
                          children: [
                            SizedBox(
                              width: 20.0,
                            ),
                            Padding(
                                padding: EdgeInsets.all(5),
                                child: Text("Qty: ${product.productquntity.toString()}")),
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
                                qtytextEC.text = product.productquntity.toStringAsFixed(2);
                                subtotaltextEC.text = product.subTotal.toStringAsFixed(2);
                                setState(() {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: true,
                                    // user must tap button!
                                    builder: (BuildContext context) {
                                      return SingleChildScrollView(
                                        child: AlertDialog(
                                          title: Container(
                                            height: 30,
                                            child: ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(product.productname),
                                              subtitle: Container(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text("Product Rate: ${product.productprice}"),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ),
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                TextField(
                                                  autofocus: true,
                                                  textAlign: TextAlign.left,
                                                  controller: qtytextEC,
                                                  keyboardType: TextInputType.number,
                                                  decoration:
                                                  InputDecoration(labelText: "Qty"),
                                                  onChanged: (newText) {
                                                    editQty = (newText);
                                                    if (product.productprice.toStringAsFixed(2).isNotEmpty) {
                                                      subTotalCal(
                                                          double.tryParse(product.productprice.toStringAsFixed(2)) ??
                                                              0.00,
                                                          double.tryParse(editQty) ??
                                                              0.00);
                                                    }
                                                    // qtytextEC.text =  (double.parse(subtotaltextEC.text) / double.parse(productrate)).toString();
                                                    // subtotaltextEC.text = (int.parse(qtytextEC.text) * double.parse(productrate)).toString();
                                                  },
                                                ),
                                                TextField(
                                                  autofocus: true,
                                                  textAlign: TextAlign.left,
                                                  controller: subtotaltextEC,
                                                  keyboardType: TextInputType.number,
                                                  decoration: InputDecoration(
                                                      labelText: "Subtotal"),
                                                  onChanged: (newText) {
                                                    setState(() {
                                                      editSubtotal = (newText);
                                                      if (product.productprice.toStringAsFixed(2).isNotEmpty) {
                                                        qtyCal(
                                                            double.tryParse(product.productprice.toStringAsFixed(2))??0.00,
                                                            double.tryParse(
                                                                editSubtotal) ??
                                                                0.00);
                                                      }
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[

                                            TextButton(
                                              child: Text('Add'),
                                              onPressed: () {
                                                if(editSubtotal==null || editQty == null){
                                                  Navigator.of(context).pop();
                                                }else{
                                                  Navigator.of(context).pop();
                                                  productData.updatePrice(
                                                      double.parse(editSubtotal), product);

                                                  productData.updateQty(double.parse(editQty), product);
                                                  editSubtotal = null;
                                                  editQty = null;
                                                }
                                              },
                                            ),
                                            TextButton(
                                              child: Text('Close'),
                                              onPressed: () {
                                                subtotaltextEC.text = "";
                                                qtytextEC.text = "";
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
                            ),
                            IconButton(icon: FaIcon(FontAwesomeIcons.trash,color: Colors.redAccent,) , onPressed: () {
                              productData.deleteTask(product);
                              // void deleteTask(ProductTrial product) {
                              //   _product.remove(product);
                              //   notifyListeners();
                              // }

                            })
                          ],
                        ),),
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

  subTotalCal(double rate, double qty) {
    setState(() {
      subtotaltextEC.text = (rate * qty).toStringAsFixed(2);
      editSubtotal=(rate * qty).toStringAsFixed(2);
    });
  }

  qtyCal(double rate, double subtotal) {
    setState(() {
      qtytextEC.text = (subtotal / rate).toStringAsFixed(1);
      editQty = (subtotal / rate).toStringAsFixed(1);
    });
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
