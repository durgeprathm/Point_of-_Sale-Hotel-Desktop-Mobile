import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/models/Menu_Category.dart';
import 'package:retailerp/models/Purchase.dart';
import 'package:retailerp/models/menu.dart';

class MenuCatgeoryReportPrint extends StatefulWidget {
  final int indexFetch;
  List<MenuCategory> MenuCategoryList = new List();

  MenuCatgeoryReportPrint(this.indexFetch, this.MenuCategoryList);

  @override
  _MenuCatgeoryReportPrintState createState() =>
      _MenuCatgeoryReportPrintState(this.indexFetch, this.MenuCategoryList);
}

class _MenuCatgeoryReportPrintState extends State<MenuCatgeoryReportPrint> {
  final int indexFetch;
  List<MenuCategory> MenuCategoryList = new List();

  _MenuCatgeoryReportPrintState(this.indexFetch, this.MenuCategoryList);

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
                'Menu Category No',
                'Menu Category Name',
              ],
              ...MenuCategoryList.map((data) => [
                data.MenuCatgoryId.toString(),
                data.MenuCatgoryName,
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
      DataCell(Text(MenuCategoryList[index].MenuCatgoryId.toString())),
      DataCell(Text(MenuCategoryList[index].MenuCatgoryName)),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < MenuCategoryList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }
}
