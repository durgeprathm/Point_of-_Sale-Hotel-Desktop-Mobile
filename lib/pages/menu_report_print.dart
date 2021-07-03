import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/models/Purchase.dart';
import 'package:retailerp/models/menu.dart';

class MenuReportPrint extends StatefulWidget {
  final int indexFetch;
  List<Menu> MenuList = new List();

  MenuReportPrint(this.indexFetch, this.MenuList);

  @override
  _MenuReportPrintState createState() =>
      _MenuReportPrintState(this.indexFetch, this.MenuList);
}

class _MenuReportPrintState extends State<MenuReportPrint> {
  final int indexFetch;
  List<Menu> MenuList = new List();

  _MenuReportPrintState(this.indexFetch, this.MenuList);

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
                'Menu No',
                'Menu Name',
                'Menu Category',
                'Menu Rate',
              ],
              ...MenuList.map((data) => [
                data.id.toString(),
                data.menuName,
                data.menucategory,
                data.menuRate,
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
      DataCell(Text(MenuList[index].id.toString())),
      DataCell(Text(MenuList[index].menuName)),
      DataCell(Text(MenuList[index].menucategory)),
      DataCell(Text(MenuList[index].menuRate.toString()))
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < MenuList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }
}
