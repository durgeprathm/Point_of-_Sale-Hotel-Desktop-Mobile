import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/models/Sales.dart';

class PaymentModeTodaysDebitReportPrint extends StatefulWidget {
  final int indexFetch;
  List<Sales> PaymentModeDebitList = new List();

  PaymentModeTodaysDebitReportPrint(this.indexFetch, this.PaymentModeDebitList);

  @override
  _PaymentModeTodaysDebitReportPrintState createState() =>
      _PaymentModeTodaysDebitReportPrintState(this.indexFetch, this.PaymentModeDebitList);
}

class _PaymentModeTodaysDebitReportPrintState extends State<PaymentModeTodaysDebitReportPrint> {
  final int indexFetch;
  List<Sales> PaymentModeDebitList = new List();

  _PaymentModeTodaysDebitReportPrintState(this.indexFetch, this.PaymentModeDebitList);

  final pdf = pw.Document();
  var imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Debit Report"),
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
                    'SN ',
                    'Customer Name ',
                    'Date ',
                    'Total\nAmount ',
                    'Payment\nCard ',
                    'Card\nType ',
                    'Name On \nCard ',
                    'Card\nNumber ',
                    'Mode '
                  ],
                  ...PaymentModeDebitList.map((data) => [
                    data.Salesid.toString(),
                    data.SalesCustomername,
                    data.SalesDate,
                    data.SalesTotal,
                    data.SalesPaymentCardType,
                    data.SalesCardType,
                    data.SalesNameOnCard,
                    data.SalesCardName,
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
      DataCell(Text(PaymentModeDebitList[index].Salesid.toString())),
      DataCell(Text(PaymentModeDebitList[index].SalesCustomername)),
      DataCell(Text(PaymentModeDebitList[index].SalesDate)),
      DataCell(Text(PaymentModeDebitList[index].SalesTotal.toString())),
      DataCell(Text(PaymentModeDebitList[index].SalesPaymentCardType)),
      DataCell(Text(PaymentModeDebitList[index].SalesNameOnCard)),
      DataCell(Text(PaymentModeDebitList[index].SalesCardName.toString())),
      DataCell(Text(PaymentModeDebitList[index].SalesPaymentMode.toString()))
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < PaymentModeDebitList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }
}
