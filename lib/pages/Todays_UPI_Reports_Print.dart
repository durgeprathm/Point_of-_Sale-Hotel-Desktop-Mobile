import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/models/Sales.dart';

class TodaysUPIReportPrint extends StatefulWidget {
  final int indexFetch;
  List<EhotelSales> UPIList = new List();
  final String date;
  final String totalsale;

  TodaysUPIReportPrint(this.indexFetch, this.UPIList,this.date,this.totalsale);

  @override
  _TodaysUPIReportPrintState createState() =>
      _TodaysUPIReportPrintState(this.indexFetch, this.UPIList);
}

class _TodaysUPIReportPrintState extends State<TodaysUPIReportPrint> {
  final int indexFetch;
  List<EhotelSales> UPIList = new List();

  _TodaysUPIReportPrintState(this.indexFetch, this.UPIList);


  var imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today\'s Debit Report"),
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
                padding: pw.EdgeInsets.symmetric(horizontal: 10.0),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Date: ${widget.date}"),
                      pw.SizedBox(height: 5),
                      pw.Table.fromTextArray(context: context, data: <List<String>>[
                        <String>[
                          'Bill No',
                          'Cust Name',
                          'Dis',
                          'Total\nAmt',
                          'Mode'
                        ],
                        ...UPIList.map((data) => [
                          data.menusalesid.toString(),
                          data.customername,
                          data.discount,
                          data.totalamount,
                          data.paymodename
                        ])
                      ]),
                      pw.Text("Total: ${widget.totalsale}"),
                    ]));
          },
        ));
    return pdf.save();
  }
}