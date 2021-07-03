import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/models/Purchase.dart';
import 'package:retailerp/utils/const.dart';

class PreviewPurchase extends StatefulWidget {
  PreviewPurchase(this.indexFetch, this.PurchaseListFetch);

  @override
  final int indexFetch;
  List<Purchase> PurchaseListFetch = new List();

  _PreviewPurchaseState createState() => _PreviewPurchaseState();
}

class _PreviewPurchaseState extends State<PreviewPurchase> {
  @override
  int PreviewBillNo;
  String CompanyName;
  String supplierComapanyPersonName;
  String supplierMobileNumber;
  String supplierEmail;
  String supplierAddress;
  String supplierGSTNumber;


  String PreviewDate;
  String PreviewProductName;
  String PreviewProductRate;
  String PreviewProductQty;
  String PreviewProductSubTotal;
  String PreviewSubTotal;
  String PreviewDiscount;
  String PreviewGST;
  String PreviewMiscellaneons;
  String PreviewTotalAmount;
  String PreviewNarration;
  var tempProductSubTotal,
      tempProductName,
      tempProductRate,
      tempProductGst,
      tempProductQTY;

  @override
  void initState() {
    PreviewBillNo = widget.PurchaseListFetch[widget.indexFetch].Purchaseid;
    CompanyName =
        widget.PurchaseListFetch[widget.indexFetch].PurchaseCompanyname;


    supplierComapanyPersonName = widget.PurchaseListFetch[widget.indexFetch].SupplierComapanyPersonName;
    supplierMobileNumber = widget.PurchaseListFetch[widget.indexFetch].SupplierMobileNumber;
    supplierEmail = widget.PurchaseListFetch[widget.indexFetch].SupplierEmail;
    supplierAddress = widget.PurchaseListFetch[widget.indexFetch].SupplierAddress;
    supplierGSTNumber = widget.PurchaseListFetch[widget.indexFetch].SupplierGSTNumber;


    PreviewDate = widget.PurchaseListFetch[widget.indexFetch].PurchaseDate;
    PreviewProductName =
        widget.PurchaseListFetch[widget.indexFetch].PurchaseProductName;
    PreviewProductRate =
        widget.PurchaseListFetch[widget.indexFetch].PurchaseProductRate;
    PreviewProductQty =
        widget.PurchaseListFetch[widget.indexFetch].PurchaseProductQty;
    PreviewProductSubTotal =
        widget.PurchaseListFetch[widget.indexFetch].PurchaseProductSubTotal;
    PreviewSubTotal =
        widget.PurchaseListFetch[widget.indexFetch].PurchaseSubTotal.toString();
    PreviewDiscount =
        widget.PurchaseListFetch[widget.indexFetch].PurchaseDiscount.toString();
    PreviewGST =
        widget.PurchaseListFetch[widget.indexFetch].PurchaseGST.toString();
    PreviewMiscellaneons = widget
        .PurchaseListFetch[widget.indexFetch].PurchaseMiscellaneons
        .toString();
    PreviewTotalAmount =
        widget.PurchaseListFetch[widget.indexFetch].PurchaseTotal.toString();
    PreviewNarration =
        widget.PurchaseListFetch[widget.indexFetch].PurchaseNarration;

    print(PreviewProductName);
    print(PreviewProductRate);
    print(PreviewProductQty);
    print(PreviewProductSubTotal);
    tempProductSubTotal = PreviewProductSubTotal.split("#");
    tempProductName = PreviewProductName.split("#");
    tempProductRate = PreviewProductRate.split("#");
    tempProductGst = PreviewGST.split("#");
    tempProductQTY = PreviewProductQty.split("#");

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
      content = _buildMobilePreviewPurchase();
    } else {
      content = _buildTabletPreviewPurchase();
    }

    return content;
  }

