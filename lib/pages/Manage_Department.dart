import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Adpater/pos_Department_Delete.dart';
import 'package:retailerp/Adpater/pos_department_fetch.dart';
import 'package:retailerp/models/Department.dart';
import 'package:retailerp/utils/const.dart';


import 'Add_Sales.dart';
import 'dashboard.dart';

class ManageDepartment extends StatefulWidget {
  @override
  _ManageDepartmentState createState() => _ManageDepartmentState();
}

class _ManageDepartmentState extends State<ManageDepartment> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;
  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileManageDepartment();
    } else {
      content = _buildTabletManageDepartment();
    }

    return content;
  }
//-------------------------------------------

  //DatabaseHelper databaseHelper = DatabaseHelper();
  List<Department> DepartmentList = new List();
  int count;


  @override
  void initState() {
    //ShowSalesdetails();
    _getSales();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletManageDepartment() {
    void handleClick(String value) {
      switch (value) {
        case 'Add Department':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
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
            Text('Manage Department'),
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
                'Add Department',
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
            child: DepartmentList.length == 0
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
                      width: 50,
                      child: Text('Sr No',
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
                      child: Text('Department Narration',
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
  Widget _buildMobileManageDepartment() {
    void handleClick(String value) {
      switch (value) {
        case 'Add Department':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
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
            Text('Department'),
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
                'Add Department',
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
            child: DepartmentList.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: DepartmentList.length,
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
                                "Department No: ${DepartmentList[index].DepartmentId.toString()} ",
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
                              "Department Name: ",
                              style: headHintTextStyle,
                            ),
                            Text("${DepartmentList[index].DepartmentName}",
                                style: headsubTextStyle),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text("Narration:      ",
                                style: headHintTextStyle),
                            Text(
                                "${DepartmentList[index].DepartmentNarration.toString()}",
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             EditSaleScreenNew(
                                //                 index, CashBillList)));
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.green,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _showMyDialog(DepartmentList[index].DepartmentId);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
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
      DataCell(Text(DepartmentList[index].DepartmentId.toString())),
      DataCell(Text(DepartmentList[index].DepartmentName)),
      DataCell(Text(DepartmentList[index].DepartmentNarration)),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
              ),
              color: Colors.green,
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => EditSales(index, SalesList)));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
              ),
              color: Colors.red,
              onPressed: () {
                _showMyDialog(DepartmentList[index].DepartmentId);
              },
            ),
          ],
        ),
      ),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < DepartmentList.length; i++) {
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
                  DepartmentDelete departmentdelete =new DepartmentDelete();
                  var result = await departmentdelete.getDepartmentDelete(id.toString());
                  print("//////////////////Print result//////$result");
                  print("///delete id///$id");
                  Navigator.of(context).pop();
                  _getSales();
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
  void _getSales() async {
    DepartmentFetch departmentfetch = new DepartmentFetch();
    var departmentData = await departmentfetch.getDepartmentFetch("1");
    var resid = departmentData["resid"];
    var departmentssd = departmentData["department"];
    //print(departmentssd.length);
    List<Department> tempDepartment = [];
    for (var n in departmentssd) {
      Department pro = Department(
          int.parse(n["DepartmentId"]),
          n["DepartmentName"],
          n["DepartmentNarration"]);
      tempDepartment.add(pro);
    }
    setState(() {
      this.DepartmentList = tempDepartment;
    });
    print("//////SalesList/////////$DepartmentList.length");
  }
//-------------------------------------

}
