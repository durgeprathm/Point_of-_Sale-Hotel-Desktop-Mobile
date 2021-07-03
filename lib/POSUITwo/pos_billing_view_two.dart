import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/LocalDbModels/POSModels/product.dart';
import 'package:retailerp/LocalDbModels/customer_model.dart';
import 'package:retailerp/POSUIONE/pos_billing.dart';
import 'package:retailerp/POSUIONE/pos_billing_list.dart';
import 'package:retailerp/POSUITwo/PayButton_two.dart';
import 'package:retailerp/POSUITwo/billing_productdata_trial_two.dart';
import 'package:retailerp/POSUITwo/pos_billing_list_two.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/utils/POSProviders/billing_productdata.dart';
import 'package:retailerp/utils/const.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:sqflite/sqflite.dart';
import '../POSUIONE/PayButton.dart';



class POSBillingViewTwo extends StatefulWidget {

  @override
  _POSBillingViewTwoState createState() => _POSBillingViewTwoState();
}

class _POSBillingViewTwoState extends State<POSBillingViewTwo> {

  String dropdownValue = "Name";
  String _mTypeValue = 'Select Type';
  String _mCategoryValue = 'Category Type';
  DateTime now = new DateTime.now();
  DateTime date;
  String CustomerName;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Product> productList;
  List<Product> tempproductList;
  List<CustomerModel> localcustomerList;
  int customercount;
//  Future<List<Product>> future;
  int count;
//  ProductDataTrialTwo
  @override
  void initState() {
    date = new DateTime(now.year, now.month, now.day);
    // updateCustomerListView();
  }

  String _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Text("Billing Items",  style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,color: PrimaryColor)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<ProductDataTrialTwo>(context, listen: false)
                          .ClearTask();
                    },
                    child: Text("Clear All",  style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,color: Colors.blue)),
                  ),
                ],
              ),
            ),
            Divider(
              height: 5,
              thickness: 3.0,
              color: PrimaryColor,
            ),
            ProductbillinglistTwo(),
            Divider(
              height: 1,
              thickness: 3.0,
              color: PrimaryColor,
            ),
            // POSBill(),
            SizedBox(
              height: 32.0,
            ),
            PayButtonTwo(CustomerName,_selectdate.toString()),
          ],
        ),
      ),
    );
  }

}

////ListTile(
////leading: Image.asset(product[0]['product'][index]['imgpath']),
////title: Text(product[0]['product'][index]['productname']),
////subtitle: Text(product[0]['product'][index]['price']),
////trailing: Container(
////child: Row(
////children: [
////Icon(
////Icons.delete
////)
////],
////),
////)
////);
//
////Column(
////children: [
////Padding(
////padding: EdgeInsets.all(8),
////child: Text(product[0]['product'][index]['productname'])
////),
////Padding(
////padding: EdgeInsets.all(8),
////child: Text(product[0]['product'][index]['price']),
////)
////],
////),
//
////count == 0 ? Center(
////child: Text("No Products"),
////) :



///TextFeilds for customer-----------------------