//-------------------------------------------
//---------------Tablet Mode Start-------------//
  Widget _buildTabletPreviewPurchase() {
    var addressTextWidth = MediaQuery.of(context).size.width * .20;
    var narroationTextWidth = MediaQuery.of(context).size.width * .40;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.moneyBillAlt),
            SizedBox(
              width: 20.0,
            ),
            Text('Invoice No:-  $PreviewBillNo'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            shape: Border.all(color: PrimaryColor, width: 2),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$CompanyName",
                                  style: labelPreviewTextStyle,
                                ),
                              ],
                            ),
                            Text(
                              "$PreviewDate",
                              style: datePreviewTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: addressTextWidth,
                                  child: Text(
                                    "$supplierAddress",
                                    style: subHeadlabelPreviewTextStyle,
                                  ),
                                ),
                                Text(
                                  "$supplierMobileNumber",
                                  style: subHeadlabelPreviewTextStyle,
                                ),
                                Text(
                                  "$supplierEmail",
                                  style: subHeadlabelPreviewTextStyle,
                                ),
                                Text(
                                  "$supplierComapanyPersonName",
                                  style: subHeadlabelPreviewTextStyle,
                                ),
                                Text(
                                  "$supplierGSTNumber",
                                  style: subHeadlabelPreviewTextStyle,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: PrimaryColor,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable(
                    columns: [
                      DataColumn(
                          label: Expanded(
                        child: Container(
                          child: Center(
                            child:
                                Text('Product Name', style: tableColmTextStyle),
                          ),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Container(
                          child: Center(
                            child:
                                Text('Product Rate', style: tableColmTextStyle),
                          ),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Container(
                          child: Center(
                            child: Text('Gst', style: tableColmTextStyle),
                          ),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Container(
                          child: Center(
                            child: Text('Product Quntity',
                                style: tableColmTextStyle),
                          ),
                        ),
                      )),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            child: Center(
                              child: Text('Product SubTotal',
                                  style: tableColmTextStyle),
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: getDataRowList(),
                  ),
                ),
                Divider(
                  color: PrimaryColor,
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
                            child: Text(
                              "Narration:- $PreviewNarration",
                              style: narrationLabelPreviewTextStyle,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 130),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "SubTotal:         $PreviewSubTotal",
                                style:subtotalLabelPreviewTextStyle,
                              ),
                              Text(
                                "Discount:         $PreviewDiscount",
                                style: discountLabelPreviewTextStyle,
                              ),
                              Text(
                                "Mis. Amount:   $PreviewMiscellaneons",
                                style: miscLabelPreviewTextStyle,
                                ),

                              Text(
                                "Total Amount: $PreviewTotalAmount",
                                style: totalAmountLabelPreviewTextStyle,
                              ),
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
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobilePreviewPurchase() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.moneyBillAlt),
            SizedBox(
              width: 20.0,
            ),
            Text('Invoice No:-  $PreviewBillNo'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Material(
          shape: Border.all(color: PrimaryColor, width: 2),
          child: Column(
            children: [
              Column(
                //mainAxisAlignment: MainAxisAlignment.start,
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
              Divider(
                color: PrimaryColor,
                thickness: 2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                child: DataTable(
                  columnSpacing: 25,
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
                        child: Text('Rate',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    )),
                    DataColumn(
                        label: Expanded(
                      child: Container(
                        child: Text('Gst',
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
                color: PrimaryColor,
                thickness: 2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "SubTotal:- $PreviewSubTotal",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 570.0,
                  ),
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
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     "GST Amount:- $PreviewGST",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.normal,
                  //       fontSize: 20.0,
                  //     ),
                  //   ),
                  // ),
                  //SizedBox(
                  //   width: 450.0,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Miscellaneons Amount:- $PreviewMiscellaneons",
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
    );
  }

//---------------Mobile Mode End-------------//

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Center(child: Text(tempProductName[index].toString()))),
      DataCell(Center(child: Text(tempProductRate[index].toString()))),
      DataCell(Center(child: Text(tempProductGst[index].toString()))),
      DataCell(Center(child: Text(tempProductQTY[index].toString()))),
      DataCell(Center(child: Text(tempProductSubTotal[index].toString()))),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < tempProductName.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }
}
