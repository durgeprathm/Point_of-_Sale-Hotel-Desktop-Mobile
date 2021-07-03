import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/models/Sales.dart';

class TodaysDebitReportPrint extends StatefulWidget {
  final int indexFetch;
  List<EhotelSales> DebitList = new List();
  final String date;
  final String totalsale;

  TodaysDebitReportPrint(this.indexFetch, this.DebitList,this.date,this.totalsale);

  @override
  _TodaysDebitReportPrintState createState() =>
      _TodaysDebitReportPrintState(this.indexFetch, this.DebitList);
}

class _TodaysDebitReportPrintState extends State<TodaysDebitReportPrint> {
  final int indexFetch;
  List<EhotelSales> DebitList = new List();

  _TodaysDebitReportPrintState(this.indexFetch, this.DebitList);


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
                  ...DebitList.map((data) => [
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

  // DataRow getRow(int index) {
  //   return DataRow(cells: [
  //     DataCell(Text(DebitList[index].SalesIDs.toString())),
  //     DataCell(Text(DebitList[index].SalesCustomername)),
  //     DataCell(Text(DebitList[index].SalesDate)),
  //     DataCell(Text(DebitList[index].SalesTotal.toString())),
  //     DataCell(Text(DebitList[index].SalesPaymentMode.toString()))
  //   ]);
  // }
  //
  // List<DataRow> getDataRowList() {
  //   List<DataRow> myTempDataRow = List();
  //   for (int i = 0; i < DebitList.length; i++) {
  //     myTempDataRow.add(getRow(i));
  //   }
  //   return myTempDataRow;
  // }
}
