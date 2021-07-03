import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GenratedBarCodeScreen extends StatefulWidget {
  final String companyName;
  final String mobNo;
  final String proName;
  final String packingDate;
  final String proPrice;

  GenratedBarCodeScreen(this.companyName, this.mobNo, this.proName,
      this.packingDate, this.proPrice);

  @override
  _GenratedBarCodeScreenState createState() => _GenratedBarCodeScreenState(
      this.companyName,
      this.mobNo,
      this.proName,
      this.packingDate,
      this.proPrice);
}

class _GenratedBarCodeScreenState extends State<GenratedBarCodeScreen> {
  String companyName;
  String mobNo;
  String proName;
  String packingDate;
  String proPrice;

  _GenratedBarCodeScreenState(this.companyName, this.mobNo, this.proName,
      this.packingDate, this.proPrice);

  final tempDir = getTemporaryDirectory();
  File _image;
  String title = "Banaana Produt";
  GlobalKey globalKey = new GlobalKey();
  PdfImage image;

  @override
  void initState() {
    super.initState();
    _captureAndSharePng();
  }

  final pdf = pw.Document();
  var imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Barcode"),
      ),
      body: PdfPreview(
        build: (format) => _generatePdf(format, title),
      ),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      final tempDir = await getTemporaryDirectory();

      setState(() {
        _image = File('${tempDir.path}/barcode.png');
        imageProvider = FileImage(_image);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    image = await pdfImageFromImageProvider(
        pdf: pdf.document, image: imageProvider);

    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(5),
        pageFormat: format,
        build: (context) {
          return pw.Container(
              width: 100,
              height: 100,
              decoration: pw.BoxDecoration(
                  border: pw.BoxBorder(
                    color: PdfColor.fromInt(0xff275E94),
                  ),
                  shape: pw.BoxShape.rectangle,
                  borderRadius: 0.5),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.SizedBox(height: 2),
                  pw.Text('$companyName', style: pw.TextStyle(fontSize: 5)),
                  pw.SizedBox(height: 2),
                  pw.Text('Mob No: $mobNo', style: pw.TextStyle(fontSize: 5)),
                  pw.SizedBox(height: 2),
                  pw.Text('$proName', style: pw.TextStyle(fontSize: 5)),
                  pw.SizedBox(height: 2),
                  pw.Text('MRP: $proPrice', style: pw.TextStyle(fontSize: 5)),
                  pw.SizedBox(height: 2),
                  pw.Text('PACKING DATE: $packingDate',
                      style: pw.TextStyle(fontSize: 5)),
                  pw.SizedBox(height: 2),
                  image != null
                      ? pw.Image(image, height: 12, width: 24)
                      : pw.Text("NO Data")
                ],
              ));
        },
      ),
    );

    return pdf.save();
  }
}
