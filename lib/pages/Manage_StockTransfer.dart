import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_stocktransfer_fetch.dart';
import 'package:retailerp/Adpater/pos_stocktransfer_delete.dart';
import 'package:retailerp/EhotelModel/StockTransfer.dart';
import 'package:retailerp/utils/const.dart';



import 'Department_Dashboard.dart';
import 'Preview_StockTransfer.dart';
import 'Stock_Send.dart';
import 'dashboard.dart';

class ManageStockTranfer extends StatefulWidget {
  @override
  _ManageStockTranferState createState() => _ManageStockTranferState();
}

class _ManageStockTranferState extends State<ManageStockTranfer> {


  StockTransferFetch  stocktransferfetch = new StockTransferFetch();

  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;
  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileManageStockTranfer();
    } else {
      content = _buildTabletManageStockTranfer();
    }

    return content;
  }
//-------------------------------------------

  //DatabaseHelper databaseHelper = DatabaseHelper();
  List<StockTranfer> StockTranferList = new List();
  int count;


  @override
  void initState() {
    //ShowSalesdetails();
    _getStockTransfer();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletManageStockTranfer() {
    void handleClick(String value) {
      switch (value) {
        case 'Add Stock Transfer':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StockSend()));
          break;
        case 'Department':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DepartmentDashboard()));

          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.shoppingBag),
            SizedBox(
              width: 20.0,
            ),
            Text('Manage Stock'),
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
                'Add Stock Transfer',
                'Department',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: StockTranferList.length == 0
                ?
            // ? Padding(
            //     padding: const EdgeInsets.all(70.0),
            //     child: Material(
            //       shape: Border.all(color: Colors.blueGrey, width: 5),
            //       child: Padding(
            //         padding: const EdgeInsets.all(40.0),
            //         child: Text(
            //           "No Record Found !",
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 50.0,
            //               color: Colors.red),
            //         ),
            //       ),
            //     ),
            //   )
            Center(child: CircularProgressIndicator())
                : DataTable(columns: [
              DataColumn(
                  label: Expanded(
                    child: Container(
                      width: 150,
                      child: Text('Stock No',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  )),
              DataColumn(
                  label: Expanded(
                    child: Container(
                      width: 200,
                      child: Text('Department Name',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  )),
              DataColumn(
                  label: Expanded(
                    child: Container(
                      child: Text('Date',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  )),
              DataColumn(
                label: Expanded(
                  child: Container(
                    width: 50,
                    child: Text('Action',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ], rows: getDataRowList()),
          ),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobileManageStockTranfer() {
    void handleClick(String value) {
      switch (value) {
        case 'Add Stock Transfer':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StockSend()));
          break;
        case 'Department':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DepartmentDashboard()));

          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.shoppingBag),
            SizedBox(
              width: 20.0,
            ),
            Text('Manage Stock'),
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
                'Add Stock Transfer',
                'Department',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: StockTranferList.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: StockTranferList.length,
                itemBuilder: (context, index) {
                  print("//in index////$index");
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Stock Transfer Id: ${StockTranferList[index].StockTranferid.toString()} ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "Department Name:",
                              style: headHintTextStyle,
                            ),
                            Text("${StockTranferList[index].StockTranferDepartmentname}",
                                style: headsubTextStyle),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text("Transfer Date:",
                                style: headHintTextStyle),
                            Text(
                                "${StockTranferList[index].StockTranferDate.toString()}",
                                style: headsubTextStyle),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PreviewStockTransfer(
                                            index, StockTranferList)));
                              },
                              icon: Icon(
                                Icons.preview,
                                color: Colors.blue,
                              ),
                            ),
                            // IconButton(
                            //   onPressed: () {
                            //     // Navigator.push(
                            //     //     context,
                            //     //     MaterialPageRoute(
                            //     //         builder: (context) =>
                            //     //             EditSaleScreenNew(
                            //     //                 index, StockTranferList)));
                            //   },
                            //   icon: Icon(
                            //     Icons.edit,
                            //     color: Colors.green,
                            //   ),
                            // ),
                            // IconButton(
                            //   onPressed: () {
                            //     _showMyDialog(StockTranferList[index].StockTranferid);
                            //   },
                            //   icon: Icon(
                            //     Icons.delete,
                            //     color: Colors.red,
                            //   ),
                            // ),
                          ],
                        ),
                        Divider()
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
//---------------Mobile Mode End-------------//

  DataRow getRow(int index) {
    int srNo = index + 1;
    return DataRow(cells: [
      DataCell(Text(srNo.toString())),
      DataCell(Text(StockTranferList[index].StockTranferDepartmentname)),
      DataCell(Text(StockTranferList[index].StockTranferDate)),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.preview,
              ),
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PreviewStockTransfer(index, StockTranferList)));
              },
            ),
            // IconButton(
            //   icon: Icon(
            //     Icons.edit,
            //   ),
            //   color: Colors.green,
            //   onPressed: () {
            //     // Navigator.push(
            //     //     context,
            //     //     MaterialPageRoute(
            //     //         builder: (context) => EditSales(index, StockTranferList)));
            //   },
            // ),
            // IconButton(
            //   icon: Icon(
            //     Icons.delete,
            //   ),
            //   color: Colors.red,
            //   onPressed: () {
            //     _showMyDialog(StockTranferList[index].StockTranferid);
            //   },
            // ),
          ],
        ),
      ),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < StockTranferList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  Future<void> _showMyDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              "Want To Delete!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Delete'),
                onPressed: () async {
                  StockTransferDelete stocktransferdelete =new StockTransferDelete();
                  var result = await stocktransferdelete.getStockTransferDelete(id.toString());
                  print("//////////////////Print result//////$result");
                  print("///delete id///$id");
                  Navigator.of(context).pop();
                  _getStockTransfer();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //-------------------------------------
//from server fetching sales data
   void _getStockTransfer() async {
    var stocktransferData = await stocktransferfetch.getStockTransferFetch();
     var resid = stocktransferData["resid"];
    var stocktransfersd = stocktransferData["stocktranferlist"];
    List<StockTranfer> tempstocktransfer = [];
    for (var n in stocktransfersd) {
      StockTranfer pro = StockTranfer.yes(
            n["DepartmentName"],
            n["StockTransferDate"],
            n["ProductName"],
            n["productQuntitySum"],
          n["StockTransferNarration"],
        int.parse(n["StockTransferDepartmentid"]));
      tempstocktransfer.add(pro);
    }
    setState(() {
      this.StockTranferList = tempstocktransfer;
    });
    print("//////StockTranferList/////////$StockTranferList.length");
   }
//-------------------------------------

}
