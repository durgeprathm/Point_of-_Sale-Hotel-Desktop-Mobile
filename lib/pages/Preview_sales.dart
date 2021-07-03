import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_shop_fetch.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/models/Shop.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';

class PreviewSales extends StatefulWidget {
  PreviewSales(this.indexFetch, this.SalesListFetch);

  @override
  final int indexFetch;
  List<EhotelSales> SalesListFetch = new List();

  _PreviewSalesState createState() => _PreviewSalesState();
}

class _PreviewSalesState extends State<PreviewSales> {
  @override
  List<Shop> ShopDetails = [];
  int PreviewBillno;
  String CompanyName;
  String PreviewDate;
  String PreviewProductName;
  String PreviewProductRate;
  String PreviewProductQty;
  String PreviewProductSubTotal;
  String PreviewSubTotal;
  String PreviewDiscount;
  String PreviewProductGST;
  String PreviewModeOfPayment;
  String PreviewTotalAmount;
  String PreviewNarration;
  var tempProductSubTotal,
      tempProductName,
      tempProductRate,
      tempProductQTY,
      tempProductgst;

  bool _showProgress = false;

  @override
  void initState() {
    _getShopDetails();
    PreviewBillno = widget.SalesListFetch[widget.indexFetch].menusalesid;
    print("//////////////in it/////////// $PreviewBillno");
    PreviewBillno = widget.SalesListFetch[widget.indexFetch].menusalesid;
    CompanyName = widget.SalesListFetch[widget.indexFetch].customername;
    PreviewDate = widget.SalesListFetch[widget.indexFetch].medate;
    PreviewProductName = widget.SalesListFetch[widget.indexFetch].menuname;
    PreviewProductRate = widget.SalesListFetch[widget.indexFetch].menurate;
    PreviewProductQty = widget.SalesListFetch[widget.indexFetch].menuquntity;
    PreviewProductSubTotal =
        widget.SalesListFetch[widget.indexFetch].menusubtotal;
    PreviewSubTotal =
        widget.SalesListFetch[widget.indexFetch].Subtotal.toString();
    print(PreviewSubTotal);
    PreviewDiscount =
        widget.SalesListFetch[widget.indexFetch].discount.toString();
    PreviewProductGST =
        widget.SalesListFetch[widget.indexFetch].menugst.toString();
    PreviewModeOfPayment = widget.SalesListFetch[widget.indexFetch].paymodename;
    PreviewTotalAmount =
        widget.SalesListFetch[widget.indexFetch].totalamount.toString();
    PreviewNarration = widget.SalesListFetch[widget.indexFetch].Narration;
    print(PreviewProductName);
    print(PreviewProductRate);
    print(PreviewProductQty);
    print(PreviewProductSubTotal);
    print(PreviewProductGST);
    tempProductSubTotal = PreviewProductSubTotal.split("#");
    tempProductName = PreviewProductName.split("#");
    tempProductRate = PreviewProductRate.split("#");
    tempProductQTY = PreviewProductQty.split("#");
    tempProductgst = PreviewProductGST.split("#");

    print(tempProductSubTotal);
  }

  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobilePreviewSales();
    } else {
      content = _buildTabletPreviewSales();
    }

    return content;
  }

