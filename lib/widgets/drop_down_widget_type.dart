import 'package:flutter/material.dart';
import '../utils/const.dart';

class DropDownWidgetType extends StatefulWidget {
  final List<String> itemList;
  Function getDropDownValue;
  final int id;
  final double fieldSize;
  String hintText;

  String rnType;

  DropDownWidgetType(this.hintText, this.itemList, this.getDropDownValue,
      this.id, this.fieldSize);

  DropDownWidgetType.withType(this.hintText, this.itemList,
      this.getDropDownValue, this.id, this.fieldSize, this.rnType);

  @override
  _DropDownWidgetTypeState createState() => _DropDownWidgetTypeState();
}

class _DropDownWidgetTypeState extends State<DropDownWidgetType> {
  @override
  void initState() {
    // dropdownValue = widget.itemList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenOrien = MediaQuery.of(context).orientation;
    double mobwidth = MediaQuery.of(context).size.width;
    String dropdownValue;
    double tabletwidth = MediaQuery.of(context).size.width * (widget.fieldSize);
    if (widget.rnType != null || widget.rnType.toString().isNotEmpty) {
      dropdownValue = widget.rnType;
    }

    return Container(
      width: screenOrien == Orientation.portrait ? mobwidth : tabletwidth,
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text('${widget.hintText}'),
                value: dropdownValue,
                isDense: true,
                items: widget.itemList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    widget.getDropDownValue(newValue, widget.id);
                  });
                },
              ),
            ),
          );
        },
      ),
    );

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
}
