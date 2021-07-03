import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/models/Sales.dart';

class AllReportPrint extends StatefulWidget {
  final int indexFetch;
  List<EhotelSales> AllList = new List();
  double totalsale;
  AllReportPrint(this.indexFetch, this.AllList,this.totalsale);

  @override
  _AllReportPrintState createState() =>
      _AllReportPrintState(this.indexFetch, this.AllList);
}

class _AllReportPrintState extends State<AllReportPrint> {
  final int indexFetch;
  List<EhotelSales> AllList = new List();

  _AllReportPrintState(this.indexFetch, this.AllList);

  var imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Report"),
      ),
      body: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw. Page(
        pageFormat: PdfPageFormat.roll80,
        build: (pw.Context context)
        {
         return
           pw.Padding(
             padding: pw.EdgeInsets.symmetric(horizontal: 10.0),
           child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Poonam POS'),
                pw.SizedBox(height: 5),
                pw.Table.fromTextArray(context: context, data: <List<String>>[
                  <String>[
                    'Bill No',
                    'Date',
                    'Dis',
                    'Total\nAmt',
                    'Mode'
                  ],
                  ...AllList.map((data) =>
                  [
                    data.menusalesid.toString(),
                    data.medate,
                    data.discount,
                    data.totalamount,
                    data.paymodename
                  ])
                ]),
                pw.Text('Total : ${widget.totalsale.toString()}'),

              ]));
        },
      ),
    );

    return pdf.save();
  }

  // DataRow getRow(int index) {
  //   return DataRow(cells: [
  //     DataCell(Text(AllList[index].SalesIDs.toString())),
  //     DataCell(Text(AllList[index].SalesCustomername)),
  //     DataCell(Text(AllList[index].SalesDate)),
  //     DataCell(Text(AllList[index].SalesTotal.toString())),
  //     DataCell(Text(AllList[index].SalesPaymentMode.toString()))
  //   ]);
  // }
  //
  // List<DataRow> getDataRowList() {
  //   List<DataRow> myTempDataRow = List();
  //   for (int i = 0; i < AllList.length; i++) {
  //     myTempDataRow.add(getRow(i));
  //   }
  //   return myTempDataRow;
  // }
}
