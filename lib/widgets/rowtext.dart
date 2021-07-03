import 'package:flutter/material.dart';
import '../utils/const.dart';

class RowText extends StatefulWidget {
  final String label;
  final String value;

  RowText(this.label, this.value);

  @override
  _RowTextState createState() => _RowTextState();
}

class _RowTextState extends State<RowText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: labelTextStyle,
        ),
        Text(
          widget.value,
          style: TextStyle(
              fontFamily: 'Montserrat', color: Colors.black, fontSize: 14.0),
        )
      ],
    );
  }
}
