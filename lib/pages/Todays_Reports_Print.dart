import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_shop_fetch.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/models/Shop.dart';
import 'package:retailerp/utils/const.dart';

class TodaysReportPrint extends StatefulWidget {
  final int indexFetch;
  final String date;
  final double totalbill;
  List<EhotelSales> TodaysList = new List();

  TodaysReportPrint(this.indexFetch,this.date, this.TodaysList,this.totalbill);

  @override
  _TodaysReportPrintState createState() =>
      _TodaysReportPrintState(this.indexFetch, this.TodaysList);
}

class _TodaysReportPrintState extends State<TodaysReportPrint> {
  final int indexFetch;
  List<EhotelSales> TodaysList = new List();
  List<Shop> ShopDetails = [];

  _TodaysReportPrintState(this.indexFetch, this.TodaysList);

  var imageProvider;

  // @override
  // void initState() {
  //   _getShopDetails();
  // }
  //
  // void _getShopDetails() async {
  //
  //   ShopFetch shopdatafetch = new ShopFetch();
  //   var ShopData = await shopdatafetch.getShopFetch("1");
  //   var resid = ShopData["resid"];
  //
  //   if (resid == 200) {
  //     var ShopDatasd = ShopData["shop"];
  //     print(ShopDatasd.length);
  //     List<Shop> tempShopDetails = [];
  //     for (var n in ShopDatasd) {
  //       Shop pro = Shop.Withoutlogo(
  //           int.parse(n["ShopId"]),
  //           n["ShopName"],
  //           n["ShopMobileNumber"],
  //           n["ShopOwnerName"],
  //           n["ShopEmail"],
  //           n["ShopGSTNumber"],
  //           n["ShopCINNumber"],
  //           n["ShopPANNumber"],
  //           n["ShopSSINNumber"],
  //           n["ShopAddress"]);
  //       tempShopDetails.add(pro);
  //     }
  //     setState(() {
  //       this.ShopDetails = tempShopDetails;
  //     });
  //     print("//////ShopDetails/////////$ShopDetails.length");
  //   } else {
  //     String msg = ShopData["message"];
  //     Fluttertoast.showToast(
  //       msg: msg,
  //       toastLength: Toast.LENGTH_SHORT,
  //       backgroundColor: PrimaryColor,
  //       textColor: Color(0xffffffff),
  //       gravity: ToastGravity.BOTTOM,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today\'s Debit Report"),
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
        build: (pw.Context context) {
          return pw.Padding(
            padding: pw.EdgeInsets.symmetric(horizontal: 10.0),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Date: ${widget.date}"),
                pw.SizedBox(height: 3.0),
                pw.Table.fromTextArray(context: context, data: <List<String>>[
                  <String>[
                    'Bill no',
                    'Cust Name',
                    'Dis',
                    'Total\nAmt',
                    'Mode'
                  ],
                  ...TodaysList.map((data) => [
                    data.menusalesid.toString(),
                    data.customername,
                    data.discount,
                    double.parse(data.totalamount).toStringAsFixed(2),
                    data.paymodename
                  ])

                ]),
                pw.Text("Total: ${widget.totalbill}"),
              ]) ) ;
        }
      ),
    );

    return pdf.save();
  }

  // DataRow getRow(int index) {
  //   return DataRow(cells: [
  //     DataCell(Text(TodaysList[index].menusalesid.toString())),
  //     DataCell(Text(TodaysList[index].customername)),
  //     DataCell(Text(TodaysList[index].medate)),
  //     DataCell(Text(TodaysList[index].totalamount.toString())),
  //     DataCell(Text(TodaysList[index].paymodename.toString()))
  //   ]);
  // }
  //
  // List<DataRow> getDataRowList() {
  //   List<DataRow> myTempDataRow = List();
  //   for (int i = 0; i < TodaysList.length; i++) {
  //     myTempDataRow.add(getRow(i));
  //   }
  //   return myTempDataRow;
  // }
}
