import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/models/Purchase.dart';

class PurchaseReportPrint extends StatefulWidget {
  final int indexFetch;
  List<Purchase> purchaseList = new List();

  PurchaseReportPrint(this.indexFetch, this.purchaseList);

  @override
  _PurchaseReportPrintState createState() =>
      _PurchaseReportPrintState(this.indexFetch, this.purchaseList);
}

class _PurchaseReportPrintState extends State<PurchaseReportPrint> {
  final int indexFetch;
  List<Purchase> purchaseList = new List();

  _PurchaseReportPrintState(this.indexFetch, this.purchaseList);

  final pdf = pw.Document();
  var imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Report"),
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
                'Supplier\nName',
                'Invoice No',
                'Total\nAmount',
                'Remark'
              ],
              ...purchaseList.map((data) => [
                data.srNo.toString(),
                data.PurchaseDate,
                data.PurchaseCompanyname,
                data.Purchaseinvoice,
                data.PurchaseTotal,
                data.PurchaseNarration
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
