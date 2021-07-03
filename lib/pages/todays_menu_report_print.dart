import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/EhotelModel/Ehotelmenu.dart';
import 'package:retailerp/models/Sales.dart';

class TodaysMenuReportPrint extends StatefulWidget {
  final int indexFetch;
  final String date;
  final String total;
  List<Ehotelmenu> TodaysmenuList = new List();

  TodaysMenuReportPrint(this.indexFetch, this.TodaysmenuList,this.date,this.total);

  @override
  _TodaysMenuReportPrintState createState() =>
      _TodaysMenuReportPrintState(this.indexFetch, this.TodaysmenuList);
}

class _TodaysMenuReportPrintState extends State<TodaysMenuReportPrint> {
  final int indexFetch;
  List<Ehotelmenu> TodaysmenuList = new List();

  _TodaysMenuReportPrintState(this.indexFetch, this.TodaysmenuList);


  var imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today\'s Menu Report"),
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
        build: (context)
        {
          return pw.Padding(
            padding: pw.EdgeInsets.symmetric(horizontal: 10.0),
              child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Date: ${widget.date}'),
                pw.SizedBox(height: 5),
                pw.Table.fromTextArray(context: context, data: <List<String>>[
                  <String>[
                    'Sr\nNO',
                    'Menu',
                    'Qty',
                    'Rate',
                    'Total\nAmt',
                  ],
                  ...TodaysmenuList.map((data) =>
                  [
                    data.menu_id.toString(),
                    data.Menu_Name,
                    data.Menu_Qty_Sum,
                    data.Menu_Rate,
                    double.parse(data.Menu_total_amount).toStringAsFixed(2),
                  ])
                ]),
                pw.Text('Total: ${widget.total}'),
              ]));
        }

      ),
    );

    return pdf.save();
  }
}
