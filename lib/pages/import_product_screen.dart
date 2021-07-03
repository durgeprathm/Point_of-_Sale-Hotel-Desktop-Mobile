import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/LocalDbModels/product_rate.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/popup_menu.dart';
import 'package:retailerp/providers/popup_menu_item.dart';
import 'package:retailerp/utils/const.dart';
import 'package:csv/csv.dart' as csv;
import 'package:flutter/services.dart' show rootBundle;

class ImportProductScreen extends StatefulWidget {
  @override
  _ImportProductScreenState createState() => _ImportProductScreenState();
}

class _ImportProductScreenState extends State<ImportProductScreen> {
  PopupMenu _selectedMenu = productPopupMenu3[0];
  List<List<dynamic>> data = [];
  List<ProductModel> prodModelList = List<ProductModel>();
  var _selectedCSVFilepath;

  // final picker = FilePicker();

  loadAsset(_filePath) async {
    final File file = await File('$_filePath');

    final mydata = await file.readAsString();

    // final mydata = await rootBundle.loadString(path);
    // final mydata = await rootBundle.loadString("assets/sample_csv2.csv");
    //
    // print(mydata);
    List<List<dynamic>> csvTable = csv.CsvToListConverter().convert(mydata);
    DatabaseHelper databaseHelper = DatabaseHelper();
    data = csvTable;

    for (int i = 1; i < csvTable.length; i++) {
      String _proType = csvTable[i][0];
      int _code = csvTable[i][1];
      String _productName = csvTable[i][2];
      String _productComName = csvTable[i][3];
      String _proCatName = csvTable[i][4];
      int _catId = await databaseHelper.getProdIntId(_proCatName);
      // var _balStock = csvTable[i][3];
      double _sp = csvTable[i][5];
      int _HSNCode = csvTable[i][6];
      String _tax = csvTable[i][7];
      String _unit = csvTable[i][8];
      int _openBal = csvTable[i][9];
      String _billMethod = csvTable[i][10];
      int _intgratedTax = csvTable[i][11];
      String _proDate = csvTable[i][12];
      //
      //   // prodModelList.add(new ProductModel(
      //   //     '',
      //   //     0,
      //   //     _productName,
      //   //     '',
      //   //     '',
      //   //    null,
      //   //     null,
      //   //     0,
      //   //     '',
      //   //     '',
      //   //     '',
      //   //     '',
      //   //     0,
      //   //     '',
      //   //     '',
      //   //     ''));
      //
      var result = await databaseHelper.insertProduct(new ProductModel(
          _proType,
          _code,
          _productName,
          _productComName,
          _proCatName,
          _catId,
          null,
          _sp,
          _HSNCode.toString(),
          _tax,
          '',
          _unit,
          _openBal,
          _billMethod,
          _intgratedTax.toString(),
          _proDate));
      if (result != 0) {
        // Success
        await databaseHelper.insertProductRate(ProductRate(result, _productName,
            _proCatName, _proDate, _sp, _catId));
      }
    }
    print('ProModel Size: ${prodModelList.length}');
    prodModelList.forEach((element) {
      print(element.proName);
    });

    _showAlertDialog('Status', 'Products Saved Successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Import Product List'),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
              // Navigator.pop(context);
              // MyNavigator.goToDashboard(context);
            },
          ),
          new PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              size: 28,
              color: Colors.white,
            ),
            itemBuilder: (BuildContext context) {
              return productPopupMenu3.map((PopupMenu popupMenu) {
                return new PopupMenuItem(
                    value: popupMenu,
                    child: new ListTile(
                      dense: true,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      leading: popupMenu.icon,
                      title: new Text(popupMenu.title),
                    ));
              }).toList();
            },
            onSelected: _selectedPopMenu,
          )
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
                          print(data);
                          // await loadAsset();
                          // data.removeAt(0);
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
                        style: btnTextStyle,
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

  void _selectedPopMenu(PopupMenu popupMenu) {
    setState(() {
      _selectedMenu = popupMenu;
      print(_selectedMenu.title);
    });
  }

  List<List> csvToList(File myCsvFile) {
    csv.CsvToListConverter c = new csv.CsvToListConverter(
      eol: "\r\n",
      fieldDelimiter: ",",
      shouldParseNumbers: true,
    );
    List<List> listCreated = c.convert(myCsvFile.readAsStringSync());
    return listCreated;
  }

  Future getCSVFile() async {
    print('csv Call');
    // FilePickerResult result = await FilePicker.platform.pickFiles(
    //   allowedExtensions: ['csv'],
    //   type: FileType.custom,
    // );
    // With parameters:
    FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
      // allowedFileExtensions: ['csv'],
      // allowedMimeTypes: ['application/*'],
      invalidFileNameSymbols: ['/'],
    );
    _selectedCSVFilepath =
        await FlutterDocumentPicker.openDocument(params: params);
    // final String pptPath = await FlutterDocumentPicker.openDocument(
    //     params: FlutterDocumentPickerParams(
    //   allowedFileExtensions: ['csv'],
    //   allowedMimeTypes: ['application/*'],
    // ));

    print('path File: $_selectedCSVFilepath');

    // if (pptPath != null) {
    //   // PlatformFile file = result.files.first;
    //   // File newFile = new File(file.path);
    //   final input = new File(pptPath).openRead();

    // }
    setState(() {
      _selectedCSVFilepath;
    });
    // loadAsset(path);
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
