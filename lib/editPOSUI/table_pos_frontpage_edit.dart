import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/editPOSUI/table_pos_billing_view_edit.dart';
import 'package:retailerp/editPOSUI/table_pos_product_view_edit.dart';


class TablePosEdit extends StatefulWidget {
  TablePosEdit(this.index,this.SalesListFetch);
  int index;
  List<EhotelSales> SalesListFetch = new List();

  @override
  _TablePosEditState createState() => _TablePosEditState();
}


class _TablePosEditState extends State<TablePosEdit> {

  bool _checkBoxval = false;
  bool isSwitched = false;
  List <bool> catgeorySelction = [
    false,
    false,
    false
  ];

  List <bool> subCatSelction = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: new AppBar(
            title: Text("POS"),
            ),
        body: new SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  TablePosEditProductView(widget.index,widget.SalesListFetch),
                  TablePOSBillingViewEdit()
                ],
              )
          ),
        ),
      ),
    );
  }
}