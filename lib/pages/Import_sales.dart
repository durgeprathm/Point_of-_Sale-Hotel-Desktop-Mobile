import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Adpater/EhotelAdapter/POS_Sales_Insert.dart';
import 'package:retailerp/utils/const.dart';
import 'package:csv/csv.dart' as csv;
import 'Add_Sales.dart';
import 'Manage_Sales.dart';
import 'dashboard.dart';

class ImportSales extends StatefulWidget {
  @override
  _ImportSalesState createState() => _ImportSalesState();
}

class _ImportSalesState extends State<ImportSales> {
  var _selectedCSVFilepath;
  List<List<dynamic>> data = [];
  SalesInsert salesInsert = new SalesInsert();

  void handleClick(String value) {
    switch (value) {
      case 'Add Sales':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddSales()));
        break;
      case 'Manage Sales':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ManageSales()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.fileImport),
            SizedBox(
              width: 20.0,
            ),
            Text('Import Sales'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return RetailerHomePage();
              }));
            },
          ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Add Sales',
                'Manage Sales',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    importProduct,
                    style: labelGrayTextStyle,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        'File Upload:',
                        style: labelTextStyle,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      FlatButton(
                        onPressed: () async {
                          await getCSVFile();
                        },
                        child: Text('Choose File', style: flatbtnTextStyle),
                        textColor: PrimaryColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: PrimaryColor,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Only Dot CSV File Upload.',
                    style: labelTextStyle,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Material(
                    elevation: 5.0,
                    color: PrimaryColor,
                    borderRadius: BorderRadius.circular(15.0),
                    child: MaterialButton(
                      onPressed: () async {
                        if (_selectedCSVFilepath != null) {
                          loadAsset(_selectedCSVFilepath);
                        } else {
                          Fluttertoast.showToast(
                            msg: "Choose CSV file Before Proceeding!!!",
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: PrimaryColor,
                            textColor: Color(0xffffffff),
                            gravity: ToastGravity.BOTTOM,
                          );
                        }
                      },
                      minWidth: 150,
                      height: 25.0,
                      child: Text(
                        'Upload',
                        style: btnHeadTextStyle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getCSVFile() async {
    print('csv Call');
    FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
      invalidFileNameSymbols: ['/'],
    );
    _selectedCSVFilepath =
        await FlutterDocumentPicker.openDocument(params: params);
    print('path File: $_selectedCSVFilepath');
    setState(() {
      _selectedCSVFilepath;
    });
    // loadAsset(path);
  }

  loadAsset(_filePath) async {
    final File file = await File('$_filePath');

    final mydata = await file.readAsString();
    List<List<dynamic>> csvTable = csv.CsvToListConverter().convert(mydata);

    data = csvTable;

    for (int i = 1; i < csvTable.length; i++) {
      String pCustName = csvTable[i][0];
      String pDatetext = csvTable[i][1];
      String saleProductName = csvTable[i][2];
      String saleProductRate = csvTable[i][3];
      String saleProductQty = csvTable[i][4];
      String saleProductSubTotal = csvTable[i][5];
      int pSubTotal = csvTable[i][6];
      int pDiscount = csvTable[i][7];
      int pGst = csvTable[i][8];
      int pMiscellaneons = csvTable[i][9];
      int pTotalAmounttext = csvTable[i][10];
      String pNarration = csvTable[i][11];
      String paymentModeorg = csvTable[i][12];

      // insert on server

      // var result = await salesInsert.getpossalesinsert(
      //     pCustName,
      //     pDatetext.toString(),
      //     saleProductName,
      //     saleProductRate,
      //     saleProductQty,
      //     saleProductSubTotal,
      //     pSubTotal.toString(),
      //     pDiscount.toString(),
      //     pGst.toString(),
      //     pTotalAmounttext.toString(),
      //     pNarration,
      //     paymentModeorg);

      // print('$result');
    }
    _showAlertDialog('Status', 'Sales Saved Successfully');
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
