import 'package:flutter/material.dart';
import 'package:retailerp/LocalDbModels/product_category.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/const.dart';

class ProDropDownStringWidget extends StatefulWidget {
  final List<ProductModel> _productList;
  Function getDropDownValue;
  final int id;
  final double fieldSize;
  var _product;

  // var cType;

  ProDropDownStringWidget(this._productList, this._product,
      this.getDropDownValue, this.id, this.fieldSize);

  // ProDropDownStringWidget.withValue(this._productList, this._product,
  //     this.getDropDownValue, this.id, this.fieldSize, this.cType);

  @override
  _ProDropDownStringWidgetState createState() =>
      _ProDropDownStringWidgetState();
}

class _ProDropDownStringWidgetState extends State<ProDropDownStringWidget> {
  // int dropdownValue;
  // List<ProductModel> _productList;
  // ProductModel _product;
  int count = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenOrien = MediaQuery.of(context).orientation;
    double mobwidth = MediaQuery.of(context).size.width;
    double tabletwidth = MediaQuery.of(context).size.width * (widget.fieldSize);
    var _current;
    // if (widget.cType != null) {
    //   _current = widget.cType;
    // } else {
    //   _current = widget._product;
    // }

    return widget._productList == null
        ? Text('')
        : Container(
            width: screenOrien == Orientation.portrait ? mobwidth : tabletwidth,
            child: DropdownButtonFormField<ProductModel>(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              hint: Text('Select Product*'),
              value: _current,
              onChanged: (ProductModel value) {
                setState(() {
                  _current = value;
                  getSendText(value.proId, value.proName, _current,
                      value.proSellingPrice.toString(), value.proCatId);
                  // widget.getDropDownValue(value.catid,value.pParentCategoryName, widget.id, _current);
                });
              },
              items: widget._productList
                  .map((user) => DropdownMenuItem<ProductModel>(
                        child: Text(user.proName),
                        value: user,
                      ))
                  .toList(),
            ));
  }

  void getSendText(
      int catid, String sName, _current, String proPrice, int proCatId) async {
    var pCategoryName = await databaseHelper.getProCatName(catid);
    widget.getDropDownValue(
        catid, sName, pCategoryName, widget.id, _current, proPrice, proCatId);
    print('pCategoryName: $pCategoryName');
  }
}
