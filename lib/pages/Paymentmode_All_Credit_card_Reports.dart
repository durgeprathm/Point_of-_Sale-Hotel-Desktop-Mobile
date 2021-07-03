import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_sales_fetch.dart';
import 'package:retailerp/Adpater/pos_Paymentmode_All_debitCardType_fetch.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';

class PaymentModeAllCreditCardsReports extends StatefulWidget {
  @override
  _PaymentModeAllCreditCardsReportsState createState() =>
      _PaymentModeAllCreditCardsReportsState();
}

class _PaymentModeAllCreditCardsReportsState
    extends State<PaymentModeAllCreditCardsReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;
  List<CreditTypeDetails> CreditCountList = [];

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobilePaymentModeAllCreditCardsReports();
    } else {
      content = _buildTabletPaymentModeAllCreditCardsReports();
    }

    return content;
  }

  //=--------mobile--------------
  bool _showCircle = false;
  DateTime fromValue = DateTime.now();
  DateTime toValue = DateTime.now();
  final dateFormat = DateFormat("yyyy-MM-dd");
  Widget appBarTitle = Text("Credit Cards Reports");
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
//-------------------------------------------

//-------------------------------------------
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;
  final initialValue = DateTime.now();

  //DatabaseHelper databaseHelper = DatabaseHelper();

  List<Sales> SalesList = new List();
  List<Sales> DebitCardsCount = new List();

  List<int> printList = [];

  int count;

  @override
  void initState() {
    _getSales();
    _getCreditCardList();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletPaymentModeAllCreditCardsReports() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.moneyBill),
            SizedBox(
              width: 20.0,
            ),
            Text('Credit Cards Reports'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SalesList.length == 0
                ? Center(child: CircularProgressIndicator())
                : Column(children: [
                    Material(
                      elevation: 5.0,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.blueGrey,
                          child: Text(
                            "${CreditCountList[0].StudentCreditcards}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          "Student Credit cards",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Material(
                      elevation: 5.0,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.blueGrey,
                          child: Text(
                            "${CreditCountList[0].SubprimeCreditcards}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          "Subprime Credit cards",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Material(
                      elevation: 5.0,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.blueGrey,
                          child: Text(
                            "${CreditCountList[0].SecuredCreditcards}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          "Secured Credit cards",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Material(
                      elevation: 5.0,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.blueGrey,
                          child: Text(
                            "${CreditCountList[0].BalancetransferCreditcards}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          "Balance transfer Credit cards",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Material(
                      elevation: 5.0,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.blueGrey,
                          child: Text(
                            "${CreditCountList[0].TravelCreditcards}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          "Travel Credit cards",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Material(
                      elevation: 5.0,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.blueGrey,
                          child: Text(
                            "${CreditCountList[0].TitaniumCreditcards}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          "Titanium Credit cards",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                  ]),
          ),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobilePaymentModeAllCreditCardsReports() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: appBarTitle,
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(Navigator.defaultRouteName));
                },
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _showCircle,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Material(
                            elevation: 5.0,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.blueGrey,
                                child: Text(
                                  "${CreditCountList[0].StudentCreditcards}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                "Student Credit cards",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Material(
                            elevation: 5.0,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.blueGrey,
                                child: Text(
                                  "${CreditCountList[0].SubprimeCreditcards}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                "Subprime Credit cards",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Material(
                            elevation: 5.0,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.blueGrey,
                                child: Text(
                                  "${CreditCountList[0].SecuredCreditcards}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                "Secured Credit cards",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Material(
                            elevation: 5.0,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.blueGrey,
                                child: Text(
                                  "${CreditCountList[0].BalancetransferCreditcards}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                "Balance transfer Credit cards",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Material(
                            elevation: 5.0,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.blueGrey,
                                child: Text(
                                  "${CreditCountList[0].TravelCreditcards}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                "Travel Credit cards",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Material(
                            elevation: 5.0,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.blueGrey,
                                child: Text(
                                  "${CreditCountList[0].TitaniumCreditcards}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                "Titanium Credit cards",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//---------------Mobile Mode End-------------//

//-------------------------------------
//from server
  void _getSales() async {
    SalesFetch salesfetch = new SalesFetch();
    var salesData = await salesfetch.getSalesFetch("1");
    var resid = salesData["resid"];

    if (resid == 200) {
      var salessd = salesData["sales"];
      print(salessd.length);
      List<Sales> tempSales = [];
      for (var n in salessd) {
        Sales pro = Sales.ManageList(
            int.parse(n["SalesId"]),
            n["SalesCustomername"],
            n["SalesDate"],
            n["SalesProductName"],
            n["SalesProductRate"],
            n["SalesProductQty"],
            n["SalesProductSubTotal"],
            n["SalesSubTotal"],
            n["SalesDiscount"],
            n["SalesGST"],
            n["SalesTotalAmount"],
            n["SalesNarration"],
            n["SalesPaymentMode"],
            n["SalesProductIDs"],
            n["SalesPaymentCardType"],
            n["SalesCardType"],
            n["SalesNameonCard"],
            n["SalesCardNumber"],
            n["SalesBankName"],
            n["SalesUPITransationNumber"]);
        tempSales.add(pro);
      }
      setState(() {
        this.SalesList = tempSales;
      });
      print("//////SalesList/////////$SalesList.length");
    } else {
      String message = salesData["message"];
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Future<void> _getCreditCardList() async {
    AllDebitCardTypeFetch alldebitcardtypefetch = new AllDebitCardTypeFetch();
    var response = await alldebitcardtypefetch.getAllDebitCardTypeFetch("1");
    var debitsd = response["sales"];
    List<CreditTypeDetails> tempCountList = [];

    for (var n in debitsd) {
      CreditTypeDetails creditTypeDetails = CreditTypeDetails(
          n["StudentCredit"],
          n["SubprimeCredit"],
          n["SecuredCredit"],
          n["BalancetransferCredit"],
          n["TravelCredit"],
          n["TitaniumCredit"]);
      tempCountList.add(creditTypeDetails);
    }

    setState(() {
      CreditCountList = tempCountList;
    });
  }
}

class CreditTypeDetails {
  final int StudentCreditcards;
  final int SubprimeCreditcards;
  final int SecuredCreditcards;
  final int BalancetransferCreditcards;
  final int TravelCreditcards;
  final int TitaniumCreditcards;

  CreditTypeDetails(
      this.StudentCreditcards,
      this.SubprimeCreditcards,
      this.SecuredCreditcards,
      this.BalancetransferCreditcards,
      this.TravelCreditcards,
      this.TitaniumCreditcards);
}
