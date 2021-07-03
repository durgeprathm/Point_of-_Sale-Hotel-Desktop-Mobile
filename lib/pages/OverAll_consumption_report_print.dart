import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/EhotelModel/Consumption.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/models/Sales.dart';

class OverAllConsumptionReportPrint extends StatefulWidget {
  final int indexFetch;
  List<Consumption> TodaysList = new List();

  OverAllConsumptionReportPrint(this.indexFetch, this.TodaysList);

  @override
  _OverAllConsumptionReportPrintState createState() =>
      _OverAllConsumptionReportPrintState(this.indexFetch, this.TodaysList);
}

class _OverAllConsumptionReportPrintState extends State<OverAllConsumptionReportPrint> {
  final int indexFetch;
  List<Consumption> TodaysList = new List();

  _OverAllConsumptionReportPrintState(this.indexFetch, this.TodaysList);

  final pdf = pw.Document();
  var imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Over All Consumption Report"),
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
                    'Department Name',
                    'Product Name',
                    'Product Quntity',
                    'Present Quntity'
                  ],
                  ...TodaysList.map((data) => [
                    data.srno.toString(),
                    data.consumption_Department_Name,
                    data.consumption_Product_Name,
                    data.consumption_Quntity,
                    data.consumption_Opening_Balance
                  ])
                ]),
              ])

        ],
      ),
    );

    return pdf.save();
  }

}
