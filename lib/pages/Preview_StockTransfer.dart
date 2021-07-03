import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/EhotelModel/StockTransfer.dart';


class PreviewStockTransfer extends StatefulWidget {
  PreviewStockTransfer(this.indexFetch,this.StockTransferFetch);
  @override
  final int indexFetch;
  List<StockTranfer> StockTransferFetch = new List();
  _PreviewStockTransferState createState() => _PreviewStockTransferState();
}

class _PreviewStockTransferState extends State<PreviewStockTransfer> {
  @override
  int PreviewStockTransferId;
  String PreviewStockTransferDepartmentName;
  String PreviewStockTransferDate;
  String PreviewStockTransferProductName;
  String PreviewStockTransferProductQty;
  String PreviewStockTransferNarration;

  var tempProductName,tempProductQTY;


  @override
  void initState() {
    PreviewStockTransferDepartmentName=widget.StockTransferFetch[widget.indexFetch].StockTranferDepartmentname;
    PreviewStockTransferDate=widget.StockTransferFetch[widget.indexFetch].StockTranferDate;
    PreviewStockTransferProductName=widget.StockTransferFetch[widget.indexFetch].StockTranferProductName;
    PreviewStockTransferProductQty=widget.StockTransferFetch[widget.indexFetch].StockTranferProductQty;
    PreviewStockTransferNarration=widget.StockTransferFetch[widget.indexFetch].StockTranferNarration;
    print(PreviewStockTransferProductName);
    print(PreviewStockTransferProductQty);
    tempProductName = PreviewStockTransferProductName.split("#");
    print(tempProductName);
    tempProductQTY = PreviewStockTransferProductQty.split("#");
    print(tempProductQTY);

    print(tempProductName);
    print(tempProductQTY);

  }
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;
  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery
        .of(context)
        .size
        .shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobilePreviewStockTransfer();
    } else {
      content = _buildTabletPreviewStockTransfer();
    }

    return content;
  }
//-------------------------------------------
//---------------Tablet Mode Start-------------//
  Widget _buildTabletPreviewStockTransfer() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.stackExchange),
            SizedBox(
              width: 20.0,
            ),
            Text('Stock No:- $PreviewStockTransferId '),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Material(
            shape: Border.all(color: Colors.blueGrey, width: 5),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          //color: Colors.lightBlueAccent,
                          child: Column(
                            children: [
                              Text(
                                "$PreviewStockTransferDepartmentName",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          //color: Colors.lightBlueAccent,
                          child: Column(
                            children: [
                              Text(
                                "$PreviewStockTransferDate",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.blueGrey,
                thickness: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DataTable(columns: [
                  DataColumn(
                      label: Expanded(
                        child: Container(
                          child: Text('Product Name',
                              style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      )),
                  DataColumn(
                      label: Expanded(
                        child: Container(
                          width: 200,
                          child: Text('Product Quntity',
                              style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      )),
                ],
                  rows: getDataRowList(),
                ),
              ),
              Divider(
                color: Colors.blueGrey,
                thickness: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Narration:- $PreviewStockTransferNarration",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobilePreviewStockTransfer() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.stackExchange),
            SizedBox(
              width: 20.0,
            ),
            Text('Stock No :- $PreviewStockTransferId '),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 8.0),
          child: Material(
            shape: Border.all(color: Colors.blueGrey, width: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            //color: Colors.lightBlueAccent,
                            child: Column(
                              children: [
                                Text(
                                  "$PreviewStockTransferDepartmentName",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            //color: Colors.lightBlueAccent,
                            child: Column(
                              children: [
                                Text(
                                  "$PreviewStockTransferDate",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.blueGrey,
                  thickness: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 5.0),
                  child: Center(
                    child: DataTable(columns: [
                      DataColumn(
                          label: Expanded(
                            child: Container(
                              child: Text('Product Name',
                                  style:
                                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            ),
                          )),
                      DataColumn(
                          label: Expanded(
                            child: Container(
                              // width: 200,
                              child: Text('Product Quntity',
                                  style:
                                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            ),
                          )),
                    ],
                      rows: getDataRowList(),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.blueGrey,
                  thickness: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Narration:- $PreviewStockTransferNarration",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
//---------------Mobile Mode End-------------//



  DataRow getRow(int index){
    return DataRow(cells: [
      DataCell(Text(tempProductName[index].toString())),
      DataCell(Text(tempProductQTY[index])),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < tempProductName.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

}
