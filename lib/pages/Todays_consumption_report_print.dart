import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/EhotelModel/Consumption.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/models/Sales.dart';

class TodaysConsumptionReportPrint extends StatefulWidget {
  final int indexFetch;
  List<Consumption> TodaysList = new List();

  TodaysConsumptionReportPrint(this.indexFetch, this.TodaysList);

  @override
  _TodaysConsumptionReportPrintState createState() =>
      _TodaysConsumptionReportPrintState(this.indexFetch, this.TodaysList);
}

class _TodaysConsumptionReportPrintState extends State<TodaysConsumptionReportPrint> {
  final int indexFetch;
  List<Consumption> TodaysList = new List();

  _TodaysConsumptionReportPrintState(this.indexFetch, this.TodaysList);

  final pdf = pw.Document();
  var imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today\'s Consumption Report"),
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
                    'Date',
                    'Product Name',
                    'Product Quntity',
                    'Present Quntity'
                  ],
                  ...TodaysList.map((data) => [
                    data.consumption_id.toString(),
                    data.consumption_Department_Name,
                    data.consumption_Date,
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
