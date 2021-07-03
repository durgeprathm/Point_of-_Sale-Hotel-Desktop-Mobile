import 'package:flutter/material.dart';
const POSBG = Color(0xffE57373);
const SALESBG =  Color(0xffF06292);
const PURCHASEBG = Color(0xffBA68C8);
const PRODUCTCATBG = Color(0xff9575CD);
const PRODUCTBG = Color(0xff7986CB);
const PRODUCTRATEBG = Color(0xff4FC3F7);
const MAGICOLOR = Color(0xff6200EE);
const CUSTOMERBG = Color(0xff4DD0E1);
const EMPBG = Color(0xff4DB6AC);
const REPROTGENBG = Color(0xff81C784);
const MENUBG = Color(0xffFF8A65);
const MENUCATBG = Color(0xff455A64);
const SETTINGSBG = Color(0xffFFB74D);
const dashtextcolor = Colors.white;
const ProductbtnColor = Color(0xff4FC3F7);
const SELECTbtnColor = Colors.white;
const ProducttextColor = Colors.white;
const SELECTtextColor = Color(0xff455A64);

TextStyle tableItemColmTextStyle = TextStyle(
  // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 14.0,
    color: Colors.black87,
    fontFamily: "Poppins-Medium",
    letterSpacing: .1);

TextStyle labelCloseTextStyle = TextStyle(
  // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 16.0,
    color: Colors.red,
    fontFamily: "Poppins-Medium",
    letterSpacing: .6);

String TempOrderID,TempOrderIDTwo,TempOrderIDThree,TempOrderFour,TempOrderFive,TempOrderSix,TempOrderSeven,TempOrderEight,TempOrderNine,TempOrderTen,
    TempOrderEleven,TempOrderTwevel,TempOrderThriteen,TempOrderFourteen,TempOrderFitten;

String editDate;
int editSalesID;

String Rupees = "₹";

final product1 = const [
  {
    'product' : [
      {'pid': '01','productname': 'Choclate', 'price': '250₹','imgpath': 'Images/chocolate.png'},
      {'pid': '02','productname': 'Apple', 'price': '250₹','imgpath': 'Images/apple.png'},
      {'pid': '03','productname': 'Orange', 'price': '350₹','imgpath':'Images/orange.png'},
      {'pid': '04','productname': 'Frooti', 'price': '150₹','imgpath':'Images/soft-drink.png'},
      {'pid': '05','productname': 'Burger', 'price': '85₹','imgpath':'Images/burger.png'},
      {'pid': '06','productname': 'Butter Chicken', 'price': '550₹','imgpath':'Images/chicken.jpg'},
    ]
  }
];

const TextStyle headsubTextStyle = TextStyle(color: Colors.black, fontSize: 18.0);

final category = const [
  {
    'category' : [
      {'cid': '01','catname': 'All', 'value': 'false'},
      {'cid': '02','catname': 'Veg', 'value': 'true'},
      {'pid': '03','catname': 'Non Veg', 'value':'false'},
    ]
  }
];

List Billingproduct =  [
  {
    'billproduct' : [
      {'pid': '01','productname': 'Choclate', 'price': '250₹','imgpath': 'Images/chocolate.png'},
      {'pid': '02','productname': 'Apple', 'price': '250₹','imgpath': 'Images/apple.png'},
    ]
  }
];

List<String> tablename = ["Table 1","Table 2","Table 3","Table 4","Table 5","Table 6","Table 7","Table 8","Table 9","Table 10","Table 11","Table 12","Table 13","Table 14","Table 15"];
List<String> tablename2 = ["Table Dashboard","Table 1","Table 2","Table 3","Table 4","Table 5","Table 6","Table 7","Table 8","Table 9","Table 10","Table 11","Table 12","Table 13","Table 14","Table 15"];

TextStyle tablecolumname =TextStyle(fontWeight: FontWeight.bold,fontSize: 15);