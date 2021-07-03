import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/POSUITwo/billing_productdata_trial_two.dart';
import 'package:retailerp/utils/POSProviders/billing_productdata.dart';
import 'package:retailerp/utils/const.dart';

import 'billing_page_two.dart';
class PayButtonTwo extends StatefulWidget {

  PayButtonTwo(this.CustomerName,this.Date);
  final String CustomerName;
  final String Date;
  @override
  _PayButtonTwoState createState() => _PayButtonTwoState();
}

class _PayButtonTwoState extends State<PayButtonTwo> {


  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDataTrialTwo>(builder: (context, productData, child) {
      return  Padding(
        padding: EdgeInsets.only(bottom: 0),
        child: Material(
          color: PrimaryColor,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            onPressed: () {
              //Navigator.pop(context);
              print(widget.CustomerName);
              print(widget.Date);
              if(productData.totalAmount1 == 0.0){
                _showMyDialog("No Product Is Added", Colors.black );
              }
              else {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) =>
                        SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery
                                      .of(context)
                                      .viewInsets
                                      .bottom
                              ),
                              child: BillingScreenTwo(productData.totalAmount1,widget.Date),
                            )
                        )
                );
              }
            },
            minWidth: 100.0,
            height: 35.0,
            child: Text(
              "Procced ${productData.totalAmount1.toString()}",
              style: TextStyle(
                  color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
    );
  });

  }
  Future<void> _showMyDialog(String msg,Color col) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child:  AlertDialog(
            title: Text(msg,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: col,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("You should add minimum \none product to genrate bill.")
                ],
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