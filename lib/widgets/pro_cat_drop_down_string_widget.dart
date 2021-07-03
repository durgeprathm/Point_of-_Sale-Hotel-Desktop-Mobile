import 'package:flutter/material.dart';
import 'package:retailerp/LocalDbModels/product_category.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/const.dart';

class ProCatDropDownStringWidget extends StatefulWidget {
  final List<ProductCategory> productCatList;
  Function getDropDownValue;
  final int id;
  final double fieldSize;
  var _productCategory;
  var cType;

  ProCatDropDownStringWidget(this.productCatList, this._productCategory,
      this.getDropDownValue, this.id, this.fieldSize);

  ProCatDropDownStringWidget.withValue(
      this.productCatList,
      this._productCategory,
      this.getDropDownValue,
      this.id,
      this.fieldSize,
      this.cType);

  @override
  _ProCatDropDownStringWidgetState createState() =>
      _ProCatDropDownStringWidgetState();
}

class _ProCatDropDownStringWidgetState
    extends State<ProCatDropDownStringWidget> {
  // int dropdownValue;
  // List<ProductCategory> productCatList;
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

    return widget.productCatList == null
        ? Text('')
        : Container(
            width: screenOrien == Orientation.portrait ? mobwidth : tabletwidth,
            child: widget.cType == null
                ? DropdownButtonFormField<ProductCategory>(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    hint: Text('Select Category *'),
                    value: _current,
                    onChanged: (ProductCategory value) {
                      setState(() {
                        _current = value;
                        getSendText(value.catid, _current, null);
                        // widget.getDropDownValue(value.catid,value.pParentCategoryName, widget.id, _current);
                      });
                    },
                    items: widget.productCatList
                        .map((user) => DropdownMenuItem<ProductCategory>(
                              child: Text(user.pCategoryname),
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
                        getSendText(null, null, _current);
                        // widget.getDropDownValue(value.catid,value.pParentCategoryName, widget.id, _current);
                      });
                    },
                    items: widget.productCatList
                        .map((user) => DropdownMenuItem<String>(
                              child: Text(user.pCategoryname),
                              value: user.pCategoryname,
                            ))
                        .toList(),
                  ),
          );
  }

  void getSendText(int catid, _current, String selectedValueName) async {
    if (_current != null) {
      var pParentCategoryName =
          await databaseHelper.getParentProductName(catid);
      widget.getDropDownValue(catid, pParentCategoryName, widget.id, _current);
      print('Parent name Values: $pParentCategoryName');
    } else {
      var cid = await databaseHelper.getProdId(selectedValueName);
      widget.getDropDownValue(
          cid, selectedValueName, widget.id, widget._productCategory);
      print('current Name Values: $cid');
    }
  }
}
