import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_consumption_data.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_consumption_overall_data.dart';
import 'package:retailerp/pages/consumption_Todays_reports.dart';
import 'OverAll_consumption_report_print.dart';
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

class ConsumptionOverAllReports extends StatefulWidget {
  @override
  _ConsumptionOverAllReportsState createState() => _ConsumptionOverAllReportsState();
}

class _ConsumptionOverAllReportsState extends State<ConsumptionOverAllReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileConsumptionOverAllReports();
    } else {
      content = _buildTabletConsumptionOverAllReports();
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
  List<Consumption> OverAllConsumptionList = new List();
  List<Consumption> OverAllConsumptionListSearch = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;


  @override
  void initState() {
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    _getConsumptionOverAllData();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletConsumptionOverAllReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.30;
    void handleClick(String value) {
      switch (value) {
        case 'Today\'s Consumption Report':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ConsumptionTodayReports()));
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
            Text('Over All Consumption Report'),
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
          OverAllConsumptionList.length != 0
              ? IconButton(
            icon: Icon(Icons.print, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return OverAllConsumptionReportPrint(1, OverAllConsumptionList);
              }));
            },
          )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Today\'s Consumption Report',
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
            child: OverAllConsumptionList.length == 0
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
  Widget _buildMobileConsumptionOverAllReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Today\'s Consumption Report':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ConsumptionTodayReports()));
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
          OverAllConsumptionList.length != 0
              ? IconButton(
            icon: Icon(Icons.print, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return OverAllConsumptionReportPrint(1, OverAllConsumptionList);
              }));
            },
          )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Today\'s Consumption Report',
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
            child: OverAllConsumptionList.length == 0
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
                    itemCount: OverAllConsumptionList.length,
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
                                    "Sr No: ${OverAllConsumptionList[index].consumption_id.toString()} ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${OverAllConsumptionList[index].consumption_Date}",
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
                                    "${OverAllConsumptionList[index].consumption_Department_Name}",
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
                                    "${OverAllConsumptionList[index].consumption_Product_Name.toString()}",
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
                                    "${OverAllConsumptionList[index].consumption_Quntity.toString()}",
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
                                    "${OverAllConsumptionList[index].consumption_Opening_Balance.toString()}",
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
      DataCell(Text(OverAllConsumptionList[index].srno.toString())),
      DataCell(Text(OverAllConsumptionList[index].consumption_Department_Name)),
      DataCell(Text(OverAllConsumptionList[index].consumption_Product_Name)),
      DataCell(Text(OverAllConsumptionList[index].consumption_Quntity.toString())),
      DataCell(Text(OverAllConsumptionList[index].consumption_Opening_Balance)),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < OverAllConsumptionList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }



  //-------------------------------------
//from server fetching sales data
  void _getConsumptionOverAllData() async {
    ConsumptionOverAllFetch consumptionoverallfetch = new ConsumptionOverAllFetch();

    var ConsumptionoverallData = await consumptionoverallfetch.getConsumptionDataFetch();
    var resid = ConsumptionoverallData["resid"];
    var ConsumptionoverallDatasd = ConsumptionoverallData["consumptionlist"];
    List<Consumption> tempConsumption = [];
    for (int i=0;i<ConsumptionoverallDatasd.length;i++)  {
      Consumption pro = Consumption.withdep(
          (i+1),
          ConsumptionoverallDatasd[i]["productid"],
          ConsumptionoverallDatasd[i]["productname"],
          ConsumptionoverallDatasd[i]["productopeningbalance"],
          ConsumptionoverallDatasd[i]["productQuntitySum"],
          ConsumptionoverallDatasd[i]["DepartmentName"]);
      tempConsumption.add(pro);
    }
    setState(() {
      this.OverAllConsumptionList = tempConsumption;
      this.OverAllConsumptionListSearch = tempConsumption;
    });
    print("//////OverAllConsumptionList/////////$OverAllConsumptionList.length");


    SerachController.addListener(() {
      setState(() {
        if (OverAllConsumptionListSearch != null) {
          String s = SerachController.text;
          OverAllConsumptionList = OverAllConsumptionListSearch.where((element) =>
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
