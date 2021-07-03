import 'package:flutter/material.dart';
import 'package:retailerp/LocalDbModels/product_category.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/const.dart';

class ProCatDropDownWidget extends StatefulWidget {
  final List<ProductCategory> productCatList;
  Function getDropDownValue;
  final int id;
  final double fieldSize;
  var _productCategory;
  var cType;

  ProCatDropDownWidget(this.productCatList, this._productCategory,
      this.getDropDownValue, this.id, this.fieldSize);

  ProCatDropDownWidget.withValue(this.productCatList, this._productCategory,
      this.getDropDownValue, this.id, this.fieldSize, this.cType);

  @override
  _ProCatDropDownWidgetState createState() => _ProCatDropDownWidgetState();
}

class _ProCatDropDownWidgetState extends State<ProCatDropDownWidget> {
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
    var screenOrien = MediaQuery.of(context).orientation;
    double tabletwidth = MediaQuery.of(context).size.width * (widget.fieldSize);
    double mobwidth = MediaQuery.of(context).size.width;

    var _current;
    if (widget.cType != null || widget.cType != 0) {
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
                        getSendText(value.catid, _current);
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
                : DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    hint: Text('Select Category'),
                    value: _current,
                    onChanged: (int value) {
                      setState(() {
                        _current = value;
                        getSendText(_current, null);
                        // widget.getDropDownValue(value.catid,value.pParentCategoryName, widget.id, _current);
                      });
                    },
                    items: widget.productCatList
                        .map((user) => DropdownMenuItem<int>(
                              child: Text(user.pCategoryname),
                              value: user.catid,
                            ))
                        .toList(),
                  ),
          );

    // return Container(
    //   width: tabletwidth,
    //   child: FormField<ProductCategory>(
    //     builder: (FormFieldState<ProductCategory> state) {
    //       return InputDecorator(
    //         decoration: InputDecoration(
    //             border: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(5.0))),
    //         child: DropdownButtonHideUnderline(
    //           child: DropdownButton<ProductCategory>(
    //             hint: Text("Select Category"),
    //             value: _productCategory,
    //             onChanged: (ProductCategory newValue) {
    //               setState(() {
    //                 dropdownValue = newValue.catid;
    //                 widget.getDropDownValue(newValue.catid, widget.id);
    //               });
    //             },
    //             items: productCatList
    //                 .map((proCat) => DropdownMenuItem<ProductCategory>(
    //                       child: Text(proCat.pCategoryname),
    //                       value: proCat,
    //                     ))
    //                 .toList(),
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );

    // return Container(
    //   width: tabletwidth,
    //   child: DropdownButtonFormField(
    //       items: widget.itemList.map<DropdownMenuItem<String>>((String value) {
    //         return DropdownMenuItem<String>(
    //           value: value,
    //           child: Text(value),
    //         );
    //       }).toList(),
    //       onChanged: (String newValue) {
    //         setState(() {
    //           dropdownValue = newValue;
    //           widget.getDropDownValue(newValue, widget.id);
    //         });
    //       },
    //       value: dropdownValue,
    //       decoration: InputDecoration(
    //         contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
    //         filled: true,
    //         fillColor: Colors.grey[100],
    //         // hintText: Localization.of(context).category,
    //         // errorText: errorSnapshot.data == 0 ? Localization.of(context).categoryEmpty : null),
    //       )),
    // );

    // return Container(
    //   width: 300.0,
    //   child: DropdownButtonHideUnderline(
    //     child: ButtonTheme(
    //       alignedDropdown: true,
    //       child: DropdownButton(
    //         value: dropdownValue,
    //         items:
    //             widget.itemList.map<DropdownMenuItem<String>>((String value) {
    //           return DropdownMenuItem<String>(
    //             value: value,
    //             child: Text(value),
    //           );
    //         }).toList(),
    //         onChanged: (String newValue) {
    //           setState(() {
    //             dropdownValue = newValue;
    //             widget.getDropDownValue(newValue, widget.id);
    //           });
    //         },
    //
    //         // style: Theme.of(context).textTheme.title,
    //       ),
    //     ),
    //   ),
    // );

    //   return Row(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //     DropdownButton<String>(
    //       value: dropdownValue,
    //       icon: Container(
    //           margin: EdgeInsets.only(top: 3),
    //           child: Icon(
    //             Icons.arrow_downward,
    //             color: PrimaryColor,
    //           )),
    //       iconSize: 24,
    //       elevation: 16,
    //       style: dropDownTextStyle,
    //       underline: Container(
    //         height: 2,
    //         color: Colors.transparent,
    //       ),
    //       onChanged: (String newValue) {
    //         setState(() {
    //           dropdownValue = newValue;
    //           widget.getDropDownValue(newValue, widget.id);
    //         });
    //       },
    //       items: widget.itemList.map<DropdownMenuItem<String>>((String value) {
    //         return DropdownMenuItem<String>(
    //           value: value,
    //           child: Text(value),
    //         );
    //       }).toList(),
    //     ),
    //   ],
    // );
  }

  void getSendText(int catid, _current) async {
    if (_current != null) {
      var pParentCategoryName =
          await databaseHelper.getParentProductName(catid);
      widget.getDropDownValue(catid, pParentCategoryName, widget.id, _current);
      print('Parent name Values: $pParentCategoryName');
    } else {
      // var pCurrentSelId = await databaseHelper.getParentProductID(_current);
      var pCurrentSelName = await databaseHelper.getParentProductName(catid);
      widget.getDropDownValue(
          catid, pCurrentSelName, widget.id, widget._productCategory);
      print('current catid Values: $catid');
    }
  }
}
