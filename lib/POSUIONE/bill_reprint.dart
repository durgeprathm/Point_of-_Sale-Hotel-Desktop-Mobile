import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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

class BillRePrint extends StatefulWidget {
  List<String> menuNames;
  List<String> menuRates;
  List<String> menuQuants;
  List<String> productSubtotal;
  List<String> gstper;
  String payAmount;
  String CustomerName;
  String date;
  String subTotal;
  String discount;
  String billno;


  BillRePrint(
      this.menuNames,
      this.menuRates,
      this.menuQuants,
      this.productSubtotal,
      this.gstper,
      this.subTotal,
      this.discount,
      this.payAmount,
      this.CustomerName,
      this.date,this.billno);

  @override
  _BillRePrintState createState() => _BillRePrintState();
}

class _BillRePrintState extends State<BillRePrint> {
  List<Shop> ShopDetails = [];
  bool _showProgress = false;
  String formattedTime, formattedDate;

  @override
  void initState() {
    _getShopDetails();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    formattedTime = DateFormat('h:mm:s').format(now);
    formattedDate = DateFormat('dd-MM-yyyy kk:mm').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text("Print"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showProgress,
        child: ShopDetails.isNotEmpty
            ? Container(
          child: PdfPreview(
            build: (format) => _generatePdf(format, "title"),
          ),
        )
            : Text(''),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (pw.Context context) {
          return
            pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 2.0),
                child: pw.Column(children: [
                  pw.Column(
                    children: [
                      pw.Center(
                        child: pw.Text(
                          '${ShopDetails[0].shopname}',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Center(
                        child: pw.Text(
                          '${ShopDetails[0].shopaddress}',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(fontSize: 6),
                        ),
                      ),
                      pw.Center(
                        child: pw.Text(
                          'GST No: ${ShopDetails[0].shopgstnumber}',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(fontSize: 6),
                        ),
                      ),
                      pw.Center(
                        child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text('Contact: ${ShopDetails[0].shopmobilenumber} ',
                                  style: pw.TextStyle(fontSize: 6)),
                              pw.Text('| ', style: pw.TextStyle(fontSize: 6)),
                              pw.Text('${ShopDetails[0].shopemail} ',
                                  style: pw.TextStyle(fontSize: 6)),
                            ]),
                      ),
                      pw.SizedBox(height: 3.0),
                    ],
                  ),
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                      pw.Text('Customer: ${widget.CustomerName}',
                          style: pw.TextStyle(fontSize: 8)),
                      pw.Text('Date: ${formattedDate}',
                          style: pw.TextStyle(fontSize: 8)),
                    ],
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.only(top:6.0),
                    child: pw.Text(
                      'Bill No: ${widget.billno}',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(fontSize: 6),
                    ),
                  ),
                  pw.Divider(thickness: 1.0),
                  pw.Container(
                      child: pw.Row(
                        children: [
                          pw.Expanded(
                              flex: 1,
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [
                                  pw.Text("Qty",
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(fontSize: 8)),
                                ],
                              )),
                          pw.Expanded(
                              flex: 5,
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [
                                  pw.Text("Item",
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(fontSize: 8)),
                                ],
                              )),
                          pw.Expanded(
                              flex: 2,
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [
                                  pw.Text("Rate",
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(fontSize: 8)),
                                ],
                              )),
                          pw.Expanded(
                              flex: 3,
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [
                                  pw.Text("Total",
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(fontSize: 8)),
                                ],
                              )),
                        ],
                      )),
                  pw.Divider(thickness: 1.0),
                  pw.Container(
                      child: pw.ListView.builder(
                        itemCount: widget.menuNames.length,
                        itemBuilder: (context, index) {
                          return pw.Container(
                            child: pw.Row(
                              children: [
                                pw.Expanded(
                                    flex: 1,
                                    child: pw.Column(
                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Text(widget.menuQuants[index].toString(),
                                              style: pw.TextStyle(fontSize: 8)),
                                        ])),
                                pw.Expanded(
                                    flex: 5,
                                    child: pw.Column(
                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Text(widget.menuNames[index].toString(),
                                              style: pw.TextStyle(fontSize: 8)),
                                        ])),
                                pw.Expanded(
                                    flex: 2,
                                    child: pw.Column(
                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Text(widget.menuRates[index].toString(),
                                              style: pw.TextStyle(fontSize: 8)),
                                        ])),
                                pw.Expanded(
                                    flex: 3,
                                    child: pw.Column(
                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Text(
                                              widget.productSubtotal[index].toString(),
                                              style: pw.TextStyle(fontSize: 8)),
                                        ])),

                              ],
                            ),
                          );
                        },
                      )),
                  pw.Divider(thickness: 1.0),
                  pw.Row(children: [
                    pw.Expanded(
                        flex: 7,
                        child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.end,
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Text('Sub Total: ',
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(fontSize: 8)),
                              pw.Text('Service Charges: ',
                                  style: pw.TextStyle(fontSize: 8)),
                              pw.Text('SGST: ', style: pw.TextStyle(fontSize: 8)),
                              pw.Text('CGST: ', style: pw.TextStyle(fontSize: 8)),
                              pw.Text('Discount: ', style: pw.TextStyle(fontSize: 8)),
                            ])),
                    pw.Expanded(
                        flex: 3,
                        child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('${widget.subTotal.toString()}',
                                  style: pw.TextStyle(fontSize: 8)),
                              pw.Text('${0.toString()}',
                                  style: pw.TextStyle(fontSize: 8)),
                              pw.Text('${0.toString()}',
                                  style: pw.TextStyle(fontSize: 8)),
                              pw.Text('${0.toString()}',
                                  style: pw.TextStyle(fontSize: 8)),
                              pw.Text('${widget.discount.toString()}',
                                  style: pw.TextStyle(fontSize: 8))
                            ]))
                  ]),

                  pw.Divider(thickness: 1.0),
                  pw.Row(children: [
                    pw.Expanded(
                      flex: 7,
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text('Total Amount: ',
                                style: pw.TextStyle(fontSize: 10)),
                          ]),
                    ),
                    pw.Expanded(
                        flex: 3,
                        child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('${widget.payAmount.toString()}',
                                  style: pw.TextStyle(
                                      fontSize: 10, fontWeight: pw.FontWeight.bold)),
                            ]))
                  ]),

                  // pw.Row(
                  //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  //     children: [
                  //
                  //       pw.Padding(
                  //         padding: pw.EdgeInsets.fromLTRB(0, 0, 65, 0),
                  //         child: pw.Text('${widget.payAmount.toString()}',
                  //             style: pw.TextStyle(fontSize: 10,fontWeight: pw.FontWeight.bold)),
                  //       ),
                  //     ]),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text("Thank You...!", style: pw.TextStyle(fontSize: 8)),
                  ),
                  pw.SizedBox(height: 5.0),
                  pw.Text("Powered By: Quintessential Informatics Systems",
                      style: pw.TextStyle(fontSize: 8)),
                  pw.Center(
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text('+91 9960586464 ',
                              style: pw.TextStyle(fontSize: 8)),
                          pw.Text('| ', style: pw.TextStyle(fontSize: 8)),
                          pw.Text('www.qisystems.in',
                              style: pw.TextStyle(fontSize: 8)),
                        ]),
                  ),
                ])); // Center
        })); // Page
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