//-------------------------------------------
//---------------Tablet Mode Start-------------//
  Widget _buildTabletPreviewSales() {
    var narroationTextWidth = MediaQuery.of(context).size.width * .40;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.moneyBill),
            SizedBox(
              width: 20.0,
            ),
            Text('Bill NO:- $PreviewBillno '),
          ],
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showProgress,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Material(
              shape: Border.all(color: Colors.blueGrey, width: 2),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShopDetails.isNotEmpty
                            ? Column(
                                children: [
                                  Text("${ShopDetails[0].shopname}",
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold)),
                                  Text("${ShopDetails[0].shopaddress}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal)),
                                ],
                              )
                            : Text(''),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ShopDetails.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  " Mobile No: ${ShopDetails[0].shopmobilenumber}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal)),
                              Text("Email: ${ShopDetails[0].shopemail} ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal)),
                            ],
                          )
                        : Text(''),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              " Customer Name: $CompanyName",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Date: $PreviewDate ",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Expanded(
                          child: Container(
                            child: Text('Oil Name',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        )),
                        DataColumn(
                            label: Expanded(
                          child: Container(
                            width: 150,
                            child: Text('Rate',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        )),
                        DataColumn(
                            label: Expanded(
                          child: Container(
                            width: 100,
                            child: Text('GST',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        )),
                        DataColumn(
                            label: Expanded(
                          child: Container(
                            child: Text('Oil Quntity (Lit)',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        )),
                        DataColumn(
                          label: Expanded(
                            child: Container(
                              child: Text('SubTotal',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                      rows: getDataRowList(),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: narroationTextWidth,
                              child: Text("Narration:- $PreviewNarration",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal)),
                            ),
                            Container(
                              width: narroationTextWidth,
                              child: Text(
                                  "Payment Mode:- $PreviewModeOfPayment",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ],
                        ),
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 130),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "SubTotal:         ${double.parse(PreviewSubTotal).toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal)),
                                Text(
                                    "Discount:         ${double.parse(PreviewDiscount).toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal)),
                                Text(
                                    "Total Amount: ${double.parse(PreviewTotalAmount).toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobilePreviewSales() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.moneyBill),
            SizedBox(
              width: 20.0,
            ),
            Text('Bill NO:- $PreviewBillno '),
          ],
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showProgress,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 8.0),
            child: Material(
              shape: Border.all(color: Colors.blueGrey, width: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              //color: Colors.lightBlueAccent,
                              child: Column(
                                children: [
                                  Text(
                                    "$CompanyName",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              //color: Colors.lightBlueAccent,
                              child: Column(
                                children: [
                                  Text(
                                    "$PreviewDate",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey,
                    thickness: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 5.0),
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Expanded(
                          child: Container(
                            child: Text('Name',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        )),
                        DataColumn(
                            label: Expanded(
                          child: Container(
                            // width: 200,
                            child: Text('Rate',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        )),
                        DataColumn(
                            label: Expanded(
                          child: Container(
                            child: Text('Quntity',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        )),
                        DataColumn(
                          label: Expanded(
                            child: Container(
                              child: Text('SubTotal',
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                      rows: getDataRowList(),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey,
                    thickness: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "SubTotal:- $PreviewSubTotal",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 570.0,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Discount:- $PreviewDiscount",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 450.0,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Mode Of Payment:- $PreviewModeOfPayment",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Total Amount:- $PreviewTotalAmount",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Narration:- $PreviewNarration",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//---------------Mobile Mode End-------------//

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(tempProductName[index].toString())),
      DataCell(Text(tempProductRate[index])),
      DataCell(Text(tempProductgst[index])),
      DataCell(Text(tempProductQTY[index])),
      DataCell(Text(tempProductSubTotal[index])),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < tempProductSubTotal.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  //from server fetching Shop Details data
  void _getShopDetails() async {
    setState(() {
      _showProgress = true;
    });
    ShopFetch shopdatafetch = new ShopFetch();
    var ShopData = await shopdatafetch.getShopFetch("1");
    int resid = ShopData["resid"];
    if (resid == 200) {
      var ShopDatasd = ShopData["shop"];
      print(ShopDatasd.length);
      List<Shop> tempShopDetails = [];
      for (var n in ShopDatasd) {
        Shop pro = Shop.Withoutlogo(
            int.parse(n["ShopId"]),
            n["ShopName"],
            n["ShopMobileNumber"],
            n["ShopOwnerName"],
            n["ShopEmail"],
            n["ShopGSTNumber"],
            n["ShopCINNumber"],
            n["ShopPANNumber"],
            n["ShopSSINNumber"],
            n["ShopAddress"]);
        tempShopDetails.add(pro);
      }
      setState(() {
        _showProgress = false;
        this.ShopDetails = tempShopDetails;
      });
    } else {
      setState(() {
        _showProgress = false;
      });
      String message = ShopData["message"];
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }

    print("//////ShopDetails/////////$ShopDetails.length");
  }
}
