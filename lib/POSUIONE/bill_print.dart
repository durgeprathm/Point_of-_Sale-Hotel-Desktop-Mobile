import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_shop_fetch.dart';
import 'dart:typed_data';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/EhotelModel/Shop.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';



class BillPrint extends StatefulWidget {
  List<String> menuNames;
  List<double> menuRates;
  List<int> menuQuants;
  List<double> productSubtotal;
  List<double> gstper;
  String payAmount;
  String CustomerName;
  String date;
  String subTotal;
  String discount;

  BillPrint(
      this.menuNames,
      this.menuRates,
      this.menuQuants,
      this.productSubtotal,
      this.gstper,
      this.subTotal,
      this.discount,
      this.payAmount,
      this.CustomerName,
      this.date);

  @override
  _BillPrintState createState() => _BillPrintState();
}

class _BillPrintState extends State<BillPrint> {
  List<Shop> ShopDetails = [];

  bool _showProgress = false;

  @override
  void initState() {
    _getShopDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Print"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white
         ),
          onPressed: () {

            Navigator.pop(context);
          },
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showProgress,
        child: ShopDetails.isNotEmpty
            ?Container(
          child: PdfPreview(
            build: (format) => _generatePdf(format, "title"),
          ),
        ):Text(''),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                children: [
                  pw.Container(
                      width: 200,
                      padding: pw.EdgeInsets.all(10.0),
                      decoration: pw.BoxDecoration(
                          border: pw.BoxBorder(
                        left: true,
                        right: true,
                        top: true,
                        bottom: true,
                        width: 1.0,
                      )),
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Customer Name: ${widget.CustomerName}'),
                          pw.Text('Date: ${widget.date}'),
                        ],
                      )),
                  pw.SizedBox(width: 25.0),
                   pw.Container(
                          width: 250,
                          padding: pw.EdgeInsets.all(10.0),
                          decoration: pw.BoxDecoration(
                              border: pw.BoxBorder(
                            left: true,
                            right: true,
                            top: true,
                            bottom: true,
                            width: 1.0,
                          )),
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('${ShopDetails[0].shopname}'),
                              pw.Text('${ShopDetails[0].shopaddress}'),
                              pw.Text(
                                  'Contact Details: ${ShopDetails[0].shopmobilenumber} '),
                              // pw.Text(
                              //     'GSTIN No:${ShopDetails[0].shopgstnumber}')
                            ],
                          ))
                  // pw.SizedBox(
                  //   width: 20.0
                  // ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Divider(thickness: 2.0),
              pw.Container(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Text("Product"),
                      ),
                      pw.Expanded(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: pw.Text("Qty"),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: pw.Text("Rate"),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.fromLTRB(4, 0, 0, 0),
                          child: pw.Text("Net Amt"),
                        ),
                      ),
                    ],
                  )),
              pw.Divider(thickness: 2.0),
              pw.Container(
                  child: pw.ListView.builder(
                itemCount: widget.menuNames.length,
                itemBuilder: (context, index) {
                  return pw.Container(
                    height: 34,
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                            child: pw.Container(
                                child: pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                              pw.Expanded(
                                  child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      children: [
                                    pw.Text(widget.menuNames[index].toString()),
                                    pw.Container(
                                      child: pw.Column(
                                        // crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Padding(
                                            padding: const pw.EdgeInsets.only(
                                                top: 1.0, bottom: 1.0),
                                            child: pw.Text(
                                                "GST: ${widget.gstper[index].toString()}%"),
                                            // child: pw.Text("Basic Amt: $Rupees${productData.getBasicAmount(product).toStringAsFixed(2)}",style: TextStyle(fontStyle: FontStyle.italic),),
                                          ),
                                        ],
                                      ),
                                    )
                                  ])),
                              pw.Expanded(
                                  child: pw.Padding(
                                padding: pw.EdgeInsets.all(8.0),
                                child: pw.Text(
                                    widget.menuQuants[index].toString()),
                              )),
                              pw.Expanded(
                                child: pw.Padding(
                                    padding: pw.EdgeInsets.all(8.0),
                                    child: pw.Text(
                                        "${widget.menuRates[index].toString()} Rs")),
                              ),
                              pw.Expanded(
                                  child: pw.Padding(
                                      padding: pw.EdgeInsets.all(8.0),
                                      child: pw.Text("${widget.productSubtotal[index].toString()} Rs")))
                            ]))),
                      ],
                    ),
                  );
                },
              )),
              pw.Divider(thickness: 2.0),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Container(
                        width: 200,
                        padding: pw.EdgeInsets.all(10.0),
                        decoration: pw.BoxDecoration(
                            border: pw.BoxBorder(
                              left: true,
                              right: true,
                              top: true,
                              bottom: true,
                              width: 1.0,
                            )),
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                                mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text('Sub Total:'),
                                  pw.Padding(
                                    padding:
                                    pw.EdgeInsets.fromLTRB(0, 0, 65, 0),
                                    child: pw.Text(
                                        '${widget.subTotal.toString()} Rs'),
                                  ),
                                ]),
                            pw.Row(
                                mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text('Discount:'),
                                  pw.Padding(
                                    padding:
                                    pw.EdgeInsets.fromLTRB(0, 0, 65, 0),
                                    child: pw.Text(
                                        '${widget.discount.toString()} Rs'),
                                  ),
                                ]),
                            pw.Row(
                                mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text('Total Amount:'),
                                  pw.Padding(
                                    padding:
                                    pw.EdgeInsets.fromLTRB(0, 0, 65, 0),
                                    child: pw.Text(
                                        '${widget.payAmount.toString()} Rs'),
                                  ),
                                ]),
                          ],
                        )),
                  ]),
              pw.SizedBox(height: 10.0),
              pw.Text("Powered By: QI Systems")
            ])
      ],
    ));
    return pdf.save();
  }

  //from server fetching Shop Details data

  void _getShopDetails() async {
    setState(() {
      _showProgress = true;
    });
    ShopFetch shopdatafetch = new ShopFetch();
    var ShopData = await shopdatafetch.getShopFetch("1");
    var resid = ShopData["resid"];

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
      print("//////ShopDetails/////////$ShopDetails.length");
    } else {
      setState(() {
        _showProgress = false;
      });
      String msg = ShopData["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}

// pw.Column(
// mainAxisAlignment: pw.MainAxisAlignment.start,
// crossAxisAlignment: pw.CrossAxisAlignment.start,
// children: [
// pw.Row(
// children: [
// pw.Container(
// width: 200,
// padding: pw.EdgeInsets.all(10.0),
// decoration: pw.BoxDecoration(
// border: pw.BoxBorder(
// left: true,
// right: true,
// top: true,
// bottom: true,
// width: 1.0,
// )
// ),
// child: pw.Column(
// mainAxisAlignment: pw.MainAxisAlignment.start,
// crossAxisAlignment: pw.CrossAxisAlignment.start,
// children: [
// pw.Text('Billed To'),
// pw.Text('Krishi Sewa Kendra, Nagpur'),
// pw.Text('Contact Details'),
// pw.Text('GSTIN No: 27AADFK8575F1Z1')
// ],
// )
// ),
// // pw.SizedBox(
// //   width: 20.0
// // ),
// pw.Container(
// width: 150,
// padding: pw.EdgeInsets.all(10.0),
// decoration: pw.BoxDecoration(
// border: pw.BoxBorder(
// left: true,
// right: true,
// top: true,
// bottom: true,
// width: 1.0,
// )
// ),
// child: pw.Column(
// mainAxisAlignment: pw.MainAxisAlignment.start,
// crossAxisAlignment: pw.CrossAxisAlignment.start,
// children: [
// pw.Text('Invoice No: GAA/20-21/00214'),
// pw.Text('Dated: 10-Dec-2020'),
// pw.Text('TAX INVOICE'),
// ],
// )
// ),
// ],
// ),
//
// pw.SizedBox(height: 5),
// pw.Table.fromTextArray(context: context, data: <List<String>>[
// <String>[
// 'SN',
// 'Order\nDate',
// 'Supplier\nName',
// 'Purchased Product',
// 'Total\nAmount',
// 'Remark'
// ],
// ]),
// ])
