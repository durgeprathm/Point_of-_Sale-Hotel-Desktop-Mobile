import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_consumption_data.dart';
import 'package:retailerp/pages/consumption_overAll_reports.dart';
import 'Todays_consumption_report_print.dart';
import 'package:retailerp/Adpater/pos_sales_delete.dart';
import 'package:retailerp/EhotelModel/Consumption.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/pages/Manage_Sales.dart';
import 'package:retailerp/pages/edit_sales_screen_new.dart';
import 'package:retailerp/utils/const.dart';

import 'Add_Sales.dart';
import 'Import_sales.dart';
import 'Preview_sales.dart';
import 'Todays_Reports_Print.dart';

class ConsumptionTodayReports extends StatefulWidget {
  @override
  _ConsumptionTodayReportsState createState() => _ConsumptionTodayReportsState();
}

class _ConsumptionTodayReportsState extends State<ConsumptionTodayReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileConsumptionTodayReports();
    } else {
      content = _buildTabletConsumptionTodayReports();
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
  List<Consumption> TodayConsumptionList = new List();
  List<Consumption> TodaysConsumptionListSearch = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;


  @override
  void initState() {
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    _getConsumptionData(_selectdate);
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletConsumptionTodayReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.30;
    void handleClick(String value) {
      switch (value) {
        case 'Over All Consumption Report':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ConsumptionOverAllReports()));
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
            Text('Today\'s Consumption Reports'),
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
          TodayConsumptionList.length != 0
              ? IconButton(
            icon: Icon(Icons.print, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return TodaysConsumptionReportPrint(1, TodayConsumptionList);
              }));
            },
          )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Over All Consumption Report',
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
            child: TodayConsumptionList.length == 0
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
                              width: 50,
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
                          DataColumn(
                              label: Expanded(
                                child: Container(
                                  child: Text('Present Quntity',
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold)),
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
  Widget _buildMobileConsumptionTodayReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Over All Consumption Report':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ConsumptionOverAllReports()));
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
          TodayConsumptionList.length != 0
              ? IconButton(
            icon: Icon(Icons.print, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return TodaysConsumptionReportPrint(1, TodayConsumptionList);
              }));
            },
          )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Over All Consumption Report',
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
            child: TodayConsumptionList.length == 0
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
                    itemCount: TodayConsumptionList.length,
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
                                    "Sr No: ${TodayConsumptionList[index].consumption_id.toString()} ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${TodayConsumptionList[index].consumption_Date}",
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
                                    "${TodayConsumptionList[index].consumption_Department_Name}",
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
                                    "${TodayConsumptionList[index].consumption_Product_Name.toString()}",
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
                                    "${TodayConsumptionList[index].consumption_Quntity.toString()}",
                                    style: headsubTextStyle),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Text("Present Quntity:      ",
                                    style: headHintTextStyle),
                                Text(
                                    "${TodayConsumptionList[index].consumption_Opening_Balance.toString()}",
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
      DataCell(Text(TodayConsumptionList[index].consumption_id.toString())),
      DataCell(Text(TodayConsumptionList[index].consumption_Department_Name)),
      DataCell(Text(TodayConsumptionList[index].consumption_Product_Name)),
      DataCell(Text(TodayConsumptionList[index].consumption_Quntity.toString())),
      DataCell(Text(TodayConsumptionList[index].consumption_Opening_Balance)),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < TodayConsumptionList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }



  //-------------------------------------
//from server fetching sales data
  void _getConsumptionData(String TodaysDate) async {
    ConsumptionDataFetch consumptiondatafetch = new ConsumptionDataFetch();

    var ConsumptionData = await consumptiondatafetch.getConsumptionDataFetch("1",TodaysDate);
    var resid = ConsumptionData["resid"];
    var ConsumptionDatasd = ConsumptionData["consumptionlist"];
    print(ConsumptionDatasd.length);
    List<Consumption> tempConsumption = [];
    for (var n in ConsumptionDatasd) {
      Consumption pro = Consumption(
          int.parse(n["consumptionid"]),
          n["date"],
          n["Departmentid"],
          n["Departmentname"],
          n["productopeningbalance"],
          n["productid"],
          n["productname"],
          n["productquntity"],
          );
      tempConsumption.add(pro);
    }
    setState(() {
      this.TodayConsumptionList = tempConsumption;
      this.TodaysConsumptionListSearch = tempConsumption;
    });
    print("//////TodayConsumptionList/////////$TodayConsumptionList.length");


    SerachController.addListener(() {
      setState(() {
        if (TodaysConsumptionListSearch != null) {
          String s = SerachController.text;
          TodayConsumptionList = TodaysConsumptionListSearch.where((element) =>
          element.consumption_id.toString()
              .toLowerCase()
              .contains(s.toLowerCase()) ||
              element.consumption_Department_Name.toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.consumption_Product_Name.toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.consumption_Quntity.toLowerCase().contains(s.toLowerCase()) ||
              element.consumption_Opening_Balance.toString()
                  .toLowerCase()
                  .contains(s.toLowerCase())).toList();
        }
      });
    });






  }

}
