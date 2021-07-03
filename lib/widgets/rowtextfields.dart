import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/const.dart';

class RowTextFields extends StatefulWidget {
  final String label;
  final int id;
  final _fromController;
  Function getInputText;
  final bool validate;
  final String inType;
  final String hintText;
  final double fieldSize;

  RowTextFields(this.label, this._fromController, this.getInputText, this.id,
      this.validate, this.inType, this.hintText, this.fieldSize);

  @override
  _RowTextFieldsState createState() => _RowTextFieldsState();
}

class _RowTextFieldsState extends State<RowTextFields> {
  @override
  void initState() {
    super.initState();
    widget._fromController.addListener(_printLatestValue);
  }

  @override
  Widget build(BuildContext context) {
    var screenOrien = MediaQuery.of(context).orientation;
    double tabletwidth = MediaQuery.of(context).size.width * (widget.fieldSize);
    double mobwidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: screenOrien == Orientation.portrait ? mobwidth : tabletwidth,
        child: TextField(
          controller: widget._fromController,
          keyboardType: widget.inType == 'text'
              ? TextInputType.text
              : TextInputType.number,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: widget.label,
              labelStyle: labelTextStyle,
              hintText: widget.hintText,
              errorText: widget.validate ? 'Field Can\'t Be Empty' : null),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   widget._fromController.dispose();
  //   super.dispose();
  // }

  _printLatestValue() {
    print("Second text field: ${widget._fromController.text}");
    widget.getInputText(widget._fromController.text, widget.id);
  }
}
