import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/models/Purchase.dart';

class StockReportPrint extends StatefulWidget {
  final int indexFetch;
  List<ProductModel> StockList = new List();

  StockReportPrint(this.indexFetch, this.StockList);

  @override
  _StockReportPrintState createState() =>
      _StockReportPrintState(this.indexFetch, this.StockList);
}

class _StockReportPrintState extends State<StockReportPrint> {
  final int indexFetch;
  List<ProductModel> StockList = new List();

  _StockReportPrintState(this.indexFetch, this.StockList);

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
                'Product Name',
                'Product Company',
                'Product Category',
                'Purchse Qty',
                'Sales Qty',
                'In Stock'
              ],
              ...StockList.map((data) => [
                indexFetch.toString(),
                data.proName,
                data.proComName,
                data.proCategory,
                data.productpurchse.toString(),
                data.productsale.toString(),
                data.productremaing.toString()
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
      DataCell(Text(StockList[index].proId.toString())),
      DataCell(Text(StockList[index].proName)),
      DataCell(Text(StockList[index].proCategory)),
      DataCell(Text(StockList[index].proComName.toString())),
      DataCell(Text(StockList[index].proOpeningBal.toString())),
      DataCell(Text(StockList[index].proSellingPrice.toString()))
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < StockList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }
}
