import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kTextfeildDecoration = InputDecoration(
  hintText: "Enter Value",
  filled: true,
  fillColor: Color(0xffe6edf7),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff275E94), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff275E94), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);

const kFacultyAddNotesText = InputDecoration(
  hintText: "Enter Value",
  filled: true,
  fillColor: Colors.grey,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

const kdf = Color(0xff8C9EFF);
const PrimaryColor = Color(0xff275E94);
const SecondaryHeaderColor = Color(0xff275E94);
const AccentColor = Color(0xff275E94);
const desgcolor = Color(0xffe80c0c);
const Color primary = Color(0xFF2F4D7D);
const TextStyle listTextStyle = TextStyle(
    color: Colors.black, fontSize: 20.0, fontFamily: "Poppins-Medium");
const TextStyle inputTextStyle = TextStyle(
    color: Colors.black, fontSize: 20.0, fontFamily: "Poppins-Medium");
const TextStyle headsubTextStyle = TextStyle(
  color: Colors.black87,
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
);
const TextStyle headHintTextStyle = TextStyle(
    color: Colors.black54, fontSize: 14.0, fontFamily: "Poppins-Medium");
const TextStyle headsTextStyle = TextStyle(
    color: Colors.black87, fontSize: 16.0, fontFamily: "Poppins-Medium");

const TextStyle textHintTextStyle = TextStyle(
    color: Colors.black54, fontSize: 16.0, fontFamily: "Poppins-Medium");
const TextStyle textLabelTextStyle = TextStyle(
    color: Colors.black, fontSize: 16.0, fontFamily: "Poppins-Medium");

const TextStyle dropDownTextStyle = TextStyle(
    color: Colors.black, fontSize: 20.0, fontFamily: "Poppins-Medium");
const TextStyle hintTextStyle =
    TextStyle(color: Colors.grey, fontSize: 16.0, fontFamily: "Poppins-Medium");

const TextStyle hintListTextStyle = TextStyle(
    color: Colors.black54, fontSize: 16.0, fontFamily: "Poppins-Medium");
const TextStyle btnTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
    fontFamily: "Poppins-Medium",
    letterSpacing: 1.0);
const TextStyle btnHeadTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontFamily: "Poppins-Medium",
    letterSpacing: 1.0);
const TextStyle flatbtnTextStyle =
    TextStyle(color: Colors.black, fontSize: 16.0);
// const TextStyle labelTextStyle = TextStyle(
//   color: Colors.black,
//   fontSize: 16.0,
// );
const TextStyle labelGrayTextStyle = TextStyle(
  color: Colors.grey,
  fontSize: 16.0,
);

TextStyle dashboadrTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 25.0,
    color: Colors.white,
    fontFamily: "Poppins-Medium",
    letterSpacing: .6);

TextStyle dashboardMobTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 18.0,
    color: Colors.white,
    fontFamily: "Poppins-Medium",
    letterSpacing: .6);

TextStyle appBarTitleTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 20.0,
    color: Colors.white,
    fontFamily: "Poppins-Medium",
    letterSpacing: .6);

TextStyle dashboadrNavTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 12.0,
    color: Colors.black,
    fontFamily: "Poppins-Medium",
    letterSpacing: .6);

TextStyle subTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 16.0,
    color: Colors.black,
    fontFamily: "Poppins-Medium",
    letterSpacing: .6);

TextStyle tableColmTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 18.0,
    color: Colors.black,
    fontFamily: "Poppins-Medium",
    letterSpacing: .6);

TextStyle labelTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 16.0,
    color: Colors.black,
    fontFamily: "Poppins-Medium",
    letterSpacing: .6);

TextStyle labelPreviewTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 18.0,
    color: Colors.black,
    fontFamily: "Poppins-Medium",
    letterSpacing: .1);

TextStyle subHeadlabelPreviewTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 14.0,
    color: Colors.black87,
    fontFamily: "Poppins-Medium",
    letterSpacing: .1);

TextStyle datePreviewTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 14.0,
    color: Colors.black,
    fontFamily: "Poppins-Medium",
    letterSpacing: .1);

TextStyle subtotalLabelPreviewTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 16.0,
    color: Colors.black,
    fontFamily: "Poppins-Medium",
    letterSpacing: .1);

TextStyle discountLabelPreviewTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 16.0,
    color: Colors.black,
    fontFamily: "Poppins-Medium",
    letterSpacing: .1);

TextStyle miscLabelPreviewTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 16.0,
    color: Colors.black,
    fontFamily: "Poppins-Medium",
    letterSpacing: .1);
TextStyle totalAmountLabelPreviewTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 16.0,
    color: Colors.black,
    fontFamily: "Poppins-Medium",
    letterSpacing: .1);
TextStyle narrationLabelPreviewTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 12.0,
    color: Colors.black,
    fontFamily: "Poppins-Medium",
    letterSpacing: .1);

const String importProduct =
    'The first line in downloaded csv file should remain as it is. Please do not change the order of columns. The correct column order is (Product Code, Product Name) & you must follow this. If you are using any other language then English, please make sure the csv file is UTF-8 encoded and not saved with byte order mark (BOM)';
