import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/models/Sales.dart';

class AllDebitReportPrint extends StatefulWidget {
  final int indexFetch;
  List<EhotelSales> DebitList = new List();
  double totalsale;
  AllDebitReportPrint(this.indexFetch, this.DebitList,this.totalsale);

  @override
  _AllDebitReportPrintState createState() =>
      _AllDebitReportPrintState(this.indexFetch, this.DebitList);
}

class _AllDebitReportPrintState extends State<AllDebitReportPrint> {
  final int indexFetch;
  List<EhotelSales> DebitList = new List();

  _AllDebitReportPrintState(this.indexFetch, this.DebitList);

  var imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Debit Report"),
      ),
      body: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (context) {
         return  pw.Padding(
           padding: pw.EdgeInsets.symmetric(horizontal: 4.0),
           child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Poonam POS'),
                pw.Text('Paymode: Debit'),
                pw.SizedBox(height: 5),
                pw.Table.fromTextArray(context: context, data: <List<String>>[
                  <String>[
                    'Bill No',
                    'Date',
                    'Dis',
                    'Total\nAmt',
                  ],
                  ...DebitList.map((data) =>
                  [
                    data.menusalesid.toString(),
                    data.medate,
                    data.discount,
                    data.totalamount,
                  ])
                ]),
                pw.Text('Total: ${widget.totalsale}'),
              ]));
        },
      ),
    );

    return pdf.save();
  }

}
