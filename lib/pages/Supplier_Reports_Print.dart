import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/LedgerManagement/Models/ledgermodel.dart';

class SupplierReportPrint extends StatefulWidget {
  final int indexFetch;
  List<Supplier> SupplierList = new List();

  SupplierReportPrint(this.indexFetch, this.SupplierList);

  @override
  _SupplierReportPrintState createState() =>
      _SupplierReportPrintState(this.indexFetch, this.SupplierList);
}

class _SupplierReportPrintState extends State<SupplierReportPrint> {
  final int indexFetch;
  List<Supplier> SupplierList = new List();

  _SupplierReportPrintState(this.indexFetch, this.SupplierList);

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
                    'Supplier No',
                    'Supplier Company Name',
                    'Supplier Name',
                    'Mobile',
                    'Email',
                    'Address'
                  ],
                  ...SupplierList.map((data) => [
                    data.Supplierid.toString(),
                    data.SupplierComapanyName,
                    data.SupplierComapanyPersonName,
                    data.SupplierMobile,
                    data.SupplierEmail,
                    data.SupplierAddress
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
      DataCell(Text(SupplierList[index].Supplierid.toString())),
      DataCell(Text(SupplierList[index].SupplierComapanyName)),
      DataCell(Text(SupplierList[index].SupplierComapanyPersonName)),
      DataCell(Text(SupplierList[index].SupplierMobile.toString())),
      DataCell(Text(SupplierList[index].SupplierEmail.toString())),
      DataCell(Text(SupplierList[index].SupplierAddress.toString()))
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < SupplierList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }
}
