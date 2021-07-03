import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';


class BillPrint extends StatefulWidget {
  @override
  _BillPrintState createState() => _BillPrintState();
}

class _BillPrintState extends State<BillPrint> {
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
      body: Container(
        child: PdfPreview(
          build: (format) => _generatePdf(format, "title"),
        ),
      ),
    );
  }


  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document();
    pdf.addPage(
        pw.MultiPage(
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
                              )
                          ),
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('Customer Name: '),
                              pw.Text('Date: '),
                              pw.Text('Contact Details: '),
                            ],
                          )
                      ),
                      pw.SizedBox(
                        width: 25.0
                      ),
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
                              )
                          ),
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('Shop Name'),
                              pw.Text('Shop address'),
                              pw.Text('Contact Details: '),
                              pw.Text('GSTIN No: 27AADFK8575F1Z1')
                            ],
                          )
                      ),
                      // pw.SizedBox(
                      //   width: 20.0
                      // ),
                    ],
                  ),
                  pw.SizedBox(height: 5),
                  pw.Divider(
                    thickness: 2.0
                  ),
                  pw.Container(
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                          child: pw.Text("Product"),
                        ),
                        pw.Expanded(
                          child: pw.Text("Qty"),
                        ),
                        pw.Expanded(
                          child: pw.Text("Rate"),
                        ),
                        pw.Expanded(
                          child: pw.Text("Net Amt"),
                        ),

                      ],
                    )
                  ),
                  pw.Divider(
                      thickness: 2.0
                  ),
                  pw.Container(
                    child: pw.ListView.builder(
                        itemCount: 5,
                     itemBuilder: (context,index){
                          return pw.Container(
                            height: 70,
                            child: pw.Row(
                              children: [
                                pw.Expanded(
                                  child: pw.Container(
                                      child: pw.Row(
                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                      children: [
                                              pw.Expanded(
                                             child: pw.Column(
                                                 crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                 mainAxisAlignment: pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Text("Menu 1"),
                                                  pw.Container(
                                                    child: pw.Column(
                                                      // crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                      children: [
                                                        pw.Padding(
                                                          padding: const pw.EdgeInsets.only(top: 3.0,bottom: 3.0),
                                                          child: pw.Text("GST: 18%"),
                                                          // child: pw.Text("Basic Amt: $Rupees${productData.getBasicAmount(product).toStringAsFixed(2)}",style: TextStyle(fontStyle: FontStyle.italic),),
                                                        ),
                                                      ],
                                                    ),
                                                  )

                                                ]
                                              )),
                                              pw.Expanded(child: pw.Padding(
                                                padding: pw.EdgeInsets.all(8.0),
                                                child:  pw.Text("1"),
                                              )),
                                              pw.Expanded(child: pw.Padding(
                                                  padding: pw.EdgeInsets.all(8.0),
                                                  child:   pw.Text("15.0")
                                              ),),
                                              pw.Expanded(child: pw.Padding(
                                                  padding: pw.EdgeInsets.all(8.0),
                                                  child:   pw.Text("15.0")
                                              ))
                                            ]
                                          )
                                      )),
                              ],
                            ),
                          );

                      },
                    )
                  ),
                  pw.Divider(
                      thickness: 2.0
                  ),
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
                          )
                      ),
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Total Amount: '),
                        ],
                      )
                  ),
                   pw.SizedBox(
                     height: 10.0
                   ),

                   pw.Text("Powered By: QI Systems")


                ])

          ],
        )
    );
    return pdf.save();
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