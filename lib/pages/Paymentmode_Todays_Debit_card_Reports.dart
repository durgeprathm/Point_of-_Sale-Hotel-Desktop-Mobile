import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_sales_fetch.dart';
import 'package:retailerp/Adpater/pos_Paymentmode_All_debitCardType_fetch.dart';
import 'package:retailerp/Adpater/pos_Paymentmode_Today_debitCardType_fetch.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';

class PaymentModeTodayDebitCardsReports extends StatefulWidget {
  @override
  _PaymentModeTodayDebitCardsReportsState createState() =>
      _PaymentModeTodayDebitCardsReportsState();
}

class _PaymentModeTodayDebitCardsReportsState
    extends State<PaymentModeTodayDebitCardsReports> {
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
      content = _buildMobilePaymentModeTodayDebitCardsReports();
    } else {
      content = _buildTabletPaymentModeTodayDebitCardsReports();
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

  List<Sales> SalesList = new List();
  List<Sales> DebitCardsCount = new List();

  List<int> printList = [];

  int count;
  String _selectdate;

  @override
  void initState() {
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    _getSales();
    _getTodayDebitCardList(_selectdate);
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletPaymentModeTodayDebitCardsReports() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.moneyBill),
            SizedBox(
              width: 20.0,
            ),
            Text('Todays Debit Cards Reports'),
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
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobilePaymentModeTodayDebitCardsReports() {
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
            child: Column(children: [
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
            ]),
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

  Future<void> _getTodayDebitCardList(String date) async {
    TodayDebitCreditCardTypeFetch todaydebitcardtypefetch =
        new TodayDebitCreditCardTypeFetch();
    var response = await todaydebitcardtypefetch
        .getTodayDebitCreditCardTypeFetch("0", date);
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
