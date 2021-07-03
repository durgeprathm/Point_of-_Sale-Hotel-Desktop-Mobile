import 'package:flutter/material.dart';
import 'package:retailerp/models/radio_button_list.dart';
import 'package:retailerp/utils/const.dart';

class RadioGroup extends StatefulWidget {
  final String radioItem1;
  final String radioItem2;
  String radioItem3;
  int id;

  // final List<RadioButtonList> fList;
  Function getRadioSelected;
  final int rowId;

  RadioGroup.copywith2(this.radioItem1, this.radioItem2, this.id,
      this.getRadioSelected, this.rowId);

  RadioGroup.copywith3(this.radioItem1, this.radioItem2, this.radioItem3,
      this.id, this.getRadioSelected, this.rowId);

  @override
  _RadioGroupWidget createState() => _RadioGroupWidget();
}

class _RadioGroupWidget extends State<RadioGroup> {
  String radioValue = '';

  @override
  void initState() {
    super.initState();
    radioValue = widget.radioItem1;
  }

  @override
  Widget build(BuildContext context) {
    // return widget.radioItem3 == null
    //     ? getTwoRadioButton()
    //     : getThreeRadioButton();
    // return Column(
    //   children: <Widget>[
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: <Widget>[
    //         Radio(
    //           value: 1,
    //           groupValue: widget.id,
    //           onChanged: (val) {
    //             setState(() {
    //               // widget.radioItem1 = 'ONE';
    //               getRadioValue(widget.radioItem1, widget.rowId);
    //               widget.id = 1;
    //             });
    //           },
    //         ),
    //         Text(
    //           widget.radioItem1,
    //           style: labelTextStyle,
    //         ),
    //         Radio(
    //           value: 2,
    //           groupValue: widget.id,
    //           onChanged: (val) {
    //             setState(() {
    //               // widget.radioItem2 = 'TWO';
    //               getRadioValue(widget.radioItem2, widget.rowId);
    //               widget.id = 2;
    //             });
    //           },
    //         ),
    //         Text(
    //           widget.radioItem2,
    //           style: labelTextStyle,
    //         ),
    //         Radio(
    //           value: 3,
    //           groupValue: widget.id,
    //           onChanged: (val) {
    //             setState(() {
    //               getRadioValue(widget.radioItem3, widget.rowId);
    //               widget.id = 3;
    //             });
    //           },
    //         ),
    //         Text(
    //           widget.radioItem3,
    //           style: labelTextStyle,
    //         ),
    //       ],
    //     ),
    //   ],
    // );

    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(14.0),
            child: Text('Selected Radio Item = ' + '$radioValue}',
                style: TextStyle(fontSize: 21))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Radio(
              value: 1,
              groupValue: widget.id,
              onChanged: (val) {
                setState(() {
                  radioValue = widget.radioItem1;
                  widget.id = 1;
                  _getRadioValue(radioValue);
                });
              },
            ),
            Text(
              widget.radioItem1,
              style: new TextStyle(fontSize: 17.0),
            ),
            Radio(
              value: 2,
              groupValue: widget.id,
              onChanged: (val) {
                setState(() {
                  radioValue = widget.radioItem2;
                  widget.id = 2;
                  _getRadioValue(radioValue);
                });
              },
            ),
            Text(
              widget.radioItem2,
              style: new TextStyle(
                fontSize: 17.0,
              ),
            ),
            Radio(
              value: 3,
              groupValue: widget.id,
              onChanged: (val) {
                setState(() {
                  radioValue = widget.radioItem3;
                  widget.id = 3;
                  _getRadioValue(radioValue);
                });
              },
            ),
            Text(
              widget.radioItem3,
              style: new TextStyle(fontSize: 17.0),
            ),
          ],
        ),
      ],
    );

    // return Column(
    //   children: widget.fList
    //       .map((data) => RadioListTile(
    //             title: Text("${data.name}"),
    //             groupValue: widget.id,
    //             value: data.index,
    //             onChanged: (val) {
    //               setState(() {
    //                 widget.radioItem = data.name;
    //                 widget.getRadioSelected(
    //                     widget.radioItem, widget.rowId);
    //                 widget.id = data.index;
    //               });
    //             },
    //           ))
    //       .toList(),
    // );
  }

  _getRadioValue(String radioItem) {
    widget.getRadioSelected(radioItem, widget.rowId);
  }
}
