import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/models/Sales.dart';

class AllCashReportPrint extends StatefulWidget {
  final int indexFetch;
  List<EhotelSales> CashList = new List();
  double totalsale;
  AllCashReportPrint(this.indexFetch, this.CashList,this.totalsale);

  @override
  _AllCashReportPrintState createState() =>
      _AllCashReportPrintState(this.indexFetch, this.CashList);
}

class _AllCashReportPrintState extends State<AllCashReportPrint> {
  final int indexFetch;
  List<EhotelSales> CashList = new List();

  _AllCashReportPrintState(this.indexFetch, this.CashList);


  var imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Cash Report"),
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
        build: (pw.Context context)  {
        return pw.Padding(
            padding: pw.EdgeInsets.symmetric(horizontal: 4.0),
          child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Poonam POS'),
                pw.Text('Paymode: CASH'),
                pw.SizedBox(height: 5),
                pw.Table.fromTextArray(context: context, data: <List<String>>[
                  <String>[
                    'Bill No',
                    'Date',
                    'Dis',
                    'Total\nAmt',
                  ],
                  ...CashList.map((data) =>
                  [
                    data.menusalesid.toString(),
                    data.medate,
                    data.discount,
                    data.totalamount,
                  ])
                ]),
                pw.Text('Total: ${widget.totalsale.toString()}'),
              ]));
        },
      ),
    );

    return pdf.save();
  }

  // DataRow getRow(int index) {
  //   return DataRow(cells: [
  //     DataCell(Text(CashList[index].SalesIDs.toString())),
  //     DataCell(Text(CashList[index].SalesCustomername)),
  //     DataCell(Text(CashList[index].SalesDate)),
  //     DataCell(Text(CashList[index].SalesTotal.toString())),
  //     DataCell(Text(CashList[index].SalesPaymentMode.toString()))
  //   ]);
  // }
  //
  // List<DataRow> getDataRowList() {
  //   List<DataRow> myTempDataRow = List();
  //   for (int i = 0; i < CashList.length; i++) {
  //     myTempDataRow.add(getRow(i));
  //   }
  //   return myTempDataRow;
  // }
}
