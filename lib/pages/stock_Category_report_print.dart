import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/LocalDbModels/product_category.dart';
import 'package:retailerp/models/Menu_Category.dart';
import 'package:retailerp/models/Purchase.dart';
import 'package:retailerp/models/menu.dart';

class StockCatgeoryReportPrint extends StatefulWidget {
  final int indexFetch;
  List<ProductCategory> StockCategoryList = new List();

  StockCatgeoryReportPrint(this.indexFetch, this.StockCategoryList);

  @override
  _StockCatgeoryReportPrintState createState() =>
      _StockCatgeoryReportPrintState(this.indexFetch, this.StockCategoryList);
}

class _StockCatgeoryReportPrintState extends State<StockCatgeoryReportPrint> {
  final int indexFetch;
  List<ProductCategory> StockCategoryList = new List();

  _StockCatgeoryReportPrintState(this.indexFetch, this.StockCategoryList);

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
                'Stock Category No',
                'Stock Category Name',
                'Stock Parent Category Name',
              ],
              ...StockCategoryList.map((data) => [
                data.catid.toString(),
                data.pCategoryname,
                data.pParentCategoryName,
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
      DataCell(Text(StockCategoryList[index].pCategoryname.toString())),
      DataCell(Text(StockCategoryList[index].pCategoryname)),
      DataCell(Text(StockCategoryList[index].pParentCategoryName)),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < StockCategoryList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }
}
