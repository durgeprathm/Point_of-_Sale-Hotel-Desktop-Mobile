import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/models/Sales.dart';

class AllUPIReportPrint extends StatefulWidget {
  final int indexFetch;
  List<EhotelSales> UPIList = new List();
  double totalsale;
  AllUPIReportPrint(this.indexFetch, this.UPIList,this.totalsale);

  @override
  _AllUPIReportPrintState createState() =>
      _AllUPIReportPrintState(this.indexFetch, this.UPIList);
}

class _AllUPIReportPrintState extends State<AllUPIReportPrint> {
  final int indexFetch;
  List<EhotelSales> UPIList = new List();

  _AllUPIReportPrintState(this.indexFetch, this.UPIList);

  final pdf = pw.Document();
  var imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All UPI Report"),
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
              padding: pw.EdgeInsets.symmetric(horizontal: 4.0),
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Poonam POS'),
                    pw.Text('Paymode: UPI'),
                    pw.SizedBox(height: 5),
                    pw.Table.fromTextArray(context: context, data: <List<String>>[
                      <String>[
                        'Bill No',
                        'Date',
                        'Dis',
                        'Total\nAmt',
                      ],
                      ...UPIList.map((data) =>
                      [
                        data.menusalesid.toString(),
                        data.medate,
                        data.discount,
                        data.totalamount,
                      ])
                    ]),

                    pw.Text('Total Amount: ${widget.totalsale.toString()}'),

                  ]));
        },
      ),
    );

    return pdf.save();
  }
}
