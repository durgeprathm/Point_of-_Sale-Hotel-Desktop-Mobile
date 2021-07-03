import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/models/Purchase.dart';
import 'package:retailerp/models/supplier.dart';

class PurchseReportPrint extends StatefulWidget {
  final int indexFetch;
  List<Purchase> PurchaseList = new List();

  PurchseReportPrint(this.indexFetch, this.PurchaseList);

  @override
  _PurchseReportPrintState createState() =>
      _PurchseReportPrintState(this.indexFetch, this.PurchaseList);
}

class _PurchseReportPrintState extends State<PurchseReportPrint> {
  final int indexFetch;
  List<Purchase> PurchaseList = new List();

  _PurchseReportPrintState(this.indexFetch, this.PurchaseList);

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
                    'Purchase No',
                    'Date',
                    'Supplier Name',
                    'Invoice No',
                    'Miscellaneous Amount',
                    'Discount',
                        'Total Amount'
                  ],
                  ...PurchaseList.map((data) => [
                    data.Purchaseid.toString(),
                    data.PurchaseDate,
                    data.PurchaseCompanyname,
                    data.Purchaseinvoice,
                    data.PurchaseMiscellaneons,
                    data.PurchaseDiscount,
                    data.PurchaseTotal
                  ])
                ]),
              ])

        ],
      ),
    );

    return pdf.save();
  }

  // DataRow getRow(int index) {
  //   return DataRow(cells: [
  //     DataCell(Text(SupplierList[index].Supplierid.toString())),
  //     DataCell(Text(SupplierList[index].SupplierComapanyName)),
  //     DataCell(Text(SupplierList[index].SupplierComapanyPersonName)),
  //     DataCell(Text(SupplierList[index].SupplierMobile.toString())),
  //     DataCell(Text(SupplierList[index].SupplierEmail.toString())),
  //     DataCell(Text(SupplierList[index].SupplierAddress.toString()))
  //   ]);
  // }
  //
  // List<DataRow> getDataRowList() {
  //   List<DataRow> myTempDataRow = List();
  //   for (int i = 0; i < SupplierList.length; i++) {
  //     myTempDataRow.add(getRow(i));
  //   }
  //   return myTempDataRow;
  // }
}
