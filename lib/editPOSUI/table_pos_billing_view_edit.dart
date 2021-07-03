import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/LocalDbModels/POSModels/product.dart';
import 'package:retailerp/LocalDbModels/customer_model.dart';
import 'package:retailerp/editPOSUI/table_PayButton_edit.dart';
import 'package:retailerp/editPOSUI/table_pos_billing_edit.dart';
import 'package:retailerp/editPOSUI/table_pos_billing_list_edit.dart';
import 'package:retailerp/utils/const.dart';



class TablePOSBillingViewEdit extends StatefulWidget {

  @override
  _TablePOSBillingViewEditState createState() => _TablePOSBillingViewEditState();
}

class _TablePOSBillingViewEditState extends State<TablePOSBillingViewEdit> {

  String dropdownValue = "Name";
  List<String> mCategory = [
    'Customer Name',
    'Moresh Sir',
    'Yogesh Sir',
    'Praful'
  ];

  String _mTypeValue = 'Select Type';
  String _mCategoryValue = 'Category Type';
  DateTime now = new DateTime.now();
  DateTime date;
  String CustomerName;
  // DatabaseHelper databaseHelper = DatabaseHelper();
  List<Product> productList;
  List<Product> tempproductList;
  List<CustomerModel> localcustomerList;
  int customercount;
//  Future<List<Product>> future;
  int count;

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
        width: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Billing Items",  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,color: PrimaryColor)),
                ],
              ),
            ),
            Divider(
              height: 5,
              thickness: 3.0,
              color: PrimaryColor,
            ),
            TableProductbillinglistEdit(),
            Divider(
              height: 5,
              thickness: 3.0,
              color: PrimaryColor,
            ),
            TablePOSBillEdit(),
            SizedBox(
              height: 35.0,
            ),
            TablePayButtonEdit(CustomerName,_selectdate.toString()),
          ],
        ),
      ),
    );
  }
}
