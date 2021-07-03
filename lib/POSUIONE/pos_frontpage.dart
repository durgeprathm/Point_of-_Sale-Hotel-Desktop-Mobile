import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/EhotelAdapter/fetch_dailycalculation.dart';
import 'package:retailerp/Adpater/fetch_POSbillList.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/POSUIONE/alert_selles_summary.dart';
import 'package:retailerp/POSUIONE/pos_billing_view.dart';
import 'package:retailerp/POSUIONE/pos_product_view.dart';
import 'package:retailerp/POSUITwo/pos_frontpage_two.dart';
import 'package:retailerp/pages/dashboard.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/POSUIThree/pos_frontpage_three.dart';
import 'package:retailerp/POSUIFour/pos_frontpage_four.dart';
import 'package:retailerp/POSUIFive/pos_frontpage_five.dart';

class POSFrontPage extends StatefulWidget {
  @override
  _POSFrontPageState createState() => _POSFrontPageState();
}

class _POSFrontPageState extends State<POSFrontPage> {

  POSBillList posBillList = new POSBillList();
  bool _checkBoxval = false;
  bool isSwitched = false;
  List<ServerBillList> salesbillingList = [];
  int TotalSales;
  String _selectdate = DateFormat('dd/MM/yyyy').format(new DateTime.now());
  FetchDailyCalculation fetchDailyCalculation = new FetchDailyCalculation();
  String totalCashSum,totalCardSum,totalUPISum;
  String todayscashbill,todayscardbill,todaysUPIbill;


  List <bool> catgeorySelction = [
    false,
    false,
    false
  ];

  List <bool> subCatSelction = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  Future<bool> _onBackPressed() async {
    // Your back press code here...
    Navigator.of(context).pop();
  }



  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }
  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss  EEE d MMM').format(now);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.wifi,
                  color: Colors.white,
                ),
                onPressed: () {
                  widePopUpCustom();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(" | ",style: appBarTitleTextStyle,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text("${formattedDate.toString()}",style: appBarTitleTextStyle,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(" | ",style: appBarTitleTextStyle,),
              ),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.exchangeAlt,
                  color: Colors.white,
                ),
                onPressed: () {
                  _openEndDrawer();
                },
              )
            ],
            title: Text("POS 1"),
        ),
         endDrawer:  Drawer(
           child: ListView(
             // Important: Remove any padding from the ListView.
             padding: EdgeInsets.zero,
             children: <Widget>[
               DrawerHeader(
                 decoration: BoxDecoration(
                   color: Colors.white,
                 ),
                 child: CircleAvatar(
                   radius: 55,
                   foregroundImage: AssetImage("Images/aruntelgirni.jpg"),
                 ),
               ),
               ListTile(
                 leading:   FaIcon(FontAwesomeIcons.calculator,
                     size: 35.0, color: primary),
                 title: Text('POS 1'),
                 onTap: () {
                   Navigator.pop(context);
                 }
               ),
               ListTile(
                 leading:   FaIcon(FontAwesomeIcons.calculator,
                     size: 35.0, color: primary),
                 title: Text('POS 2'),
                 onTap: () {
                   Navigator.pop(context);
                   Navigator.of(context)
                       .push(MaterialPageRoute(builder: (_) {
                     return POSFrontPageTwo();
                   }));

                 },
               ),
               ListTile(
                 leading:   FaIcon(FontAwesomeIcons.calculator,
                     size: 35.0, color: primary),
                 title: Text('POS 3'),
                 onTap: () {

                   Navigator.pop(context);
                   Navigator.of(context)
                       .push(MaterialPageRoute(builder: (_) {
                     return POSFrontPageThree();
                   }));
                 },
               ),
               ListTile(
                 leading:   FaIcon(FontAwesomeIcons.calculator,
                     size: 35.0, color: primary),
                 title: Text('POS 4'),
                 onTap: () {
                   Navigator.pop(context);
                   Navigator.of(context)
                       .push(MaterialPageRoute(builder: (_) {
                     return POSFrontPageFour();
                   }));
                 },
               ),
               ListTile(
                 leading:   FaIcon(FontAwesomeIcons.calculator,
                     size: 35.0, color: primary),
                 title: Text('POS 5'),
                 onTap: () {
                   Navigator.pop(context);
                   Navigator.of(context)
                       .push(MaterialPageRoute(builder: (_) {
                     return POSFrontPageFive();
                   }));
                 },
               ),
               ListTile(
                 leading:   FaIcon(FontAwesomeIcons.moneyBillWave,
                     size: 35.0, color: primary),
                 title: Text('Billing'),
                 onTap: () {
                   Navigator.pop(context);
                   widePopUpCustom();
                 },
               ),
             ],
           ),
         ),
        body:  new SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  POSProductViewer(),
                  POSBillingView()
                ],
              )
          ),
        ),
//         TabBarView(
//           children: [
//             new SafeArea(
//               child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Row(
//                     children: [
//                       POSProductViewerTwo(),
//                       POSBillingTwoView()
//                     ],
//                   )
//               ),
//             ),
// //            SafeArea(
// //              child: Padding(
// //                  padding: EdgeInsets.symmetric(horizontal: 10.0),
// //                  child: Row(
// //                    children: [
// //                       POSProductViewer(),
// //                       POSBillingView()
// //                    ],
// //                  )
// //              ),
// //            ),
// //            SafeArea(
// //              child: Padding(
// //                  padding: EdgeInsets.symmetric(horizontal: 10.0),
// //                  child: Row(
// //                    children: [
// //                      POSProductViewer(),
// //                      POSBillingView()
// //                    ],
// //                  )
// //              ),
// //            ),
// //            SafeArea(
// //              child: Padding(
// //                  padding: EdgeInsets.symmetric(horizontal: 10.0),
// //                  child: Row(
// //                    children: [
// //                      POSProductViewer(),
// //                      POSBillingView()
// //                    ],
// //                  )
// //              ),
// //            ),
// //            SafeArea(
// //              child: Padding(
// //                  padding: EdgeInsets.symmetric(horizontal: 10.0),
// //                  child: Row(
// //                    children: [
// //                      POSProductViewer(),
// //                      POSBillingView()
// //                    ],
// //                  )
// //              ),
// //            ),
// //            SafeArea(
// //              child: Padding(
// //                  padding: EdgeInsets.symmetric(horizontal: 10.0),
// //                  child: Row(
// //                    children: [
// //                      POSProductViewer(),
// //                      POSBillingView()
// //                    ],
// //                  )
// //              ),
// //            ),
// //            SafeArea(
// //              child: Padding(
// //                  padding: EdgeInsets.symmetric(horizontal: 10.0),
// //                  child: Row(
// //                    children: [
// //                      POSProductViewer(),
// //                      POSBillingView()
// //                    ],
// //                  )
// //              ),
// //            ),
//           ],
//         ),
      ),
    );
  }


  Future<void> widePopUpCustom() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertSellsSummary();
      },
    );
  }

}

class ServerBillList{

  String CustomerName;
  String BillAmount;

  ServerBillList(this.CustomerName,this.BillAmount);
}