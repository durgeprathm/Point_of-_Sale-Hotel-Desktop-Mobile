import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/models/Purchase.dart';

class ProductWisePurchaseReportPrint extends StatefulWidget {
  final int indexFetch;
  List<Purchase> purchaseList = new List();

  ProductWisePurchaseReportPrint(this.indexFetch, this.purchaseList);

  @override
  _ProductWisePurchaseReportPrintState createState() =>
      _ProductWisePurchaseReportPrintState(this.indexFetch, this.purchaseList);
}

class _ProductWisePurchaseReportPrintState
    extends State<ProductWisePurchaseReportPrint> {
  final int indexFetch;
  List<Purchase> purchaseList = new List();

  _ProductWisePurchaseReportPrintState(this.indexFetch, this.purchaseList);

  final pdf = pw.Document();
  var imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Wise Purchase Report"),
      ),
      body: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Retail ERP'),
                pw.SizedBox(height: 5),
                pw.Table.fromTextArray(context: context, data: <List<String>>[
                  <String>[
                    'SN',
                    'Order\nDate',
                    'Product\nName',
                    'Qty',
                    'GST',
                    'Rate',
                    'Total\nAmount',
                  ],
                  ...purchaseList.map((data) => [
                        data.srNo.toString(),
                        data.PurchaseDate,
                        data.PurchaseProductName,
                        data.PurchaseProductQty,
                        data.PurchaseGST,
                    data.PurchaseProductRate,
                        data.PurchaseProductSubTotal
                      ])
                ]),
              ])
        ],
      ),
    );

    return pdf.save();
  }

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(purchaseList[index].Purchaseid.toString())),
      DataCell(Text(purchaseList[index].PurchaseCompanyname)),
      DataCell(Text(purchaseList[index].PurchaseDate)),
      DataCell(Text(purchaseList[index].PurchaseTotal.toString()))
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < purchaseList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }
}
