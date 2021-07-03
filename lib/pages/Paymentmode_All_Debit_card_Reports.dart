import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_sales_fetch.dart';
import 'package:retailerp/Adpater/pos_Paymentmode_All_debitCardType_fetch.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';

class PaymentModeAllDebitCardsReports extends StatefulWidget {
  @override
  _PaymentModeAllDebitCardsReportsState createState() =>
      _PaymentModeAllDebitCardsReportsState();
}

class _PaymentModeAllDebitCardsReportsState
    extends State<PaymentModeAllDebitCardsReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;
  List<DebitTypeDetails> debitCountList = [];

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobilePaymentModeAllDebitCardsReports();
    } else {
      content = _buildTabletPaymentModeAllDebitCardsReports();
    }

    return content;
  }

  //=--------mobile--------------
  bool _showCircle = false;
  DateTime fromValue = DateTime.now();
  DateTime toValue = DateTime.now();
  final dateFormat = DateFormat("yyyy-MM-dd");
  Widget appBarTitle = Text("Debit Cards Reports");
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
    _getDebitCardList();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletPaymentModeAllDebitCardsReports() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.moneyBill),
            SizedBox(
              width: 20.0,
            ),
            Text('Debit Cards Reports'),
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
        child: ModalProgressHUD(
          inAsyncCall: _showCircle,
          child: SingleChildScrollView(
            child: Center(
              child: Column(children: [
                Material(
                  elevation: 5.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.blueGrey,
                      child: Text(
                        "${debitCountList[0].MasterCard}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      "Mastercard Cards",
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
                        "${debitCountList[0].VisaCard}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      "Visa Cards",
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
                        "${debitCountList[0].RupayCard}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      "RuPay Cards",
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
                        "${debitCountList[0].MasteroCard}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      "Maestro Cards",
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
                        "${debitCountList[0].ClessCard}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      "Contactless Cards",
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
                        "${debitCountList[0].VElectoCard}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      "Visa Electron Cards",
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
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobilePaymentModeAllDebitCardsReports() {
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
                debitCountList != null
                    ? Expanded(
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
                                        "${debitCountList[0].MasterCard}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    title: Text(
                                      "Mastercard Cards",
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
                                        "${debitCountList[0].VisaCard}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    title: Text(
                                      "Visa Cards",
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
                                        "${debitCountList[0].RupayCard}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    title: Text(
                                      "RuPay Cards",
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
                                        "${debitCountList[0].MasteroCard}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    title: Text(
                                      "Maestro Cards",
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
                                        "${debitCountList[0].ClessCard}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    title: Text(
                                      "Contactless Cards",
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
                                        "${debitCountList[0].VElectoCard}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    title: Text(
                                      "Visa Electron Cards",
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
                      )
                    : Text(''),
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
    setState(() {
      _showCircle = true;
    });
    SalesFetch salesfetch = new SalesFetch();
    var salesData = await salesfetch.getSalesFetch("1");
    var resid = salesData["resid"];
    if (resid == 200) {
      var rowcount = salesData["rowcount"];

      if (rowcount > 0) {
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
          _showCircle = false;
        });
        print("//////SalesList/////////$SalesList.length");
      } else {
        setState(() {
          _showCircle = false;
        });
        String message = salesData["message"];
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: PrimaryColor,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      setState(() {
        _showCircle = false;
      });
      String message = salesData["message"];
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Future<void> _getDebitCardList() async {
    setState(() {
      _showCircle = true;
    });
    AllDebitCardTypeFetch alldebitcardtypefetch = new AllDebitCardTypeFetch();
    var response = await alldebitcardtypefetch.getAllDebitCardTypeFetch("0");
    var debitsd = response["sales"];
    List<DebitTypeDetails> tempCountList = [];

    for (var n in debitsd) {
      DebitTypeDetails debitTypeDetails = DebitTypeDetails(
          n["mastercard"],
          n["visacard"],
          n["rupaycards"],
          n["Maestrocard"],
          n["ContactlessCards"],
          n["VisaElectronCards"]);
      tempCountList.add(debitTypeDetails);
    }

    setState(() {
      debitCountList = tempCountList;
      _showCircle = false;
    });
  }
}

class DebitTypeDetails {
  final int MasterCard;
  final int VisaCard;
  final int RupayCard;
  final int MasteroCard;
  final int ClessCard;
  final int VElectoCard;

  DebitTypeDetails(this.MasterCard, this.VisaCard, this.RupayCard,
      this.MasteroCard, this.ClessCard, this.VElectoCard);
}
