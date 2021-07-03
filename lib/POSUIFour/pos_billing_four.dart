import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/POSUIThree/billing_productdata_trial_three.dart';
import 'package:retailerp/POSUIFour/billing_productdata_trial_four.dart';

class POSBillFour extends StatefulWidget {
  @override
  _POSBillFourState createState() => _POSBillFourState();
}

class _POSBillFourState extends State<POSBillFour> {
  int FinalSubTotal = 0;
  int updatedDiscount =0;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDataTrialFour>(builder: (context, productData, child) {
      return Material(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 18.0,
                child: ListTile(
                  title: Text("Total Items:"),
                  trailing: Text(
                      productData.productCount.toString(),
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
              SizedBox(
                height: 13.0,
              ),
              Container(
                height: 18.0,
                child: ListTile(
                  title: Text("Sub Total"),
                  trailing: Text(productData.totalAmount1!=null?"${((productData.totalAmount1)-(productData.TotalGSTAmount)).toStringAsFixed(2)}":'',
                  // trailing: Text(productData.totalAmount1!=null?"₹${productData.getBasicAmount}":'',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
              SizedBox(
                height: 13.0,
              ),
              Container(
                height: 18.0,
                child: ListTile(
                  title: Text("SGST"),
                  trailing: Text("${(productData.TotalGSTAmount/2).toStringAsFixed(2)}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
              SizedBox(
                height: 13.0,
              ),
              Container(
                height: 18.0,
                child: ListTile(
                  title: Text("CGST"),
                  trailing: Text("${(productData.TotalGSTAmount/2).toStringAsFixed(2)}",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
              SizedBox(
                height: 13.0,
              ),
              Container(
                height: 18.0,
                child: ListTile(
                  title: Text(
                    "Grand Total",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text("${productData.totalAmount1.toString()}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
