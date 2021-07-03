import 'package:flutter/material.dart';
import 'package:retailerp/LocalDbModels/product_category.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/const.dart';

class ProDropDownStringWidget1 extends StatefulWidget {
  final List<ProductModel> _productList;
  Function getDropDownValue;
  final int id;
  final double fieldSize;
  var _productCategory;
  var cType;

  ProDropDownStringWidget1(this._productList, this._productCategory,
      this.getDropDownValue, this.id, this.fieldSize);

  ProDropDownStringWidget1.withValue(
      this._productList,
      this._productCategory,
      this.getDropDownValue,
      this.id,
      this.fieldSize,
      this.cType);

  @override
  _ProDropDownStringWidget1State createState() =>
      _ProDropDownStringWidget1State();
}

class _ProDropDownStringWidget1State
    extends State<ProDropDownStringWidget1> {
  // int dropdownValue;
  // List<ProductCategory> _productList;
  // ProductCategory _productCategory;
  int count = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double tabletwidth = MediaQuery.of(context).size.width * (widget.fieldSize);
    var screenOrien = MediaQuery.of(context).orientation;
    double mobwidth = MediaQuery.of(context).size.width;
    var _current;
    if (widget.cType != null) {
      _current = widget.cType;
    } else {
      _current = widget._productCategory;
    }

    return widget._productList == null
        ? Text('')
        : Container(
      width: screenOrien == Orientation.portrait ? mobwidth : tabletwidth,
      child: widget.cType == null
          ? DropdownButtonFormField<ProductModel>(
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0))),
        hint: Text('Select Category *'),
        value: _current,
        onChanged: (ProductModel value) {
          setState(() {
            _current = value;
        //    getSendText(value.proId, _current, null);
            // widget.getDropDownValue(value.catid,value.pParentCategoryName, widget.id, _current);
          });
        },
        items: widget._productList
            .map((user) => DropdownMenuItem<ProductModel>(
          child: Text(user.proName),
          value: user,
        ))
            .toList(),
      )
          : DropdownButtonFormField<String>(
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0))),
        hint: Text('Select Category'),
        value: _current,
        onChanged: (String value) {
          setState(() {
            _current = value;
            // getSendText(value);
            // widget.getDropDownValue(value.catid,value.pParentCategoryName, widget.id, _current);
          });
        },
        items: widget._productList
            .map((user) => DropdownMenuItem<String>(
          child: Text(user.proName),
          value: user.proName,
        ))
            .toList(),
      ),
    );
  }
  void getSendText(
      int catid, String sName, _current, String proPrice, int proCatId) async {
    var pCategoryName = await databaseHelper.getProCatName(catid);
    widget.getDropDownValue(
        catid, sName, pCategoryName, widget.id, _current, proPrice, proCatId);
    print('pCategoryName: $pCategoryName');
  }
}
