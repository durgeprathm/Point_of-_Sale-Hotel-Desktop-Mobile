import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/EhotelModel/StockTransfer.dart';
import 'package:retailerp/models/Sales.dart';

class OverAllStockTransferReportPrint extends StatefulWidget {
  List<StockTranfer> TodaysList = new List();

  OverAllStockTransferReportPrint(this.TodaysList);

  @override
  _OverAllStockTransferReportPrintState createState() =>
      _OverAllStockTransferReportPrintState();
}

class _OverAllStockTransferReportPrintState extends State<OverAllStockTransferReportPrint> {

  final pdf = pw.Document();
  var imageProvider;
  int index = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Over All Stock Transfer Report"),
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
                  ],
                  ...widget.TodaysList.map((data) => [
                    data.srno.toString(),
                    data.StockTranferDepartmentname,
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
