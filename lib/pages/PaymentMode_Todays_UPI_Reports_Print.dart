import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/models/Sales.dart';

class PaymentModeTodaysUPIReportPrint extends StatefulWidget {
  final int indexFetch;
  List<Sales> PaymentmodeUPIList = new List();

  PaymentModeTodaysUPIReportPrint(this.indexFetch, this.PaymentmodeUPIList);

  @override
  _PaymentModeTodaysUPIReportPrintState createState() =>
      _PaymentModeTodaysUPIReportPrintState(this.indexFetch, this.PaymentmodeUPIList);
}

class _PaymentModeTodaysUPIReportPrintState extends State<PaymentModeTodaysUPIReportPrint> {
  final int indexFetch;
  List<Sales> PaymentmodeUPIList = new List();

  _PaymentModeTodaysUPIReportPrintState(this.indexFetch, this.PaymentmodeUPIList);

  final pdf = pw.Document();
  var imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
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
                    'Customer Name',
                    'Date',
                    'Total\nAmount',
                    'Bank Name',
                    'Transaction Id',
                    'Mode'
                  ],
                  ...PaymentmodeUPIList.map((data) => [
                    data.Salesid.toString(),
                    data.SalesCustomername,
                    data.SalesDate,
                    data.SalesTotal,
                    data.SalesBankName,
                    data.SalesUpiTransationId,
                    data.SalesPaymentMode
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
      DataCell(Text(PaymentmodeUPIList[index].Salesid.toString())),
      DataCell(Text(PaymentmodeUPIList[index].SalesCustomername)),
      DataCell(Text(PaymentmodeUPIList[index].SalesDate)),
      DataCell(Text(PaymentmodeUPIList[index].SalesTotal.toString())),
      DataCell(Text(PaymentmodeUPIList[index].SalesBankName)),
      DataCell(Text(PaymentmodeUPIList[index].SalesUpiTransationId)),
      DataCell(Text(PaymentmodeUPIList[index].SalesPaymentMode.toString()))
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < PaymentmodeUPIList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }
}
