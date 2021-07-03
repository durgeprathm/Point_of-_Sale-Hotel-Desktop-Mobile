import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/EhotelModel/StockTransfer.dart';
import 'package:retailerp/models/Sales.dart';

class TodaysStockTransferReportPrint extends StatefulWidget {
  List<StockTranfer> TodaysList = new List();

  TodaysStockTransferReportPrint(this.TodaysList);

  @override
  _TodaysStockTransferReportPrintState createState() =>
      _TodaysStockTransferReportPrintState();
}

class _TodaysStockTransferReportPrintState extends State<TodaysStockTransferReportPrint> {

  final pdf = pw.Document();
  var imageProvider;
  int index = 0;

  int getIndex(){
    return index + 1;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today\'s Stock Transfer Report"),
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
                  ],
                  ...widget.TodaysList.map((data) => [
                      data.srno.toString(),
                    data.StockTranferDepartmentname,
                    data.StockTranferDate,
                    data.StockTranferProductName,
                    data.StockTranferProductQty,
                  ])
                ]),
              ])

        ],
      ),
    );

    return pdf.save();
  }


}
