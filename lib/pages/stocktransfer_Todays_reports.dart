import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_stocktransfer_todays_fetch_.dart';
import 'package:retailerp/pages/stocktransfer_Monthly_reports.dart';
import 'Todays_stock_transfer_reports_print.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/EhotelModel/StockTransfer.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/pages/Manage_Sales.dart';
import 'package:retailerp/pages/edit_sales_screen_new.dart';
import 'package:retailerp/utils/const.dart';

import 'Add_Sales.dart';
import 'Import_sales.dart';
import 'Preview_sales.dart';
import 'Todays_Reports_Print.dart';

class StockTransferTodayReports extends StatefulWidget {
  @override
  _StockTransferTodayReportsState createState() => _StockTransferTodayReportsState();
}

class _StockTransferTodayReportsState extends State<StockTransferTodayReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileStockTransferTodayReports();
    } else {
      content = _buildTabletStockTransferTodayReports();
    }

    return content;
  }

//-------------------------------------------
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  final format = DateFormat("yyyy-MM-dd");
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;
  String _selectdate;
  String PaymentMode;

  //DatabaseHelper databaseHelper = DatabaseHelper();
  List<StockTranfer> TodayStockTransferList = new List();
  List<StockTranfer> TodayStockTransferListSearch = new List();
  TextEditingController SerachController = new TextEditingController();
  List<int> indexList = [];



  @override
  void initState() {
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    _getTodaysStockTransfer(_selectdate);
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletStockTransferTodayReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.30;
    void handleClick(String value) {
      switch (value) {
        case 'Over All Stock Transfer Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StockTransferMonthlyReports()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.calendar),
            SizedBox(
              width: 20.0,
            ),
            Text('Today\'s Stock Transfer Report'),
          ],
        ),
        actions: [
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Container(
              //width: tabletWidth,
                child: Text("Today\'s Date:- $_selectdate",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
          ),
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          TodayStockTransferList.length != 0
              ? IconButton(
            icon: Icon(Icons.print, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return TodaysStockTransferReportPrint(TodayStockTransferList);
              }));
            },
          )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Over All Stock Transfer Reports',
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
            child: TodayStockTransferList.length == 0
                ?
                Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: tabletWidthSearch,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: TextField(
                                controller: SerachController,
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                                decoration: InputDecoration(
                                    hintText: "Start typing here..",
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.search),
                                      color: PrimaryColor,
                                      onPressed: () {},
                                    )),
                              ),
                            ),
                          ),
                          // Container(
                          //   width: tabletWidth,
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(
                          //         vertical: 10.0, horizontal: 20.0),
                          //     child: DropdownSearch(
                          //       isFilteredOnline: true,
                          //       showClearButton: true,
                          //       showSearchBox: true,
                          //       items:[
                          //         "All",
                          //         "CASH",
                          //         "DEBIT",
                          //         "UPI",
                          //       ],
                          //       label: "Payment Mode",
                          //       autoValidateMode:
                          //       AutovalidateMode.onUserInteraction,
                          //       onChanged: (value) {
                          //         PaymentMode = value;
                          //         if(PaymentMode=="All" ||PaymentMode==null)
                          //         {
                          //           _getTodaysBill(_selectdate);
                          //         }else
                          //         {
                          //           // _getSalesPaymentMode(PaymentMode,_selectdate);
                          //         }
                          //
                          //         print(PaymentMode);
                          //       },
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DataTable(columns: [
                          DataColumn(
                              label: Expanded(
                            child: Container(
                              width: 60,
                              child: Text('Sr No',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Container(
                              width: 200,
                              child: Text('Department Name',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Container(
                              child: Text('Product Name',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Container(
                              child: Text('Product Quntity',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )),
                        ], rows: getDataRowList()),
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
  Widget _buildMobileStockTransferTodayReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Over All Stock Transfer Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StockTransferMonthlyReports()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.calendar),
            SizedBox(
              width: 20.0,
            ),
            Text('Today\'s Bill'),
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
          TodayStockTransferList.length != 0
              ? IconButton(
            icon: Icon(Icons.print, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return TodaysStockTransferReportPrint(TodayStockTransferList);
              }));
            },
          )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Over All Stock Transfer Reports',
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
            child: TodayStockTransferList.length == 0
                ?
                // ? Padding(
                //     padding: const EdgeInsets.all(40.0),
                //     child: Material(
                //       shape: Border.all(color: Colors.blueGrey, width: 5),
                //       child: Padding(
                //         padding: const EdgeInsets.all(40.0),
                //         child: Text(
                //           "No Record Found !",
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 30.0,
                //               color: Colors.red),
                //         ),
                //       ),
                //     ),
                //   )
                Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: TodayStockTransferList.length,
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
                                    "Sr No: ${TodayStockTransferList[index].StockTranferid.toString()} ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${TodayStockTransferList[index].StockTranferDate}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18.0,
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
                                  "Department Name: ",
                                  style: headHintTextStyle,
                                ),
                                Text(
                                    "${TodayStockTransferList[index].StockTranferDepartmentname}",
                                    style: headsubTextStyle),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Text("Product Name:      ",
                                    style: headHintTextStyle),
                                Text(
                                    "${TodayStockTransferList[index].StockTranferProductName.toString()}",
                                    style: headsubTextStyle),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Text("Product Quntity:      ",
                                    style: headHintTextStyle),
                                Text(
                                    "${TodayStockTransferList[index].StockTranferProductQty.toString()}",
                                    style: headsubTextStyle),
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
    return DataRow(cells: [
      DataCell(Text((index+1).toString())),
      DataCell(Text(TodayStockTransferList[index].StockTranferDepartmentname)),
      DataCell(Text(TodayStockTransferList[index].StockTranferProductName)),
      DataCell(Text(TodayStockTransferList[index].StockTranferProductQty.toString())),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < TodayStockTransferList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }



  //-------------------------------------
//from server fetching sales data
  void _getTodaysStockTransfer(String TodaysDate) async {
    StockTarnsferDataFetch stocktarnsferdatafetch = new StockTarnsferDataFetch();

    var stocktarnsferdataData = await stocktarnsferdatafetch.getStockTarnsferDataFetch("1",TodaysDate);
    var resid = stocktarnsferdataData["resid"];
    var stocktarnsferdatasd = stocktarnsferdataData["stocktranferlist"];
    print(stocktarnsferdatasd.length);
    List<StockTranfer> tempstocktarnsferdatasd = [];
    for (int i=0;i<stocktarnsferdatasd.length;i++) {
      StockTranfer pro = StockTranfer(
          (i+1),
          int.parse(stocktarnsferdatasd[i]["StockTransferid"]),
          stocktarnsferdatasd[i]["DepartmentName"],
          stocktarnsferdatasd[i]["StockTransferDate"],
          stocktarnsferdatasd[i]["ProductName"],
          stocktarnsferdatasd[i]["productQuntitySum"],
          stocktarnsferdatasd[i]["StockTransferNarration"]);
      tempstocktarnsferdatasd.add(pro);
    }
    setState(() {
      this.TodayStockTransferList = tempstocktarnsferdatasd;
      this.TodayStockTransferListSearch = tempstocktarnsferdatasd;
    });
    print("//////TodayStockTransferList/////////$TodayStockTransferList.length");




    SerachController.addListener(() {
      setState(() {
        if (TodayStockTransferListSearch != null) {
          String s = SerachController.text;
          TodayStockTransferList = TodayStockTransferListSearch.where((element) =>
          element.StockTranferid.toString()
              .toLowerCase()
              .contains(s.toLowerCase()) ||
              element.StockTranferDepartmentname.toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.StockTranferProductName.toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.StockTranferProductQty.toLowerCase().contains(s.toLowerCase()) ).toList();
        }
      });
    });






  }
}
