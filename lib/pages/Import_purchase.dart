import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/POS_Purchase_Insert.dart';
import 'package:retailerp/utils/const.dart';
import 'Add_Supliers.dart';
import 'Add_purchase.dart';
import 'Manage_Purchase.dart';
import 'Manage_Suppliers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:csv/csv.dart' as csv;

class ImportPurchase extends StatefulWidget {
  @override
  _ImportPurchaseState createState() => _ImportPurchaseState();
}

class _ImportPurchaseState extends State<ImportPurchase> {
  var _selectedCSVFilepath;
  List<List<dynamic>> data = [];
  PurchaseInsert purchaseinsert = new PurchaseInsert();

  void handleClick(String value) {
    switch (value) {
      case 'Add Purchase':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddPurchase()));
        break;
      case 'Manage Purchase':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Managepurchase()));
        break;
      case 'Add Supplier':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddSupplierDetails()));
        break;
      case 'Manage Suppliers':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ManageSuppliers()));
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
            Text('Import Purchase'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Add Purchase',
                'Manage Purchase',
                'Add Supplier',
                'Manage Suppliers',
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
                            backgroundColor: Colors.black38,
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
      String pCompanyName = csvTable[i][0];
      String pDatetext = csvTable[i][1];

      // var inputFormat = DateFormat("dd-MM-yyyy");
      // var date1 = inputFormat.parse("$pDatetext");
      //
      // var outputFormat = DateFormat("yyyy-MM-dd");
      // var date2 = outputFormat.parse("$date1");
      //
      // print('$date2');

      String purchaseProductName = csvTable[i][2];
      String purchaseProductRate = csvTable[i][3];
      String purchaseProductQty = csvTable[i][4];
      String purchaseProductSubTotal = csvTable[i][5];
      int pSubTotal = csvTable[i][6];
      int pDiscount = csvTable[i][7];
      int pGst = csvTable[i][8];
      int pMiscellaneons = csvTable[i][9];
      int pTotalAmounttext = csvTable[i][10];
      String pNarration = csvTable[i][11];

      // insert on server
      var result = await purchaseinsert.getpospurchaseinsert(
          pCompanyName,
          pDatetext.toString(),
          purchaseProductName,
          purchaseProductRate,
          purchaseProductQty,
          purchaseProductSubTotal,
          pSubTotal.toString(),
          pDiscount.toString(),
          pGst.toString(),
          pMiscellaneons.toString(),
          pTotalAmounttext.toString(),
          pNarration);


      print('$result');
    }
    _showAlertDialog('Status', 'Purchase Saved Successfully');
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
